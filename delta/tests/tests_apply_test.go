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

func TestApply(t *testing.T) {

	type itemType struct {
		solo     bool
		name     string
		op       *delta.Op
		data     proto.Message
		expected proto.Message
	}
	items := []itemType{
		{
			name:     "list_enum_set",
			op:       Op().Person().TypeList().Set([]Person_Type{Person_Charlie, Person_Alpha}),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "a", TypeList: []Person_Type{Person_Charlie, Person_Alpha}},
		},
		{
			name:     "map_enum_set",
			op:       Op().Person().TypeMap().Set(map[string]Person_Type{"b": Person_Charlie}),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "a", TypeMap: map[string]Person_Type{"b": Person_Charlie}},
		},
		{
			name:     "key_missing_map_value",
			op:       Op().Person().Cases().Key("b").Name().Set("c"),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "a", Cases: map[string]*Case{"b": {Name: "c"}}},
		},
		{
			name:     "insert_out_of_range",
			op:       Op().Person().Alias().Insert(10, "b"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"a", "b"}},
		},
		{
			name:     "oneof_delete_choice",
			op:       Op().Chooser().Choice().Delete(),
			data:     &Chooser{Choice: &Chooser_Itm{Itm: &Item{Flags: []string{"a"}}}},
			expected: &Chooser{},
		},
		{
			name:     "oneof_delete_itm",
			op:       Op().Chooser().Choice().Itm().Delete(),
			data:     &Chooser{Choice: &Chooser_Itm{Itm: &Item{Flags: []string{"a"}}}},
			expected: &Chooser{},
		},
		{
			name:     "oneof_delete_flags",
			op:       Op().Chooser().Choice().Itm().Flags().Delete(),
			data:     &Chooser{Choice: &Chooser_Itm{Itm: &Item{Flags: []string{"a"}}}},
			expected: &Chooser{Choice: &Chooser_Itm{Itm: &Item{}}},
		},
		{
			name:     "oneof_set_inner",
			op:       Op().Chooser().Choice().Itm().Flags().Insert(0, "a"),
			data:     &Chooser{Choice: &Chooser_Dbl{Dbl: 1.1}},
			expected: &Chooser{Choice: &Chooser_Itm{Itm: &Item{Flags: []string{"a"}}}},
		},
		{
			name:     "oneof_edit",
			op:       Op().Chooser().Choice().Str().Edit("", "a"),
			data:     &Chooser{Choice: &Chooser_Dbl{Dbl: 1.1}},
			expected: &Chooser{Choice: &Chooser_Str{Str: "a"}},
		},
		{
			name:     "oneof_set_overwrite",
			op:       Op().Chooser().Choice().Dbl().Set(1.1),
			data:     &Chooser{Choice: &Chooser_Str{Str: "a"}},
			expected: &Chooser{Choice: &Chooser_Dbl{Dbl: 1.1}},
		},
		{

			name:     "oneof_set_dbl",
			op:       Op().Chooser().Choice().Dbl().Set(2),
			data:     &Chooser{},
			expected: &Chooser{Choice: &Chooser_Dbl{Dbl: 2}},
		},
		{

			name:     "oneof_set_str",
			op:       Op().Chooser().Choice().Str().Set("a"),
			data:     &Chooser{},
			expected: &Chooser{Choice: &Chooser_Str{Str: "a"}},
		},
		{
			name:     "replace_message_with_enum",
			op:       Op().Company().Ceo().Set(&Person{Name: "a", TypeList: []Person_Type{Person_Bravo}}),
			data:     &Company{Name: "a"},
			expected: &Company{Name: "a", Ceo: &Person{Name: "a", TypeList: []Person_Type{Person_Bravo}}},
		},
		{
			name:     "insert_map_enum",
			op:       Op().Person().TypeMap().Key("b").Set(Person_Charlie),
			data:     &Person{Name: "a", TypeMap: map[string]Person_Type{"a": Person_Alpha, "b": Person_Bravo}},
			expected: &Person{Name: "a", TypeMap: map[string]Person_Type{"a": Person_Alpha, "b": Person_Charlie}},
		},
		{
			name:     "insert_list_enum",
			op:       Op().Person().TypeList().Insert(0, Person_Bravo),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "a", TypeList: []Person_Type{Person_Bravo}},
		},
		{
			name:     "replace_enum",
			op:       Op().Person().Type().Set(Person_Alpha),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "a", Type: Person_Alpha},
		},
		{
			name:     "delete_root",
			op:       Op().Person().Delete(),
			data:     &Person{Name: "a"},
			expected: &Person{},
		},
		{
			name:     "replace_root",
			op:       Op().Person().Set(&Person{Name: "x"}),
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
			op:       Op().Company().Flags().Key(1).Set("a"),
			data:     &Company{Flags: map[int64]string{}},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "nil_map",
			op:       Op().Company().Flags().Key(1).Set("a"),
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
			op:       Op().Company().Flags().Key(10).Set("x"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b", 10: "x"}},
		},
		{
			name:     "insert_map_message",
			op:       Op().Person().Cases().Key("x").Set(&Case{Name: "x"}),
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
			op:       Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "a", "c", "d", "e"}},
		},
		{
			name:     "move_list_scalar_start_mid",
			op:       Op().Person().Alias().Move(0, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "a", "d", "e"}},
		},
		{
			name:     "move_list_scalar_start_end",
			op:       Op().Person().Alias().Move(0, 5),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "d", "e", "a"}},
		},
		{
			name:     "move_list_scalar_mid_next",
			op:       Op().Person().Alias().Move(2, 4),
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
			op:       Op().Person().Alias().Move(2, 5),
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
			op:       Op().Case().Items().Move(0, 3),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}, {Title: "a"}}},
		},
		{
			name:     "move_map_scalar",
			op:       Op().Company().Flags().Rename(2, 5),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 5: "b"}},
		},
		{
			name:     "move_map_message",
			op:       Op().Person().Cases().Rename("b", "c"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "c": {Name: "b"}}},
		},
		{
			name:     "replace_scalar",
			op:       Op().Person().Name().Set("john"),
			data:     &Person{Name: "dave"},
			expected: &Person{Name: "john"},
		},
		{
			name:     "replace_field_scalar",
			op:       Op().Person().Company().Name().Set("apple"),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace_field",
			op:       Op().Person().Company().Set(&Company{Name: "apple"}),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace_index_scalar",
			op:       Op().Person().Alias().Index(1).Set("alex"),
			data:     &Person{Alias: []string{"jim", "bob", "dave"}},
			expected: &Person{Alias: []string{"jim", "alex", "dave"}},
		},
		{
			name:     "replace_index_field",
			op:       Op().Case().Items().Index(1).Set(&Item{Title: "baz"}),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "foo"}, {Title: "baz"}}},
		},
		{
			name:     "replace_index_field_scalar",
			op:       Op().Case().Items().Index(0).Title().Set("baz"),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "baz"}, {Title: "bar"}}},
		},
		{
			name:     "replace_map_scalar",
			op:       Op().Company().Flags().Key(2).Set("qux"),
			data:     &Company{Flags: map[int64]string{1: "foo", 2: "bar", 3: "baz"}},
			expected: &Company{Flags: map[int64]string{1: "foo", 2: "qux", 3: "baz"}},
		},
		{
			name:     "replace_map_field",
			op:       Op().Person().Cases().Key("c").Set(&Case{Name: "foo"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "caseC"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "foo"}}},
		},
		{
			name:     "replace_map_field_scalar",
			op:       Op().Person().Cases().Key("a").Name().Set("foo"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "foo"}, "b": {Name: "caseB"}}},
		},
		{
			name:     "replace_replace_list_scalar",
			op:       Op().Person().Alias().Set([]string{"x", "y"}),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:     "replace_replace_list_message",
			op:       Op().Case().Items().Set([]*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}},
		},
		{
			name:     "replace_replace_map_message",
			op:       Op().Person().Cases().Set(map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}},
		},
		{
			name:     "replace_replace_map_scalar",
			op:       Op().Company().Flags().Set(map[int64]string{10: "x", 11: "y"}),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{10: "x", 11: "y"}},
		},
		{
			name:     "edit_lorem_ipsum",
			op:       Op().Person().Name().Edit("Lorem ipsum dolor.", "Lorem dolor sit amet."),
			data:     &Person{Name: "Lorem ipsum dolor."},
			expected: &Person{Name: "Lorem dolor sit amet."},
		},
		{
			name:     "edit_quick_brown_fox",
			op:       Op().Person().Name().Edit("the quick brown fox jumped over the lazy dog.", "the quick orange fox jumped over me."),
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
			var expectedAny *anypb.Any
			if item.expected != nil {
				expectedAny, err = ptypes.MarshalAny(proto1.MessageV1(item.expected))
				if err != nil {
					t.Fatal(err)
				}
			}
			tc := &ApplyTestCase{
				Solo:     item.solo,
				Name:     item.name,
				Op:       item.op,
				Data:     dataAny,
				Expected: expectedAny,
			}
			sb, err := protojson.Marshal(tc)
			if err != nil {
				t.Fatal(err)
			}
			cases += string(sb) + "\n"

			runApplyTest(t, tc)

		})
	}
	if OUTPUT_CASES {
		fmt.Println(cases)
	}
	if solo {
		t.Fatal("tests skipped")
	}
}

