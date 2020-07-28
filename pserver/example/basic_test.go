package example

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"testing"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
	"google.golang.org/protobuf/proto"
)

func TestRenameChain(t *testing.T) {
	ctx := context.Background()
	resetDatabase(t)
	server := New(ctx)
	defer server.Close()

	id := uniqueID()
	var err error
	var msg proto.Message
	var op *delta.Op

	var user1State = int64(1)
	var user1Value = &tests.Company{Flags: map[int64]string{1: "a"}}

	var user2State int64
	var user2Value *tests.Company

	var payload *pserver.Payload_Response

	// user1 adds value
	err = Add(ctx, server, COMPANY, id, user1Value)
	handle(t, err)

	// user2 gets document
	user2State, msg, err = Get(ctx, server, COMPANY, id)
	handle(t, err)
	user2Value = msg.(*tests.Company)
	check(t, "user2 get", user2Value, user2State, user1Value, user1State)

	// user1 renames key
	op = tests.Op().Company().Flags().Rename(1, 4)
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, COMPANY, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 rename key", user1Value, user1State, &tests.Company{Flags: map[int64]string{4: "a"}}, 2)

	// user2 set inside renamed key
	op = delta.Compound(
		tests.Op().Company().Flags().Rename(1, 2),
		tests.Op().Company().Flags().Rename(2, 3),
	)
	handle(t, delta.Apply(op, user2Value))
	payload, err = Edit(ctx, server, COMPANY, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user2State, Op: op})
	handle(t, err)
	user2State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user2Value))
	check(t, "user2 multi rename", user2Value, user2State, &tests.Company{Flags: map[int64]string{4: "a"}}, 3)

	// user1 renames key
	op = tests.Op().Company().Name().Set("a")
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, COMPANY, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 rename key", user1Value, user1State, &tests.Company{Name: "a", Flags: map[int64]string{4: "a"}}, 4)

}

func TestRenameConflict(t *testing.T) {
	ctx := context.Background()
	resetDatabase(t)
	server := New(ctx)
	defer server.Close()

	id := uniqueID()
	var err error
	var msg proto.Message
	var op *delta.Op

	var user1State = int64(1)
	var user1Value = &tests.Person{Cases: map[string]*tests.Case{"a": {Name: "x", Flags: map[int64]string{1: "a", 2: "b"}}}}

	var user2State int64
	var user2Value *tests.Person

	var payload *pserver.Payload_Response

	// user1 adds value
	err = Add(ctx, server, PERSON, id, user1Value)
	handle(t, err)

	// user2 gets value
	user2State, msg, err = Get(ctx, server, PERSON, id)
	handle(t, err)
	user2Value = msg.(*tests.Person)
	check(t, "user2 get", user2Value, user2State, user1Value, user1State)

	// user1 renames key
	op = tests.Op().Person().Cases().Rename("a", "b")
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 rename key", user1Value, user1State, &tests.Person{Cases: map[string]*tests.Case{"b": {Name: "x", Flags: map[int64]string{1: "a", 2: "b"}}}}, 2)

	// user2 set inside renamed key
	op = tests.Op().Person().Cases().Key("a").Flags().Rename(1, 3)
	handle(t, delta.Apply(op, user2Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user2State, Op: op})
	handle(t, err)
	user2State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user2Value))
	check(t, "user2 set inside renamed key", user2Value, user2State, &tests.Person{Cases: map[string]*tests.Case{"b": {Name: "x", Flags: map[int64]string{3: "a", 2: "b"}}}}, 3)

	// user1 renames key
	op = tests.Op().Person().Cases().Key("b").Name().Set("y")
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 rename key", user1Value, user1State, &tests.Person{Cases: map[string]*tests.Case{"b": {Name: "y", Flags: map[int64]string{3: "a", 2: "b"}}}}, 4)
}

func TestConflict(t *testing.T) {
	ctx := context.Background()
	resetDatabase(t)
	server := New(ctx)
	defer server.Close()

	id := uniqueID()
	var err error
	var msg proto.Message
	var op *delta.Op

	var user1State = int64(1)
	var user1Value = &tests.Person{Name: "a", Cases: map[string]*tests.Case{"b": {Name: "c"}}}

	var user2State int64
	var user2Value *tests.Person

	var payload *pserver.Payload_Response

	// user1 adds value
	err = Add(ctx, server, PERSON, id, user1Value)
	handle(t, err)

	// user2 gets value
	user2State, msg, err = Get(ctx, server, PERSON, id)
	handle(t, err)
	user2Value = msg.(*tests.Person)
	check(t, "user2 get", user2Value, user2State, user1Value, user1State)

	// user1 sets name
	op = tests.Op().Person().Cases().Key("b").Name().Edit("c", "d")
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 edit 1", user1Value, user1State, &tests.Person{Name: "a", Cases: map[string]*tests.Case{"b": {Name: "d"}}}, 2)

	// user2 deletes name
	op = tests.Op().Person().Cases().Key("b").Delete()
	handle(t, delta.Apply(op, user2Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user2State, Op: op})
	handle(t, err)
	user2State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user2Value))
	check(t, "user2 edit 1", user2Value, user2State, &tests.Person{Name: "a", Cases: map[string]*tests.Case{}}, 3)
}

