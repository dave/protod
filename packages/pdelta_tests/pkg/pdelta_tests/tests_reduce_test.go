package pdelta_tests

import (
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
)

func TestReduce(t *testing.T) {
	type itemType struct {
		solo     bool
		name     string
		op       *pdelta.Op
		expected *pdelta.Op
	}
	items := []itemType{
		//{
		//	name: "SET_EDIT_CHILD_OBJECT",
		//	op: pdelta.Compound(
		//		Op().Person().Cases().Set(map[string]*Case{"a": {}}),
		//		Op().Person().Cases().Key("a").Name().Set("b"),
		//	),
		//	expected: Op().Person().Cases().Set(map[string]*Case{"a": {Name: "b"}}),
		//},
		{
			name: "SET_EDIT_CHILD_MESSAGE",
			op: pdelta.Compound(
				Op().Person().Company().Set(&Company{Name: "a"}),
				Op().Person().Company().Name().Set("b"),
			),
			expected: Op().Person().Company().Set(&Company{Name: "b"}),
		},
		{
			// EDIT A d1, EDIT A d2 => EDIT A d3 (use quill to merge d1 and d2)
			name: "EDIT_EDIT",
			op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Edit("a b", "a b c"),
			),
			expected: Op().Person().Name().Edit("a", "a b c"),
		},
		{
			// EDIT A, SET A => SET A
			name: "EDIT_SET",
			op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Set("c"),
			),
			expected: Op().Person().Name().Set("c"),
		},
		{
			// EDIT A, DELETE A => DELETE A
			name: "EDIT_DELETE",
			op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Delete(),
			),
			expected: Op().Person().Name().Delete(),
		},

		{
			// EDIT A, RENAME B to A => RENAME B to A
			name: "EDIT_RENAME",
			op: pdelta.Compound(
				Op().Company().Flags().Key(1).Edit("a", "a b"),
				Op().Company().Flags().Rename(2, 1),
			),
			expected: Op().Company().Flags().Rename(2, 1),
		},

		{
			// SET A v1, EDIT A d1 => SET A v2 (use quill to calculate v2)
			name: "SET_EDIT",
			op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Edit("a", "a b"),
			),
			expected: Op().Person().Name().Set("a b"),
		},

		{
			// SET A v1, SET A v2 => SET A v2
			name: "SET_SET",
			op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Set("b"),
			),
			expected: Op().Person().Name().Set("b"),
		},

		{
			// SET A, DELETE A => DELETE A
			name: "SET_DELETE",
			op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Delete(),
			),
			expected: Op().Person().Name().Delete(),
		},

		{
			// SET A, RENAME B to A => RENAME B to A
			name: "SET_RENAME",
			op: pdelta.Compound(
				Op().Company().Flags().Key(1).Set("a"),
				Op().Company().Flags().Rename(2, 1),
			),
			expected: Op().Company().Flags().Rename(2, 1),
		},

		{
			// INSERT A v1, SET A v2 => INSERT A v2
			name: "INSERT_SET",
			op: pdelta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Index(0).Set("b"),
			),
			expected: Op().Person().Alias().Insert(0, "b"),
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

			name: "INSERT_MOVE_FORWARD",
			op: pdelta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Move(0, 3),
			),
			expected: Op().Person().Alias().Insert(2, "a"),
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

			name: "INSERT_MOVE_BACK",
			op: pdelta.Compound(
				Op().Person().Alias().Insert(3, "a"),
				Op().Person().Alias().Move(3, 0),
			),
			expected: Op().Person().Alias().Insert(0, "a"),
		},

		// Removed, because the insert operation will create the parent if it doesn't already exist. The delete
		// operation will reverse the insert but not the creation of the parent.
		//{
		//	// INSERT A, DELETE A => null
		//	name: "INSERT_DELETE",
		//	op: pdelta.Compound(
		//		Op().Person().Alias().Insert(0, "a"),
		//		Op().Person().Alias().Index(0).Delete(),
		//	),
		//	expected: nil,
		//},

		{
			// MOVE A to B, MOVE B to A => null
			name: "MOVE_MOVE_FORWARD_BACK_NULL",

			// Two operations:
			// 0 1 2 3
			// x B C D
			// move(0, 3)
			// B C x D
			// move(2, 0)
			// x B C D

			op: pdelta.Compound(
				Op().Person().Alias().Move(0, 3),
				Op().Person().Alias().Move(2, 0),
			),
			expected: nil,
		},

		{
			// MOVE A to B, MOVE B to A => null
			name: "MOVE_MOVE_BACK_FORWARD_NULL",

			// Two operations:
			// 0 1 2 3
			// A B x D
			// move(2, 0)
			// x A B D
			// move(0, 3)
			// A B x D

			op: pdelta.Compound(
				Op().Person().Alias().Move(2, 0),
				Op().Person().Alias().Move(0, 3),
			),
			expected: nil,
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C
			name: "MOVE_MOVE_FORWARD_A",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(2, 5),
				Op().Person().Alias().Move(4, 1),
			),
			expected: Op().Person().Alias().Move(2, 1),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C
			name: "MOVE_MOVE_FORWARD_B",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(2, 5),
				Op().Person().Alias().Move(4, 3),
			),
			expected: Op().Person().Alias().Move(2, 4),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C
			name: "MOVE_MOVE_FORWARD_C",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(2, 5),
				Op().Person().Alias().Move(4, 6),
			),
			expected: Op().Person().Alias().Move(2, 6),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C
			name: "MOVE_MOVE_BACK_A",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(4, 2),
				Op().Person().Alias().Move(2, 1),
			),
			expected: Op().Person().Alias().Move(4, 1),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C
			name: "MOVE_MOVE_BACK_B",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(4, 2),
				Op().Person().Alias().Move(2, 4),
			),
			expected: Op().Person().Alias().Move(4, 3),
		},

		{
			// MOVE A to B, MOVE B to C => MOVE A to C
			name: "MOVE_MOVE_BACK_C",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(4, 2),
				Op().Person().Alias().Move(2, 6),
			),
			expected: Op().Person().Alias().Move(4, 6),
		},

		{
			// MOVE A to B, DELETE B => DELETE A
			name: "MOVE_FORWARD_DELETE",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(0, 3),
				Op().Person().Alias().Index(2).Delete(),
			),
			expected: Op().Person().Alias().Index(0).Delete(),
		},

		{
			// MOVE A to B, DELETE B => DELETE A
			name: "MOVE_BACK_DELETE",

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

			op: pdelta.Compound(
				Op().Person().Alias().Move(3, 1),
				Op().Person().Alias().Index(1).Delete(),
			),
			expected: Op().Person().Alias().Index(3).Delete(),
		},
	}
	var solo bool
	for _, item := range items {
		if item.solo {
			solo = true
			break
		}
	}
	for _, item := range items {
		if solo && !item.solo {
			continue
		}
		t.Run(item.name, func(t *testing.T) {
			result := pdelta.Reduce(item.op)
			if result == nil && item.expected == nil {
				return // ok
			}
			if !compareJson(mustJson(result), mustJson(item.expected)) {
				t.Fatalf("\nop:\n%s\nresult:\n%s\nexpect:\n%s\n", item.op.Debug(), result.Debug(), item.expected.Debug())
			}
		})
	}
}
