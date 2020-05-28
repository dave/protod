import 'dart:convert';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:protod/delta.dart' as delta;
import 'package:protod/delta.pb.dart' as pb;
import 'package:test/test.dart';

import 'pb/pb.pb.dart';
import 'pb/registry.dart' as registry;
import 'pb/tests.op.dart';

class testInfo {
  final String name;
  final String diff;
  final pb.Op op;
  final protobuf.GeneratedMessage data;
  final protobuf.GeneratedMessage expected;
  final bool solo;

  testInfo({
    this.solo,
    this.name,
    this.op,
    this.data,
    this.expected,
    this.diff,
  });
}

void main() {
  List<testInfo> tests = [
    testInfo(
      // TODO: failing test
      name: "nil map",
      op: Op().Company().Flags().Insert(1, "b"),
      data: Company(),
      expected: Company()..flags[fixnum.Int64(1)] = "b",
    ),
    testInfo(
      name: "empty map",
      op: Op().Company().Flags().Insert(1, "b"),
      data: Company()..flags.clear(),
      expected: Company()..flags[fixnum.Int64(1)] = "b",
    ),
    testInfo(
      name: "nil list",
      op: Op().Person().Alias().Insert(0, "b"),
      data: Person(),
      expected: Person()..alias.addAll(["b"]),
    ),
    testInfo(
      name: "empty list",
      op: Op().Person().Alias().Insert(0, "b"),
      data: Person()..alias.clear(),
      expected: Person()..alias.addAll(["b"]),
    ),
    testInfo(
      name: "insert: list scalar 0",
      op: Op().Person().Alias().Insert(0, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["x", "a", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 1",
      op: Op().Person().Alias().Insert(1, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "x", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 0",
      op: Op().Person().Alias().Insert(0, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["x", "a", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 1",
      op: Op().Person().Alias().Insert(1, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "x", "b", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 2",
      op: Op().Person().Alias().Insert(2, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "x", "c", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 3",
      op: Op().Person().Alias().Insert(3, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "c", "x", "d"]),
    ),
    testInfo(
      name: "insert: list scalar 4",
      op: Op().Person().Alias().Insert(4, "x"),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "c", "d", "x"]),
    ),
    testInfo(
      name: "insert: list message",
      op: Op().Case().Items().Insert(0, Item()..title = "x"),
      data: Case()..items.addAll([Item()..title = "a", Item()..title = "b"]),
      expected: Case()
        ..items.addAll(
            [Item()..title = "x", Item()..title = "a", Item()..title = "b"]),
    ),
    testInfo(
      name: "insert: map scalar",
      op: Op().Company().Flags().Insert(10, "x"),
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
      op: Op().Person().Cases().Insert("x", Case()..name = "x"),
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
      op: Op().Person().Name().Delete(),
      data: Person()..name = "foo",
      expected: Person(),
    ),
    testInfo(
      name: "delete: field scalar",
      op: Op().Person().Company().Name().Delete(),
      data: Person()..company = (Company()..name = "foo"),
      expected: Person()..company = Company(),
    ),
    testInfo(
      name: "delete: message",
      op: Op().Person().Company().Delete(),
      data: Person()..company = (Company()..name = "foo"),
      expected: Person(),
    ),
    testInfo(
      name: "delete: list scalar start",
      op: Op().Person().Alias().Index(0).Delete(),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["b", "c", "d"]),
    ),
    testInfo(
      name: "delete: list scalar mid",
      op: Op().Person().Alias().Index(2).Delete(),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "d"]),
    ),
    testInfo(
      name: "delete: list scalar end",
      op: Op().Person().Alias().Index(3).Delete(),
      data: Person()..alias.addAll(["a", "b", "c", "d"]),
      expected: Person()..alias.addAll(["a", "b", "c"]),
    ),
    testInfo(
      name: "delete: list message",
      op: Op().Case().Items().Index(0).Delete(),
      data: Case()
        ..items.addAll([
          (Item()..title = "a"),
          (Item()..title = "b"),
          (Item()..title = "c")
        ]),
      expected: Case()
        ..items.addAll([(Item()..title = "b"), (Item()..title = "c")]),
    ),
    testInfo(
      name: "delete: map scalar",
      op: Op().Company().Flags().Key(2).Delete(),
      data: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b"
        ..flags[fixnum.Int64(3)] = "c",
      expected: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(3)] = "c",
    ),
    testInfo(
      name: "move: list scalar start-next",
      op: Op().Person().Alias().Move(0, 1),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["b", "a", "c", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar start-mid",
      op: Op().Person().Alias().Move(0, 2),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["b", "c", "a", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar start-end",
      op: Op().Person().Alias().Move(0, 4),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["b", "c", "d", "e", "a"]),
    ),
    testInfo(
      name: "move: list scalar mid-next",
      op: Op().Person().Alias().Move(2, 3),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "d", "c", "e"]),
    ),
    testInfo(
      name: "move: list scalar mid-prev",
      op: Op().Person().Alias().Move(2, 1),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "c", "b", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar mid-end",
      op: Op().Person().Alias().Move(2, 4),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "d", "e", "c"]),
    ),
    testInfo(
      name: "move: list scalar mid-start",
      op: Op().Person().Alias().Move(2, 0),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["c", "a", "b", "d", "e"]),
    ),
    testInfo(
      name: "move: list scalar end-prev",
      op: Op().Person().Alias().Move(4, 3),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "c", "e", "d"]),
    ),
    testInfo(
      name: "move: list scalar end-mid",
      op: Op().Person().Alias().Move(4, 2),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["a", "b", "e", "c", "d"]),
    ),
    testInfo(
      name: "move: list scalar end-start",
      op: Op().Person().Alias().Move(4, 0),
      data: Person()..alias.addAll(["a", "b", "c", "d", "e"]),
      expected: Person()..alias.addAll(["e", "a", "b", "c", "d"]),
    ),
    testInfo(
      name: "move: list message",
      op: Op().Case().Items().Move(0, 2),
      data: Case()
        ..items.addAll(
            [Item()..title = "a", Item()..title = "b", Item()..title = "c"]),
      expected: Case()
        ..items.addAll(
            [Item()..title = "b", Item()..title = "c", Item()..title = "a"]),
    ),
    testInfo(
      name: "move: map scalar",
      op: Op().Company().Flags().Move(2, 5),
      data: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b",
      expected: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(5)] = "b",
    ),
    testInfo(
      name: "move: map message",
      op: Op().Person().Cases().Move("b", "c"),
      data: Person()
        ..cases["a"] = (Case()..name = "a")
        ..cases["b"] = (Case()..name = "b"),
      expected: Person()
        ..cases["a"] = (Case()..name = "a")
        ..cases["c"] = (Case()..name = "b"),
    ),
    testInfo(
      name: "replace: scalar",
      op: Op().Person().Name().Replace("john"),
      data: Person()..name = "dave",
      expected: Person()..name = "john",
    ),
    testInfo(
      name: "replace: field scalar",
      op: Op().Person().Company().Name().Replace("apple"),
      data: Person()..company = (Company()..name = "google"),
      expected: Person()..company = (Company()..name = "apple"),
    ),
    testInfo(
      name: "replace: field",
      op: Op().Person().Company().Replace(Company()..name = "apple"),
      data: Person()..company = (Company()..name = "google"),
      expected: Person()..company = (Company()..name = "apple"),
    ),
    testInfo(
      name: "replace: index scalar",
      op: Op().Person().Alias().Index(1).Replace("alex"),
      data: Person()..alias.addAll(["jim", "bob", "dave"]),
      expected: Person()..alias.addAll(["jim", "alex", "dave"]),
    ),
    testInfo(
      name: "replace: index field",
      op: Op().Case().Items().Index(1).Replace(Item()..title = "baz"),
      data: Case()
        ..items.addAll([Item()..title = "foo", Item()..title = "bar"]),
      expected: Case()
        ..items.addAll([Item()..title = "foo", Item()..title = "baz"]),
    ),
    testInfo(
      name: "replace: index field scalar",
      op: Op().Case().Items().Index(0).Title().Replace("baz"),
      data: Case()
        ..items.addAll([Item()..title = "foo", Item()..title = "bar"]),
      expected: Case()
        ..items.addAll([Item()..title = "baz", Item()..title = "bar"]),
    ),
    testInfo(
      name: "replace: map scalar",
      op: Op().Company().Flags().Key(2).Replace("qux"),
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
      op: Op().Person().Cases().Key("c").Replace(Case()..name = "foo"),
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
      op: Op().Person().Cases().Key("a").Name().Replace("foo"),
      data: Person()
        ..cases["a"] = (Case()..name = "caseA")
        ..cases["b"] = (Case()..name = "caseB"),
      expected: Person()
        ..cases["a"] = (Case()..name = "foo")
        ..cases["b"] = (Case()..name = "caseB"),
    ),
    testInfo(
      name: "replace: replace list scalar",
      op: Op().Person().Alias().Replace(["x", "y"]),
      data: Person()..alias.addAll(["a", "b"]),
      expected: Person()..alias.addAll(["x", "y"]),
    ),
    testInfo(
      name: "replace: replace list message",
      op: Op().Case().Items().Replace(
          [Item()..title = "x", Item()..title = "y", Item()..title = "z"]),
      data: Case()..items.addAll([Item()..title = "a", Item()..title = "b"]),
      expected: Case()
        ..items.addAll(
            [Item()..title = "x", Item()..title = "y", Item()..title = "z"]),
    ),
    testInfo(
      name: "replace: replace map message",
      op: Op().Person().Cases().Replace({
        "x": Case()..name = "x",
        "y": Case()..name = "y",
        "z": Case()..name = "z"
      }),
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
      op: Op()
          .Company()
          .Flags()
          .Replace({fixnum.Int64(10): "x", fixnum.Int64(11): "y"}),
      data: Company()
        ..flags[fixnum.Int64(1)] = "a"
        ..flags[fixnum.Int64(2)] = "b",
      expected: Company()
        ..flags[fixnum.Int64(10)] = "x"
        ..flags[fixnum.Int64(11)] = "y",
    ),
    testInfo(
      name: "edit: lorem ipsum",
      op: Op()
          .Person()
          .Name()
          .Edit("Lorem ipsum dolor.", "Lorem dolor sit amet."),
      diff:
          '{"ops":[{"retain":"6"},{"delete":"11"},{"insert":"dolor sit amet"},{"retain":"1"}]}',
      data: Person()..name = "Lorem ipsum dolor.",
      expected: Person()..name = "Lorem dolor sit amet.",
    ),
    testInfo(
      name: "edit: quick brown fox",
      op: Op().Person().Name().Edit(
          "the quick brown fox jumped over the lazy dog.",
          "the quick orange fox jumped over me."),
      diff:
          '{"ops":[{"retain":"10"},{"delete":"5"},{"insert":"orange"},{"retain":"17"},{"delete":"12"},{"insert":"me"},{"retain":"1"}]}',
      data: Person()..name = "the quick brown fox jumped over the lazy dog.",
      expected: Person()..name = "the quick orange fox jumped over me.",
    ),
  ];
  delta.setDefaultRegistry(registry.types);
  final solo = tests.any((info) => info.solo ?? false);
  tests.forEach((info) {
    if (solo && !(info.solo ?? false)) {
      return;
    }
    test(info.name, () {
      if (info.diff != null) {
        expect(info.op.delta.toProto3Json(), jsonDecode(info.diff));
      }
      delta.apply(info.op, info.data);
      expect(info.data, info.expected);
    });
  });
}
