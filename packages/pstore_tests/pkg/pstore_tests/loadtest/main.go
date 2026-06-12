// Command loadtest drives concurrent random edits at a deployed pserver instance and reports throughput.
//
// Each simulated user owns a connection to one document: it gets the document, then loops generating a
// compound op of random fuzzer edits, sending it, and applying the transformed response ops - exactly the
// client flow from gae_random_test.go, but duration-bounded and parameterized for scale.
package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"math/rand"
	"net/http"
	"sort"
	"sync"
	"sync/atomic"
	"time"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/fuzzer"
	"github.com/dave/protod/packages/pstore/pkg/pstore"
	"github.com/dave/protod/packages/pstore_tests/pkg/pstore_tests"
	"google.golang.org/protobuf/proto"
)

var (
	prefix   = flag.String("prefix", "https://pserver-testing.nw.r.appspot.com", "server prefix")
	docs     = flag.Int("docs", 10, "number of documents")
	users    = flag.Int("users", 30, "number of concurrent users")
	duration = flag.Duration("duration", 30*time.Second, "how long to run")
	think    = flag.Duration("think", 0, "think time between edits per user")
	maxOps   = flag.Int("maxops", 5, "max ops per edit")
	retries  = flag.Int("retries", 20, "request retries (busy backoff)")
	backoff  = flag.Int("backoff", 100, "base retry backoff in ms (busy contention)")
	verify   = flag.Bool("verify", true, "verify convergence between users sharing a document")
)

var client = &http.Client{
	Timeout: 60 * time.Second,
	Transport: &http.Transport{
		MaxIdleConns:        2000,
		MaxIdleConnsPerHost: 2000,
		MaxConnsPerHost:     0,
		IdleConnTimeout:     90 * time.Second,
		ForceAttemptHTTP2:   true,
	},
}

// metrics
var (
	editCount    int64
	opCount      int64
	retryCount   int64
	failCount    int64
	latencySumNs int64
)

var latencies = struct {
	sync.Mutex
	ns []int64
}{}

func recordLatency(ns int64) {
	atomic.AddInt64(&latencySumNs, ns)
	latencies.Lock()
	latencies.ns = append(latencies.ns, ns)
	latencies.Unlock()
}

func percentile(sorted []int64, p float64) time.Duration {
	if len(sorted) == 0 {
		return 0
	}
	i := int(float64(len(sorted)-1) * p)
	return time.Duration(sorted[i])
}

func post(path string, message, response proto.Message) error {
	var err error
	for i := 0; i < *retries; i++ {
		if i > 0 {
			atomic.AddInt64(&retryCount, 1)
			delay := *backoff/2 + rand.Intn(*backoff*(1<<min(i, 4)))
			time.Sleep(time.Duration(delay) * time.Millisecond)
		}
		var messageBytes []byte
		messageBytes, err = proto.Marshal(message)
		if err != nil {
			continue
		}
		var resp *http.Response
		resp, err = client.Post(path, "application/protobuf", bytes.NewBuffer(messageBytes))
		if err != nil {
			continue
		}
		var body []byte
		body, err = ioutil.ReadAll(resp.Body)
		resp.Body.Close()
		if err != nil {
			continue
		}
		if resp.StatusCode != 200 {
			err = fmt.Errorf("status %q: %q", resp.Status, string(body))
			continue
		}
		if err = proto.Unmarshal(body, response); err != nil {
			continue
		}
		return nil
	}
	return err
}

type doc struct {
	id     pstore.DocumentId
	mutex  sync.Mutex
	states map[int64][]byte // state -> marshaled document, for convergence checking
}

type user struct {
	doc      *doc
	document *pdelta_tests.Person
	state    int64
}

func (u *user) get() error {
	resp := &pstore_tests.Person_Get_Response{}
	if err := post(*prefix+"/Person_Get_Request", &pstore_tests.Person_Get_Request{DocumentId: string(u.doc.id)}, resp); err != nil {
		return err
	}
	if resp.Err != "" {
		return fmt.Errorf("get: %s", resp.Err)
	}
	u.state = resp.State
	u.document = resp.Person
	return nil
}

func (u *user) edit() error {
	started := time.Now()
	var ops []*pdelta.Op
	for i := 0; i < rand.Intn(*maxOps)+1; i++ {
		op := fuzzer.Get(u.document)
		ops = append(ops, op)
		if err := pdelta.Apply(op, u.document); err != nil {
			return fmt.Errorf("applying local op: %w", err)
		}
	}
	op := pdelta.Compound(ops...)
	resp := &pstore_tests.Person_Edit_Response{}
	err := post(*prefix+"/Person_Edit_Request", &pstore_tests.Person_Edit_Request{
		DocumentId: string(u.doc.id),
		StateId:    string(pstore.NewStateID()),
		State:      u.state,
		Op:         op,
	}, resp)
	if err != nil {
		return err
	}
	if resp.Err != "" {
		return fmt.Errorf("edit: %s", resp.Err)
	}
	if err := pdelta.Apply(resp.Op, u.document); err != nil {
		return fmt.Errorf("applying response op: %w", err)
	}
	u.state = resp.State

	recordLatency(time.Since(started).Nanoseconds())
	atomic.AddInt64(&editCount, 1)
	atomic.AddInt64(&opCount, int64(len(ops)))

	if *verify {
		b, err := proto.Marshal(u.document)
		if err != nil {
			return err
		}
		u.doc.mutex.Lock()
		defer u.doc.mutex.Unlock()
		previous, found := u.doc.states[u.state]
		if !found {
			u.doc.states[u.state] = b
		} else if !bytes.Equal(previous, b) {
			// marshaling isn't guaranteed deterministic, so compare semantically before failing
			prev := &pdelta_tests.Person{}
			if err := proto.Unmarshal(previous, prev); err != nil {
				return err
			}
			if !proto.Equal(prev, u.document) {
				return fmt.Errorf("state diverged at %d on document %s", u.state, u.doc.id)
			}
		}
	}
	return nil
}

