import 'package:protod/delta.dart' as delta;
import 'package:protod/delta.pb.dart' as delta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'pb.pb.dart' as pb;

Op_root_type Op() {
  return Op_root_type();
}

class Op_root_type {
  Op_root_type();
  Person_type Person() {
    return Person_type([]);
  }
  Company_type Company() {
    return Company_type([]);
  }
  Case_type Case() {
    return Case_type([]);
  }
  Item_type Item() {
    return Item_type([]);
  }
}

class Person_type extends delta.Location {
  Person_type(List<delta.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  delta.Uint32_scalar Age() {
    return delta.Uint32_scalar(delta.copyAndAppendField(location, "age", 2));
  }
  Case_type_string_map Cases() {
    return Case_type_string_map(delta.copyAndAppendField(location, "cases", 4));
  }
  Company_type Company() {
    return Company_type(delta.copyAndAppendField(location, "company", 5));
  }
  delta.String_scalar_list Alias() {
    return delta.String_scalar_list(delta.copyAndAppendField(location, "alias", 6));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(pb.Person value) {
    return delta.replace(location, value);
  }

}

class Person_type_list extends delta.Location {
  Person_type_list(List<delta.Locator> location) : super(location);
  Person_type Index(int i) {
    return Person_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op Insert(int index, pb.Person value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveList(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(List<pb.Person> value) {
    return delta.replace(location, value);
  }

}

class Person_type_bool_map extends delta.Location {
  Person_type_bool_map(List<delta.Locator> location) : super(location);
  Person_type Key(bool key) {
    return Person_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Insert(bool key, pb.Person value) {
    return delta.insert(delta.copyAndAppendKeyBool(location, key), value);
  }

  delta.Op Move(bool from, bool to) {
    return delta.moveMap(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<bool, pb.Person> value) {
    return delta.replace(location, value);
  }

}

class Person_type_int32_map extends delta.Location {
  Person_type_int32_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Insert(int key, pb.Person value) {
    return delta.insert(delta.copyAndAppendKeyInt32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Person> value) {
    return delta.replace(location, value);
  }

}

class Person_type_int64_map extends delta.Location {
  Person_type_int64_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Person value) {
    return delta.insert(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Person> value) {
    return delta.replace(location, value);
  }

}

class Person_type_uint32_map extends delta.Location {
  Person_type_uint32_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Insert(int key, pb.Person value) {
    return delta.insert(delta.copyAndAppendKeyUint32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Person> value) {
    return delta.replace(location, value);
  }

}

class Person_type_uint64_map extends delta.Location {
  Person_type_uint64_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Person value) {
    return delta.insert(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Person> value) {
    return delta.replace(location, value);
  }

}

class Person_type_string_map extends delta.Location {
  Person_type_string_map(List<delta.Locator> location) : super(location);
  Person_type Key(String key) {
    return Person_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Insert(String key, pb.Person value) {
    return delta.insert(delta.copyAndAppendKeyString(location, key), value);
  }

  delta.Op Move(String from, String to) {
    return delta.moveMap(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<String, pb.Person> value) {
    return delta.replace(location, value);
  }

}

class Company_type extends delta.Location {
  Company_type(List<delta.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 11));
  }
  delta.Float_scalar Revenue() {
    return delta.Float_scalar(delta.copyAndAppendField(location, "revenue", 12));
  }
  delta.String_scalar_int64_map Flags() {
    return delta.String_scalar_int64_map(delta.copyAndAppendField(location, "flags", 13));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(pb.Company value) {
    return delta.replace(location, value);
  }

}

class Company_type_list extends delta.Location {
  Company_type_list(List<delta.Locator> location) : super(location);
  Company_type Index(int i) {
    return Company_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op Insert(int index, pb.Company value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveList(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(List<pb.Company> value) {
    return delta.replace(location, value);
  }

}

class Company_type_bool_map extends delta.Location {
  Company_type_bool_map(List<delta.Locator> location) : super(location);
  Company_type Key(bool key) {
    return Company_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Insert(bool key, pb.Company value) {
    return delta.insert(delta.copyAndAppendKeyBool(location, key), value);
  }

  delta.Op Move(bool from, bool to) {
    return delta.moveMap(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<bool, pb.Company> value) {
    return delta.replace(location, value);
  }

}

class Company_type_int32_map extends delta.Location {
  Company_type_int32_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Insert(int key, pb.Company value) {
    return delta.insert(delta.copyAndAppendKeyInt32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Company> value) {
    return delta.replace(location, value);
  }

}

class Company_type_int64_map extends delta.Location {
  Company_type_int64_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Company value) {
    return delta.insert(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Company> value) {
    return delta.replace(location, value);
  }

}

class Company_type_uint32_map extends delta.Location {
  Company_type_uint32_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Insert(int key, pb.Company value) {
    return delta.insert(delta.copyAndAppendKeyUint32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Company> value) {
    return delta.replace(location, value);
  }

}

class Company_type_uint64_map extends delta.Location {
  Company_type_uint64_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Company value) {
    return delta.insert(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Company> value) {
    return delta.replace(location, value);
  }

}

class Company_type_string_map extends delta.Location {
  Company_type_string_map(List<delta.Locator> location) : super(location);
  Company_type Key(String key) {
    return Company_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Insert(String key, pb.Company value) {
    return delta.insert(delta.copyAndAppendKeyString(location, key), value);
  }

  delta.Op Move(String from, String to) {
    return delta.moveMap(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<String, pb.Company> value) {
    return delta.replace(location, value);
  }

}

class Case_type extends delta.Location {
  Case_type(List<delta.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 21));
  }
  Item_type_list Items() {
    return Item_type_list(delta.copyAndAppendField(location, "items", 22));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(pb.Case value) {
    return delta.replace(location, value);
  }

}

class Case_type_list extends delta.Location {
  Case_type_list(List<delta.Locator> location) : super(location);
  Case_type Index(int i) {
    return Case_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op Insert(int index, pb.Case value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveList(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(List<pb.Case> value) {
    return delta.replace(location, value);
  }

}

class Case_type_bool_map extends delta.Location {
  Case_type_bool_map(List<delta.Locator> location) : super(location);
  Case_type Key(bool key) {
    return Case_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Insert(bool key, pb.Case value) {
    return delta.insert(delta.copyAndAppendKeyBool(location, key), value);
  }

  delta.Op Move(bool from, bool to) {
    return delta.moveMap(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<bool, pb.Case> value) {
    return delta.replace(location, value);
  }

}

class Case_type_int32_map extends delta.Location {
  Case_type_int32_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Insert(int key, pb.Case value) {
    return delta.insert(delta.copyAndAppendKeyInt32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Case> value) {
    return delta.replace(location, value);
  }

}

class Case_type_int64_map extends delta.Location {
  Case_type_int64_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Case value) {
    return delta.insert(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Case> value) {
    return delta.replace(location, value);
  }

}

class Case_type_uint32_map extends delta.Location {
  Case_type_uint32_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Insert(int key, pb.Case value) {
    return delta.insert(delta.copyAndAppendKeyUint32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Case> value) {
    return delta.replace(location, value);
  }

}

class Case_type_uint64_map extends delta.Location {
  Case_type_uint64_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Case value) {
    return delta.insert(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Case> value) {
    return delta.replace(location, value);
  }

}

class Case_type_string_map extends delta.Location {
  Case_type_string_map(List<delta.Locator> location) : super(location);
  Case_type Key(String key) {
    return Case_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Insert(String key, pb.Case value) {
    return delta.insert(delta.copyAndAppendKeyString(location, key), value);
  }

  delta.Op Move(String from, String to) {
    return delta.moveMap(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<String, pb.Case> value) {
    return delta.replace(location, value);
  }

}

class Item_type extends delta.Location {
  Item_type(List<delta.Locator> location) : super(location);
  delta.String_scalar Title() {
    return delta.String_scalar(delta.copyAndAppendField(location, "title", 31));
  }
  delta.Bool_scalar Done() {
    return delta.Bool_scalar(delta.copyAndAppendField(location, "done", 34));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(pb.Item value) {
    return delta.replace(location, value);
  }

}

class Item_type_list extends delta.Location {
  Item_type_list(List<delta.Locator> location) : super(location);
  Item_type Index(int i) {
    return Item_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op Insert(int index, pb.Item value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveList(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(List<pb.Item> value) {
    return delta.replace(location, value);
  }

}

class Item_type_bool_map extends delta.Location {
  Item_type_bool_map(List<delta.Locator> location) : super(location);
  Item_type Key(bool key) {
    return Item_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Insert(bool key, pb.Item value) {
    return delta.insert(delta.copyAndAppendKeyBool(location, key), value);
  }

  delta.Op Move(bool from, bool to) {
    return delta.moveMap(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<bool, pb.Item> value) {
    return delta.replace(location, value);
  }

}

class Item_type_int32_map extends delta.Location {
  Item_type_int32_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Insert(int key, pb.Item value) {
    return delta.insert(delta.copyAndAppendKeyInt32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Item> value) {
    return delta.replace(location, value);
  }

}

class Item_type_int64_map extends delta.Location {
  Item_type_int64_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Item value) {
    return delta.insert(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Item> value) {
    return delta.replace(location, value);
  }

}

class Item_type_uint32_map extends delta.Location {
  Item_type_uint32_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Insert(int key, pb.Item value) {
    return delta.insert(delta.copyAndAppendKeyUint32(location, key), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<int, pb.Item> value) {
    return delta.replace(location, value);
  }

}

class Item_type_uint64_map extends delta.Location {
  Item_type_uint64_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Insert(int key, pb.Item value) {
    return delta.insert(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.moveMap(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<fixnum.Int64, pb.Item> value) {
    return delta.replace(location, value);
  }

}

class Item_type_string_map extends delta.Location {
  Item_type_string_map(List<delta.Locator> location) : super(location);
  Item_type Key(String key) {
    return Item_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Insert(String key, pb.Item value) {
    return delta.insert(delta.copyAndAppendKeyString(location, key), value);
  }

  delta.Op Move(String from, String to) {
    return delta.moveMap(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Replace(Map<String, pb.Item> value) {
    return delta.replace(location, value);
  }

}

