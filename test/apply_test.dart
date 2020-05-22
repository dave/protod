import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:protod/delta.dart' as delta;
import 'package:protod/delta.pb.dart' as pb;
import 'package:test/test.dart';

import 'pb/pb.def.dart';
import 'pb/pb.pb.dart';
import 'pb/registry.dart' as registry;

class testInfo {
  final String name;
  final pb.Op op;
  final protobuf.GeneratedMessage data;
  final protobuf.GeneratedMessage expected;

  testInfo({
    this.name,
    this.op,
    this.data,
    this.expected,
  });
}

void main() {
  List<testInfo> tests = [
    testInfo(
      name: "insert: list scalar 0",
      op: delta.insert(PersonDef().Alias().Index(0), "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["x", "a", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 1",
      op: delta.insert(PersonDef().Alias().Index(1), "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "x", "b", "c", "d"]),
    )
  ];
  delta.setDefaultRegistry(registry.types);
  tests.forEach((info) {
    test(info.name, () {
      delta.apply(info.op, info.data);
      expect(info.data, info.expected);
    });
  });
  /*
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
  */
//
//  test('test apply map string', () {
//    delta.setDefaultRegistry(registry.types);
//
//    var person = Person()
//      ..name = "dave"
//      ..company = (Company()..name = "cambro")
//      ..casesStringMap['foo'] = (Case()..name = "foo")
//      ..casesStringMap['bar'] = (Case()..name = "bar");
//
//    delta.apply(
//      delta.edit("baz", PersonDef().CasesStringMap().Key('foo').Name()),
//      person,
//    );
//
//    expect(person.casesStringMap['foo'].name, "baz");
//  });
//
//  test('test apply map int', () {
//    delta.setDefaultRegistry(registry.types);
//
//    var person = Person()
//      ..name = "dave"
//      ..company = (Company()..name = "cambro")
//      ..casesIntMap[1] = (Case()..name = "foo")
//      ..casesIntMap[2] = (Case()..name = "bar");
//
//    delta.apply(
//      delta.edit("baz", PersonDef().CasesIntMap().Key(2).Name()),
//      person,
//    );
//
//    expect(person.casesIntMap[2].name, "baz");
//  });
//
//  test('test apply', () {
//    delta.setDefaultRegistry(registry.types);
//
//    var person = Person()
//      ..name = "dave"
//      ..company = (Company()..name = "cambro")
//      ..cases.addAll([
//        Case()..name = "foo",
//        Case()..name = "bar",
//        Case()..name = "baz",
//      ]);
//
//    delta.apply(
//      delta.edit("spotify", PersonDef().Company().Name()),
//      person,
//    );
//
//    expect(person.company.name, "spotify");
//
//    delta.apply(
//      delta.edit(Company()..name = 'spacex', PersonDef().Company()),
//      person,
//    );
//
//    expect(person.company.name, "spacex");
//
//    delta.apply(
//      delta.edit(Case()..name = 'qux', PersonDef().Cases().Index(1)),
//      person,
//    );
//
//    expect(person.cases[1].name, "qux");
//
//    delta.apply(
//      delta.edit("qaz", PersonDef().Cases().Index(2).Name()),
//      person,
//    );
//
//    expect(person.cases[2].name, "qaz");
//  });
}
