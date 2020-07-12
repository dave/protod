package example

import (
	"context"
	"fmt"
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
	server := New(ctx, t)
	defer server.Close()

	id, err := Add(ctx, server, PERSON, uniqueID(), &tests.Person{Name: "a"})
	if err != nil {
		t.Fatal(err)
	}
	u1 := &User{user: 1, t: t, server: server}
	u2 := &User{user: 2, t: t, server: server}
	wg := &sync.WaitGroup{}
	wg.Add(1)
	go u1.Run(id, wg)
	go u2.Run(id, wg)
	wg.Wait()
}

type User struct {
	user     int
	t        *testing.T
	id       string
	server   *pserver.Server
	document proto.Message
	state    int64
}

const REPEATS = 1000

func (u *User) Run(id string, wg *sync.WaitGroup) {
	time.Sleep(time.Duration(rand.Intn(200)) * time.Millisecond)
	u.Get(id)
	for i := 0; i < REPEATS; i++ {
		time.Sleep(time.Duration(rand.Intn(200)) * time.Millisecond)
		u.Edit()
	}
	wg.Done()
}

func (u *User) Get(id string) {
	u.id = id
	var err error
	u.state, u.document, err = Get(context.Background(), u.server, PERSON, id)
	if err != nil {
		u.t.Fatal(err)
	}
	fmt.Printf("%d) GET %d %s\n", u.user, u.state, mustJson(u.document))
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
	fmt.Printf("%d) EDIT %d %s\n", u.user, u.state, mustJson(u.document))
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
	fmt.Printf("%d) REFRESH %d %s\n", u.user, u.state, mustJson(u.document))
}