func main() {
	flag.Parse()

	fmt.Printf("loadtest: %d users, %d docs, %s duration, think %s, max %d ops/edit\n", *users, *docs, *duration, *think, *maxOps)

	// create documents
	docList := make([]*doc, *docs)
	for i := range docList {
		id := pstore.NewDocumentID()
		resp := &pstore_tests.Person_Edit_Response{}
		err := post(*prefix+"/Person_Edit_Request", &pstore_tests.Person_Edit_Request{
			DocumentId: string(id),
			StateId:    string(pstore.NewStateID()),
			State:      0,
			Op:         pdelta.Root(&pdelta_tests.Person{Name: "loadtest"}),
		}, resp)
		if err != nil || resp.Err != "" {
			panic(fmt.Sprintf("creating doc: %v %s", err, resp.Err))
		}
		docList[i] = &doc{id: id, states: map[int64][]byte{}}
	}
	fmt.Printf("created %d documents\n", *docs)

	deadline := time.Now().Add(*duration)
	start := time.Now()
	wg := &sync.WaitGroup{}
	stop := int32(0)

	for i := 0; i < *users; i++ {
		d := docList[i%len(docList)]
		wg.Add(1)
		go func(d *doc, n int) {
			defer wg.Done()
			// stagger startup over the first 2 seconds to avoid a thundering herd
			time.Sleep(time.Duration(rand.Intn(2000)) * time.Millisecond)
			u := &user{doc: d}
			if err := u.get(); err != nil {
				fmt.Printf("user %d: get failed: %v\n", n, err)
				atomic.AddInt64(&failCount, 1)
				return
			}
			for time.Now().Before(deadline) && atomic.LoadInt32(&stop) == 0 {
				if err := u.edit(); err != nil {
					fmt.Printf("user %d: %v\n", n, err)
					atomic.AddInt64(&failCount, 1)
					return
				}
				if *think > 0 {
					time.Sleep(*think)
				}
			}
		}(d, i)
	}

	// reporter
	done := make(chan struct{})
	go func() {
		ticker := time.NewTicker(5 * time.Second)
		defer ticker.Stop()
		var lastEdits, lastOps int64
		lastTime := time.Now()
		for {
			select {
			case <-done:
				return
			case <-ticker.C:
				edits := atomic.LoadInt64(&editCount)
				ops := atomic.LoadInt64(&opCount)
				retriesN := atomic.LoadInt64(&retryCount)
				dt := time.Since(lastTime).Seconds()
				fmt.Printf("[%4.0fs] %6.1f edits/sec, %6.1f ops/sec (total: %d edits, %d ops, %d retries)\n",
					time.Since(start).Seconds(), float64(edits-lastEdits)/dt, float64(ops-lastOps)/dt, edits, ops, retriesN)
				lastEdits, lastOps = edits, ops
				lastTime = time.Now()
			}
		}
	}()

	wg.Wait()
	close(done)
	atomic.StoreInt32(&stop, 1)

	total := time.Since(start).Seconds()
	edits := atomic.LoadInt64(&editCount)
	ops := atomic.LoadInt64(&opCount)
	latencies.Lock()
	sorted := append([]int64{}, latencies.ns...)
	latencies.Unlock()
	sort.Slice(sorted, func(i, j int) bool { return sorted[i] < sorted[j] })

	fmt.Printf("\n=== results ===\n")
	fmt.Printf("duration:    %.1fs\n", total)
	fmt.Printf("edits:       %d (%.1f/sec)\n", edits, float64(edits)/total)
	fmt.Printf("ops:         %d (%.1f/sec)\n", ops, float64(ops)/total)
	fmt.Printf("retries:     %d, failed users: %d\n", atomic.LoadInt64(&retryCount), atomic.LoadInt64(&failCount))
	if edits > 0 {
		fmt.Printf("latency:     mean %s, p50 %s, p95 %s, p99 %s\n",
			time.Duration(atomic.LoadInt64(&latencySumNs)/edits).Round(time.Millisecond),
			percentile(sorted, 0.5).Round(time.Millisecond),
			percentile(sorted, 0.95).Round(time.Millisecond),
			percentile(sorted, 0.99).Round(time.Millisecond))
	}
	// each edit is at least one Firestore write plus reads; snapshot refreshes add more
	fmt.Printf("est. cost:   ~£%.2f (rough, writes only)\n", float64(edits)*1.2/100000*0.09)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
