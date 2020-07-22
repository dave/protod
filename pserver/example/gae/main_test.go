package main

import (
	"context"
	"crypto/rand"
	"fmt"
	"testing"

	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver/example"
)

func TestServer(t *testing.T) {
	document := &tests.Person{
		Name: "dave",
	}
	app := &App{Server: example.New(context.Background())}
	defer app.Server.Close()

	addResponse := app.ProcessMessage(context.Background(), &Person_Add_Request{
		Request: uniqueID(),
		Person:  document,
	}).(*Person_Add_Response)

	if addResponse.Err != "" {
		t.Fatal(addResponse.Err)
	}

	getResponse := app.ProcessMessage(context.Background(), &Person_Get_Request{
		Id: addResponse.Id,
	}).(*Person_Get_Response)

	if getResponse.Err != "" {
		t.Fatal(getResponse.Err)
	}

	if getResponse.Person.Name != "dave" {
		t.Fatal("document not received correctly in get")
	}

	editResponse := app.ProcessMessage(context.Background(), &Person_Edit_Request{
		Id:      addResponse.Id,
		Request: uniqueID(),
		State:   1,
		Op:      tests.Op().Person().Name().Edit("dave", "dave foo"),
	}).(*Person_Edit_Response)

	if editResponse.Err != "" {
		t.Fatal(editResponse.Err)
	}

	if editResponse.Op != nil {
		t.Fatal("expected nil op")
	}

	if editResponse.State != 2 {
		t.Fatalf("expected state 2, got %d", editResponse.State)
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
