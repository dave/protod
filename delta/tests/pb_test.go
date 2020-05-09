package tests

import (
	"testing"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/tests/tests_defs"
)

// https://github.com/yoheimuta/go-protoparser

func TestPb(t *testing.T) {

	person := &Person{
		Name:    "dave",
		Company: &Company{Name: "cambro"},
		Cases: []*Case{
			{Name: "foo"},
			{Name: "bar"},
			{Name: "baz"},
		},
	}

	delta.Apply(delta.EditValue("spotify", tests_defs.Person().Company().Name()), person)

	if person.Company.Name != "spotify" {
		t.Fail()
	}

	delta.Apply(delta.EditValue(&Company{Name: "spacex"}, tests_defs.Person().Company()), person)

	if person.Company.Name != "spacex" {
		t.Fail()
	}

	delta.Apply(delta.EditValue(&Case{Name: "qux"}, tests_defs.Person().Cases().Index(1)), person)

	if person.Cases[1].Name != "qux" {
		t.Fail()
	}

	delta.Apply(delta.EditValue("qaz", tests_defs.Person().Cases().Index(2).Name()), person)

	if person.Cases[2].Name != "qaz" {
		t.Fail()
	}
}
