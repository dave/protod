package pdelta_tests

import (
	"io/ioutil"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"google.golang.org/protobuf/encoding/protojson"
)

func TestMultiReduceCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../assets/cases_multi_reduce_manual.json")
	if err != nil {
		t.Fatal(err)
	}
	caseStrings := strings.Split(string(casesBytes), "\n")
	for _, caseString := range caseStrings {
		caseString = strings.TrimPrefix(caseString, "[")
		caseString = strings.TrimSuffix(caseString, "]")
		caseString = strings.TrimSuffix(caseString, ",")
		var tc ReduceTestCase
		if err := protojson.Unmarshal([]byte(caseString), &tc); err != nil {
			t.Fatal(err)
		}
		runReduceCase(t, &tc)
	}
}

func TestMultiReduce(t *testing.T) {

	const write = false

	items := []*ReduceTestCase{
		{
			// Three sets of the same field merge to a single set.
			Name: "SET_SET_SET",
			Op: pdelta.Compound(
				Op().Person().Name().Set("x"),
				Op().Person().Name().Set("y"),
				Op().Person().Name().Set("z"),
			),
			Reduced: Op().Person().Name().Set("z"),
			Data:    &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			// The two moves act on the same value (after the first move, "b" is at index 2), so they merge to a
			// single move, transposed past the unrelated set.
			Name: "MOVE_SET_MOVE",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(1, 3),
				Op().Person().Name().Set("x"),
				Op().Person().Alias().Move(2, 0),
			),
			Reduced: pdelta.Compound(
				Op().Person().Name().Set("x"),
				Op().Person().Alias().Move(1, 0),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			// The set is overwritten by the second set after a move shifts its index: after MOVE(0, 2) the value
			// set at index 0 is at index 1, so the second set overwrites it and the first set can be dropped.
			Name: "SET_MOVE_SET",
			Op: pdelta.Compound(
				Op().Person().Alias().Index(0).Set("x"),
				Op().Person().Alias().Move(0, 2),
				Op().Person().Alias().Index(1).Set("y"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(0, 2),
				Op().Person().Alias().Index(1).Set("y"),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			// The insert and the move of the inserted value merge to a single insert at the move destination. The
			// edit of the inserted value is not merged into the insert (see INSERT_EDIT_BUG in
			// reduce_manual_test.go) but its index follows the inserted value.
			Name: "INSERT_MOVE_EDIT",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(1, "foo"),
				Op().Person().Alias().Move(1, 4),
				Op().Person().Alias().Index(3).Edit("foo", "bar"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Insert(3, "foo"),
				Op().Person().Alias().Index(3).Edit("foo", "bar"),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			// A delete cancels the whole chain of operations on the deleted value, leaving only the unrelated set.
			Name: "SET_EDIT_SET_DELETE",
			Op: pdelta.Compound(
				Op().Person().Embedded().Name().Set("x"),
				Op().Person().Name().Set("y"),
				Op().Person().Embedded().Name().Edit("x", "z"),
				Op().Person().Embedded().Delete(),
			),
			Reduced: pdelta.Compound(
				Op().Person().Name().Set("y"),
				Op().Person().Embedded().Delete(),
			),
			Data: &Person{Name: "a", Embedded: &Person_Embed{Name: "e"}},
		},
		{
			// Two moves that exactly cancel, with an unrelated set in between: everything except the set is
			// removed.
			Name: "MOVE_SET_MOVE_CANCEL",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(0, 2),
				Op().Person().Name().Set("x"),
				Op().Person().Alias().Move(1, 0),
			),
			Reduced: Op().Person().Name().Set("x"),
			Data:    &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
	}
	var solo bool
	for _, item := range items {
		if item.Solo {
			solo = true
			break
		}
	}
	var sbj strings.Builder
	sbj.WriteString("[")
	for i, item := range items {
		if solo && !item.Solo {
			continue
		}

		b, err := protojson.Marshal(item)
		if err != nil {
			t.Fatal(err)
		}
		if i > 0 {
			sbj.WriteString(",\n")
		}
		sbj.Write(b)

		runReduceCase(t, item)

	}
	if solo {
		t.Fatal("solo")
	}
	sbj.WriteString("]")
	if write {
		if err := ioutil.WriteFile("../../assets/cases_multi_reduce_manual.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}
