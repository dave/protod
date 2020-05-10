package tests

import (
	"fmt"
	"testing"

	"github.com/dave/protod/delta"
	"github.com/sergi/go-diff/diffmatchpatch"
)

func TestApplyMap(t *testing.T) {

	person := &Person{
		Name:    "dave",
		Company: &Company{Name: "cambro"},
		CasesStringMap: map[string]*Case{
			"foo": {Name: "foo"},
		},
	}

	if err := delta.Apply(delta.EditValue("bar", PersonDef().CasesStringMap().Key("foo").Name()), person); err != nil {
		t.Fail()
	}

	if person.CasesStringMap["foo"].Name != "bar" {
		t.Fail()
	}
}

func TestApply(t *testing.T) {

	person := &Person{
		Name:    "dave",
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

	if err := delta.Apply(delta.EditValue("spotify", PersonDef().Company().Name()), person); err != nil {
		t.Fail()
	}

	if person.Company.Name != "spotify" {
		t.Fail()
	}

	if err := delta.Apply(delta.EditValue(&Company{Name: "spacex"}, PersonDef().Company()), person); err != nil {
		t.Fail()
	}

	if person.Company.Name != "spacex" {
		t.Fail()
	}

	if err := delta.Apply(delta.EditValue(&Case{Name: "qux"}, PersonDef().Cases().Index(1)), person); err != nil {
		t.Fail()
	}

	if person.Cases[1].Name != "qux" {
		t.Fail()
	}

	if err := delta.Apply(delta.EditValue("qaz", PersonDef().Cases().Index(2).Name()), person); err != nil {
		t.Fail()
	}

	if person.Cases[2].Name != "qaz" {
		t.Fail()
	}

	if err := delta.Apply(delta.EditValue("xxx", PersonDef().CasesStringMap().Key("foo").Name()), person); err != nil {
		t.Fail()
	}

	if person.CasesStringMap["foo"].Name != "xxx" {
		t.Fail()
	}
}

func TestDiff(t *testing.T) {

	text1 := "the quick brown fox jumped over the lazy dog"
	text2 := "the quick brown bat jumped over the lazy dog"

	dmp := diffmatchpatch.New()

	diffs := dmp.DiffMain(text1, text2, false)
	dlt := dmp.DiffToDelta(diffs)

	for _, diff := range diffs {
		fmt.Printf("%d %q\n", diff.Type, diff.Text)
	}
	fmt.Printf("%q\n", dlt)

	diffs1, err := dmp.DiffFromDelta(text1, dlt)
	if err != nil {
		panic(err)
	}

	patches := dmp.PatchMake(text1, diffs1)

	text3, applied := dmp.PatchApply(patches, text1)

	fmt.Println(text3)

	fmt.Printf("%#v\n", applied)

}

func TestApplyDiff(t *testing.T) {

	from := "the quick brown fox jumped over the lazy dog"
	to := "the quick orange fox jumped over me"

	person := &Person{
		Name:    "dave",
		Company: &Company{Name: from},
	}

	dlt := delta.EditDiff(person.Company.Name, to, PersonDef().Company().Name())

	dltStr := delta.MustUnmarshalAny(dlt.Value).Message.(*delta.Scalar).V.(*delta.Scalar_Delta).Delta

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

	dlt := delta.EditDiff(person.Company.Name, to, PersonDef().Company().Name())

	dltStr := delta.MustUnmarshalAny(dlt.Value).Message.(*delta.Scalar).V.(*delta.Scalar_Delta).Delta

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
