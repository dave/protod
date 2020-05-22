import 'package:protod/delta.dart' as delta;
import 'package:protod/delta.pb.dart' as pb;
import 'package:fixnum/fixnum.dart' as fixnum;

Person_type PersonDef() {
  return Person_type([]);
}

class Person_type extends delta.Location {
  Person_type(List<pb.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "name"..number = 1)));
  }
  delta.Uint32_scalar Age() {
    return delta.Uint32_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "age"..number = 2)));
  }
  Case_type_string_map Cases() {
    return Case_type_string_map([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "cases"..number = 4)));
  }
  Company_type Company() {
    return Company_type([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "company"..number = 5)));
  }
  delta.String_scalar_repeated Alias() {
    return delta.String_scalar_repeated([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "alias"..number = 6)));
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

Company_type CompanyDef() {
  return Company_type([]);
}

class Company_type extends delta.Location {
  Company_type(List<pb.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "name"..number = 11)));
  }
  delta.Float_scalar Revenue() {
    return delta.Float_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "revenue"..number = 12)));
  }
  delta.String_scalar_int64_map Flags() {
    return delta.String_scalar_int64_map([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "flags"..number = 13)));
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
    return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "name"..number = 21)));
  }
  Item_type_repeated Items() {
    return Item_type_repeated([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "items"..number = 22)));
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

Item_type ItemDef() {
  return Item_type([]);
}

class Item_type extends delta.Location {
  Item_type(List<pb.Locator> location) : super(location);
  delta.String_scalar Title() {
    return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "title"..number = 31)));
  }
  delta.Bool_scalar Done() {
    return delta.Bool_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "done"..number = 34)));
  }
}

class Item_type_repeated extends delta.Location {
  Item_type_repeated(List<pb.Locator> location) : super(location);
  Item_type Index(int i) {
    return Item_type([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Item_type Index64(fixnum.Int64 i) {
    return Item_type([...location]..add(pb.Locator()..index = i));
  }
}

class Item_type_bool_map extends delta.Location {
  Item_type_bool_map(List<pb.Locator> location) : super(location);
  Item_type Key(bool k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Item_type_int32_map extends delta.Location {
  Item_type_int32_map(List<pb.Locator> location) : super(location);
  Item_type Key(int k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Item_type_int64_map extends delta.Location {
  Item_type_int64_map(List<pb.Locator> location) : super(location);
  Item_type Key(int k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Item_type Key64(fixnum.Int64 k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Item_type_uint32_map extends delta.Location {
  Item_type_uint32_map(List<pb.Locator> location) : super(location);
  Item_type Key(int k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Item_type_uint64_map extends delta.Location {
  Item_type_uint64_map(List<pb.Locator> location) : super(location);
  Item_type Key(int k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Item_type Key64(fixnum.Int64 k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Item_type_string_map extends delta.Location {
  Item_type_string_map(List<pb.Locator> location) : super(location);
  Item_type Key(String k) {
    return Item_type([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

