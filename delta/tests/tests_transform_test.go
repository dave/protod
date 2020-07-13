package tests

import (
	"fmt"
	"strings"
	"testing"

	"github.com/dave/protod/delta"
	proto1 "github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/types/known/anypb"
)

func TestTransform(t *testing.T) {
	type itemType struct {
		solo      bool
		name      string
		op1       *delta.Op
		op2       *delta.Op
		data      proto.Message
		expected  proto.Message
		expected1 proto.Message
		expected2 proto.Message
	}
	items := []itemType{
		{
			name:     "renames_bug",
			op1:      Op().Person().Cases().Rename("a", "b"),
			op2:      Op().Person().Cases().Key("a").Flags().Rename(1, 3),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "b", Flags: map[int64]string{1: "c"}}}},
			expected: &Person{Cases: map[string]*Case{"b": {Name: "b", Flags: map[int64]string{3: "c"}}}},
		},
		{
			name:      "renames",
			op1:       Op().Person().Cases().Rename("a", "b"),
			op2:       Op().Person().Cases().Rename("a", "c"),
			data:      &Person{Cases: map[string]*Case{"a": {Name: "x"}}},
			expected1: &Person{Cases: map[string]*Case{"b": {Name: "x"}}},
			expected2: &Person{Cases: map[string]*Case{"c": {Name: "x"}}},
		},
		{
			name:     "delete_key_edit_inside",
			op1:      Op().Person().Cases().Key("b").Name().Edit("c", "d"),
			op2:      Op().Person().Cases().Key("b").Delete(),
			data:     &Person{Name: "a", Cases: map[string]*Case{"b": {Name: "c"}}},
			expected: &Person{Name: "a", Cases: map[string]*Case{}},
		},
		{
			name:     "index_shifter_ancestor",
			op1:      Op().Person().Cases().Key("a").Items().Index(1).Done().Set(true),
			op2:      Op().Person().Cases().Key("a").Items().Index(2).Delete(),
			data:     &Person{Cases: map[string]*Case{"a": {Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}}}},
			expected: &Person{Cases: map[string]*Case{"a": {Items: []*Item{{Title: "a"}, {Title: "b", Done: true}}}}},
		},
		{
			name: "compound",
			op1: delta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Index(0).Edit("a", "b"),
			),
			op2:       Op().Person().Alias().Insert(0, "c"),
			data:      &Person{},
			expected1: &Person{Alias: []string{"b", "c"}},
			expected2: &Person{Alias: []string{"c", "b"}},
		},
		{
			name: "compound_2",
			op1: delta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Index(0).Edit("a", "b"),
			),
			op2: delta.Compound(
				Op().Person().Alias().Insert(0, "c"),
				Op().Person().Alias().Index(0).Edit("c", "d"),
			),
			data:      &Person{},
			expected1: &Person{Alias: []string{"b", "d"}},
			expected2: &Person{Alias: []string{"d", "b"}},
		},
		{
			name: "compound_3",
			op1: delta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Index(0).Edit("a", "b"),
				Op().Person().Alias().Insert(0, "c"),
				Op().Person().Alias().Index(0).Edit("a", "d"),
			),
			op2:       Op().Person().Alias().Insert(0, "e"),
			data:      &Person{},
			expected1: &Person{Alias: []string{"d", "b", "e"}},
			expected2: &Person{Alias: []string{"e", "d", "b"}},
		},
		{
			name:      "oneof_insert_set",
			op1:       Op().Chooser().Choice().Itm().Flags().Insert(1, "b"),
			op2:       Op().Chooser().Choice().Dbl().Set(1),
			data:      &Chooser{Choice: &Chooser_Itm{Itm: &Item{Flags: []string{"a"}}}},
			expected1: &Chooser{Choice: &Chooser_Itm{Itm: &Item{Flags: []string{"b"}}}},
			expected2: &Chooser{Choice: &Chooser_Dbl{Dbl: 1}},
		},
		{
			name:     "set_inner_delete",
			op1:      Op().Person().Company().Flags().Key(2).Set("b"),
			op2:      Op().Person().Company().Delete(),
			data:     &Person{Name: "a", Company: &Company{Name: "a", Flags: map[int64]string{1: "a"}}},
			expected: &Person{Name: "a"},
		},
		{
			name:      "oneof_move_set",
			op1:       Op().Chooser().Choice().Itm().Flags().Move(0, 3),
			op2:       Op().Chooser().Choice().Dbl().Set(1),
			data:      &Chooser{Choice: &Chooser_Itm{Itm: &Item{Flags: []string{"a", "b", "c"}}}},
			expected1: &Chooser{Choice: &Chooser_Dbl{Dbl: 1}},
			expected2: &Chooser{Choice: &Chooser_Dbl{Dbl: 1}},
		},
		{
			name:      "oneof_set_inner_set",
			op1:       Op().Chooser().Choice().Itm().Title().Set("b"),
			op2:       Op().Chooser().Choice().Dbl().Set(1),
			data:      &Chooser{Choice: &Chooser_Itm{Itm: &Item{Title: "a", Done: true}}},
			expected1: &Chooser{Choice: &Chooser_Itm{Itm: &Item{Title: "b"}}}, // TODO is it OK to have Done disappear
			expected2: &Chooser{Choice: &Chooser_Dbl{Dbl: 1}},
		},
		{
			name:      "oneof_edit_set",
			op1:       Op().Chooser().Choice().Itm().Title().Edit("a", "b"),
			op2:       Op().Chooser().Choice().Dbl().Set(1),
			data:      &Chooser{Choice: &Chooser_Itm{Itm: &Item{Title: "a", Done: true}}},
			expected1: &Chooser{Choice: &Chooser_Dbl{Dbl: 1}},
			expected2: &Chooser{Choice: &Chooser_Dbl{Dbl: 1}},
		},
		{
			name:      "oneof_set_set",
			op1:       Op().Chooser().Choice().Dbl().Set(2),
			op2:       Op().Chooser().Choice().Str().Set("a"),
			data:      &Chooser{},
			expected1: &Chooser{Choice: &Chooser_Dbl{Dbl: 2}},
			expected2: &Chooser{Choice: &Chooser_Str{Str: "a"}},
		},
		{
			name:     "delete_all_insert",
			op1:      Op().Person().Alias().Insert(1, "b"),
			op2:      Op().Person().Alias().Delete(),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{},
		},
		{
			name:     "delete_field_delete_field_independent",
			op1:      Op().Person().Name().Delete(),
			op2:      Op().Person().Age().Delete(),
			data:     &Person{Name: "a", Age: 10, Alias: []string{"b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "delete_field_delete_field",
			op1:      Op().Person().Name().Delete(),
			op2:      Op().Person().Name().Delete(),
			data:     &Person{Name: "a", Age: 10, Alias: []string{"b", "c"}},
			expected: &Person{Age: 10, Alias: []string{"b", "c"}},
		},
		{
			name:     "move_move_not_bug",              // a b c d e f
			op1:      Op().Person().Alias().Move(2, 6), // a b d e f c
			op2:      Op().Person().Alias().Move(1, 3), // a c b d e f
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e", "f"}},
			expected: &Person{Alias: []string{"a", "b", "d", "e", "f", "c"}},
		},
		{
			name:     "move_index_insert_index_backward_4", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(4, "x"), // a b c d x
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "c", "x"}},
		},
		{
			name:     "move_index_insert_index_backward_3", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(3, "x"), // a b c x d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "c", "x"}},
		},
		{
			name:     "move_index_insert_index_backward_2", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(2, "x"), // a b x c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "x", "c"}},
		},
		{
			name:      "move_index_insert_index_backward_1", // a b c d
			op1:       Op().Person().Alias().Move(3, 1),     // a d b c
			op2:       Op().Person().Alias().Insert(1, "x"), // a x b c d
			data:      &Person{Alias: []string{"a", "b", "c", "d"}},
			expected1: &Person{Alias: []string{"a", "d", "x", "b", "c"}},
			expected2: &Person{Alias: []string{"a", "x", "d", "b", "c"}},
		},
		{
			name:     "move_index_insert_index_backward_0", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(0, "x"), // x a b c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "d", "b", "c"}},
		},
		{
			name:      "move_index_insert_index_forward_4",  // a b c d
			op1:       Op().Person().Alias().Move(1, 4),     // a c d b
			op2:       Op().Person().Alias().Insert(4, "x"), // a b c d x
			data:      &Person{Alias: []string{"a", "b", "c", "d"}},
			expected1: &Person{Alias: []string{"a", "c", "d", "b", "x"}},
			expected2: &Person{Alias: []string{"a", "c", "d", "x", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_3",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(3, "x"), // a b c x d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "c", "x", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_2",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(2, "x"), // a b x c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_1",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(1, "x"), // a x b c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_0",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(0, "x"), // x a b c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "c", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_to",         // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(3, "x"), // a b c x d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "c", "x", "d", "b"}},
		},
		{
			name:     "insert_index_move_index_from",
			op1:      Op().Person().Alias().Insert(1, "x"),
			op2:      Op().Person().Alias().Move(1, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "insert_index_move_index_independent_end_reverse",
			op1:      Op().Person().Alias().Insert(3, "x"),
			op2:      Op().Person().Alias().Move(2, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "c", "b", "x", "d"}},
		},
		{
			name:     "insert_index_move_index_independent_mid_reverse",
			op1:      Op().Person().Alias().Insert(2, "x"),
			op2:      Op().Person().Alias().Move(3, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "x", "c"}},
		},
		{
			name:     "insert_index_move_index_independent_before_reverse",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Move(2, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "c", "b", "d"}},
		},
		{
			name:      "insert_index_move_index_independent_end_forward", // a b c d
			op1:       Op().Person().Alias().Insert(3, "x"),              // a b c x d
			op2:       Op().Person().Alias().Move(1, 3),                  // a c b d
			data:      &Person{Alias: []string{"a", "b", "c", "d"}},
			expected1: &Person{Alias: []string{"a", "c", "x", "b", "d"}}, // a c b x d
			expected2: &Person{Alias: []string{"a", "c", "b", "x", "d"}}, // a c x b d
		},
		{
			name:     "insert_index_move_index_independent_mid_forward",
			op1:      Op().Person().Alias().Insert(2, "x"),
			op2:      Op().Person().Alias().Move(1, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "insert_index_move_index_independent_before_forward",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Move(1, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "c", "b", "d"}},
		},
		{
			name:     "insert_index_move_index_null",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Move(0, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c", "d"}},
		},
		{
			name:      "set_key_rename_key_to",
			op1:       Op().Company().Flags().Key(2).Set("x"),
			op2:       Op().Company().Flags().Rename(1, 2),
			data:      &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected1: &Company{Flags: map[int64]string{2: "x"}},
			expected2: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "set_key_rename_key_from",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Rename(1, 10),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{10: "x", 2: "b"}},
		},
		{
			name:     "set_key_rename_key_independent_ancestor",
			op1:      Op().Person().Cases().Key("a").Flags().Key(1).Set("x"),
			op2:      Op().Person().Cases().Rename("a", "y"),
			data:     &Person{Cases: map[string]*Case{"a": {Flags: map[int64]string{1: "a"}}}},
			expected: &Person{Cases: map[string]*Case{"y": {Flags: map[int64]string{1: "x"}}}},
		},
		{
			name:     "set_key_rename_key_independent",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Rename(2, 10),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 10: "b"}},
		},
		{
			name:     "set_key_rename_key_null",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Rename(1, 1),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "b"}},
		},
		{
			name:     "replace_index_move_index_independent",
			op1:      Op().Person().Alias().Index(1).Set("x"),
			op2:      Op().Person().Alias().Move(0, 3),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"x", "c", "a"}},
		},
		{
			name:     "replace_index_move_index_to",
			op1:      Op().Person().Alias().Index(1).Set("x"),
			op2:      Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "a"}},
		},
		{
			name:     "replace_index_move_index_from",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "replace_index_null_move_index_from",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Move(0, 1),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "b"}},
		},
		{
			name:      "replace_index_replace_index",
			op1:       Op().Person().Alias().Index(0).Set("x"),
			op2:       Op().Person().Alias().Index(0).Set("y"),
			data:      &Person{Alias: []string{"a", "b"}},
			expected1: &Person{Alias: []string{"x", "b"}},
			expected2: &Person{Alias: []string{"y", "b"}},
		},
		{
			name:      "replace_field_delete_field",
			op1:       Op().Company().Name().Set("b"),
			op2:       Op().Company().Name().Delete(),
			data:      &Company{Name: "a"},
			expected1: &Company{Name: "b"},
			expected2: &Company{},
		},
		{
			name:     "edit_key_delete_key",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Delete(),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "b"}},
		},
		{
			name:     "edit_key_move_key_null",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Rename(1, 1),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "b"}},
		},
		{
			name:     "edit_key_move_key_independent",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Rename(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 3: "b"}},
		},
		{
			name:     "edit_key_move_key_to",
			op1:      Op().Company().Flags().Key(2).Edit("b", "x"),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "edit_key_move_key_from",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "x"}},
		},
		{
			name:     "edit_key_insert_key",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "y", 2: "b"}},
		},
		{
			name:     "edit_key_replace_key_independent",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(2).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "y"}},
		},
		{
			name:     "edit_key_replace_key",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "y", 2: "b"}},
		},
		{
			name:     "edit_key_edit_key_independent",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(2).Edit("b", "y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "y"}},
		},
		{
			name:      "edit_key_edit_key",
			op1:       Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:       Op().Company().Flags().Key(1).Edit("a", "y"),
			data:      &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected1: &Company{Flags: map[int64]string{1: "xy", 2: "b"}},
			expected2: &Company{Flags: map[int64]string{1: "yx", 2: "b"}},
		},
		{
			name:     "edit_index_delete_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "edit_index_move_index_null",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Move(0, 0),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "b"}},
		},
		{
			name:     "edit_index_replace_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Index(0).Set("y"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"y", "b"}},
		},
		{
			name:     "edit_index_edit_index_independent",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Index(1).Edit("b", "y"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:      "edit_index_edit_index",
			op1:       Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:       Op().Person().Alias().Index(0).Edit("a", "y"),
			data:      &Person{Alias: []string{"a", "b"}},
			expected1: &Person{Alias: []string{"xy", "b"}},
			expected2: &Person{Alias: []string{"yx", "b"}},
		},
		{
			name:     "edit_field_delete_field",
			op1:      Op().Person().Name().Edit("a", "b"),
			op2:      Op().Person().Name().Delete(),
			data:     &Person{Name: "a"},
			expected: &Person{},
		},
		{
			name:     "edit_index_move_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_index_insert_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "b"),
			op2:      Op().Person().Alias().Insert(0, "x"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"x", "b"}},
		},
		{
			name:     "independent_operations_in_same_list",
			op1:      Op().Person().Alias().Move(4, 0),
			op2:      Op().Person().Alias().Move(1, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"e", "a", "c", "d", "b"}},
		},
		{
			name:     "ancestor_of_deleted_value",
			op1:      Op().Person().Cases().Key("a").Name().Set("x"),
			op2:      Op().Person().Cases().Rename("b", "a"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "b"}}},
		},
		{
			name:     "edit_delta_edit_equal",
			op1:      Op().Company().Name().Edit("a", "x"),
			op2:      Op().Company().Name().Set("y"),
			data:     &Company{Name: "a"},
			expected: &Company{Name: "y"},
		},
		{
			name:     "edit_delta_edit_independent",
			op1:      Op().Company().Name().Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Name: "a", Flags: map[int64]string{1: "b"}},
			expected: &Company{Name: "x", Flags: map[int64]string{1: "y"}},
		},
		{
			name:     "edit_edit_independent",
			op1:      Op().Company().Name().Set("x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Name: "a", Flags: map[int64]string{1: "b"}},
			expected: &Company{Name: "x", Flags: map[int64]string{1: "y"}},
		},
		{
			name:     "edit_insert_key_ancestor",
			op1:      Op().Company().Set(&Company{Flags: map[int64]string{10: "x"}}),
			op2:      Op().Company().Flags().Key(2).Set("b"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{10: "x"}},
		},
		{
			name:     "edit_insert_key",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Key(2).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "y"}},
		},
		{
			name:      "insert_key_edit_equal",
			op1:       Op().Company().Flags().Key(1).Set("y"),
			op2:       Op().Company().Flags().Key(1).Set("x"),
			data:      &Company{Flags: map[int64]string{1: "a"}},
			expected1: &Company{Flags: map[int64]string{1: "y"}},
			expected2: &Company{Flags: map[int64]string{1: "x"}},
		},
		{
			name:     "edit_insert_index_descendent",
			op1:      Op().Case().Items().Set([]*Item{{Title: "x"}}),
			op2:      Op().Case().Items().Index(0).Flags().Insert(0, "a"),
			data:     &Case{Items: []*Item{{Title: "a"}}},
			expected: &Case{Items: []*Item{{Title: "x"}}},
		},
		{
			name:     "edit_insert_index_ancestor",
			op1:      Op().Case().Items().Set([]*Item{{Title: "x"}}),
			op2:      Op().Case().Items().Insert(1, &Item{Title: "b"}),
			data:     &Case{Items: []*Item{{Title: "a"}}},
			expected: &Case{Items: []*Item{{Title: "x"}}},
		},
		{
			name:     "edit_insert_index_after",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Insert(1, "c"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "c", "b"}},
		},
		{
			name:     "edit_insert_index_before",
			op1:      Op().Person().Alias().Index(1).Set("x"),
			op2:      Op().Person().Alias().Insert(0, "c"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"c", "a", "x"}},
		},
		{
			name:     "edit_insert_index_equal",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_insert_conflict",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_insert",
			op1:      Op().Person().Alias().Set([]string{"x"}),
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
			op1:      Op().Company().Flags().Rename(2, 1),
			op2:      Op().Company().Flags().Key(1).Edit("a", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "b"}},
		},
		{
			name:     "chained_move_1",
			op1:      Op().Company().Flags().Rename(1, 2),
			op2:      Op().Company().Flags().Rename(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{3: "a"}},
		},
		{
			name:     "chained_move_1_reversed",
			op1:      Op().Company().Flags().Rename(2, 3),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{3: "a"}},
		},
		{
			name:     "chained_move_1a",
			op1:      Op().Company().Flags().Rename(1, 2),
			op2:      Op().Company().Flags().Rename(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{3: "a"}},
		},
		{
			name:     "chained_move_3",
			op1:      Op().Company().Flags().Rename(2, 1),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{}},
		},
		{
			name:     "conflicting_map_move_and_edit",
			op1:      Op().Company().Flags().Rename(2, 3),
			op2:      Op().Company().Flags().Key(2).Edit("b", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:      "conflicting_map_insert_and_delete_1",
			op1:       Op().Company().Flags().Key(3).Delete(),
			op2:       Op().Company().Flags().Key(3).Set("c"),
			data:      &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected1: &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected2: &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
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
			name:      "conflicting_replace",
			op1:       Op().Person().Company().Set(&Company{Name: "bar"}),
			op2:       Op().Person().Company().Set(&Company{Name: "baz"}),
			data:      &Person{Company: &Company{Name: "foo"}},
			expected1: &Person{Company: &Company{Name: "bar"}},
			expected2: &Person{Company: &Company{Name: "baz"}},
		},
		{
			name:     "operation_inside_replace_1",
			op1:      Op().Person().Company().Set(&Company{Name: "bar"}),
			op2:      Op().Person().Company().Name().Set("baz"),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "operation_inside_replace_2",
			op1:      Op().Person().Company().Name().Set("baz"),
			op2:      Op().Person().Company().Set(&Company{Name: "bar"}),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:      "conflicting_diffs",
			op1:       Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:       Op().Person().Name().Edit("foo bar", "foo bar qux"),
			data:      &Person{Name: "foo bar"},
			expected1: &Person{Name: "foo bar baz qux"},
			expected2: &Person{Name: "foo bar qux baz"},
		},
		{
			name:     "transform_diffs",
			op1:      Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:      Op().Person().Name().Edit("foo bar", "foo qux bar"),
			data:     &Person{Name: "foo bar"},
			expected: &Person{Name: "foo qux bar baz"},
		},
		{
			name:     "move_then_edit_0_to_0",
			op1:      Op().Person().Alias().Move(0, 0),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "b", "c", "d"}},
		},
		{
			name:     "move_then_edit_0_to_1",
			op1:      Op().Person().Alias().Move(0, 1),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "b", "c", "d"}},
		},
		{
			name:     "move_then_edit_0_to_2",
			op1:      Op().Person().Alias().Move(0, 2),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "x", "c", "d"}},
		},
		{
			name:     "move_then_edit_0_to_3",
			op1:      Op().Person().Alias().Move(0, 3),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "x", "d"}},
		},
		{
			name:     "move_then_edit_0_to_4",
			op1:      Op().Person().Alias().Move(0, 4),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d", "x"}},
		},
		{
			name:     "move_then_edit_3_to_0",
			op1:      Op().Person().Alias().Move(3, 0),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c"}},
		},
		{
			name:     "move_then_edit_3_to_1",
			op1:      Op().Person().Alias().Move(3, 1),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c"}},
		},
		{
			name:     "move_then_edit_3_to_2",
			op1:      Op().Person().Alias().Move(3, 2),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c"}},
		},
		{
			name:     "move_then_edit_3_to_3",
			op1:      Op().Person().Alias().Move(3, 3),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x"}},
		},
		{
			name:      "identical_map_inserts",
			op1:       Op().Company().Flags().Key(1).Set("a"),
			op2:       Op().Company().Flags().Key(1).Set("b"),
			data:      &Company{},
			expected1: &Company{Flags: map[int64]string{1: "a"}},
			expected2: &Company{Flags: map[int64]string{1: "b"}},
		},
		{
			name:     "insert_delete",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"x"}},
		},
		{
			name:      "identical_list_inserts",
			op1:       Op().Person().Alias().Insert(0, "x"),
			op2:       Op().Person().Alias().Insert(0, "y"),
			data:      &Person{},
			expected1: &Person{Alias: []string{"x", "y"}},
			expected2: &Person{Alias: []string{"y", "x"}},
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
			op1:      Op().Person().Company().Flags().Key(1).Set("a"),
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
	var cases string
	for _, item := range items {
		if solo && !item.solo {
			continue
		}
		t.Run(item.name, func(t *testing.T) {
			dataAny, err := ptypes.MarshalAny(proto1.MessageV1(item.data))
			if err != nil {
				t.Fatal(err)
			}
			var expectedAny, expected1Any, expected2Any *anypb.Any
			if item.expected != nil {
				expectedAny, err = ptypes.MarshalAny(proto1.MessageV1(item.expected))
				if err != nil {
					t.Fatal(err)
				}
			}
			if item.expected1 != nil {
				expected1Any, err = ptypes.MarshalAny(proto1.MessageV1(item.expected1))
				if err != nil {
					t.Fatal(err)
				}
			}
			if item.expected2 != nil {
				expected2Any, err = ptypes.MarshalAny(proto1.MessageV1(item.expected2))
				if err != nil {
					t.Fatal(err)
				}
			}
			tc := &TransformTestCase{
				Solo:      item.solo,
				Name:      item.name,
				Op1:       item.op1,
				Op2:       item.op2,
				Data:      dataAny,
				Expected:  expectedAny,
				Expected1: expected1Any,
				Expected2: expected2Any,
			}
			sb, err := protojson.Marshal(tc)
			if err != nil {
				t.Fatal(err)
			}
			cases += string(sb) + "\n"

			runTransformTest(t, tc)

		})
	}
	if OUTPUT_CASES {
		fmt.Println(cases)
	}
	if solo {
		t.Fatal("tests skipped")
	}
}

