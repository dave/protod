import 'dart:convert';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:pdelta/pdelta/pdelta.dart' as delta;
import 'package:pdelta/pdelta/pdelta.pb.dart' as pb;
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:test/test.dart';

void main() {
  List<testInfo> tests = [
    testInfo(
      name: "oneof_deep_delete_4",
      op: op.person.choice.cas.flags.delete(),
      data: Person()..str = "a",
      expected: Person()..cas = Case(),
    ),
    testInfo(
      name: "oneof_deep_delete_3",
      op: op.person.choice.itm.flags.delete(),
      data: Person()..str = "a",
      expected: Person()..itm = Item(),
    ),
    testInfo(
      name: "oneof_deep_delete_2",
      op: op.person.choice.itm.delete(),
      data: Person()..str = "a",
      expected: Person(),
    ),
    testInfo(
      name: "set item",
      op: op.person.cases.key("a").items.insert(0, Item()..done = true),
      data: Person()..name = "a",
      expected: Person()
        ..name = "a"
        ..cases.addAll({"a": Case()..items.add(Item()..done = true)}),
    ),
    testInfo(
      name: "set list enum item",
      op: op.person.typeList.index(0).set(Person_Type.Bravo),
      data: Person()
        ..name = "a"
        ..typeList.add(Person_Type.Alpha),
      expected: Person()
        ..name = "a"
        ..typeList.addAll([Person_Type.Bravo]),
    ),
    testInfo(
      name: "set list enum",
      op: op.person.typeList.set([Person_Type.Charlie, Person_Type.Alpha]),
      data: Person()..name = "a",
      expected: Person()
        ..name = "a"
        ..typeList.addAll([Person_Type.Charlie, Person_Type.Alpha]),
    ),
    testInfo(
      name: "set map enum",
      op: op.person.typeMap.set({"a": Person_Type.Charlie}),
      data: Person()..name = "a",
      expected: Person()
        ..name = "a"
        ..typeMap.addAll({"a": Person_Type.Charlie}),
    ),
    testInfo(
      name: "edit bug",
      op: op.company.flags.key(2).edit("b", "c"),
      data: Company()..flags.addAll({fixnum.Int64(1): "a", fixnum.Int64(2): "b"}),
      expected: Company()..flags.addAll({fixnum.Int64(1): "a", fixnum.Int64(2): "c"}),
    ),
    testInfo(
      name: "key set unset parent",
      op: op.person.company.flags.key(1).set("a"),
      data: Person(),
      expected: Person()..company = (Company()..flags.addAll({fixnum.Int64(1): "a"})),
    ),
    testInfo(
      name: "delete root",
      op: op.person.delete(),
      data: Person()..name = "a",
      expected: Person(),
    ),
    testInfo(
      name: "oneof set inner",
      op: op.chooser.choice.itm.title.set("a"),
      data: Chooser(),
      expected: Chooser()..itm = (Item()..title = "a"),
    ),
    testInfo(
      name: "oneof set inner set outer first",
      op: delta.compound([
        op.chooser.choice.itm.set(Item()),
        op.chooser.choice.itm.title.set("a"),
      ]),
      data: Chooser(),
      expected: Chooser()..itm = (Item()..title = "a"),
    ),
    testInfo(
      name: "oneof_insert_inner",
      op: op.chooser.choice.itm.flags.insert(0, "a"),
      data: Chooser()..dbl = 1.1,
      expected: Chooser()..itm = (Item()..flags.add("a")),
    ),
    testInfo(
      name: "oneof set inner with other oneof",
      op: op.chooser.choice.itm.title.set("a"),
      data: Chooser()..dbl = 1.1,
      expected: Chooser()..itm = (Item()..title = "a"),
    ),
    testInfo(
      name: "oneof set str with other oneof",
      op: op.chooser.choice.str.set("a"),
      data: Chooser()..dbl = 1.1,
      expected: Chooser()..str = "a",
    ),
    testInfo(
      name: "insert_into_null",
      op: op.item.flags.insert(0, "a"),
      data: Item(),
      expected: Item()..flags.add("a"),
    ),
    testInfo(
      name: "oneof delete",
      op: op.chooser.choice.delete(),
      data: Chooser()..str = "a",
      expected: Chooser(),
    ),
    testInfo(
      name: "oneof set str",
      op: op.chooser.choice.str.set("a"),
      data: Chooser(),
      expected: Chooser()..str = "a",
    ),
    testInfo(
      name: "set enum in map",
      op: op.person.typeMap.key("a").set(Person_Type.Charlie),
      data: Person(),
      expected: Person()..typeMap["a"] = Person_Type.Charlie,
    ),
    testInfo(
      name: "set enum in map",
      op: op.person.typeMap.key("a").set(Person_Type.Charlie),
      data: Person(),
      expected: Person()..typeMap["a"] = Person_Type.Charlie,
    ),
    testInfo(
      name: "set enum in list",
      op: op.person.typeList.insert(0, Person_Type.Bravo),
      data: Person(),
      expected: Person()..typeList.add(Person_Type.Bravo),
    ),
    testInfo(
      name: "set enum",
      op: op.person.type.set(Person_Type.Alpha),
      data: Person(),
      expected: Person()..type = Person_Type.Alpha,
    ),
    testInfo(
      // TODO: failing test because of: https://github.com/dart-lang/protobuf/issues/373
      name: "nil map",
      op: op.company.flags.key(1).set("b"),
      data: Company(),
      expected: Company()..flags[fixnum.Int64(1)] = "b",
    ),
    testInfo(
      name: "empty map",
      op: op.company.flags.key(1).set("b"),
      data: Company()..flags.clear(),
      expected: Company()..flags[fixnum.Int64(1)] = "b",
    ),
    testInfo(
      name: "nil list",
      op: op.person.alias.insert(0, "b"),
      data: Person(),
      expected: Person()..alias.addAll(["b"]),
    ),
    testInfo(
      name: "empty list",
      op: op.person.alias.insert(0, "b"),
      data: Person()..alias.clear(),
      expected: Person()..alias.addAll(["b"]),
    ),
    testInfo(
      name: "insert: list scalar 0",
      op: op.person.alias.insert(0, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["x", "a", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 1",
      op: op.person.alias.insert(1, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "x", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 0",
      op: op.person.alias.insert(0, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["x", "a", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 1",
      op: op.person.alias.insert(1, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "x", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 2",
      op: op.person.alias.insert(2, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "x", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 3",
      op: op.person.alias.insert(3, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "c", "x", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 4",
      op: op.person.alias.insert(4, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "c", "d", "x"]),
    ),
    testInfo(
      name: "insert: list message",
      op: op.case_.items.insert(0, Item()..title = "x"),
      data: Case()..items.addAll([Item()..title = "a", Item()..title = "b"]),
      expected: Case()..items.addAll([Item()..title = "x", Item()..title = "a", Item()..title = "b"]),
    ),
    testInfo(
      name: "insert: map scalar",
      op: op.company.flags.key(10).set("x"),
      data: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b",
      expected: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b"
        ..flags[fixnum.Int64(10)] = "x",
    ),
    testInfo(
      name: "insert: map message",
      op: op.person.cases.key("x").set(Case()..name = "x"),
      data: Person()
        ..cases["a"] = (Case()..name = "a")
        ..cases["b"] = (Case()..name = "b"),
      expected: Person()
        ..cases["a"] = (Case()..name = "a")
        ..cases["b"] = (Case()..name = "b")
        ..cases["x"] = (Case()..name = "x"),
    ),
    testInfo(
      name: "delete: scalar",
      op: op.person.name.delete(),
      data: Person()..name = "foo",
      expected: Person(),
    ),
    testInfo(
      name: "delete: field scalar",
      op: op.person.company.name.delete(),
      data: Person()..company = (Company()..name = "foo"),
      expected: Person()..company = Company(),
    ),
    testInfo(
      name: "delete: message",
      op: op.person.company.delete(),
      data: Person()..company = (Company()..name = "foo"),
      expected: Person(),
    ),
    testInfo(
      name: "delete: list scalar start",
      op: op.person.alias.index(0).delete(),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["b", "c", "d"]),
    ),
    testInfo(
      name: "delete: list scalar mid",
      op: op.person.alias.index(2).delete(),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "d"]),
    ),
    testInfo(
      name: "delete: list scalar end",
      op: op.person.alias.index(3).delete(),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "c"]),
    ),
    testInfo(
      name: "delete: list message",
      op: op.case_.items.index(0).delete(),
      data: Case()..items.addAll([(Item()..title = "a"), (Item()..title = "b"), (Item()..title = "c")]),
      expected: Case()..items.addAll([(Item()..title = "b"), (Item()..title = "c")]),
    ),
    testInfo(
      name: "delete: map scalar",
      op: op.company.flags.key(2).delete(),
      data: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b"
        ..flags[fixnum.Int64(3)] = "c",
      expected: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(3)] = "c",
    ),
    testInfo(
      name: "move: list scalar start-next-1",
      op: op.person.alias.move(0, 1),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar start-next",
      op: op.person.alias.move(0, 2),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["b", "a", "c", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar start-mid",
      op: op.person.alias.move(0, 3),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["b", "c", "a", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar start-end",
      op: op.person.alias.move(0, 5),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["b", "c", "d", "e", "a"]),
    ),
    testInfo(
      name: "move: list scalar mid-next",
      op: op.person.alias.move(2, 4),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "d", "c", "e"]),
    ),
    testInfo(
      name: "move: list scalar mid-prev",
      op: op.person.alias.move(2, 1),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "c", "b", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar mid-end",
      op: op.person.alias.move(2, 5),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "d", "e", "c"]),
    ),
    testInfo(
      name: "move: list scalar mid-start",
      op: op.person.alias.move(2, 0),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["c", "a", "b", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar end-prev",
      op: op.person.alias.move(4, 3),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "c", "e", "d"]),
    ),
    testInfo(
      name: "move: list scalar end-mid",
      op: op.person.alias.move(4, 2),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "e", "c", "d"]),
    ),
    testInfo(
      name: "move: list scalar end-start",
      op: op.person.alias.move(4, 0),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["e", "a", "b", "c", "d"]),
    ),
    testInfo(
      name: "move: list message",
      op: op.case_.items.move(0, 3),
      data: Case()..items.addAll([Item()..title = "a", Item()..title = "b", Item()..title = "c"]),
      expected: Case()..items.addAll([Item()..title = "b", Item()..title = "c", Item()..title = "a"]),
    ),
    testInfo(
      name: "move: map scalar",
      op: op.company.flags.rename(2, 5),
      data: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b",
      expected: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(5)] = "b",
    ),
    testInfo(
      name: "move: map message",
      op: op.person.cases.rename("b", "c"),
      data: Person()
        ..cases["a"] = (Case()..name = "a")
        ..cases["b"] = (Case()..name = "b"),
      expected: Person()
        ..cases["a"] = (Case()..name = "a")
        ..cases["c"] = (Case()..name = "b"),
    ),
    testInfo(
      name: "replace: scalar",
      op: op.person.name.set("john"),
      data: Person()..name = "dave",
      expected: Person()..name = "john",
    ),
    testInfo(
      name: "replace: field scalar",
      op: op.person.company.name.set("apple"),
      data: Person()..company = (Company()..name = "google"),
      expected: Person()..company = (Company()..name = "apple"),
    ),
    testInfo(
      name: "replace: field",
      op: op.person.company.set(Company()..name = "apple"),
      data: Person()..company = (Company()..name = "google"),
      expected: Person()..company = (Company()..name = "apple"),
    ),
    testInfo(
      name: "replace: index scalar",
      op: op.person.alias.index(1).set("alex"),
      data: Person()..alias.addAll(["jim", "bob", "dave"]),
      expected: Person()..alias.addAll(["jim", "alex", "dave"]),
    ),
    testInfo(
      name: "replace: index field",
      op: op.case_.items.index(1).set(Item()..title = "baz"),
      data: Case()..items.addAll([Item()..title = "foo", Item()..title = "bar"]),
      expected: Case()..items.addAll([Item()..title = "foo", Item()..title = "baz"]),
    ),
    testInfo(
      name: "replace: index field scalar",
      op: op.case_.items.index(0).title.set("baz"),
      data: Case()..items.addAll([Item()..title = "foo", Item()..title = "bar"]),
      expected: Case()..items.addAll([Item()..title = "baz", Item()..title = "bar"]),
    ),
    testInfo(
      name: "replace: map scalar",
      op: op.company.flags.key(2).set("qux"),
      data: Company()
        ..flags[fixnum.Int64(1)] = "foo"
        ..flags[fixnum.Int64(2)] = "bar"
        ..flags[fixnum.Int64(3)] = "baz",
      expected: Company()
        ..flags[fixnum.Int64(1)] = "foo"
        ..flags[fixnum.Int64(2)] = "qux"
        ..flags[fixnum.Int64(3)] = "baz",
    ),
    testInfo(
      name: "replace: map field",
      op: op.person.cases.key("c").set(Case()..name = "foo"),
      data: Person()
        ..cases["a"] = (Case()..name = "caseA")
        ..cases["b"] = (Case()..name = "caseB")
        ..cases["c"] = (Case()..name = "caseC"),
      expected: Person()
        ..cases["a"] = (Case()..name = "caseA")
        ..cases["b"] = (Case()..name = "caseB")
        ..cases["c"] = (Case()..name = "foo"),
    ),
    testInfo(
      name: "replace: map field scalar",
      op: op.person.cases.key("a").name.set("foo"),
      data: Person()
        ..cases["a"] = (Case()..name = "caseA")
        ..cases["b"] = (Case()..name = "caseB"),
      expected: Person()
        ..cases["a"] = (Case()..name = "foo")
        ..cases["b"] = (Case()..name = "caseB"),
    ),
    testInfo(
      name: "replace: replace list scalar",
      op: op.person.alias.set(["x", "y"]),
      data: Person()..alias.addAll(["a", "b"]),
      expected: Person()..alias.addAll(["x", "y"]),
    ),
    testInfo(
      name: "replace: replace list message",
      op: op.case_.items.set([Item()..title = "x", Item()..title = "y", Item()..title = "z"]),
      data: Case()..items.addAll([Item()..title = "a", Item()..title = "b"]),
      expected: Case()..items.addAll([Item()..title = "x", Item()..title = "y", Item()..title = "z"]),
    ),
    testInfo(
      name: "replace: replace map message",
      op: op.person.cases.set({"x": Case()..name = "x", "y": Case()..name = "y", "z": Case()..name = "z"}),
      data: Person()
        ..cases["a"] = (Case()..name = "a")
        ..cases["b"] = (Case()..name = "b"),
      expected: Person()
        ..cases["x"] = (Case()..name = "x")
        ..cases["y"] = (Case()..name = "y")
        ..cases["z"] = (Case()..name = "z"),
    ),
    testInfo(
      name: "replace: replace map scalar",
      op: op.company.flags.set({fixnum.Int64(10): "x", fixnum.Int64(11): "y"}),
      data: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b",
      expected: Company()
        ..flags[fixnum.Int64(10)] = "x"
        ..flags[fixnum.Int64(11)] = "y",
    ),
    testInfo(
      name: "edit: lorem ipsum",
      op: op.person.name.edit("Lorem ipsum dolor.", "Lorem dolor sit amet."),
      diff: '{"ops":[{"retain":"6"},{"delete":"11"},{"insert":"dolor sit amet"},{"retain":"1"}]}',
      data: Person()..name = "Lorem ipsum dolor.",
      expected: Person()..name = "Lorem dolor sit amet.",
    ),
    testInfo(
      name: "edit: quick brown fox",
      op: op.person.name.edit("the quick brown fox jumped over the lazy dog.", "the quick orange fox jumped over me."),
      diff:
          '{"ops":[{"retain":"10"},{"delete":"5"},{"insert":"orange"},{"retain":"17"},{"delete":"12"},{"insert":"me"},{"retain":"1"}]}',
      data: Person()..name = "the quick brown fox jumped over the lazy dog.",
      expected: Person()..name = "the quick orange fox jumped over me.",
    ),
  ];
  final solo = tests.any((info) => info.solo ?? false);
  tests.forEach((info) {
    if (solo && !(info.solo ?? false)) {
      return;
    }
    test(info.name, () {
      if (info.diff != null) {
        expect(info.op.delta.quill.toProto3Json(), jsonDecode(info.diff));
      }
      delta.apply(info.op, info.data);
      expect(info.data, info.expected);
    });
  });
}

class testInfo {
  final String name;
  final String diff;
  final pb.Op op;
  final protobuf.GeneratedMessage data;
  final protobuf.GeneratedMessage expected;
  final bool solo;

  testInfo({
    this.solo = false,
    this.name,
    this.op,
    this.data,
    this.expected,
    this.diff,
  });
}
