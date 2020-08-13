package main

import (
	"testing"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pstore"
)

func TestGae(t *testing.T) {

	if SKIP_GAE {
		return
	}

	document := &tests.Person{Name: "dave"}
	prefix := "https://pserver-testing.nw.r.appspot.com"
	id := pstore.NewDocumentID()

	addResponse := req(prefix, &Person_Edit_Response{}, &Person_Edit_Request{
		DocumentId: string(id),
		StateId:    string(pstore.NewStateID()),
		State:      0,
		Op:         delta.Root(document),
	}).(*Person_Edit_Response)

	if addResponse.Err != "" {
		t.Fatal(addResponse.Err)
	}
	if addResponse.State != 1 {
		t.Fatal("unexpected state")
	}
	if addResponse.Op != nil {
		t.Fatal("unexpected op")
	}

	getResponse := req(prefix, &Person_Get_Response{}, &Person_Get_Request{
		DocumentId: string(id),
	}).(*Person_Get_Response)

	if getResponse.Err != "" {
		t.Fatal(getResponse.Err)
	}
	if getResponse.State != 1 {
		t.Fatal("unexpected state")
	}
	if getResponse.Person.Name != "dave" {
		t.Fatal("document not received correctly in get")
	}

	editResponse := req(prefix, &Person_Edit_Response{}, &Person_Edit_Request{
		StateId:    string(pstore.NewStateID()),
		DocumentId: string(id),
		State:      1,
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
