package tests

import (
	"encoding/json"
	"reflect"
	"testing"

	"github.com/dave/protod/delta"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

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
			name:     "insert: list scalar 0",
			op:       delta.Insert(PersonDef().Alias().Index(0), "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c", "d"}},
		},
		{
			name:     "insert: list scalar 1",
			op:       delta.Insert(PersonDef().Alias().Index(1), "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c", "d"}},
		},
		{
			name:     "insert: list scalar 2",
			op:       delta.Insert(PersonDef().Alias().Index(2), "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c", "d"}},
		},
		{
			name:     "insert: list scalar 3",
			op:       delta.Insert(PersonDef().Alias().Index(3), "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x", "d"}},
		},
		{
			name:     "insert: list scalar 4",
			op:       delta.Insert(PersonDef().Alias().Index(4), "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "d", "x"}},
		},
		{
			name:     "insert: list message",
			op:       delta.Insert(CaseDef().Items().Index(0), &Item{Title: "x"}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "a"}, {Title: "b"}}},
		},
		{
			name:     "insert: map scalar",
			op:       delta.Insert(CompanyDef().Flags().Key(10), "x"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b", 10: "x"}},
		},
		{
			name:     "insert: map message",
			op:       delta.Insert(PersonDef().Cases().Key("x"), &Case{Name: "x"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}, "x": {Name: "x"}}},
		},
		{
			name:     "delete: scalar",
			op:       delta.Delete(PersonDef().Name()),
			data:     &Person{Name: "foo"},
			expected: &Person{},
		},
		{
			name:     "delete: field scalar",
			op:       delta.Delete(PersonDef().Company().Name()),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{}},
		},
		{
			name:     "delete: message",
			op:       delta.Delete(PersonDef().Company()),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{},
		},
		{
			name:     "delete: list scalar start",
			op:       delta.Delete(PersonDef().Alias().Index(0)),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d"}},
		},
		{
			name:     "delete: list scalar mid",
			op:       delta.Delete(PersonDef().Alias().Index(2)),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "d"}},
		},
		{
			name:     "delete: list scalar end",
			op:       delta.Delete(PersonDef().Alias().Index(3)),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c"}},
		},
		{
			name:     "delete: list message",
			op:       delta.Delete(CaseDef().Items().Index(0)),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}}},
		},
		{
			name:     "delete: map scalar",
			op:       delta.Delete(CompanyDef().Flags().Key(2)),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:     "move: list scalar start-next",
			op:       delta.Move(PersonDef().Alias().Index(0), 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "a", "c", "d", "e"}},
		},
		{
			name:     "move: list scalar start-mid",
			op:       delta.Move(PersonDef().Alias().Index(0), 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "a", "d", "e"}},
		},
		{
			name:     "move: list scalar start-end",
			op:       delta.Move(PersonDef().Alias().Index(0), 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "d", "e", "a"}},
		},
		{
			name:     "move: list scalar mid-next",
			op:       delta.Move(PersonDef().Alias().Index(2), 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "c", "e"}},
		},
		{
			name:     "move: list scalar mid-prev",
			op:       delta.Move(PersonDef().Alias().Index(2), 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "c", "b", "d", "e"}},
		},
		{
			name:     "move: list scalar mid-end",
			op:       delta.Move(PersonDef().Alias().Index(2), 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "e", "c"}},
		},
		{
			name:     "move: list scalar mid-start",
			op:       delta.Move(PersonDef().Alias().Index(2), 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"c", "a", "b", "d", "e"}},
		},
		{
			name:     "move: list scalar end-prev",
			op:       delta.Move(PersonDef().Alias().Index(4), 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "c", "e", "d"}},
		},
		{
			name:     "move: list scalar end-mid",
			op:       delta.Move(PersonDef().Alias().Index(4), 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "e", "c", "d"}},
		},
		{
			name:     "move: list scalar end-start",
			op:       delta.Move(PersonDef().Alias().Index(4), 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"e", "a", "b", "c", "d"}},
		},
		{
			name:     "move: list message",
			op:       delta.Move(CaseDef().Items().Index(0), 2),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}, {Title: "a"}}},
		},
		{
			name:     "move: map scalar",
			op:       delta.Move(CompanyDef().Flags().Key(2), 5),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 5: "b"}},
		},
		{
			name:     "move: map message",
			op:       delta.Move(PersonDef().Cases().Key("b"), "c"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "c": {Name: "b"}}},
		},
		{
			name:     "edit: scalar",
			op:       delta.Edit(PersonDef().Name(), "john"),
			data:     &Person{Name: "dave"},
			expected: &Person{Name: "john"},
		},
		{
			name:     "edit: field scalar",
			op:       delta.Edit(PersonDef().Company().Name(), "apple"),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "edit: field",
			op:       delta.Edit(PersonDef().Company(), &Company{Name: "apple"}),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "edit: index scalar",
			op:       delta.Edit(PersonDef().Alias().Index(1), "alex"),
			data:     &Person{Alias: []string{"jim", "bob", "dave"}},
			expected: &Person{Alias: []string{"jim", "alex", "dave"}},
		},
		{
			name:     "edit: index field",
			op:       delta.Edit(CaseDef().Items().Index(1), &Item{Title: "baz"}),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "foo"}, {Title: "baz"}}},
		},
		{
			name:     "edit: index field scalar",
			op:       delta.Edit(CaseDef().Items().Index(0).Title(), "baz"),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "baz"}, {Title: "bar"}}},
		},
		{
			name:     "edit: map scalar",
			op:       delta.Edit(CompanyDef().Flags().Key(2), "qux"),
			data:     &Company{Flags: map[int64]string{1: "foo", 2: "bar", 3: "baz"}},
			expected: &Company{Flags: map[int64]string{1: "foo", 2: "qux", 3: "baz"}},
		},
		{
			name:     "edit: map field",
			op:       delta.Edit(PersonDef().Cases().Key("c"), &Case{Name: "foo"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "caseC"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "foo"}}},
		},
		{
			name:     "edit: map field scalar",
			op:       delta.Edit(PersonDef().Cases().Key("a").Name(), "foo"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "foo"}, "b": {Name: "caseB"}}},
		},
		{
			name:     "edit: replace list scalar",
			op:       delta.Edit(PersonDef().Alias(), []string{"x", "y"}),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:     "edit: replace list message",
			op:       delta.Edit(CaseDef().Items(), []*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}},
		},
		{
			name:     "edit: replace map message",
			op:       delta.Edit(PersonDef().Cases(), map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}},
		},
		{
			name:     "edit: replace map scalar",
			op:       delta.Edit(CompanyDef().Flags(), map[int64]string{10: "x", 11: "y"}),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{10: "x", 11: "y"}},
		},
		{
			name:     "diff: lorem ipsum",
			op:       delta.Diff(PersonDef().Name(), "Lorem ipsum dolor.", "Lorem dolor sit amet."),
			diff:     `{"ops":[{"retain":"6"},{"delete":"11"},{"insert":"dolor sit amet"},{"retain":"1"}]}`,
			data:     &Person{Name: "Lorem ipsum dolor."},
			expected: &Person{Name: "Lorem dolor sit amet."},
		},
		{
			name:     "diff: quick brown fox",
			op:       delta.Diff(PersonDef().Name(), "the quick brown fox jumped over the lazy dog.", "the quick orange fox jumped over me."),
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
