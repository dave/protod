import 'package:protod/delta.dart' as delta;
import 'package:protod/delta.pb.dart' as pb;
import 'package:fixnum/fixnum.dart' as fixnum;

Company_type CompanyDef() {
  return Company_type([]);
}

class Company_type extends delta.Location {
  Company_type(List<pb.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "name"..number = 11)));
  }
}

class Company_type_repeated extends delta.Location {
  Company_type_repeated(List<pb.Locator> location) : super(location);
  Company_type Index(int i) {
    return Company_type([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Company_type Index64(fixnum.Int64 i) {
    return Company_type([...location]..add(pb.Locator()..index = i));
  }
}

class Company_type_bool_map extends delta.Location {
  Company_type_bool_map(List<pb.Locator> location) : super(location);
  Company_type Key(bool k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Company_type_int32_map extends delta.Location {
  Company_type_int32_map(List<pb.Locator> location) : super(location);
  Company_type Key(int k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Company_type_int64_map extends delta.Location {
  Company_type_int64_map(List<pb.Locator> location) : super(location);
  Company_type Key(int k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Company_type Key64(fixnum.Int64 k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Company_type_uint32_map extends delta.Location {
  Company_type_uint32_map(List<pb.Locator> location) : super(location);
  Company_type Key(int k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Company_type_uint64_map extends delta.Location {
  Company_type_uint64_map(List<pb.Locator> location) : super(location);
  Company_type Key(int k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Company_type Key64(fixnum.Int64 k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Company_type_string_map extends delta.Location {
  Company_type_string_map(List<pb.Locator> location) : super(location);
  Company_type Key(String k) {
    return Company_type([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

Case_type CaseDef() {
  return Case_type([]);
}

class Case_type extends delta.Location {
  Case_type(List<pb.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "name"..number = 12)));
  }
}

class Case_type_repeated extends delta.Location {
  Case_type_repeated(List<pb.Locator> location) : super(location);
  Case_type Index(int i) {
    return Case_type([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Case_type Index64(fixnum.Int64 i) {
    return Case_type([...location]..add(pb.Locator()..index = i));
  }
}

class Case_type_bool_map extends delta.Location {
  Case_type_bool_map(List<pb.Locator> location) : super(location);
  Case_type Key(bool k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Case_type_int32_map extends delta.Location {
  Case_type_int32_map(List<pb.Locator> location) : super(location);
  Case_type Key(int k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Case_type_int64_map extends delta.Location {
  Case_type_int64_map(List<pb.Locator> location) : super(location);
  Case_type Key(int k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Case_type Key64(fixnum.Int64 k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Case_type_uint32_map extends delta.Location {
  Case_type_uint32_map(List<pb.Locator> location) : super(location);
  Case_type Key(int k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Case_type_uint64_map extends delta.Location {
  Case_type_uint64_map(List<pb.Locator> location) : super(location);
  Case_type Key(int k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Case_type Key64(fixnum.Int64 k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Case_type_string_map extends delta.Location {
  Case_type_string_map(List<pb.Locator> location) : super(location);
  Case_type Key(String k) {
    return Case_type([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

Person_type PersonDef() {
  return Person_type([]);
}

class Person_type extends delta.Location {
  Person_type(List<pb.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "name"..number = 13)));
  }
  delta.Uint32_scalar Age() {
    return delta.Uint32_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "age"..number = 14)));
  }
  Case_type_repeated Cases() {
    return Case_type_repeated([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "cases"..number = 15)));
  }
  Case_type_string_map CasesStringMap() {
    return Case_type_string_map([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "casesStringMap"..number = 16)));
  }
  Case_type_int32_map CasesIntMap() {
    return Case_type_int32_map([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "casesIntMap"..number = 17)));
  }
  Company_type Company() {
    return Company_type([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "company"..number = 18)));
  }
}

class Person_type_repeated extends delta.Location {
  Person_type_repeated(List<pb.Locator> location) : super(location);
  Person_type Index(int i) {
    return Person_type([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Person_type Index64(fixnum.Int64 i) {
    return Person_type([...location]..add(pb.Locator()..index = i));
  }
}

class Person_type_bool_map extends delta.Location {
  Person_type_bool_map(List<pb.Locator> location) : super(location);
  Person_type Key(bool k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Person_type_int32_map extends delta.Location {
  Person_type_int32_map(List<pb.Locator> location) : super(location);
  Person_type Key(int k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Person_type_int64_map extends delta.Location {
  Person_type_int64_map(List<pb.Locator> location) : super(location);
  Person_type Key(int k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Person_type Key64(fixnum.Int64 k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Person_type_uint32_map extends delta.Location {
  Person_type_uint32_map(List<pb.Locator> location) : super(location);
  Person_type Key(int k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Person_type_uint64_map extends delta.Location {
  Person_type_uint64_map(List<pb.Locator> location) : super(location);
  Person_type Key(int k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Person_type Key64(fixnum.Int64 k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Person_type_string_map extends delta.Location {
  Person_type_string_map(List<pb.Locator> location) : super(location);
  Person_type Key(String k) {
    return Person_type([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

