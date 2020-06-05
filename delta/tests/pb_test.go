package tests

import (
	"encoding/json"
	"fmt"
	"reflect"
	"testing"

	"github.com/dave/protod/delta"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestTransform(t *testing.T) {
	type itemType struct {
		solo     bool
		name     string
		op1      *delta.Op
		op2      *delta.Op
		data     proto.Message
		expected proto.Message
	}
	items := []itemType{
		{
			name:     "move edit 1",
			op1:      Op().Person().Alias().Move(0, 2),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "move edit 2",
			op1:      Op().Company().Flags().Move(2, 1),
			op2:      Op().Company().Flags().Key(1).Edit("a", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "b"}},
		},
		{
			name:     "chained move 1",
			op1:      Op().Company().Flags().Move(1, 2),
			op2:      Op().Company().Flags().Move(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "chained move 1a",
			op1:      Op().Company().Flags().Move(1, 2),
			op2:      Op().Company().Flags().Move(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "chained move 2",
			op1:      Op().Company().Flags().Move(2, 3),
			op2:      Op().Company().Flags().Move(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "chained move 3",
			op1:      Op().Company().Flags().Move(2, 1),
			op2:      Op().Company().Flags().Move(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{}}, // TODO ??? ugh
		},
		{
			name:     "conflicting map move and edit",
			op1:      Op().Company().Flags().Move(2, 3),
			op2:      Op().Company().Flags().Key(2).Edit("b", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:     "conflicting map insert and delete 1",
			op1:      Op().Company().Flags().Key(3).Delete(),
			op2:      Op().Company().Flags().Insert(3, "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b"}},
		},
		{
			name:     "conflicting map insert and delete 2",
			op1:      Op().Company().Flags().Insert(3, "c"),
			op2:      Op().Company().Flags().Key(3).Delete(),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
		},
		{
			name:     "conflicting deletes",
			op1:      Op().Person().Alias().Index(0).Delete(),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "two deletes",
			op1:      Op().Person().Alias().Index(0).Delete(),
			op2:      Op().Person().Alias().Index(1).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"c"}},
		},
		{
			name:     "delete move",
			op1:      Op().Person().Alias().Move(0, 1),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "conflicting replace",
			op1:      Op().Person().Company().Replace(&Company{Name: "bar"}),
			op2:      Op().Person().Company().Replace(&Company{Name: "baz"}),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "operation inside replace 1",
			op1:      Op().Person().Company().Replace(&Company{Name: "bar"}),
			op2:      Op().Person().Company().Name().Replace("baz"),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "operation inside replace 2",
			op1:      Op().Person().Company().Name().Replace("baz"),
			op2:      Op().Person().Company().Replace(&Company{Name: "bar"}),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "conflicting diffs",
			op1:      Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:      Op().Person().Name().Edit("foo bar", "foo bar qux"),
			data:     &Person{Name: "foo bar"},
			expected: &Person{Name: "foo bar baz qux"},
		},
		{
			name:     "transform diffs",
			op1:      Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:      Op().Person().Name().Edit("foo bar", "foo qux bar"),
			data:     &Person{Name: "foo bar"},
			expected: &Person{Name: "foo qux bar baz"},
		},
		{
			name:     "move then edit 0 to 1",
			op1:      Op().Person().Alias().Move(0, 1),
			op2:      Op().Person().Alias().Index(0).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "x", "c", "d"}},
		},
		{
			name:     "move then edit 0 to 2",
			op1:      Op().Person().Alias().Move(0, 2),
			op2:      Op().Person().Alias().Index(0).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "x", "d"}},
		},
		{
			name:     "move then edit 0 to 3",
			op1:      Op().Person().Alias().Move(0, 3),
			op2:      Op().Person().Alias().Index(0).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d", "x"}},
		},
		{
			name:     "move then edit 3 to 0",
			op1:      Op().Person().Alias().Move(3, 0),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c"}},
		},
		{
			name:     "move then edit 3 to 1",
			op1:      Op().Person().Alias().Move(3, 1),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c"}},
		},
		{
			name:     "move then edit 3 to 2",
			op1:      Op().Person().Alias().Move(3, 2),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c"}},
		},
		{
			name:     "move then edit 3 to 3",
			op1:      Op().Person().Alias().Move(3, 3),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x"}},
		},
		{
			name:     "identical map inserts",
			op1:      Op().Company().Flags().Insert(1, "a"),
			op2:      Op().Company().Flags().Insert(1, "b"),
			data:     &Company{},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "insert delete",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"x"}},
		},
		{
			name:     "identical list inserts",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Insert(0, "y"),
			data:     &Person{},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:     "double inserts",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Insert(1, "y"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "a", "y", "b"}},
		},
		{
			//solo:     true,
			name:     "independent inserts",
			op1:      Op().Person().Company().Flags().Insert(1, "a"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{},
			expected: &Person{Company: &Company{Flags: map[int64]string{1: "a"}}, Alias: []string{"b"}},
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

			op1x, op2x, err := delta.Transform(item.op1, item.op2, true)
			if err != nil {
				t.Fatal(err)
			}

			data1 := proto.Clone(item.data)
			if err := delta.Apply(item.op1, data1); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op2x, data1); err != nil {
				t.Fatal(err)
			}

			data2 := proto.Clone(item.data)
			if err := delta.Apply(item.op2, data2); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op1x, data2); err != nil {
				t.Fatal(err)
			}

			result1, err := protojson.Marshal(data1)
			if err != nil {
				t.Fatal(err)
			}

			result2, err := protojson.Marshal(data2)
			if err != nil {
				t.Fatal(err)
			}

			input, err := protojson.Marshal(item.data)
			if err != nil {
				t.Fatal(err)
			}

			expected, err := protojson.Marshal(item.expected)
			if err != nil {
				t.Fatal(err)
			}

			if !compareJson(string(result1), string(expected)) || !compareJson(string(result2), string(expected)) {
				fmt.Println("op1", item.op1)
				fmt.Println("op2x", op2x)
				fmt.Println("op2", item.op2)
				fmt.Println("op1x", op1x)
				t.Fatalf("\ndata:     %s\nresult1:  %s\nresult2:  %s\nexpected: %s", string(input), string(result1), string(result2), string(expected))
			}
		})
	}
	if solo {
		t.Fatal("tests skipped")
	}
}

