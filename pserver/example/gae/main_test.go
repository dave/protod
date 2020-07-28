package main

import (
	"context"
	"crypto/rand"
	"fmt"
	"testing"

	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
	"github.com/dave/protod/pserver/example"
)

func TestServer(t *testing.T) {
	document := &tests.Person{
		Name: "dave",
	}
	app := &App{Server: example.New(context.Background())}
	defer app.Server.Close()

	id := uniqueID()

	addResponse := app.ProcessMessage(context.Background(), &Person_Add_Request{
		Id:     id,
		Person: document,
	}).(*Person_Add_Response)

	if addResponse.Err != "" {
		t.Fatal(addResponse.Err)
	}

	getResponse := app.ProcessMessage(context.Background(), &Person_Get_Request{
		Id: id,
	}).(*Person_Get_Response)

	if getResponse.Err != "" {
		t.Fatal(getResponse.Err)
	}

	if getResponse.Person.Name != "dave" {
		t.Fatal("document not received correctly in get")
	}

	editResponse := app.ProcessMessage(context.Background(), &Person_Edit_Request{
		Payload: &pserver.Payload_Request{
			Id:      id,
			Request: uniqueID(),
			State:   1,
			Op:      tests.Op().Person().Name().Edit("dave", "dave foo"),
		},
	}).(*Person_Edit_Response)

	if editResponse.Err != "" {
		t.Fatal(editResponse.Err)
	}

	if editResponse.Payload.Op != nil {
		t.Fatal("expected nil op")
	}

	if editResponse.Payload.State != 2 {
		t.Fatalf("expected state 2, got %d", editResponse.Payload.State)
	}
}

const alphanum = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

func uniqueID() string {
	b := make([]byte, 20)
	if _, err := rand.Read(b); err != nil {
		panic(fmt.Sprintf("firestore: crypto/rand.Read error: %v", err))
	}
	for i, byt := range b {
		b[i] = alphanum[int(byt)%len(alphanum)]
	}
	return string(b)
}
