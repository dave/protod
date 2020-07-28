package main

import (
	"testing"

	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
)

func TestGae(t *testing.T) {

	if SKIP_GAE {
		return
	}

	document := &tests.Person{Name: "dave"}
	prefix := "https://pserver-testing.nw.r.appspot.com"
	id := uniqueID()

	addResponse := req(prefix, &Person_Add_Response{}, &Person_Add_Request{
		Id:     id,
		Person: document,
	}).(*Person_Add_Response)

	if addResponse.Err != "" {
		t.Fatal(addResponse.Err)
	}

	getResponse := req(prefix, &Person_Get_Response{}, &Person_Get_Request{
		Id: id,
	}).(*Person_Get_Response)

	if getResponse.Err != "" {
		t.Fatal(getResponse.Err)
	}

	if getResponse.Person.Name != "dave" {
		t.Fatal("document not received correctly in get")
	}

	editResponse := req(prefix, &Person_Edit_Response{}, &Person_Edit_Request{
		Payload: &pserver.Payload_Request{
			Id:       uniqueID(),
			Document: id,
			State:    1,
			Op:       tests.Op().Person().Name().Edit("dave", "dave foo"),
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
