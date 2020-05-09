import 'package:protod/delta.dart' as delta;
import 'package:test/test.dart';

import 'pb/pb.defs.dart' as pb_defs;
import 'pb/pb.pb.dart';
import 'pb/registry.dart' as registry;

void main() {
  test('test', () {
    delta.setDefaultRegistry(registry.types);

    var person = Person()
      ..name = "dave"
      ..company = (Company()..name = "cambro")
      ..cases.addAll([
        Case()..name = "foo",
        Case()..name = "bar",
        Case()..name = "baz",
      ]);

    delta.apply(
      delta.editValue("spotify", pb_defs.Person().Company().Name()),
      person,
    );

    expect(person.company.name, "spotify");

    delta.apply(
      delta.editValue(Company()..name = 'spacex', pb_defs.Person().Company()),
      person,
    );

    expect(person.company.name, "spacex");

    delta.apply(
      delta.editValue(Case()..name = 'qux', pb_defs.Person().Cases().Index(1)),
      person,
    );

    expect(person.cases[1].name, "qux");

    delta.apply(
      delta.editValue("qaz", pb_defs.Person().Cases().Index(2).Name()),
      person,
    );

    expect(person.cases[2].name, "qaz");
  });
}
