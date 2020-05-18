import 'package:protod/delta.dart' as delta;
import 'package:test/test.dart';

import 'pb/pb.def.dart';
import 'pb/pb.pb.dart';
import 'pb/registry.dart' as registry;

void main() {
  /*
  func TestApplyMap(t *testing.T) {

	person := &Person{
		Name:    "dave",
		Company: &Company{Name: "cambro"},
		CasesStringMap: map[string]*Case{
			"foo": {Name: "foo"},
		},
	}

	if err := delta.Apply(delta.EditValue("bar", PersonDef().CasesStringMap().Key("foo").Name()), person); err != nil {
		t.Fail()
	}

	if person.CasesStringMap["foo"].Name != "bar" {
		t.Fail()
	}
}
   */
  test('test apply map string', () {
    delta.setDefaultRegistry(registry.types);

    var person = Person()
      ..name = "dave"
      ..company = (Company()..name = "cambro")
      ..casesStringMap['foo'] = (Case()..name = "foo")
      ..casesStringMap['bar'] = (Case()..name = "bar");

    delta.apply(
      delta.edit("baz", PersonDef().CasesStringMap().Key('foo').Name()),
      person,
    );

    expect(person.casesStringMap['foo'].name, "baz");
  });

  test('test apply map int', () {
    delta.setDefaultRegistry(registry.types);

    var person = Person()
      ..name = "dave"
      ..company = (Company()..name = "cambro")
      ..casesIntMap[1] = (Case()..name = "foo")
      ..casesIntMap[2] = (Case()..name = "bar");

    delta.apply(
      delta.edit("baz", PersonDef().CasesIntMap().Key(2).Name()),
      person,
    );

    expect(person.casesIntMap[2].name, "baz");
  });

  test('test apply', () {
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
      delta.edit("spotify", PersonDef().Company().Name()),
      person,
    );

    expect(person.company.name, "spotify");

    delta.apply(
      delta.edit(Company()..name = 'spacex', PersonDef().Company()),
      person,
    );

    expect(person.company.name, "spacex");

    delta.apply(
      delta.edit(Case()..name = 'qux', PersonDef().Cases().Index(1)),
      person,
    );

    expect(person.cases[1].name, "qux");

    delta.apply(
      delta.edit("qaz", PersonDef().Cases().Index(2).Name()),
      person,
    );

    expect(person.cases[2].name, "qaz");
  });
}
