import 'package:protod/delta.dart' as delta;
import 'package:test/test.dart';

import 'pb/pb.def.dart';
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
      delta.editValue("spotify", PersonDef().Company().Name()),
      person,
    );

    expect(person.company.name, "spotify");

    delta.apply(
      delta.editValue(Company()..name = 'spacex', PersonDef().Company()),
      person,
    );

    expect(person.company.name, "spacex");

    delta.apply(
      delta.editValue(Case()..name = 'qux', PersonDef().Cases().Index(1)),
      person,
    );

    expect(person.cases[1].name, "qux");

    delta.apply(
      delta.editValue("qaz", PersonDef().Cases().Index(2).Name()),
      person,
    );

    expect(person.cases[2].name, "qaz");
  });
}
