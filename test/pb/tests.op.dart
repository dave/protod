import 'package:protod/delta/delta.dart' as delta;
import 'package:protod/delta/delta.pb.dart' as delta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'tests.pb.dart' as pb;

Op_root_type Op() {
  return Op_root_type();
}

class Op_root_type {
  Op_root_type();
  Person_type Person() {
    return Person_type([]);
  }
  Person_Type_type Person_Type() {
    return Person_Type_type([]);
  }
  Person_Embed_type Person_Embed() {
    return Person_Embed_type([]);
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
  Chooser_type Chooser() {
    return Chooser_type([]);
  }
  Chooser_Choice_oneof Chooser_Choice() {
    return Chooser_Choice_oneof([]);
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
  Person_Type_type Type() {
    return Person_Type_type(delta.copyAndAppendField(location, "type", 7));
  }
  Person_Type_type_list TypeList() {
    return Person_Type_type_list(delta.copyAndAppendField(location, "typeList", 8));
  }
  Person_Type_type_string_map TypeMap() {
    return Person_Type_type_string_map(delta.copyAndAppendField(location, "typeMap", 9));
  }
  Person_Embed_type Embedded() {
    return Person_Embed_type(delta.copyAndAppendField(location, "embedded", 10));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(pb.Person value) {
    return delta.set(location, value);
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
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(List<pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_bool_map extends delta.Location {
  Person_type_bool_map(List<delta.Locator> location) : super(location);
  Person_type Key(bool key) {
    return Person_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<bool, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_int32_map extends delta.Location {
  Person_type_int32_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_int64_map extends delta.Location {
  Person_type_int64_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_uint32_map extends delta.Location {
  Person_type_uint32_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_uint64_map extends delta.Location {
  Person_type_uint64_map(List<delta.Locator> location) : super(location);
  Person_type Key(int key) {
    return Person_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_string_map extends delta.Location {
  Person_type_string_map(List<delta.Locator> location) : super(location);
  Person_type Key(String key) {
    return Person_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<String, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type extends delta.Location {
  Person_Type_type(List<delta.Locator> location) : super(location);
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(pb.Person_Type value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_list extends delta.Location {
  Person_Type_type_list(List<delta.Locator> location) : super(location);
  Person_Type_type Index(int i) {
    return Person_Type_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op Insert(int index, pb.Person_Type value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(List<pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_bool_map extends delta.Location {
  Person_Type_type_bool_map(List<delta.Locator> location) : super(location);
  Person_Type_type Key(bool key) {
    return Person_Type_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<bool, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_int32_map extends delta.Location {
  Person_Type_type_int32_map(List<delta.Locator> location) : super(location);
  Person_Type_type Key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_int64_map extends delta.Location {
  Person_Type_type_int64_map(List<delta.Locator> location) : super(location);
  Person_Type_type Key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_uint32_map extends delta.Location {
  Person_Type_type_uint32_map(List<delta.Locator> location) : super(location);
  Person_Type_type Key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_uint64_map extends delta.Location {
  Person_Type_type_uint64_map(List<delta.Locator> location) : super(location);
  Person_Type_type Key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_string_map extends delta.Location {
  Person_Type_type_string_map(List<delta.Locator> location) : super(location);
  Person_Type_type Key(String key) {
    return Person_Type_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<String, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type extends delta.Location {
  Person_Embed_type(List<delta.Locator> location) : super(location);
  delta.String_scalar Name() {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(pb.Person_Embed value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_list extends delta.Location {
  Person_Embed_type_list(List<delta.Locator> location) : super(location);
  Person_Embed_type Index(int i) {
    return Person_Embed_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op Insert(int index, pb.Person_Embed value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(List<pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_bool_map extends delta.Location {
  Person_Embed_type_bool_map(List<delta.Locator> location) : super(location);
  Person_Embed_type Key(bool key) {
    return Person_Embed_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<bool, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_int32_map extends delta.Location {
  Person_Embed_type_int32_map(List<delta.Locator> location) : super(location);
  Person_Embed_type Key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_int64_map extends delta.Location {
  Person_Embed_type_int64_map(List<delta.Locator> location) : super(location);
  Person_Embed_type Key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_uint32_map extends delta.Location {
  Person_Embed_type_uint32_map(List<delta.Locator> location) : super(location);
  Person_Embed_type Key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_uint64_map extends delta.Location {
  Person_Embed_type_uint64_map(List<delta.Locator> location) : super(location);
  Person_Embed_type Key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_string_map extends delta.Location {
  Person_Embed_type_string_map(List<delta.Locator> location) : super(location);
  Person_Embed_type Key(String key) {
    return Person_Embed_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<String, pb.Person_Embed> value) {
    return delta.set(location, value);
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
  Person_type Ceo() {
    return Person_type(delta.copyAndAppendField(location, "ceo", 14));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(pb.Company value) {
    return delta.set(location, value);
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
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(List<pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_bool_map extends delta.Location {
  Company_type_bool_map(List<delta.Locator> location) : super(location);
  Company_type Key(bool key) {
    return Company_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<bool, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_int32_map extends delta.Location {
  Company_type_int32_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_int64_map extends delta.Location {
  Company_type_int64_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_uint32_map extends delta.Location {
  Company_type_uint32_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_uint64_map extends delta.Location {
  Company_type_uint64_map(List<delta.Locator> location) : super(location);
  Company_type Key(int key) {
    return Company_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_string_map extends delta.Location {
  Company_type_string_map(List<delta.Locator> location) : super(location);
  Company_type Key(String key) {
    return Company_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<String, pb.Company> value) {
    return delta.set(location, value);
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
  delta.String_scalar_int64_map Flags() {
    return delta.String_scalar_int64_map(delta.copyAndAppendField(location, "flags", 23));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(pb.Case value) {
    return delta.set(location, value);
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
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(List<pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_bool_map extends delta.Location {
  Case_type_bool_map(List<delta.Locator> location) : super(location);
  Case_type Key(bool key) {
    return Case_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<bool, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_int32_map extends delta.Location {
  Case_type_int32_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_int64_map extends delta.Location {
  Case_type_int64_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_uint32_map extends delta.Location {
  Case_type_uint32_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_uint64_map extends delta.Location {
  Case_type_uint64_map(List<delta.Locator> location) : super(location);
  Case_type Key(int key) {
    return Case_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_string_map extends delta.Location {
  Case_type_string_map(List<delta.Locator> location) : super(location);
  Case_type Key(String key) {
    return Case_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<String, pb.Case> value) {
    return delta.set(location, value);
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
  delta.String_scalar_list Flags() {
    return delta.String_scalar_list(delta.copyAndAppendField(location, "flags", 35));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(pb.Item value) {
    return delta.set(location, value);
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
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(List<pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_bool_map extends delta.Location {
  Item_type_bool_map(List<delta.Locator> location) : super(location);
  Item_type Key(bool key) {
    return Item_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<bool, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_int32_map extends delta.Location {
  Item_type_int32_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_int64_map extends delta.Location {
  Item_type_int64_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_uint32_map extends delta.Location {
  Item_type_uint32_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_uint64_map extends delta.Location {
  Item_type_uint64_map(List<delta.Locator> location) : super(location);
  Item_type Key(int key) {
    return Item_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_string_map extends delta.Location {
  Item_type_string_map(List<delta.Locator> location) : super(location);
  Item_type Key(String key) {
    return Item_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<String, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Chooser_type extends delta.Location {
  Chooser_type(List<delta.Locator> location) : super(location);
  Chooser_Choice_oneof Choice() {
    return Chooser_Choice_oneof(delta.copyAndAppendOneof(location, "choice", [delta.Field()..name="str"..number=1, delta.Field()..name="dbl"..number=2, delta.Field()..name="itm"..number=3]));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(pb.Chooser value) {
    return delta.set(location, value);
  }

}

class Chooser_type_list extends delta.Location {
  Chooser_type_list(List<delta.Locator> location) : super(location);
  Chooser_type Index(int i) {
    return Chooser_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op Insert(int index, pb.Chooser value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op Move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(List<pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_bool_map extends delta.Location {
  Chooser_type_bool_map(List<delta.Locator> location) : super(location);
  Chooser_type Key(bool key) {
    return Chooser_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op Rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<bool, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_int32_map extends delta.Location {
  Chooser_type_int32_map(List<delta.Locator> location) : super(location);
  Chooser_type Key(int key) {
    return Chooser_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_int64_map extends delta.Location {
  Chooser_type_int64_map(List<delta.Locator> location) : super(location);
  Chooser_type Key(int key) {
    return Chooser_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_uint32_map extends delta.Location {
  Chooser_type_uint32_map(List<delta.Locator> location) : super(location);
  Chooser_type Key(int key) {
    return Chooser_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<int, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_uint64_map extends delta.Location {
  Chooser_type_uint64_map(List<delta.Locator> location) : super(location);
  Chooser_type Key(int key) {
    return Chooser_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op Rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<fixnum.Int64, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_string_map extends delta.Location {
  Chooser_type_string_map(List<delta.Locator> location) : super(location);
  Chooser_type Key(String key) {
    return Chooser_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op Rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op Delete() {
    return delta.delete(location);
  }

  delta.Op Set(Map<String, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_Choice_oneof extends delta.Location {
  Chooser_Choice_oneof(List<delta.Locator> location) : super(location);
  delta.String_scalar Str() {
    return delta.String_scalar(delta.copyAndAppendField(location, "str", 1));
  }
  delta.Double_scalar Dbl() {
    return delta.Double_scalar(delta.copyAndAppendField(location, "dbl", 2));
  }
  Item_type Itm() {
    return Item_type(delta.copyAndAppendField(location, "itm", 3));
  }
  delta.Op Delete() {
    return delta.delete(location);
  }

}

