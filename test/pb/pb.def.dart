import 'package:protod/delta.dart' as delta;

Company_type CompanyDef() {
  return Company_type([]);
}

class Company_type extends delta.Locator {
  Company_type(List<delta.Indexer> location) : super(location);

  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(delta.Field("name", 11)));
  }

}

class Company_type_repeated extends delta.Locator {
  Company_type_repeated(List<delta.Indexer> location) : super(location);
  Company_type Index(int i) {
    return Company_type([...location]..add(delta.Index(i)));
  }
}

Case_type CaseDef() {
  return Case_type([]);
}

class Case_type extends delta.Locator {
  Case_type(List<delta.Indexer> location) : super(location);

  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(delta.Field("name", 12)));
  }

}

class Case_type_repeated extends delta.Locator {
  Case_type_repeated(List<delta.Indexer> location) : super(location);
  Case_type Index(int i) {
    return Case_type([...location]..add(delta.Index(i)));
  }
}

Person_type PersonDef() {
  return Person_type([]);
}

class Person_type extends delta.Locator {
  Person_type(List<delta.Indexer> location) : super(location);

  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(delta.Field("name", 13)));
  }

  delta.Int32_scalar Age() {
    return delta.Int32_scalar([...location]..add(delta.Field("age", 14)));
  }

  Case_type_repeated Cases() {
    return Case_type_repeated([...location]..add(delta.Field("cases", 15)));
  }

  Company_type Company() {
    return Company_type([...location]..add(delta.Field("company", 16)));
  }

}

class Person_type_repeated extends delta.Locator {
  Person_type_repeated(List<delta.Indexer> location) : super(location);
  Person_type Index(int i) {
    return Person_type([...location]..add(delta.Index(i)));
  }
}

