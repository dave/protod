package pdelta_tests

import (
	"io/ioutil"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
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
			Name: "INSERT_MOVE_REDUCED",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(1, "foo"),
				Op().Person().Alias().Move(0, 2),
			),
			Reduced: Op().Person().Alias().Insert(0, "foo"),
			Data:    &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "MOVE_INSERT_BUG",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(1, 0),
				Op().Person().Alias().Insert(1, "foo"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Insert(0, "foo"),
				Op().Person().Alias().Move(2, 0),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "INSERT_MOVE_BUG",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(0, "foo"),
				Op().Person().Alias().Move(1, 3),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(1, 0),
				Op().Person().Alias().Insert(0, "foo"),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "EDIT_MOVE_BUG",
			Op: pdelta.Compound(
				Op().Person().Alias().Index(0).Edit("a", "foo"),
				Op().Person().Alias().Move(0, 2),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(0, 2),
				Op().Person().Alias().Index(1).Edit("a", "foo"),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "INSERT_INSERT_BUG",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(1, "foo"),
				Op().Person().Alias().Insert(2, "bar"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Insert(1, "bar"),
				Op().Person().Alias().Insert(1, "foo"),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "INSERT_EDIT_BUG",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(2, "foo"),
				Op().Person().Alias().Index(2).Edit("foo", "bar"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Insert(2, "foo"),
				Op().Person().Alias().Index(2).Edit("foo", "bar"),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "MOVE_MOVE_SAME_TO_NIL",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(3, 1),
				Op().Person().Alias().Move(2, 1),
			),
			Reduced: Op().Person().Alias().Move(3, 2),
			Data:    &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "MOVE_INSERT_AFTER",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(0, 2),
				Op().Person().Alias().Insert(2, "foo"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Insert(2, "foo"),
				Op().Person().Alias().Move(0, 2),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "INSERT_INSERT_EQUAL",
			Op: pdelta.Compound(
				Op().Person().TypeList().Insert(0, Person_Alpha),
				Op().Person().TypeList().Insert(0, Person_Bravo),
			),
			Reduced: pdelta.Compound(
				Op().Person().TypeList().Insert(0, Person_Bravo),
				Op().Person().TypeList().Insert(1, Person_Alpha),
			),
			Data: &Person{Name: "a", TypeList: []Person_Type{Person_Charlie}},
		},
		{
			Name: "SET_RENAME_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Set(&Case{Name: "a"}),
				Op().Person().Cases().Rename("a", "b"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Set(&Case{Name: "a"}),
				Op().Person().Cases().Rename("a", "b"),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{}},
		},
		{
			Name: "SET_RENAME_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Flags().Key(1).Set("c"),
				Op().Person().Cases().Rename("a", "b"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Flags().Key(1).Set("c"),
				Op().Person().Cases().Rename("a", "b"),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Name: "d"}}},
		},
		{
			Name: "MOVE_MOVE_SIBLINGS",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(0, 2),
				Op().Person().Alias().Move(2, 0),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(2, 0),
				Op().Person().Alias().Move(1, 3),
			),
			Data: &Person{Name: "a", Alias: []string{"a", "b", "c", "d"}},
		},
		{
			Name: "RENAME_RENAME_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Flags().Rename(1, 2),
				Op().Person().Cases().Rename("a", "b"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Flags().Rename(1, 2),
				Op().Person().Cases().Rename("a", "b"),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Flags: map[int64]string{1: "a"}}}},
		},
		{
			Name: "SET_SET_ONEOF",
			Op: pdelta.Compound(
				Op().Person().Choice().Str().Set("a"),
				Op().Person().Choice().Itm().Done().Set(true),
			),
			Reduced: pdelta.Compound(
				Op().Person().Choice().Str().Set("a"),
				Op().Person().Choice().Itm().Done().Set(true),
			),
			Data: &Person{Name: "a", Choice: &Person_Itm{Itm: &Item{Title: "b"}}},
		},

		{
			Name: "SET_RENAME_KEY",
			Op: pdelta.Compound(
				Op().Person().TypeMap().Key("b").Set(Person_Charlie),
				Op().Person().TypeMap().Rename("b", "c"),
			),
			Reduced: pdelta.Compound(
				Op().Person().TypeMap().Key("b").Set(Person_Charlie),
				Op().Person().TypeMap().Rename("b", "c"),
			),
			Data: &Person{Name: "a", TypeMap: map[string]Person_Type{"a": Person_Alpha, "b": Person_Bravo}},
		},
		{
			Name: "DELETE_INSERT",
			Op: pdelta.Compound(
				Op().Person().Delete(),
				Op().Person().Alias().Insert(0, "a"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Delete(),
				Op().Person().Alias().Insert(0, "a"),
			),
			Data: &Person{Name: "a"},
		},
		{
			Name: "RENAME_RENAME",
			Op: pdelta.Compound(
				Op().Person().TypeMap().Rename("a", "b"),
				Op().Person().TypeMap().Rename("b", "c"),
			),
			Reduced: pdelta.Compound(
				Op().Person().TypeMap().Rename("a", "c"),
				Op().Person().TypeMap().Key("b").Delete(),
			),
			Data: &Person{Name: "a", TypeMap: map[string]Person_Type{"a": Person_Alpha, "b": Person_Alpha, "c": Person_Alpha, "d": Person_Alpha}},
		},
		{
			Name: "MOVE_SET_INDEX_SIBLINGS_6",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(1, 4),
				Op().Person().Cases().Key("a").Items().Index(5).Title().Set("g"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(5).Title().Set("g"),
				Op().Person().Cases().Key("a").Items().Move(1, 4),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}, {Flags: []string{"d"}}, {Flags: []string{"e"}}, {Flags: []string{"f"}}}}}},
		},
		{
			Name: "MOVE_SET_INDEX_SIBLINGS_5",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(3, 1),
				Op().Person().Cases().Key("a").Items().Index(2).Title().Set("f"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(1).Title().Set("f"),
				Op().Person().Cases().Key("a").Items().Move(3, 1),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}, {Flags: []string{"d"}}, {Flags: []string{"e"}}}}}},
		},
		{
			Name: "MOVE_SET_INDEX_SIBLINGS_5_A",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(3, 1),
				Op().Person().Cases().Key("a").Items().Index(4).Title().Set("f"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(4).Title().Set("f"),
				Op().Person().Cases().Key("a").Items().Move(3, 1),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}, {Flags: []string{"d"}}, {Flags: []string{"e"}}}}}},
		},
		{
			Name: "MOVE_SET_INDEX_SIBLINGS_4",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(3, 1),
				Op().Person().Cases().Key("a").Items().Index(3).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(2).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Move(3, 1),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}, {Flags: []string{"d"}}}}}},
		},
		{
			Name: "MOVE_SET_INDEX_SIBLINGS_4_A",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(3, 1),
				Op().Person().Cases().Key("a").Items().Index(1).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(3).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Move(3, 1),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}, {Flags: []string{"d"}}}}}},
		},

		{
			Name: "MOVE_SET_INDEX_SIBLINGS_3",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(1, 4),
				Op().Person().Cases().Key("a").Items().Index(1).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(2).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Move(1, 4),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}, {Flags: []string{"d"}}}}}},
		},
		{
			Name: "MOVE_SET_INDEX_SIBLINGS_2",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(1, 4),
				Op().Person().Cases().Key("a").Items().Index(3).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(1).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Move(1, 4),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}, {Flags: []string{"d"}}}}}},
		},

		{
			Name: "MOVE_SET_INDEX_SIBLINGS_1",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Move(1, 3),
				Op().Person().Cases().Key("a").Items().Index(0).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Move(1, 3),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}}}}},
		},

		{
			Name: "DELETE_SET_INDEX_SIBLINGS_1",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(1).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Index(1).Delete(),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}}}}},
		},
		{
			Name: "DELETE_SET_INDEX_SIBLINGS_2",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(1).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}}}}},
		},
		{
			Name: "DELETE_SET_INDEX_SIBLINGS_3",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
				Op().Person().Cases().Key("a").Items().Index(1).Title().Set("d"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(2).Title().Set("d"),
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}}}}},
		},

		{
			Name: "DELETE_DELETE_KEY_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Flags().Key(1).Delete(),
				Op().Person().Cases().Key("a").Delete(),
			),
			Reduced: Op().Person().Cases().Key("a").Delete(),
			Data:    &Person{Name: "a"},
		},
		{
			Name: "DELETE_DELETE_KEY_DESCENDENT",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Delete(),
				Op().Person().Cases().Key("a").Flags().Key(1).Delete(),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Delete(),
				Op().Person().Cases().Key("a").Flags().Key(1).Delete(),
			),
			Data: &Person{Name: "a"},
		},
		{
			Name: "DELETE_DELETE_KEY_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Delete(),
				Op().Person().Cases().Key("a").Delete(),
			),
			Reduced: Op().Person().Cases().Key("a").Delete(),
			Data:    &Person{Name: "a"},
		},

		{
			Name: "DELETE_DELETE_INDEX_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Flags().Index(0).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			),
			Reduced: Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			Data:    &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}}}}},
		},
		{
			Name: "DELETE_DELETE_INDEX_DESCENDENT",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Flags().Index(0).Delete(),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Flags().Index(0).Delete(),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}}}}},
		},
		{
			Name: "DELETE_DELETE_INDEX_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(1).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}}}}},
		},
		{
			Name: "DELETE_DELETE_INDEX_SIBLINGS",
			Op: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(1).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
				Op().Person().Cases().Key("a").Items().Index(0).Delete(),
			),
			Data: &Person{Name: "a", Cases: map[string]*Case{"a": {Items: []*Item{{Flags: []string{"a"}}, {Flags: []string{"b"}}, {Flags: []string{"c"}}}}}},
		},

		{
			Name: "DELETE_DELETE_FIELD_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Company().Name().Delete(),
				Op().Person().Company().Delete(),
			),
			Reduced: Op().Person().Company().Delete(),
			Data:    &Person{Name: "a"},
		},
		{
			Name: "DELETE_DELETE_FIELD_DESCENDENT",
			Op: pdelta.Compound(
				Op().Person().Company().Delete(),
				Op().Person().Company().Name().Delete(),
			),
			Reduced: pdelta.Compound(
				Op().Person().Company().Delete(),
				Op().Person().Company().Name().Delete(),
			),
			Data: &Person{Name: "a"},
		},
		{
			Name: "DELETE_DELETE_FIELD_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Name().Delete(),
				Op().Person().Name().Delete(),
			),
			Reduced: Op().Person().Name().Delete(),
			Data:    &Person{Name: "a"},
		},
		{
			Name: "DELETE_FIELD_EDIT_FIELD",
			Op: pdelta.Compound(
				Op().Person().Name().Delete(),
				Op().Person().Name().Edit("", "b"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Name().Delete(),
				Op().Person().Name().Edit("", "b"),
			),
			Data: &Person{Name: "a"},
		},
		{
			Name: "RENAME_KEY_DELETE_KEY_TO_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("b").Delete(),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("b").Delete(),
				Op().Person().Cases().Key("a").Delete(),
			),
			Data: &Person{Cases: map[string]*Case{"a": {Name: "d"}}},
		},
		{
			Name: "RENAME_KEY_DELETE_KEY_FROM_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("a").Delete(),
			),
			Reduced: Op().Person().Cases().Rename("a", "b"),
			Data:    &Person{Cases: map[string]*Case{"a": {Name: "d"}}},
		},
		{
			Name: "RENAME_KEY_SET_TO_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("b").Name().Set("c"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("a").Name().Set("c"),
				Op().Person().Cases().Rename("a", "b"),
			),
			Data: &Person{Cases: map[string]*Case{"a": {Name: "d"}}},
		},
		{
			Name: "RENAME_KEY_SET_KEY_FROM_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("a").Name().Set("c"),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("a").Name().Set("c"),
			),
			Data: &Person{Cases: map[string]*Case{"a": {Name: "d"}}},
		},
		{
			Name: "RENAME_KEY_SET_KEY_FROM_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("a").Set(&Case{Name: "c"}),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("a").Set(&Case{Name: "c"}),
			),
			Data: &Person{Cases: map[string]*Case{"a": {Name: "d"}}},
		},
		{
			Name: "RENAME_KEY_SET_KEY_TO_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Cases().Rename("a", "b"),
				Op().Person().Cases().Key("b").Set(&Case{Name: "c"}),
			),
			Reduced: pdelta.Compound(
				Op().Person().Cases().Key("b").Set(&Case{Name: "c"}),
				Op().Person().Cases().Key("a").Delete(),
			),
			Data: &Person{Cases: map[string]*Case{"a": {Name: "d"}}},
		},
		{
			Name: "DELETE_SET_INDEPENDENT_2",
			Op: pdelta.Compound(
				Op().Person().Type().Delete(),
				Op().Person().Name().Set(""),
			),
			Reduced: pdelta.Compound(
				Op().Person().Name().Set(""),
				Op().Person().Type().Delete(),
			),
			Data: &Person{},
		},
		{
			Name: "DELETE_SET_INDEPENDENT",
			Op: pdelta.Compound(
				Op().Person().Type().Delete(),
				Op().Person().Name().Set(""),
			),
			Reduced: pdelta.Compound(
				Op().Person().Name().Set(""),
				Op().Person().Type().Delete(),
			),
			Data: &Person{},
		},
		{
			Name: "DELETE_SET_DESCENDENT",
			Op: pdelta.Compound(
				Op().Person().Type().Delete(),
				Op().Person().Set(&Person{Name: "a"}),
			),
			Reduced: Op().Person().Set(&Person{Name: "a"}),
			Data:    &Person{},
		},
		{
			Name: "DELETE_SET_ANCESTOR",
			Op: pdelta.Compound(
				Op().Person().Delete(),
				Op().Person().Type().Set(Person_Alpha),
			),
			Reduced: pdelta.Compound(
				Op().Person().Delete(),
				Op().Person().Type().Set(Person_Alpha),
			),
			Data: &Person{},
		},
		{
			Name: "DELETE_SET_EQUAL",
			Op: pdelta.Compound(
				Op().Person().Type().Delete(),
				Op().Person().Type().Set(Person_Alpha),
			),
			Reduced: Op().Person().Type().Set(Person_Alpha),
			Data:    &Person{},
		},
		{
			Name: "SET_SET_DESCENDANT",
			Op: pdelta.Compound(
				Op().Person().Name().Set("b"),
				Op().Person().Set(&Person{Name: "a"}),
			),
			Reduced: Op().Person().Set(&Person{Name: "a"}),
			Data:    &Person{},
		},
		{
			Name: "MOVE_MOVE_1",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(1, 2),
				Op().Person().Alias().Move(5, 6),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(5, 6),
				Op().Person().Alias().Move(1, 2),
			),
			Data: &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}},
		},
		{
			Name: "MOVE_MOVE_2",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(1, 8),
				Op().Person().Alias().Move(2, 3),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(3, 4),
				Op().Person().Alias().Move(1, 8),
			),
			Data: &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}},
		},
		{
			Name: "MOVE_MOVE_3",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(1, 5),
				Op().Person().Alias().Move(3, 7),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(4, 7),
				Op().Person().Alias().Move(1, 4),
			),
			Data: &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}},
		},
		{
			Name: "MOVE_MOVE_4",
			Op: pdelta.Compound(
				Op().Person().Alias().Move(5, 1),
				Op().Person().Alias().Move(3, 7),
			),
			Reduced: pdelta.Compound(
				Op().Person().Alias().Move(2, 7),
				Op().Person().Alias().Move(4, 1),
			),
			Data: &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}},
		},
		{
			Name: "SET_EDIT_CHILD_OBJECT",
			Op: pdelta.Compound(
				Op().Person().Cases().Set(map[string]*Case{"a": {}}),
				Op().Person().Cases().Key("a").Name().Set("b"),
			),
			Reduced: Op().Person().Cases().Set(map[string]*Case{"a": {Name: "b"}}),
			Data:    &Person{},
		},
		{
			Name: "SET_EDIT_CHILD_MESSAGE",
			Op: pdelta.Compound(
				Op().Person().Company().Set(&Company{Name: "a"}),
				Op().Person().Company().Name().Set("b"),
			),
			Reduced: Op().Person().Company().Set(&Company{Name: "b"}),
			Data:    &Person{},
		},
		{
			// EDIT A d1, EDIT A d2 => EDIT A d3 (use quill to merge d1 and d2)
			Name: "EDIT_EDIT",
			Op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Edit("a b", "a b c"),
			),
			Reduced: Op().Person().Name().Edit("a", "a b c"),
			Data:    &Person{Name: "a"},
		},
		{
			// EDIT A, SET A => SET A
			Name: "EDIT_SET",
			Op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Set("c"),
			),
			Reduced: Op().Person().Name().Set("c"),
			Data:    &Person{Name: "a"},
		},
		{
			// EDIT A, DELETE A => DELETE A
			Name: "EDIT_DELETE",
			Op: pdelta.Compound(
				Op().Person().Name().Edit("a", "a b"),
				Op().Person().Name().Delete(),
			),
			Reduced: Op().Person().Name().Delete(),
			Data:    &Person{Name: "a"},
		},

		{
			// EDIT A, RENAME B to A => RENAME B to A
			Name: "EDIT_RENAME",
			Op: pdelta.Compound(
				Op().Person().Company().Flags().Key(1).Edit("a", "a b"),
				Op().Person().Company().Flags().Rename(2, 1),
			),
			Reduced: Op().Person().Company().Flags().Rename(2, 1),
			Data:    &Person{Company: &Company{Flags: map[int64]string{1: "a", 2: "b"}}},
		},

		{
			// SET A v1, EDIT A d1 => SET A v2 (use quill to calculate v2)
			Name: "SET_EDIT",
			Op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Edit("a", "a b"),
			),
			Reduced: Op().Person().Name().Set("a b"),
			Data:    &Person{},
		},

		{
			// SET A v1, SET A v2 => SET A v2
			Name: "SET_SET",
			Op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Set("b"),
			),
			Reduced: Op().Person().Name().Set("b"),
			Data:    &Person{},
		},

		{
			// SET A, DELETE A => DELETE A
			Name: "SET_DELETE",
			Op: pdelta.Compound(
				Op().Person().Name().Set("a"),
				Op().Person().Name().Delete(),
			),
			Reduced: Op().Person().Name().Delete(),
			Data:    &Person{},
		},

		{
			// SET A, RENAME B to A => RENAME B to A
			Name: "SET_RENAME",
			Op: pdelta.Compound(
				Op().Person().Company().Flags().Key(1).Set("a"),
				Op().Person().Company().Flags().Rename(2, 1),
			),
			Reduced: Op().Person().Company().Flags().Rename(2, 1),
			Data:    &Person{Company: &Company{Flags: map[int64]string{2: "b"}}},
		},

		{
			// INSERT A v1, SET A v2 => INSERT A v2
			Name: "INSERT_SET",
			Op: pdelta.Compound(
				Op().Person().Alias().Insert(0, "a"),
				Op().Person().Alias().Index(0).Set("b"),
			),
			Reduced: Op().Person().Alias().Insert(0, "b"),
			Data:    &Person{},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6", "7", "8"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6", "7", "8"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5"}},
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
			Data:    &Person{Alias: []string{"0", "1", "2", "3", "4", "5"}},
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
	t.Helper()
	data1 := proto.Clone(item.Data).(*Person)
	data2 := proto.Clone(item.Data).(*Person)
	data3 := proto.Clone(item.Data).(*Person)
	opMerged := pdelta.Reduce(item.Op)

	// TODO: uncomment this:
	//if opMerged == nil && item.Reduced == nil {
	//	// no need to compare
	//} else if !compareProto(item.Reduced, opMerged) {
	//	t.Fatalf("reduce case %v:\nop: %v\nexpected: %v\nfound: %v\n\ncase:\n%v", item.Name, item.Op.Debug(), item.Reduced.Debug(), opMerged.Debug(), mustJson(item))
	//}

	if err := pdelta.Apply(item.Op, data1); err != nil {
		t.Fatalf("reduce case %v, data1: %v\n\ncase:\n%v", item.Name, err, mustJson(item))
	}
	if err := pdelta.Apply(opMerged, data2); err != nil {
		t.Fatalf("reduce case %v, data2: %v\n\ncase:\n%v", item.Name, err, mustJson(item))
	}
	if !pdelta.IsNull(item.Reduced) {
		if err := pdelta.Apply(item.Reduced, data3); err != nil {
			t.Fatalf("reduce case %v, data3: %v\n\ncase:\n%v", item.Name, err, mustJson(item))
		}
	}
	if !compareProto(data1, data3) {
		t.Fatalf("reduce case %v, result of applying op does not match expected", item.Name)
	}
	if !compareProto(data1, data2) {
		t.Fatalf("reduce case %v:\nop: %v\nexpected: %v\nfound: %v\ndata: %v\nexpected: %v\nfound: %v\n\ncase:\n%v",
			item.Name,
			item.Op.Debug(),
			item.Reduced.Debug(),
			opMerged.Debug(),
			mustJsonPretty(item.Data),
			mustJsonPretty(data1),
			mustJsonPretty(data2),
			mustJson(item),
		)
	}
}
