package example

import (
	"context"
	"fmt"
	"math/rand"
	"sync"
	"testing"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/randop"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
	"google.golang.org/protobuf/proto"
)

func TestRandom(t *testing.T) {
	ctx := context.Background()
	resetDatabase(t)
	server := New(ctx, t)
	defer server.Close()
	states := map[int64]proto.Message{}
	statesMutex := &sync.Mutex{}

	id, err := Add(ctx, server, PERSON, uniqueID(), &tests.Person{Name: "a"})
	if err != nil {
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
}

const REPEATS = 1000

func (u *User) Run(id string) {
	//time.Sleep(time.Duration(rand.Intn(20)) * time.Millisecond)
	defer u.wg.Done()
	u.Get(id)
	for i := 0; i < REPEATS; i++ {
		//time.Sleep(time.Duration(rand.Intn(2000)) * time.Microsecond)
		u.Edit()
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
	state, opx, err := Edit(context.Background(), u.server, PERSON, uniqueID(), u.id, u.state, op)
	if err != nil {
		u.t.Fatal(err)
	}
	if err := delta.Apply(opx, u.document); err != nil {
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
	if int(u.state)%(rand.Intn(10)+10) == 0 {
		//fmt.Printf("%d) EDIT %d %s\n", u.user, u.state, mustJson(u.document))
		fmt.Printf("%d) EDIT %d\n", u.user, u.state)
	}
}

func (u *User) Refresh() {
	state, opx, err := Edit(context.Background(), u.server, PERSON, uniqueID(), u.id, u.state, nil)
	if err != nil {
		u.t.Fatal(err)
	}
	if err := delta.Apply(opx, u.document); err != nil {
		u.t.Fatal(err)
	}
	u.state = state
	//fmt.Printf("%d) REFRESH %d %s\n", u.user, u.state, mustJson(u.document))
}
