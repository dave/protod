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
			name:     "edit_delta_edit_equal",
			op1:      Op().Company().Name().Edit("a", "x"),
			op2:      Op().Company().Name().Replace("y"),
			data:     &Company{Name: "a"},
			expected: &Company{Name: "y"},
		},
		{
			name:     "edit_delta_edit_independent",
			op1:      Op().Company().Name().Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Replace("y"),
			data:     &Company{Name: "a", Flags: map[int64]string{1: "b"}},
			expected: &Company{Name: "x", Flags: map[int64]string{1: "y"}},
		},
		{
			name:     "edit_edit_independent",
			op1:      Op().Company().Name().Replace("x"),
			op2:      Op().Company().Flags().Key(1).Replace("y"),
			data:     &Company{Name: "a", Flags: map[int64]string{1: "b"}},
			expected: &Company{Name: "x", Flags: map[int64]string{1: "y"}},
		},
		{
			name:     "edit_insert_key_ancestor",
			op1:      Op().Company().Replace(&Company{Flags: map[int64]string{10: "x"}}),
			op2:      Op().Company().Flags().Insert(2, "b"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{10: "x"}},
		},
		{
			name:     "edit_insert_key",
			op1:      Op().Company().Flags().Key(1).Replace("x"),
			op2:      Op().Company().Flags().Insert(2, "y"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "y"}},
		},
		{
			name:     "insert_key_edit_equal",
			op1:      Op().Company().Flags().Insert(1, "y"),
			op2:      Op().Company().Flags().Key(1).Replace("x"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{1: "y"}},
		},
		{
			name:     "edit_insert_key_equal",
			op1:      Op().Company().Flags().Key(1).Replace("x"),
			op2:      Op().Company().Flags().Insert(1, "y"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{1: "x"}},
		},
		{
			name:     "edit_insert_index_descendent",
			op1:      Op().Case().Items().Replace([]*Item{{Title: "x"}}),
			op2:      Op().Case().Items().Index(0).Flags().Insert(0, "a"),
			data:     &Case{Items: []*Item{{Title: "a"}}},
			expected: &Case{Items: []*Item{{Title: "x"}}},
		},
		{
			name:     "edit_insert_index_ancestor",
			op1:      Op().Case().Items().Replace([]*Item{{Title: "x"}}),
			op2:      Op().Case().Items().Insert(1, &Item{Title: "b"}),
			data:     &Case{Items: []*Item{{Title: "a"}}},
			expected: &Case{Items: []*Item{{Title: "x"}}},
		},
		{
			name:     "edit_insert_index_after",
			op1:      Op().Person().Alias().Index(0).Replace("x"),
			op2:      Op().Person().Alias().Insert(1, "c"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "c", "b"}},
		},
		{
			name:     "edit_insert_index_before",
			op1:      Op().Person().Alias().Index(1).Replace("x"),
			op2:      Op().Person().Alias().Insert(0, "c"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"c", "a", "x"}},
		},
		{
			name:     "edit_insert_index_equal",
			op1:      Op().Person().Alias().Index(0).Replace("x"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_insert_conflict",
			op1:      Op().Person().Alias().Index(0).Replace("x"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_insert",
			op1:      Op().Person().Alias().Replace([]string{"x"}),
			op2:      Op().Person().Alias().Insert(3, "d"),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"x"}},
		},
		{
			name:     "move_edit_1",
			op1:      Op().Person().Alias().Move(0, 2),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "move_edit_2",
			op1:      Op().Company().Flags().Move(2, 1),
			op2:      Op().Company().Flags().Key(1).Edit("a", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "b"}},
		},
		{
			name:     "chained_move_1",
			op1:      Op().Company().Flags().Move(1, 2),
			op2:      Op().Company().Flags().Move(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "chained_move_1a",
			op1:      Op().Company().Flags().Move(1, 2),
			op2:      Op().Company().Flags().Move(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "chained_move_2",
			op1:      Op().Company().Flags().Move(2, 3),
			op2:      Op().Company().Flags().Move(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "chained_move_3",
			op1:      Op().Company().Flags().Move(2, 1),
			op2:      Op().Company().Flags().Move(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{}},
		},
		{
			name:     "conflicting_map_move_and_edit",
			op1:      Op().Company().Flags().Move(2, 3),
			op2:      Op().Company().Flags().Key(2).Edit("b", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:     "conflicting_map_insert_and_delete_1",
			op1:      Op().Company().Flags().Key(3).Delete(),
			op2:      Op().Company().Flags().Insert(3, "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b"}},
		},
		{
			name:     "conflicting_map_insert_and_delete_2",
			op1:      Op().Company().Flags().Insert(3, "c"),
			op2:      Op().Company().Flags().Key(3).Delete(),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
		},
		{
			name:     "conflicting_deletes",
			op1:      Op().Person().Alias().Index(0).Delete(),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "two_deletes",
			op1:      Op().Person().Alias().Index(0).Delete(),
			op2:      Op().Person().Alias().Index(1).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"c"}},
		},
		{
			name:     "delete_move",
			op1:      Op().Person().Alias().Move(0, 1),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "conflicting_replace",
			op1:      Op().Person().Company().Replace(&Company{Name: "bar"}),
			op2:      Op().Person().Company().Replace(&Company{Name: "baz"}),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "operation_inside_replace_1",
			op1:      Op().Person().Company().Replace(&Company{Name: "bar"}),
			op2:      Op().Person().Company().Name().Replace("baz"),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "operation_inside_replace_2",
			op1:      Op().Person().Company().Name().Replace("baz"),
			op2:      Op().Person().Company().Replace(&Company{Name: "bar"}),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "conflicting_diffs",
			op1:      Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:      Op().Person().Name().Edit("foo bar", "foo bar qux"),
			data:     &Person{Name: "foo bar"},
			expected: &Person{Name: "foo bar baz qux"},
		},
		{
			name:     "transform_diffs",
			op1:      Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:      Op().Person().Name().Edit("foo bar", "foo qux bar"),
			data:     &Person{Name: "foo bar"},
			expected: &Person{Name: "foo qux bar baz"},
		},
		{
			name:     "move_then_edit_0_to_1",
			op1:      Op().Person().Alias().Move(0, 1),
			op2:      Op().Person().Alias().Index(0).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "x", "c", "d"}},
		},
		{
			name:     "move_then_edit_0_to_2",
			op1:      Op().Person().Alias().Move(0, 2),
			op2:      Op().Person().Alias().Index(0).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "x", "d"}},
		},
		{
			name:     "move_then_edit_0_to_3",
			op1:      Op().Person().Alias().Move(0, 3),
			op2:      Op().Person().Alias().Index(0).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d", "x"}},
		},
		{
			name:     "move_then_edit_3_to_0",
			op1:      Op().Person().Alias().Move(3, 0),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c"}},
		},
		{
			name:     "move_then_edit_3_to_1",
			op1:      Op().Person().Alias().Move(3, 1),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c"}},
		},
		{
			name:     "move_then_edit_3_to_2",
			op1:      Op().Person().Alias().Move(3, 2),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c"}},
		},
		{
			name:     "move_then_edit_3_to_3",
			op1:      Op().Person().Alias().Move(3, 3),
			op2:      Op().Person().Alias().Index(3).Replace("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x"}},
		},
		{
			name:     "identical_map_inserts",
			op1:      Op().Company().Flags().Insert(1, "a"),
			op2:      Op().Company().Flags().Insert(1, "b"),
			data:     &Company{},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "insert_delete",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"x"}},
		},
		{
			name:     "identical_list_inserts",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Insert(0, "y"),
			data:     &Person{},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:     "double_inserts",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Insert(1, "y"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "a", "y", "b"}},
		},
		{
			name:     "independent_inserts",
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
			if err := delta.Apply(item.op1, &data1); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op2x, &data1); err != nil {
				t.Fatal(err)
			}

			data2 := proto.Clone(item.data)
			if err := delta.Apply(item.op2, &data2); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op1x, &data2); err != nil {
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
			name:     "delete_root",
			op:       Op().Person().Delete(),
			data:     &Person{Name: "a"},
			expected: nil,
		},
		{
			name:     "replace_root",
			op:       Op().Person().Replace(&Person{Name: "x"}),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "x"},
		},
		{
			name:     "empty_list",
			op:       Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{}},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "nil_list",
			op:       Op().Person().Alias().Insert(0, "b"),
			data:     &Person{},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "empty_map",
			op:       Op().Company().Flags().Insert(1, "a"),
			data:     &Company{Flags: map[int64]string{}},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "nil_map",
			op:       Op().Company().Flags().Insert(1, "a"),
			data:     &Company{},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "insert_list_scalar_0",
			op:       Op().Person().Alias().Insert(0, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c", "d"}},
		},
		{
			name:     "insert_list_scalar_1",
			op:       Op().Person().Alias().Insert(1, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c", "d"}},
		},
		{
			name:     "insert_list_scalar_2",
			op:       Op().Person().Alias().Insert(2, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c", "d"}},
		},
		{
			name:     "insert_list_scalar_3",
			op:       Op().Person().Alias().Insert(3, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x", "d"}},
		},
		{
			name:     "insert_list_scalar_4",
			op:       Op().Person().Alias().Insert(4, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "d", "x"}},
		},
		{
			name:     "insert_list_message",
			op:       Op().Case().Items().Insert(0, &Item{Title: "x"}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "a"}, {Title: "b"}}},
		},
		{
			name:     "insert_map_scalar",
			op:       Op().Company().Flags().Insert(10, "x"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b", 10: "x"}},
		},
		{
			name:     "insert_map_message",
			op:       Op().Person().Cases().Insert("x", &Case{Name: "x"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}, "x": {Name: "x"}}},
		},
		{
			name:     "delete_scalar",
			op:       Op().Person().Name().Delete(),
			data:     &Person{Name: "foo"},
			expected: &Person{},
		},
		{
			name:     "delete_field_scalar",
			op:       Op().Person().Company().Name().Delete(),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{}},
		},
		{
			name:     "delete_message",
			op:       Op().Person().Company().Delete(),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{},
		},
		{
			name:     "delete_list_scalar_start",
			op:       Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d"}},
		},
		{
			name:     "delete_list_scalar_mid",
			op:       Op().Person().Alias().Index(2).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "d"}},
		},
		{
			name:     "delete_list_scalar_end",
			op:       Op().Person().Alias().Index(3).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c"}},
		},
		{
			name:     "delete_list_message",
			op:       Op().Case().Items().Index(0).Delete(),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}}},
		},
		{
			name:     "delete_map_scalar",
			op:       Op().Company().Flags().Key(2).Delete(),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:     "move_list_scalar_start_next",
			op:       Op().Person().Alias().Move(0, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "a", "c", "d", "e"}},
		},
		{
			name:     "move_list_scalar_start_mid",
			op:       Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "a", "d", "e"}},
		},
		{
			name:     "move_list_scalar_start_end",
			op:       Op().Person().Alias().Move(0, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "d", "e", "a"}},
		},
		{
			name:     "move_list_scalar_mid_next",
			op:       Op().Person().Alias().Move(2, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "c", "e"}},
		},
		{
			name:     "move_list_scalar_mid_prev",
			op:       Op().Person().Alias().Move(2, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "c", "b", "d", "e"}},
		},
		{
			name:     "move_list_scalar_mid_end",
			op:       Op().Person().Alias().Move(2, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "e", "c"}},
		},
		{
			name:     "move_list_scalar_mid_start",
			op:       Op().Person().Alias().Move(2, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"c", "a", "b", "d", "e"}},
		},
		{
			name:     "move_list_scalar_end_prev",
			op:       Op().Person().Alias().Move(4, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "c", "e", "d"}},
		},
		{
			name:     "move_list_scalar_end_mid",
			op:       Op().Person().Alias().Move(4, 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "e", "c", "d"}},
		},
		{
			name:     "move_list_scalar_end_start",
			op:       Op().Person().Alias().Move(4, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"e", "a", "b", "c", "d"}},
		},
		{
			name:     "move_list_message",
			op:       Op().Case().Items().Move(0, 2),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}, {Title: "a"}}},
		},
		{
			name:     "move_map_scalar",
			op:       Op().Company().Flags().Move(2, 5),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 5: "b"}},
		},
		{
			name:     "move_map_message",
			op:       Op().Person().Cases().Move("b", "c"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "c": {Name: "b"}}},
		},
		{
			name:     "replace_scalar",
			op:       Op().Person().Name().Replace("john"),
			data:     &Person{Name: "dave"},
			expected: &Person{Name: "john"},
		},
		{
			name:     "replace_field_scalar",
			op:       Op().Person().Company().Name().Replace("apple"),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace_field",
			op:       Op().Person().Company().Replace(&Company{Name: "apple"}),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace_index_scalar",
			op:       Op().Person().Alias().Index(1).Replace("alex"),
			data:     &Person{Alias: []string{"jim", "bob", "dave"}},
			expected: &Person{Alias: []string{"jim", "alex", "dave"}},
		},
		{
			name:     "replace_index_field",
			op:       Op().Case().Items().Index(1).Replace(&Item{Title: "baz"}),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "foo"}, {Title: "baz"}}},
		},
		{
			name:     "replace_index_field_scalar",
			op:       Op().Case().Items().Index(0).Title().Replace("baz"),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "baz"}, {Title: "bar"}}},
		},
		{
			name:     "replace_map_scalar",
			op:       Op().Company().Flags().Key(2).Replace("qux"),
			data:     &Company{Flags: map[int64]string{1: "foo", 2: "bar", 3: "baz"}},
			expected: &Company{Flags: map[int64]string{1: "foo", 2: "qux", 3: "baz"}},
		},
		{
			name:     "replace_map_field",
			op:       Op().Person().Cases().Key("c").Replace(&Case{Name: "foo"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "caseC"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "foo"}}},
		},
		{
			name:     "replace_map_field_scalar",
			op:       Op().Person().Cases().Key("a").Name().Replace("foo"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "foo"}, "b": {Name: "caseB"}}},
		},
		{
			name:     "replace_replace_list_scalar",
			op:       Op().Person().Alias().Replace([]string{"x", "y"}),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:     "replace_replace_list_message",
			op:       Op().Case().Items().Replace([]*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}},
		},
		{
			name:     "replace_replace_map_message",
			op:       Op().Person().Cases().Replace(map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}},
		},
		{
			name:     "replace_replace_map_scalar",
			op:       Op().Company().Flags().Replace(map[int64]string{10: "x", 11: "y"}),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{10: "x", 11: "y"}},
		},
		{
			name:     "edit_lorem_ipsum",
			op:       Op().Person().Name().Edit("Lorem ipsum dolor.", "Lorem dolor sit amet."),
			diff:     `{"ops":[{"retain":"6"},{"delete":"11"},{"insert":"dolor sit amet"},{"retain":"1"}]}`,
			data:     &Person{Name: "Lorem ipsum dolor."},
			expected: &Person{Name: "Lorem dolor sit amet."},
		},
		{
			name:     "edit_quick_brown_fox",
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
			if err := delta.Apply(item.op, &item.data); err != nil {
				t.Fatal(err)
			}
			var result, expected []byte
			var err error
			if item.data != nil {
				result, err = protojson.Marshal(item.data)
				if err != nil {
					t.Fatal(err)
				}
			} else {
				result = []byte("nil")
			}
			if item.expected != nil {
				expected, err = protojson.Marshal(item.expected)
				if err != nil {
					t.Fatal(err)
				}
			} else {
				expected = []byte("nil")
			}
			if string(result) != string(expected) && !compareJson(string(result), string(expected)) {
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
