package main

import (
	"fmt"
	"math/rand"
	"sync"
	"testing"
	"time"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/randop"
	"github.com/dave/protod/delta/tests"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

var count int
var elapsed int64
var startTime int64

const SKIP_GAE = true
const REPEATS = 20

func TestGaeRandom(t *testing.T) {

	if SKIP_GAE {
		return
	}

	prefix := "https://pserver-testing.nw.r.appspot.com"
	docStates := map[string]map[int64]proto.Message{}

	count = 0
	elapsed = 0
	startTime = time.Now().UnixNano()
	mutex := &sync.Mutex{}

	var docs []string
	for i := 0; i < 5; i++ {
		id := uniqueID()
		resp := req(prefix, &Person_Add_Response{}, &Person_Add_Request{
			Id:     id,
			Person: &tests.Person{Name: "dave"},
		}).(*Person_Add_Response)
		if resp.Err != "" {
			t.Fatal(resp.Err)
		}
		docs = append(docs, id)

		//id := resp.Id
		fmt.Println(id)
	}
	//docs := []string{
	//	"jGCmF29WkHFE785IgPCL", // 300k edits
	//	"VVFJQFCXBe04KvF5eivD",
	//	"QvLR2ylyB4gEwnb7gINP",
	//	//"3Y8Tsmo91DkpvWQAgYdb",
	//	//"f0DFGUIfTvoermX92WtS",
	//	//"HNEHMuhbBr8mVcyFSLx7",
	//}

	for _, id := range docs {
		docStates[id] = map[int64]proto.Message{}
	}
	//id := "jGCmF29WkHFE785IgPCL"
	//fmt.Println(id)
	wg := &sync.WaitGroup{}
	users := 10
	for i := 1; i < users; i++ {
		id := docs[rand.Intn(len(docs))]
		u := &User{user: i, t: t, wg: wg, states: docStates[id], mutex: mutex, prefix: prefix}
		wg.Add(1)
		go u.Run(id)
	}
	wg.Wait()
}

type User struct {
	user     int
	t        *testing.T
	id       string
	document proto.Message
	state    int64
	states   map[int64]proto.Message
	mutex    *sync.Mutex
	wg       *sync.WaitGroup
	prefix   string
}

func (u *User) Run(id string) {
	defer u.wg.Done()
	time.Sleep(time.Duration(rand.Intn(5000)) * time.Millisecond)
	u.Get(id)
	for i := 0; i < REPEATS; i++ {
		delay := rand.Intn(50)
		//fmt.Printf("waiting %.1fsec\n", float64(delay)/1000.0)
		time.Sleep(time.Duration(delay) * time.Millisecond)
		u.Edit()
	}
}

func (u *User) Get(id string) {
	u.id = id
	resp := req(u.prefix, &Person_Get_Response{}, &Person_Get_Request{
		Id: id,
	}).(*Person_Get_Response)
	if resp.Err != "" {
		u.t.Fatal(resp.Err)
	}
	u.state = resp.State
	u.document = resp.Person
}

const MAX_OPS = 10

func (u *User) Edit() {
	editStartTime := time.Now().UnixNano()
	var ops []*delta.Op
	for i := 0; i < rand.Intn(MAX_OPS)+1; i++ {
		op := randop.Get(u.document)
		ops = append(ops, op)
		if err := delta.Apply(op, u.document); err != nil {
			u.t.Fatal(err)
		}
	}
	op := delta.Compound(ops...)
	resp := req(u.prefix, &Person_Edit_Response{}, &Person_Edit_Request{
		Id:       uniqueID(),
		Document: u.id,
		State:    u.state,
		Op:       op,
	}).(*Person_Edit_Response)
	if resp.Err != "" {
		u.t.Fatal(resp.Err)
	}
	if err := delta.Apply(resp.Op, u.document); err != nil {
		u.t.Fatal(err)
	}
	u.state = resp.State

	u.mutex.Lock()
	defer func() { u.mutex.Unlock() }()

	previous, found := u.states[u.state]
	if !found {
		u.states[u.state] = proto.Clone(u.document)
	} else {
		if !proto.Equal(u.document, previous) {
			u.t.Fatalf("state diverged at %d\nprevious: %s\nnew: %s", u.state, mustJson(previous), mustJson(u.document))
		}
	}

	endTime := time.Now().UnixNano()
	count++
	elapsed += endTime - editStartTime

	if count%10 == 0 {
		total := endTime - startTime
		milisecondsPerEdit := (float64(elapsed) / float64(count)) / 1000.0 / 1000.0
		editsPerSecond := float64(count) / (float64(total) / 1000.0 / 1000.0 / 1000.0)
		fmt.Printf("State: %d, %d edits, %.1f/sec, %dms\n", u.state, count, editsPerSecond, int(milisecondsPerEdit))
	}
	if count%1000 == 0 {
		elapsed = 0
		count = 0
		startTime = time.Now().UnixNano()
	}
}

func mustJson(message proto.Message) string {
	if message == nil {
		return "[nil]"
	}
	if !message.ProtoReflect().IsValid() {
		return "[invalid]"
	}
	b, err := protojson.MarshalOptions{Indent: "\t"}.Marshal(message)
	if err != nil {
		panic(err)
	}
	return string(b)
}