func TestTransformCases(t *testing.T) {
	caseStrings := strings.Split(transformCases, "\n")
	for _, caseString := range caseStrings {
		var tc TransformTestCase
		if err := protojson.Unmarshal([]byte(caseString), &tc); err != nil {
			t.Fatal(err)
		}
		t.Run(tc.Name, func(t *testing.T) {
			runTransformTest(t, &tc)
		})
	}
}

func runTransformTest(t *testing.T, tc *TransformTestCase) {

	// op1 has priority
	op1xp1, op2xp1, err := delta.Transform(tc.Op1, tc.Op2, true)
	if err != nil {
		t.Fatal(err)
	}

	// op2 has priority
	op1xp2, op2xp2, err := delta.Transform(tc.Op1, tc.Op2, false)
	if err != nil {
		t.Fatal(err)
	}

	data1p1 := mustUnmarshalAny(tc.Data)
	if err := delta.Apply(tc.Op1, data1p1); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(op2xp1, data1p1); err != nil {
		t.Fatal(err)
	}

	data2p1 := mustUnmarshalAny(tc.Data)
	if err := delta.Apply(tc.Op2, data2p1); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(op1xp1, data2p1); err != nil {
		t.Fatal(err)
	}

	data1p2 := mustUnmarshalAny(tc.Data)
	if err := delta.Apply(tc.Op1, data1p2); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(op2xp2, data1p2); err != nil {
		t.Fatal(err)
	}

	data2p2 := mustUnmarshalAny(tc.Data)
	if err := delta.Apply(tc.Op2, data2p2); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(op1xp2, data2p2); err != nil {
		t.Fatal(err)
	}

	result1p1, err := protojson.Marshal(data1p1)
	if err != nil {
		t.Fatal(err)
	}

	result1p2, err := protojson.Marshal(data1p2)
	if err != nil {
		t.Fatal(err)
	}

	result2p1, err := protojson.Marshal(data2p1)
	if err != nil {
		t.Fatal(err)
	}

	result2p2, err := protojson.Marshal(data2p2)
	if err != nil {
		t.Fatal(err)
	}

	input, err := protojson.Marshal(mustUnmarshalAny(tc.Data))
	if err != nil {
		t.Fatal(err)
	}

	expected := mustUnmarshalAny(tc.Expected)
	var expectedp1, expectedp2 []byte
	if expected != nil {
		expectedp1, err = protojson.Marshal(expected)
		if err != nil {
			t.Fatal(err)
		}
		expectedp2, err = protojson.Marshal(expected)
		if err != nil {
			t.Fatal(err)
		}
	} else {
		expectedp1, err = protojson.Marshal(mustUnmarshalAny(tc.Expected1))
		if err != nil {
			t.Fatal(err)
		}
		expectedp2, err = protojson.Marshal(mustUnmarshalAny(tc.Expected2))
		if err != nil {
			t.Fatal(err)
		}
	}

	if !compareJson(string(result1p1), string(expectedp1)) || !compareJson(string(result1p2), string(expectedp2)) || !compareJson(string(result2p1), string(expectedp1)) || !compareJson(string(result2p2), string(expectedp2)) {
		if expected != nil {
			t.Fatalf("\ndata:        %s\nresult1-p1:  %s\nresult2-p1:  %s\nresult1-p2:  %s\nresult2-p2:  %s\nexpected:    %s", string(input), string(result1p1), string(result2p1), string(result1p2), string(result2p2), string(expectedp1))
		} else {
			t.Fatalf("\ndata:        %s\nresult1-p1:  %s\nresult2-p1:  %s\nexpected-p1: %s\nresult1-p2:  %s\nresult2-p2:  %s\nexpected-p2: %s", string(input), string(result1p1), string(result2p1), string(expectedp1), string(result1p2), string(result2p2), string(expectedp2))
		}
	}
}
