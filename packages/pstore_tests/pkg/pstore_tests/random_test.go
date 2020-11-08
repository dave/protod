package pstore_tests

import (
	"context"
	"math/rand"
	"sync"
	"testing"
	"time"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests"
	"github.com/dave/protod/packages/perr/pkg/perr"
	"github.com/dave/protod/packages/pfuzzer/pkg/pfuzzer"
	"github.com/dave/protod/packages/pserver/pkg/pserver"
	"github.com/dave/protod/packages/pstore/pkg/pstore"
	"google.golang.org/protobuf/proto"
)

const RANDOM_TEST_RETRIES_ON_BUSY = 100
const RANDOM_TEST_REPEATS = 100
const RANDOM_MAX_OPS = 10

func TestRandom(t *testing.T) {
	ctx := context.Background()
	resetDatabase(t)
	server := New(ctx, PERSON, COMPANY)
	defer func() { _ = server.Close() }()
	states := map[int64]proto.Message{}
	statesMutex := &sync.Mutex{}

	id := pstore.NewDocumentID()
	if _, err := pstore.Add(ctx, server, PersonTypeName, id, pstore.NewStateID(), &pdelta_tests.Person{Name: "a"}); err != nil {
		t.Fatal(err)
	}
	wg := &sync.WaitGroup{}
	u1 := &RandomUser{user: 1, t: t, wg: wg, server: server, states: states, mutex: statesMutex}
	u2 := &RandomUser{user: 2, t: t, wg: wg, server: server, states: states, mutex: statesMutex}
	u3 := &RandomUser{user: 3, t: t, wg: wg, server: server, states: states, mutex: statesMutex}
	wg.Add(3)
	go u1.Run(id)
	go u2.Run(id)
	go u3.Run(id)
	wg.Wait()
}

type RandomUser struct {
	user     int
	t        *testing.T
	id       pstore.DocumentId
	document proto.Message
	state    int64
	states   map[int64]proto.Message
	mutex    *sync.Mutex
	wg       *sync.WaitGroup
	elapsed  int64
	edits    int
	server   *pserver.Server
}

func (u *RandomUser) Run(id pstore.DocumentId) {
	//time.Sleep(time.Duration(rand.Intn(20)) * time.Millisecond)
	defer u.wg.Done()
	u.Get(id)
	for i := 0; i < RANDOM_TEST_REPEATS; i++ {
		time.Sleep(time.Duration(rand.Intn(5000)) * time.Microsecond)
		t := time.Now().UnixNano()
		u.Edit()
		d := time.Now().UnixNano() - t
		u.elapsed += d
		u.edits++
	}
}

func (u *RandomUser) Get(id pstore.DocumentId) {
	u.id = id
	var err error
	u.state, u.document, err = pstore.Get(context.Background(), u.server, PersonTypeName, id, false)
	if err != nil {
		u.t.Fatal(err)
	}
	//fmt.Printf("%d) GET %d %s\n", u.user, u.state, mustJson(u.document))
}

func (u *RandomUser) Edit() {
	var ops []*pdelta.Op
	for i := 0; i < rand.Intn(RANDOM_MAX_OPS)+1; i++ {
		op := pfuzzer.Get(u.document)
		ops = append(ops, op)
		if err := pdelta.Apply(op, u.document); err != nil {
			u.t.Fatal(err)
		}
	}

	var state int64
	var opx *pdelta.Op
	f := func() error {
		var err error
		state, opx, err = pstore.Edit(context.Background(), u.server, PersonTypeName, u.id, pstore.NewStateID(), u.state, pdelta.Compound(ops...))
		return err
	}
	err := repeatOnBusy(f)

	if err != nil {
		u.t.Fatal(err)
	}
	if err := pdelta.Apply(opx, u.document); err != nil {
		u.t.Fatal(err)
	}
	u.state = state

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
	//if int(u.state)%(rand.Intn(10)+10) == 0 {
	//fmt.Printf("%d) EDIT %d %s\n", u.user, u.state, mustJson(u.document))
	//milisecondsPerEdit := (float64(u.elapsed) / float64(u.edits)) / 1000.0 / 1000.0
	//u.elapsed = 0
	//u.edits = 0
	//fmt.Printf("%d) EDIT %d duration: %dms\n", u.user, u.state, int(milisecondsPerEdit))
	//}
}

func (u *RandomUser) Refresh() {
	state, op, err := pstore.Edit(context.Background(), u.server, PersonTypeName, u.id, pstore.NewStateID(), u.state, nil)
	if err != nil {
		u.t.Fatal(err)
	}
	if err := pdelta.Apply(op, u.document); err != nil {
		u.t.Fatal(err)
	}
	u.state = state
	//fmt.Printf("%d) REFRESH %d %s\n", u.user, u.state, mustJson(u.document))
}

func repeatOnBusy(f func() error) error {
	for i := 0; i < RANDOM_TEST_RETRIES_ON_BUSY; i++ {
		if i > 0 {
			delay := 500 + rand.Intn(500*(1<<i))
			time.Sleep(time.Duration(delay) * time.Millisecond)
		}
		if err := f(); !(perr.AnyFlag(err, perr.Busy) || perr.Any(err, pserver.IsBusy)) {
			return err
		}
	}
	return perr.Flag(perr.Busy)
}
