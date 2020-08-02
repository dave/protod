package main

import (
	"context"
	"testing"

	"github.com/dave/protod/delta/tests"
)

func TestServer(t *testing.T) {
	document := &tests.Person{
		Name: "dave",
	}
	app := &App{Server: New(context.Background())}
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
		Id:       uniqueID(),
		Document: id,
		State:    1,
		Op:       tests.Op().Person().Name().Edit("dave", "dave foo"),
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