func TestApplyCases(t *testing.T) {
	caseStrings := strings.Split(applyCases, "\n")
	for _, caseString := range caseStrings {
		var tc ApplyTestCase
		if err := protojson.Unmarshal([]byte(caseString), &tc); err != nil {
			t.Fatal(err)
		}
		t.Run(tc.Name, func(t *testing.T) {
			runApplyTest(t, &tc)
		})
	}
}

func runApplyTest(t *testing.T, tc *ApplyTestCase) {

	data := mustUnmarshalAny(tc.Data)
	expected := mustUnmarshalAny(tc.Expected)

	if err := delta.Apply(tc.Op, data); err != nil {
		t.Fatal(err)
	}
	var resultBytes, expectedBytes []byte
	var err error
	if data != nil {
		resultBytes, err = protojson.Marshal(data)
		if err != nil {
			t.Fatal(err)
		}
	} else {
		resultBytes = []byte("nil")
	}
	if expected != nil {
		expectedBytes, err = protojson.Marshal(expected)
		if err != nil {
			t.Fatal(err)
		}
	} else {
		expectedBytes = []byte("nil")
	}
	if string(resultBytes) != string(expectedBytes) && !compareJson(string(resultBytes), string(expectedBytes)) {
		t.Fatalf("\nresult:   %s\nexpected: %s", string(resultBytes), string(expectedBytes))
	}
}
