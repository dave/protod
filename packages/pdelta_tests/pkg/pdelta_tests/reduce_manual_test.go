package pdelta_tests

import (
	"io/ioutil"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"google.golang.org/protobuf/encoding/protojson"
)

func TestReduceCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../assets/cases_reduce_manual.json")
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

func TestReduce(t *testing.T) {

	const write = false

	items := []*ReduceTestCase{
		{
			Name: "SET_EDIT_CHILD_OBJECT",
			Op: pdelta.Compound(
				Op().Person().Cases().Set(map[string]*Case{"a": {}}),
				Op().Person().Cases().Key("a").Name().Set("b"),
			),
			Reduced: Op().Person().Cases().Set(map[string]*Case{"a": {Name: "b"}}),
		},
		{
			Name: "SET_EDIT_CHILD_MESSAGE",
			Op: pdelta.Compound(
				Op().Person().Company().Set(&Company{Name: "a"}),
				Op().Person().Company().Name().Set("b"),
			),
			Reduced: Op().Person().Company().Set(&Company{Name: "b"}),
		},
		{
			// EDIT A d1, EDIT A d2 => EDIT A d3 (use quill to merge d1 and d2)
			Name: "EDIT_EDIT",
			Op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Edit("a b", "a b c"),
			),
			Reduced: Op().Person().Name().Edit("a", "a b c"),
		},
		{
			// EDIT A, SET A => SET A
			Name: "EDIT_SET",
			Op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Set("c"),
			),
			Reduced: Op().Person().Name().Set("c"),
		},
		{
			// EDIT A, DELETE A => DELETE A
			Name: "EDIT_DELETE",
			Op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Delete(),
			),
			Reduced: Op().Person().Name().Delete(),
		},

		{
			// EDIT A, RENAME B to A => RENAME B to A
			Name: "EDIT_RENAME",
			Op: pdelta.Compound(
				Op().Company().Flags().Key(1).Edit("a", "a b"),
				Op().Company().Flags().Rename(2, 1),
			),
			Reduced: Op().Company().Flags().Rename(2, 1),
		},

		{
			// SET A v1, EDIT A d1 => SET A v2 (use quill to calculate v2)
			Name: "SET_EDIT",
			Op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Edit("a", "a b"),
			),
			Reduced: Op().Person().Name().Set("a b"),
		},

		{
			// SET A v1, SET A v2 => SET A v2
			Name: "SET_SET",
			Op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Set("b"),
			),
			Reduced: Op().Person().Name().Set("b"),
		},

		{
			// SET A, DELETE A => DELETE A
			Name: "SET_DELETE",
			Op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Delete(),
			),
			Reduced: Op().Person().Name().Delete(),
		},

		{
			// SET A, RENAME B to A => RENAME B to A
			Name: "SET_RENAME",
			Op: pdelta.Compound(
				Op().Company().Flags().Key(1).Set("a"),
				Op().Company().Flags().Rename(2, 1),
			),
			Reduced: Op().Company().Flags().Rename(2, 1),
		},

		{
			// INSERT A v1, SET A v2 => INSERT A v2
			Name: "INSERT_SET",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Index(0).Set("b"),
			),
			Reduced: Op().Person().Alias().Insert(0, "b"),
		},

		{
			// INSERT A, MOVE A to B => INSERT B

			// Two operations:
			// 0 1 2 3 4
			// A B C D
			// insert(0, "x")
			// x A B C D
			// move(0, 3)
			// A B x C D

			// Merged operation:
			// 0 1 2 3 4
			// A B C D
			// insert(2, "x")
			// A B x C D

			Name: "INSERT_MOVE_FORWARD",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Move(0, 3),
			),
			Reduced: Op().Person().Alias().Insert(2, "a"),
		},

		{
			// INSERT A, MOVE A to B => INSERT B

			// Two operations:
			// 0 1 2 3
			// A B C
			// insert(3, "x")
			// A B C x
			// move(3, 0)
			// x A B C

			// Merged operation:
			// 0 1 2 3
			// A B C
			// insert(0, "x")
			// x A B C

			Name: "INSERT_MOVE_BACK",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(3, "a"),
				Op().Person().Alias().Move(3, 0),
			),
			Reduced: Op().Person().Alias().Insert(0, "a"),
		},

		// Removed, because the insert operation will create the parent if it doesn't already exist. The delete
		// operation will reverse the insert but not the creation of the parent.
		//{
		//	// INSERT A, DELETE A => null
		//	Name: "INSERT_DELETE",
		//  Op: pdelta.Compound(
		//		Op().Person().Alias().Insert(0, "a"),
		//		Op().Person().Alias().Index(0).Delete(),
		//	),
		//	Reduced: nil,
		//},

		{
			// MOVE A to B, MOVE B to A => null

			// Two operations:
			// 0 1 2 3
			// x B C D
			// move(0, 3)
			// B C x D
			// move(2, 0)
			// x B C D

			Name: "MOVE_MOVE_FORWARD_BACK_NULL",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(0, 3),
				Op().Person().Alias().Move(2, 0),
			),
			Reduced: nil,
		},

		{
			// MOVE A to B, MOVE B to A => null

			// Two operations:
			// 0 1 2 3
			// A B x D
			// move(2, 0)
			// x A B D
			// move(0, 3)
			// A B x D

			Name: "MOVE_MOVE_BACK_FORWARD_NULL",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(2, 0),
				Op().Person().Alias().Move(0, 3),
			),
			Reduced: nil,
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C

			// Two operations:
			// 0 1 2 3 4 5 6 7
			// A B x D E F G H
			// move(2, 5)
			// A B D E x F G H
			// move(4, 1)
			// A x B D E F G H

			// Merged operation:
			// 0 1 2 3 4 5 6 7
			// A B x D E F G H
			// move(2, 1)
			// A x B D E F G H

			Name: "MOVE_MOVE_FORWARD_A",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(2, 5),
				Op().Person().Alias().Move(4, 1),
			),
			Reduced: Op().Person().Alias().Move(2, 1),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C

			// Two operations:
			// 0 1 2 3 4 5 6
			// A B x D E F G
			// move(2, 5)
			// A B D E x F G
			// move(4, 3)
			// A B D x E F G

			// Merged operation:
			// 0 1 2 3 4 5 6
			// A B x D E F G
			// move(2, 4)
			// A B D x E F G

			Name: "MOVE_MOVE_FORWARD_B",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(2, 5),
				Op().Person().Alias().Move(4, 3),
			),
			Reduced: Op().Person().Alias().Move(2, 4),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C

			// Two operations:
			// 0 1 2 3 4 5 6
			// A B x D E F G
			// move(2, 5)
			// A B D E x F G
			// move(4, 6)
			// A B D E F x G

			// Merged operation:
			// 0 1 2 3 4 5 6
			// A B x D E F G
			// move(2, 6)
			// A B D E F x G

			Name: "MOVE_MOVE_FORWARD_C",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(2, 5),
				Op().Person().Alias().Move(4, 6),
			),
			Reduced: Op().Person().Alias().Move(2, 6),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C

			// Two operations:
			// 0 1 2 3 4 5 6
			// A B C D x F G
			// move(4, 2)
			// A B x C D F G
			// move(2, 1)
			// A x B C D F G

			// Merged operation:
			// 0 1 2 3 4 5 6
			// A B C D x F G
			// move(4, 1)
			// A x B C D F G

			Name: "MOVE_MOVE_BACK_A",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(4, 2),
				Op().Person().Alias().Move(2, 1),
			),
			Reduced: Op().Person().Alias().Move(4, 1),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C

			// Two operations:
			// 0 1 2 3 4 5 6
			// A B C D x F G
			// move(4, 2)
			// A B x C D F G
			// move(2, 4)
			// A B C x D F G

			// Merged operation:
			// 0 1 2 3 4 5 6
			// A B C D x F G
			// move(4, 3)
			// A B C x D F G

			Name: "MOVE_MOVE_BACK_B",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(4, 2),
				Op().Person().Alias().Move(2, 4),
			),
			Reduced: Op().Person().Alias().Move(4, 3),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C

			// Two operations:
			// 0 1 2 3 4 5 6
			// A B C D x F G
			// move(4, 2)
			// A B x C D F G
			// move(2, 6)
			// A B C D F x G

			// Merged operation:
			// 0 1 2 3 4 5 6
			// A B C D x F G
			// move(4, 6)
			// A B C x D F G

			Name: "MOVE_MOVE_BACK_C",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(4, 2),
				Op().Person().Alias().Move(2, 6),
			),
			Reduced: Op().Person().Alias().Move(4, 6),
		},

		{
			// MOVE A to B, DELETE B => DELETE A

			// Two operations:
			// 0 1 2 3
			// x B C D
			// move(0, 3)
			// B C x D
			// delete(2)
			// B C D

			// Merged operation:
			// 0 1 2 3
			// x B C D
			// delete(0)
			// B C D

			Name: "MOVE_FORWARD_DELETE",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(0, 3),
				Op().Person().Alias().Index(2).Delete(),
			),
			Reduced: Op().Person().Alias().Index(0).Delete(),
		},

		{
			// MOVE A to B, DELETE B => DELETE A

			// Two operations:
			// 0 1 2 3
			// A B C x
			// move(3, 1)
			// A x B C
			// delete(1)
			// A B C

			// Merged operation:
			// 0 1 2 3
			// A B C x
			// delete(3)
			// A B C

			Name: "MOVE_BACK_DELETE",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(3, 1),
				Op().Person().Alias().Index(1).Delete(),
			),
			Reduced: Op().Person().Alias().Index(3).Delete(),
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
		if err := ioutil.WriteFile("../../assets/cases_reduce_manual.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}

func runReduceCase(t *testing.T, item *ReduceTestCase) {
	result := pdelta.Reduce(item.Op)
	if result == nil && item.Reduced == nil {
		return // ok
	}
	if !compareJson(mustJson(result), mustJson(item.Reduced)) {
		t.Fatalf("%s:\nop:\n%s\nresult:\n%s\nexpect:\n%s\n", item.Name, item.Op.Debug(), result.Debug(), item.Reduced.Debug())
	}
}