func TestApply(t *testing.T) {
	type itemType struct {
		solo     bool
		name     string
		op       *delta.Op
		diff     string
		data     proto.Message
		expected proto.Message
	}
	items := []itemType{
		{
			name:     "empty list",
			op:       Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{}},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "nil list",
			op:       Op().Person().Alias().Insert(0, "b"),
			data:     &Person{},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "empty map",
			op:       Op().Company().Flags().Insert(1, "a"),
			data:     &Company{Flags: map[int64]string{}},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "nil map",
			op:       Op().Company().Flags().Insert(1, "a"),
			data:     &Company{},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "insert: list scalar 0",
			op:       Op().Person().Alias().Insert(0, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c", "d"}},
		},
		{
			name:     "insert: list scalar 1",
			op:       Op().Person().Alias().Insert(1, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c", "d"}},
		},
		{
			name:     "insert: list scalar 2",
			op:       Op().Person().Alias().Insert(2, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c", "d"}},
		},
		{
			name:     "insert: list scalar 3",
			op:       Op().Person().Alias().Insert(3, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x", "d"}},
		},
		{
			name:     "insert: list scalar 4",
			op:       Op().Person().Alias().Insert(4, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "d", "x"}},
		},
		{
			name:     "insert: list message",
			op:       Op().Case().Items().Insert(0, &Item{Title: "x"}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "a"}, {Title: "b"}}},
		},
		{
			name:     "insert: map scalar",
			op:       Op().Company().Flags().Insert(10, "x"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b", 10: "x"}},
		},
		{
			name:     "insert: map message",
			op:       Op().Person().Cases().Insert("x", &Case{Name: "x"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}, "x": {Name: "x"}}},
		},
		{
			name:     "delete: scalar",
			op:       Op().Person().Name().Delete(),
			data:     &Person{Name: "foo"},
			expected: &Person{},
		},
		{
			name:     "delete: field scalar",
			op:       Op().Person().Company().Name().Delete(),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{}},
		},
		{
			name:     "delete: message",
			op:       Op().Person().Company().Delete(),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{},
		},
		{
			name:     "delete: list scalar start",
			op:       Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d"}},
		},
		{
			name:     "delete: list scalar mid",
			op:       Op().Person().Alias().Index(2).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "d"}},
		},
		{
			name:     "delete: list scalar end",
			op:       Op().Person().Alias().Index(3).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c"}},
		},
		{
			name:     "delete: list message",
			op:       Op().Case().Items().Index(0).Delete(),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}}},
		},
		{
			name:     "delete: map scalar",
			op:       Op().Company().Flags().Key(2).Delete(),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:     "move: list scalar start-next",
			op:       Op().Person().Alias().Move(0, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "a", "c", "d", "e"}},
		},
		{
			name:     "move: list scalar start-mid",
			op:       Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "a", "d", "e"}},
		},
		{
			name:     "move: list scalar start-end",
			op:       Op().Person().Alias().Move(0, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "d", "e", "a"}},
		},
		{
			name:     "move: list scalar mid-next",
			op:       Op().Person().Alias().Move(2, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "c", "e"}},
		},
		{
			name:     "move: list scalar mid-prev",
			op:       Op().Person().Alias().Move(2, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "c", "b", "d", "e"}},
		},
		{
			name:     "move: list scalar mid-end",
			op:       Op().Person().Alias().Move(2, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "e", "c"}},
		},
		{
			name:     "move: list scalar mid-start",
			op:       Op().Person().Alias().Move(2, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"c", "a", "b", "d", "e"}},
		},
		{
			name:     "move: list scalar end-prev",
			op:       Op().Person().Alias().Move(4, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "c", "e", "d"}},
		},
		{
			name:     "move: list scalar end-mid",
			op:       Op().Person().Alias().Move(4, 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "e", "c", "d"}},
		},
		{
			name:     "move: list scalar end-start",
			op:       Op().Person().Alias().Move(4, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"e", "a", "b", "c", "d"}},
		},
		{
			name:     "move: list message",
			op:       Op().Case().Items().Move(0, 2),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}, {Title: "a"}}},
		},
		{
			name:     "move: map scalar",
			op:       Op().Company().Flags().Move(2, 5),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 5: "b"}},
		},
		{
			name:     "move: map message",
			op:       Op().Person().Cases().Move("b", "c"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "c": {Name: "b"}}},
		},
		{
			name:     "replace: scalar",
			op:       Op().Person().Name().Replace("john"),
			data:     &Person{Name: "dave"},
			expected: &Person{Name: "john"},
		},
		{
			name:     "replace: field scalar",
			op:       Op().Person().Company().Name().Replace("apple"),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace: field",
			op:       Op().Person().Company().Replace(&Company{Name: "apple"}),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace: index scalar",
			op:       Op().Person().Alias().Index(1).Replace("alex"),
			data:     &Person{Alias: []string{"jim", "bob", "dave"}},
			expected: &Person{Alias: []string{"jim", "alex", "dave"}},
		},
		{
			name:     "replace: index field",
			op:       Op().Case().Items().Index(1).Replace(&Item{Title: "baz"}),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "foo"}, {Title: "baz"}}},
		},
		{
			name:     "replace: index field scalar",
			op:       Op().Case().Items().Index(0).Title().Replace("baz"),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "baz"}, {Title: "bar"}}},
		},
		{
			name:     "replace: map scalar",
			op:       Op().Company().Flags().Key(2).Replace("qux"),
			data:     &Company{Flags: map[int64]string{1: "foo", 2: "bar", 3: "baz"}},
			expected: &Company{Flags: map[int64]string{1: "foo", 2: "qux", 3: "baz"}},
		},
		{
			name:     "replace: map field",
			op:       Op().Person().Cases().Key("c").Replace(&Case{Name: "foo"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "caseC"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "foo"}}},
		},
		{
			name:     "replace: map field scalar",
			op:       Op().Person().Cases().Key("a").Name().Replace("foo"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "foo"}, "b": {Name: "caseB"}}},
		},
		{
			name:     "replace: replace list scalar",
			op:       Op().Person().Alias().Replace([]string{"x", "y"}),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:     "replace: replace list message",
			op:       Op().Case().Items().Replace([]*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}},
		},
		{
			name:     "replace: replace map message",
			op:       Op().Person().Cases().Replace(map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}},
		},
		{
			name:     "replace: replace map scalar",
			op:       Op().Company().Flags().Replace(map[int64]string{10: "x", 11: "y"}),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{10: "x", 11: "y"}},
		},
		{
			name:     "edit: lorem ipsum",
			op:       Op().Person().Name().Edit("Lorem ipsum dolor.", "Lorem dolor sit amet."),
			diff:     `{"ops":[{"retain":"6"},{"delete":"11"},{"insert":"dolor sit amet"},{"retain":"1"}]}`,
			data:     &Person{Name: "Lorem ipsum dolor."},
			expected: &Person{Name: "Lorem dolor sit amet."},
		},
		{
			name:     "edit: quick brown fox",
			op:       Op().Person().Name().Edit("the quick brown fox jumped over the lazy dog.", "the quick orange fox jumped over me."),
			diff:     `{"ops":[{"retain":"10"},{"delete":"5"},{"insert":"orange"},{"retain":"17"},{"delete":"12"},{"insert":"me"},{"retain":"1"}]}`,
			data:     &Person{Name: "the quick brown fox jumped over the lazy dog."},
			expected: &Person{Name: "the quick orange fox jumped over me."},
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
			if item.diff != "" {
				diff, err := protojson.Marshal(item.op.Value.(*delta.Op_Delta).Delta)
				if err != nil {
					t.Fatal(err)
				}
				if !compareJson(string(diff), item.diff) {
					t.Fatalf("\ndiff result:   %s\ndiff expected: %s", string(diff), item.diff)
				}
			}
			if err := delta.Apply(item.op, item.data); err != nil {
				t.Fatal(err)
			}
			result, err := protojson.Marshal(item.data)
			if err != nil {
				t.Fatal(err)
			}
			expected, err := protojson.Marshal(item.expected)
			if err != nil {
				t.Fatal(err)
			}
			if !compareJson(string(result), string(expected)) {
				t.Fatalf("\nresult:   %s\nexpected: %s", string(result), string(expected))
			}
		})
	}
	if solo {
		t.Fatal("tests skipped")
	}
}

func compareJson(s1, s2 string) bool {
	var i1, i2 interface{}
	if err := json.Unmarshal([]byte(s1), &i1); err != nil {
		return false
	}
	if err := json.Unmarshal([]byte(s2), &i2); err != nil {
		return false
	}
	return reflect.DeepEqual(i1, i2)
}
