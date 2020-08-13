package main

import (
	"context"
	"testing"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pstore"
)

func TestServer(t *testing.T) {
	document := &tests.Person{
		Name: "dave",
	}
	app := &App{Server: New(context.Background(), PERSON, COMPANY)}
	defer app.Server.Close()

	state := int64(0)
	id := pstore.NewDocumentID()

	addResponse := app.ProcessMessage(context.Background(), &Person_Edit_Request{
		DocumentId: string(id),
		StateId:    string(pstore.NewStateID()),
		State:      state,
		Op:         delta.Root(document),
	}).(*Person_Edit_Response)

	if addResponse.Err != "" {
		t.Fatal(addResponse.Err)
	}
	state = addResponse.State

	getResponse := app.ProcessMessage(context.Background(), &Person_Get_Request{
		DocumentId: string(id),
	}).(*Person_Get_Response)

	if getResponse.Err != "" {
		t.Fatal(getResponse.Err)
	}

	if getResponse.Person.Name != "dave" {
		t.Fatal("document not received correctly in get")
	}

	state = getResponse.State

	editResponse := app.ProcessMessage(context.Background(), &Person_Edit_Request{
		StateId:    string(pstore.NewStateID()),
		DocumentId: string(id),
		State:      state,
		Op:         tests.Op().Person().Name().Edit("dave", "dave foo"),
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
