import 'package:protod/delta.dart' as defs;

Company_type Company() {
  return Company_type([]);
}

class Company_type extends defs.Locator {
  Company_type(List<defs.Indexer> location) : super(location);

  defs.String_scalar Name() {
    return defs.String_scalar([...location]..add(defs.Field("name", 11)));
  }

}

class Company_type_repeated extends defs.Locator {
  Company_type_repeated(List<defs.Indexer> location) : super(location);
  Company_type Index(int i) {
    return Company_type([...location]..add(defs.Index(i)));
  }
}

Case_type Case() {
  return Case_type([]);
}

class Case_type extends defs.Locator {
  Case_type(List<defs.Indexer> location) : super(location);

  defs.String_scalar Name() {
    return defs.String_scalar([...location]..add(defs.Field("name", 12)));
  }

}

class Case_type_repeated extends defs.Locator {
  Case_type_repeated(List<defs.Indexer> location) : super(location);
  Case_type Index(int i) {
    return Case_type([...location]..add(defs.Index(i)));
  }
}

Person_type Person() {
  return Person_type([]);
}

class Person_type extends defs.Locator {
  Person_type(List<defs.Indexer> location) : super(location);

  defs.String_scalar Name() {
    return defs.String_scalar([...location]..add(defs.Field("name", 13)));
  }

  defs.Int32_scalar Age() {
    return defs.Int32_scalar([...location]..add(defs.Field("age", 14)));
  }

  Case_type_repeated Cases() {
    return Case_type_repeated([...location]..add(defs.Field("cases", 15)));
  }

  Company_type Company() {
    return Company_type([...location]..add(defs.Field("company", 16)));
  }

}

class Person_type_repeated extends defs.Locator {
  Person_type_repeated(List<defs.Indexer> location) : super(location);
  Person_type Index(int i) {
    return Person_type([...location]..add(defs.Index(i)));
  }
}

