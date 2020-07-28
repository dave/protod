package example

import (
	"context"
	"math/rand"
	"sync"
	"testing"
	"time"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/randop"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
	"google.golang.org/protobuf/proto"
)

func TestRandom(t *testing.T) {
	ctx := context.Background()
	resetDatabase(t)
	server := New(ctx)
	defer func() { _ = server.Close() }()
	states := map[int64]proto.Message{}
	statesMutex := &sync.Mutex{}

	id := uniqueID()
	if err := Add(ctx, server, PERSON, id, &tests.Person{Name: "a"}); err != nil {
		t.Fatal(err)
	}
	wg := &sync.WaitGroup{}
	u1 := &User{user: 1, t: t, wg: wg, server: server, states: states, mutex: statesMutex}
	u2 := &User{user: 2, t: t, wg: wg, server: server, states: states, mutex: statesMutex}
	u3 := &User{user: 3, t: t, wg: wg, server: server, states: states, mutex: statesMutex}
	wg.Add(3)
	go u1.Run(id)
	go u2.Run(id)
	go u3.Run(id)
	wg.Wait()
}

type User struct {
	user     int
	t        *testing.T
	id       string
	server   *pserver.Server
	document proto.Message
	state    int64
	states   map[int64]proto.Message
	mutex    *sync.Mutex
	wg       *sync.WaitGroup
	elapsed  int64
	edits    int
}

const REPEATS = 100

func (u *User) Run(id string) {
	//time.Sleep(time.Duration(rand.Intn(20)) * time.Millisecond)
	defer u.wg.Done()
	u.Get(id)
	for i := 0; i < REPEATS; i++ {
		time.Sleep(time.Duration(rand.Intn(5000)) * time.Microsecond)
		t := time.Now().UnixNano()
		u.Edit()
		d := time.Now().UnixNano() - t
		u.elapsed += d
		u.edits++
	}
}

func (u *User) Get(id string) {
	u.id = id
	var err error
	u.state, u.document, err = Get(context.Background(), u.server, PERSON, id)
	if err != nil {
		u.t.Fatal(err)
	}
	//fmt.Printf("%d) GET %d %s\n", u.user, u.state, mustJson(u.document))
}

const MAX_OPS = 10

func (u *User) Edit() {
	var ops []*delta.Op
	for i := 0; i < rand.Intn(MAX_OPS)+1; i++ {
		op := randop.Get(u.document)
		ops = append(ops, op)
		if err := delta.Apply(op, u.document); err != nil {
			u.t.Fatal(err)
		}
	}
	op := delta.Compound(ops...)

	var payload *pserver.Payload_Response
	f := func() error {
		var err error
		payload, err = Edit(context.Background(), u.server, PERSON, &pserver.Payload_Request{Id: uniqueID(), Document: u.id, State: u.state, Op: op})
		return err
	}
	err := repeatOnBusy(f)

	//state, opx, err := Edit(context.Background(), u.server, PERSON, uniqueID(), u.id, u.state, op)
	if err != nil {
		u.t.Fatal(err)
	}
	if err := delta.Apply(payload.Op, u.document); err != nil {
		u.t.Fatal(err)
	}
	u.state = payload.State

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

func (u *User) Refresh() {
	payload, err := Edit(context.Background(), u.server, PERSON, &pserver.Payload_Request{Id: uniqueID(), Document: u.id, State: u.state, Op: nil})
	if err != nil {
		u.t.Fatal(err)
	}
	if err := delta.Apply(payload.Op, u.document); err != nil {
		u.t.Fatal(err)
	}
	u.state = payload.State
	//fmt.Printf("%d) REFRESH %d %s\n", u.user, u.state, mustJson(u.document))
}

const RETRIES_ON_BUSY = 100

func repeatOnBusy(f func() error) error {
	for i := 0; i < RETRIES_ON_BUSY; i++ {
		if i > 0 {
			delay := 500 + rand.Intn(500*(1<<i))
			time.Sleep(time.Duration(delay) * time.Millisecond)
		}
		if err := f(); err != pserver.ServerBusy {
			return err
		}
	}
	return pserver.ServerBusy
}