func TestBasic(t *testing.T) {
	ctx := context.Background()
	resetDatabase(t)
	server := New(ctx)
	defer server.Close()

	id := uniqueID()
	var err error
	var msg proto.Message
	var op *delta.Op

	var user1State = int64(1)
	var user1Value = &tests.Person{Name: "a"}

	var user2State int64
	var user2Value *tests.Person

	var user3State int64
	var user3Value *tests.Person

	var payload *pserver.Payload_Response

	// user1 adds value
	err = Add(ctx, server, PERSON, id, user1Value)
	handle(t, err)

	// user2 gets value
	user2State, msg, err = Get(ctx, server, PERSON, id)
	handle(t, err)
	user2Value = msg.(*tests.Person)
	check(t, "user2 get", user2Value, user2State, user1Value, user1State)

	// user1 inserts value
	op = tests.Op().Person().Alias().Insert(0, "b")
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 edit 1", user1Value, user1State, &tests.Person{Name: "a", Alias: []string{"b"}}, 2)

	// user1 modifies value
	op = tests.Op().Person().Alias().Index(0).Edit("b", "c")
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 edit 2", user1Value, user1State, &tests.Person{Name: "a", Alias: []string{"c"}}, 3)

	// user2 modifies value
	op = tests.Op().Person().Alias().Insert(0, "d")
	handle(t, delta.Apply(op, user2Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user2State, Op: op})
	handle(t, err)
	user2State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user2Value))
	check(t, "user2 edit 1", user2Value, user2State, &tests.Person{Name: "a", Alias: []string{"c", "d"}}, 4)

	// user1 refresh
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: nil})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 refresh", user1Value, user1State, &tests.Person{Name: "a", Alias: []string{"c", "d"}}, 4)

	// user2 modifies value
	op = tests.Op().Person().Company().Set(&tests.Company{Name: "e"})
	handle(t, delta.Apply(op, user2Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user2State, Op: op})
	handle(t, err)
	user2State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user2Value))
	check(t, "user2 edit 2", user2Value, user2State, &tests.Person{Name: "a", Alias: []string{"c", "d"}, Company: &tests.Company{Name: "e"}}, 5)

	// user3 gets value
	user3State, msg, err = Get(ctx, server, PERSON, id)
	handle(t, err)
	user3Value = msg.(*tests.Person)
	check(t, "user3 get", user3Value, user3State, &tests.Person{Name: "a", Alias: []string{"c", "d"}, Company: &tests.Company{Name: "e"}}, 5)

	// user1 big update
	op = delta.Compound(
		tests.Op().Person().Alias().Insert(2, "e"),
		tests.Op().Person().Alias().Move(0, 3),
		tests.Op().Person().Cases().Key("a").Set(&tests.Case{Name: "a"}),
		tests.Op().Person().Cases().Key("a").Flags().Key(1).Set("b"),
		tests.Op().Person().Cases().Key("a").Flags().Key(1).Edit("b", "c"),
		tests.Op().Person().Cases().Key("a").Flags().Rename(1, 2),
	)
	handle(t, delta.Apply(op, user1Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user1State, Op: op})
	handle(t, err)
	user1State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user1Value))
	check(t, "user1 edit 3", user1Value, user1State, &tests.Person{Name: "a", Alias: []string{"d", "e", "c"}, Company: &tests.Company{Name: "e"}, Cases: map[string]*tests.Case{"a": {Name: "a", Flags: map[int64]string{2: "c"}}}}, 6)

	// user2 modifies value
	op = tests.Op().Person().Company().Name().Set("f")
	handle(t, delta.Apply(op, user2Value))
	payload, err = Edit(ctx, server, PERSON, &pserver.Payload_Request{Request: uniqueID(), Id: id, State: user2State, Op: op})
	handle(t, err)
	user2State, op = payload.State, payload.Op
	handle(t, delta.Apply(op, user2Value))
	check(t, "user2 edit 3", user2Value, user2State, &tests.Person{Name: "a", Alias: []string{"d", "e", "c"}, Company: &tests.Company{Name: "f"}, Cases: map[string]*tests.Case{"a": &tests.Case{Name: "a", Flags: map[int64]string{2: "c"}}}}, 7)

}

func check(t *testing.T, label string, value proto.Message, state int64, expectedValue proto.Message, expectedState int64) {
	t.Helper()
	if !proto.Equal(value, expectedValue) {
		t.Fatalf("%s value got [%v], expected [%v]", label, value, expectedValue)
	}
	if state != expectedState {
		t.Fatalf("%s state got [%v], expected [%v]", label, state, expectedState)
	}
}

func handle(t *testing.T, err error) {
	t.Helper()
	if err != nil {
		t.Fatal(err)
	}
}

func resetDatabase(t *testing.T) {
	addr := os.Getenv("FIRESTORE_EMULATOR_HOST")
	if addr == "" {
		t.Fatal("can't find FIRESTORE_EMULATOR_HOST env")
	}
	client := &http.Client{}
	url := fmt.Sprintf("http://%s/emulator/v1/projects/%s/databases/(default)/documents", addr, PROJECT_ID)
	req, err := http.NewRequest(http.MethodDelete, url, nil)
	if err != nil {
		t.Fatal(err)
	}
	resp, err := client.Do(req)
	if err != nil {
		t.Fatal(err)
	}
	if resp.StatusCode != 200 {
		t.Fatalf("reset database call returned %d: %s", resp.StatusCode, resp.Status)
	}
}
