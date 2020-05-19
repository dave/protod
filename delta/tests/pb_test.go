package tests

import (
	"testing"

	"github.com/dave/protod/delta"
)

func TestApplyMap(t *testing.T) {

	person := &Person{
		Name:    "dave",
		Company: &Company{Name: "cambro"},
		CasesStringMap: map[string]*Case{
			"foo": {Name: "foo"},
		},
	}

	if err := delta.Apply(delta.Edit("bar", PersonDef().CasesStringMap().Key("foo").Name()), person); err != nil {
		t.Fail()
	}

	if person.CasesStringMap["foo"].Name != "bar" {
		t.Fail()
	}
}

func TestApply(t *testing.T) {

	person := &Person{
		Name:    "dave",
		Age:     20,
		Company: &Company{Name: "cambro"},
		Cases: []*Case{
			{Name: "foo"},
			{Name: "bar"},
			{Name: "baz"},
		},
		CasesIntMap: map[int32]*Case{
			1:  {Name: "foo"},
			10: {Name: "bar"},
			11: {Name: "baz"},
		},
		CasesStringMap: map[string]*Case{
			"foo": {Name: "foo"},
			"bar": {Name: "bar"},
			"baz": {Name: "baz"},
		},
	}

	if err := delta.Apply(delta.Edit("spotify", PersonDef().Company().Name()), person); err != nil {
		t.Fail()
	}

	if person.Company.Name != "spotify" {
		t.Fail()
	}

	if err := delta.Apply(delta.Edit(&Company{Name: "spacex"}, PersonDef().Company()), person); err != nil {
		t.Fail()
	}

	if person.Company.Name != "spacex" {
		t.Fail()
	}

	if err := delta.Apply(delta.Edit(&Case{Name: "qux"}, PersonDef().Cases().Index(1)), person); err != nil {
		t.Fail()
	}

	if person.Cases[1].Name != "qux" {
		t.Fail()
	}

	if err := delta.Apply(delta.Edit("qaz", PersonDef().Cases().Index(2).Name()), person); err != nil {
		t.Fail()
	}

	if person.Cases[2].Name != "qaz" {
		t.Fail()
	}

	if err := delta.Apply(delta.Edit("xxx", PersonDef().CasesStringMap().Key("foo").Name()), person); err != nil {
		t.Fail()
	}

	if person.CasesStringMap["foo"].Name != "xxx" {
		t.Fail()
	}
}

func TestApplyDiff(t *testing.T) {

	from := "the quick brown fox jumped over the lazy dog"
	to := "the quick orange fox jumped over me"

	person := &Person{
		Name:    "dave",
		Company: &Company{Name: from},
	}

	dlt := delta.Diff(person.Company.Name, to, PersonDef().Company().Name())

	dltStr := delta.MustUnmarshalAny(dlt.Value).Message.(*delta.Scalar).V.(*delta.Scalar_Diff).Diff

	if dltStr != "=10\t-5\t+orange\t=17\t-12\t+me" {
		t.Fail()
	}

	if err := delta.Apply(dlt, person); err != nil {
		t.Fail()
	}

	if person.Company.Name != to {
		t.Fail()
	}

}

func TestApplyDiff1(t *testing.T) {

	from := "Lorem ipsum dolor."
	to := "Lorem dolor sit amet."

	person := &Person{
		Name:    "dave",
		Company: &Company{Name: from},
	}

	dlt := delta.Diff(person.Company.Name, to, PersonDef().Company().Name())

	dltStr := delta.MustUnmarshalAny(dlt.Value).Message.(*delta.Scalar).V.(*delta.Scalar_Diff).Diff

	if dltStr != "=6\t-11\t+dolor sit amet\t=1" {
		t.Fail()
	}

	if err := delta.Apply(dlt, person); err != nil {
		t.Fail()
	}

	if person.Company.Name != to {
		t.Fail()
	}

}
