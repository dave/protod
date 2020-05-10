import 'package:protod/delta.dart' as delta;
import 'package:fixnum/fixnum.dart' as fixnum;

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

class Company_type_bool_map extends delta.Locator {
  Company_type_bool_map(List<delta.Indexer> location) : super(location);
  Company_type Key(bool k) {
    return Company_type([...location]..add(delta.Key(k)));
  }
}

class Company_type_int32_map extends delta.Locator {
  Company_type_int32_map(List<delta.Indexer> location) : super(location);
  Company_type Key(int k) {
    return Company_type([...location]..add(delta.Key(k)));
  }
}

class Company_type_int64_map extends delta.Locator {
  Company_type_int64_map(List<delta.Indexer> location) : super(location);
  Company_type Key(fixnum.Int64 k) {
    return Company_type([...location]..add(delta.Key(k)));
  }
}

class Company_type_uint32_map extends delta.Locator {
  Company_type_uint32_map(List<delta.Indexer> location) : super(location);
  Company_type Key(fixnum.Int64 k) {
    return Company_type([...location]..add(delta.KeyUint32(k)));
  }
}

class Company_type_uint64_map extends delta.Locator {
  Company_type_uint64_map(List<delta.Indexer> location) : super(location);
  Company_type Key(fixnum.Int64 k) {
    return Company_type([...location]..add(delta.KeyUint64(k)));
  }
}

class Company_type_string_map extends delta.Locator {
  Company_type_string_map(List<delta.Indexer> location) : super(location);
  Company_type Key(String k) {
    return Company_type([...location]..add(delta.Key(k)));
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

class Case_type_bool_map extends delta.Locator {
  Case_type_bool_map(List<delta.Indexer> location) : super(location);
  Case_type Key(bool k) {
    return Case_type([...location]..add(delta.Key(k)));
  }
}

class Case_type_int32_map extends delta.Locator {
  Case_type_int32_map(List<delta.Indexer> location) : super(location);
  Case_type Key(int k) {
    return Case_type([...location]..add(delta.Key(k)));
  }
}

class Case_type_int64_map extends delta.Locator {
  Case_type_int64_map(List<delta.Indexer> location) : super(location);
  Case_type Key(fixnum.Int64 k) {
    return Case_type([...location]..add(delta.Key(k)));
  }
}

class Case_type_uint32_map extends delta.Locator {
  Case_type_uint32_map(List<delta.Indexer> location) : super(location);
  Case_type Key(fixnum.Int64 k) {
    return Case_type([...location]..add(delta.KeyUint32(k)));
  }
}

class Case_type_uint64_map extends delta.Locator {
  Case_type_uint64_map(List<delta.Indexer> location) : super(location);
  Case_type Key(fixnum.Int64 k) {
    return Case_type([...location]..add(delta.KeyUint64(k)));
  }
}

class Case_type_string_map extends delta.Locator {
  Case_type_string_map(List<delta.Indexer> location) : super(location);
  Case_type Key(String k) {
    return Case_type([...location]..add(delta.Key(k)));
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
  Case_type_string_map CasesStringMap() {
    return Case_type_string_map([...location]..add(delta.Field("casesStringMap", 16)));
  }
  Case_type_int32_map CasesIntMap() {
    return Case_type_int32_map([...location]..add(delta.Field("casesIntMap", 17)));
  }
  Company_type Company() {
    return Company_type([...location]..add(delta.Field("company", 18)));
  }
}

class Person_type_repeated extends delta.Locator {
  Person_type_repeated(List<delta.Indexer> location) : super(location);
  Person_type Index(int i) {
    return Person_type([...location]..add(delta.Index(i)));
  }
}

class Person_type_bool_map extends delta.Locator {
  Person_type_bool_map(List<delta.Indexer> location) : super(location);
  Person_type Key(bool k) {
    return Person_type([...location]..add(delta.Key(k)));
  }
}

class Person_type_int32_map extends delta.Locator {
  Person_type_int32_map(List<delta.Indexer> location) : super(location);
  Person_type Key(int k) {
    return Person_type([...location]..add(delta.Key(k)));
  }
}

class Person_type_int64_map extends delta.Locator {
  Person_type_int64_map(List<delta.Indexer> location) : super(location);
  Person_type Key(fixnum.Int64 k) {
    return Person_type([...location]..add(delta.Key(k)));
  }
}

class Person_type_uint32_map extends delta.Locator {
  Person_type_uint32_map(List<delta.Indexer> location) : super(location);
  Person_type Key(fixnum.Int64 k) {
    return Person_type([...location]..add(delta.KeyUint32(k)));
  }
}

class Person_type_uint64_map extends delta.Locator {
  Person_type_uint64_map(List<delta.Indexer> location) : super(location);
  Person_type Key(fixnum.Int64 k) {
    return Person_type([...location]..add(delta.KeyUint64(k)));
  }
}

class Person_type_string_map extends delta.Locator {
  Person_type_string_map(List<delta.Indexer> location) : super(location);
  Person_type Key(String k) {
    return Person_type([...location]..add(delta.Key(k)));
  }
}

