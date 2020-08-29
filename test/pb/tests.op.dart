import 'package:protod/delta/delta.dart' as delta;
import 'package:protod/delta/delta.pb.dart' as delta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'tests.pb.dart' as pb;

Op_root_type get op {
  return Op_root_type();
}

class Op_root_type {
  Op_root_type();
  Person_type get person {
    return Person_type([]);
  }
  Person_Type_type get person_type {
    return Person_Type_type([]);
  }
  Person_Embed_type get person_embed {
    return Person_Embed_type([]);
  }
  Company_type get company {
    return Company_type([]);
  }
  Case_type get case_ {
    return Case_type([]);
  }
  Item_type get item {
    return Item_type([]);
  }
  Chooser_type get chooser {
    return Chooser_type([]);
  }
  Person_Choice_oneof get person_choice {
    return Person_Choice_oneof([]);
  }
  Chooser_Choice_oneof get chooser_choice {
    return Chooser_Choice_oneof([]);
  }
}

class Person_type extends delta.Location {
  Person_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  delta.Uint32_scalar get age {
    return delta.Uint32_scalar(delta.copyAndAppendField(location, "age", 2));
  }
  Case_type_string_map get cases {
    return Case_type_string_map(delta.copyAndAppendField(location, "cases", 4));
  }
  Company_type get company {
    return Company_type(delta.copyAndAppendField(location, "company", 5));
  }
  delta.String_scalar_list get alias {
    return delta.String_scalar_list(delta.copyAndAppendField(location, "alias", 6));
  }
  Person_Type_type get type {
    return Person_Type_type(delta.copyAndAppendField(location, "type", 7));
  }
  Person_Type_type_list get typeList {
    return Person_Type_type_list(delta.copyAndAppendField(location, "typeList", 8));
  }
  Person_Type_type_string_map get typeMap {
    return Person_Type_type_string_map(delta.copyAndAppendField(location, "typeMap", 9));
  }
  Person_Embed_type get embedded {
    return Person_Embed_type(delta.copyAndAppendField(location, "embedded", 10));
  }
  Person_Choice_oneof get choice {
    return Person_Choice_oneof(delta.copyAndAppendOneof(location, "choice", [delta.Field()..name="str"..number=11, delta.Field()..name="dbl"..number=12, delta.Field()..name="itm"..number=13, delta.Field()..name="cas"..number=14, delta.Field()..name="cho"..number=15]));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(pb.Person value) {
    return delta.set(location, value);
  }

}

class Person_type_list extends delta.Location {
  Person_type_list(List<delta.Locator> location) : super(location);
  Person_type index(int i) {
    return Person_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Person value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_bool_map extends delta.Location {
  Person_type_bool_map(List<delta.Locator> location) : super(location);
  Person_type key(bool key) {
    return Person_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_int32_map extends delta.Location {
  Person_type_int32_map(List<delta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_int64_map extends delta.Location {
  Person_type_int64_map(List<delta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_uint32_map extends delta.Location {
  Person_type_uint32_map(List<delta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_uint64_map extends delta.Location {
  Person_type_uint64_map(List<delta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_type_string_map extends delta.Location {
  Person_type_string_map(List<delta.Locator> location) : super(location);
  Person_type key(String key) {
    return Person_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Person> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type extends delta.Location {
  Person_Type_type(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(pb.Person_Type value) {
    return delta.set(location, delta.scalarEnum(value));
  }

}

class Person_Type_type_list extends delta.Location {
  Person_Type_type_list(List<delta.Locator> location) : super(location);
  Person_Type_type index(int i) {
    return Person_Type_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Person_Type value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarEnum(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_bool_map extends delta.Location {
  Person_Type_type_bool_map(List<delta.Locator> location) : super(location);
  Person_Type_type key(bool key) {
    return Person_Type_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_int32_map extends delta.Location {
  Person_Type_type_int32_map(List<delta.Locator> location) : super(location);
  Person_Type_type key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_int64_map extends delta.Location {
  Person_Type_type_int64_map(List<delta.Locator> location) : super(location);
  Person_Type_type key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_uint32_map extends delta.Location {
  Person_Type_type_uint32_map(List<delta.Locator> location) : super(location);
  Person_Type_type key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_uint64_map extends delta.Location {
  Person_Type_type_uint64_map(List<delta.Locator> location) : super(location);
  Person_Type_type key(int key) {
    return Person_Type_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Type_type_string_map extends delta.Location {
  Person_Type_type_string_map(List<delta.Locator> location) : super(location);
  Person_Type_type key(String key) {
    return Person_Type_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Person_Type> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type extends delta.Location {
  Person_Embed_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(pb.Person_Embed value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_list extends delta.Location {
  Person_Embed_type_list(List<delta.Locator> location) : super(location);
  Person_Embed_type index(int i) {
    return Person_Embed_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Person_Embed value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_bool_map extends delta.Location {
  Person_Embed_type_bool_map(List<delta.Locator> location) : super(location);
  Person_Embed_type key(bool key) {
    return Person_Embed_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_int32_map extends delta.Location {
  Person_Embed_type_int32_map(List<delta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_int64_map extends delta.Location {
  Person_Embed_type_int64_map(List<delta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_uint32_map extends delta.Location {
  Person_Embed_type_uint32_map(List<delta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_uint64_map extends delta.Location {
  Person_Embed_type_uint64_map(List<delta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_type_string_map extends delta.Location {
  Person_Embed_type_string_map(List<delta.Locator> location) : super(location);
  Person_Embed_type key(String key) {
    return Person_Embed_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Person_Embed> value) {
    return delta.set(location, value);
  }

}

class Company_type extends delta.Location {
  Company_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 11));
  }
  delta.Float_scalar get revenue {
    return delta.Float_scalar(delta.copyAndAppendField(location, "revenue", 12));
  }
  delta.String_scalar_int64_map get flags {
    return delta.String_scalar_int64_map(delta.copyAndAppendField(location, "flags", 13));
  }
  Person_type get ceo {
    return Person_type(delta.copyAndAppendField(location, "ceo", 14));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(pb.Company value) {
    return delta.set(location, value);
  }

}

class Company_type_list extends delta.Location {
  Company_type_list(List<delta.Locator> location) : super(location);
  Company_type index(int i) {
    return Company_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Company value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_bool_map extends delta.Location {
  Company_type_bool_map(List<delta.Locator> location) : super(location);
  Company_type key(bool key) {
    return Company_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_int32_map extends delta.Location {
  Company_type_int32_map(List<delta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_int64_map extends delta.Location {
  Company_type_int64_map(List<delta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_uint32_map extends delta.Location {
  Company_type_uint32_map(List<delta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_uint64_map extends delta.Location {
  Company_type_uint64_map(List<delta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Company_type_string_map extends delta.Location {
  Company_type_string_map(List<delta.Locator> location) : super(location);
  Company_type key(String key) {
    return Company_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Company> value) {
    return delta.set(location, value);
  }

}

class Case_type extends delta.Location {
  Case_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 21));
  }
  Item_type_list get items {
    return Item_type_list(delta.copyAndAppendField(location, "items", 22));
  }
  delta.String_scalar_int64_map get flags {
    return delta.String_scalar_int64_map(delta.copyAndAppendField(location, "flags", 23));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(pb.Case value) {
    return delta.set(location, value);
  }

}

class Case_type_list extends delta.Location {
  Case_type_list(List<delta.Locator> location) : super(location);
  Case_type index(int i) {
    return Case_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Case value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_bool_map extends delta.Location {
  Case_type_bool_map(List<delta.Locator> location) : super(location);
  Case_type key(bool key) {
    return Case_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_int32_map extends delta.Location {
  Case_type_int32_map(List<delta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_int64_map extends delta.Location {
  Case_type_int64_map(List<delta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_uint32_map extends delta.Location {
  Case_type_uint32_map(List<delta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_uint64_map extends delta.Location {
  Case_type_uint64_map(List<delta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Case_type_string_map extends delta.Location {
  Case_type_string_map(List<delta.Locator> location) : super(location);
  Case_type key(String key) {
    return Case_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Case> value) {
    return delta.set(location, value);
  }

}

class Item_type extends delta.Location {
  Item_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get title {
    return delta.String_scalar(delta.copyAndAppendField(location, "title", 31));
  }
  delta.Bool_scalar get done {
    return delta.Bool_scalar(delta.copyAndAppendField(location, "done", 34));
  }
  delta.String_scalar_list get flags {
    return delta.String_scalar_list(delta.copyAndAppendField(location, "flags", 35));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(pb.Item value) {
    return delta.set(location, value);
  }

}

class Item_type_list extends delta.Location {
  Item_type_list(List<delta.Locator> location) : super(location);
  Item_type index(int i) {
    return Item_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Item value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_bool_map extends delta.Location {
  Item_type_bool_map(List<delta.Locator> location) : super(location);
  Item_type key(bool key) {
    return Item_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_int32_map extends delta.Location {
  Item_type_int32_map(List<delta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_int64_map extends delta.Location {
  Item_type_int64_map(List<delta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_uint32_map extends delta.Location {
  Item_type_uint32_map(List<delta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_uint64_map extends delta.Location {
  Item_type_uint64_map(List<delta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Item_type_string_map extends delta.Location {
  Item_type_string_map(List<delta.Locator> location) : super(location);
  Item_type key(String key) {
    return Item_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Item> value) {
    return delta.set(location, value);
  }

}

class Chooser_type extends delta.Location {
  Chooser_type(List<delta.Locator> location) : super(location);
  Chooser_Choice_oneof get choice {
    return Chooser_Choice_oneof(delta.copyAndAppendOneof(location, "choice", [delta.Field()..name="str"..number=1, delta.Field()..name="dbl"..number=2, delta.Field()..name="itm"..number=3]));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(pb.Chooser value) {
    return delta.set(location, value);
  }

}

class Chooser_type_list extends delta.Location {
  Chooser_type_list(List<delta.Locator> location) : super(location);
  Chooser_type index(int i) {
    return Chooser_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Chooser value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_bool_map extends delta.Location {
  Chooser_type_bool_map(List<delta.Locator> location) : super(location);
  Chooser_type key(bool key) {
    return Chooser_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_int32_map extends delta.Location {
  Chooser_type_int32_map(List<delta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_int64_map extends delta.Location {
  Chooser_type_int64_map(List<delta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_uint32_map extends delta.Location {
  Chooser_type_uint32_map(List<delta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_uint64_map extends delta.Location {
  Chooser_type_uint64_map(List<delta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Chooser_type_string_map extends delta.Location {
  Chooser_type_string_map(List<delta.Locator> location) : super(location);
  Chooser_type key(String key) {
    return Chooser_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Chooser> value) {
    return delta.set(location, value);
  }

}

class Person_Choice_oneof extends delta.Location {
  Person_Choice_oneof(List<delta.Locator> location) : super(location);
  delta.String_scalar get str {
    return delta.String_scalar(delta.copyAndAppendField(location, "str", 11));
  }
  delta.Double_scalar get dbl {
    return delta.Double_scalar(delta.copyAndAppendField(location, "dbl", 12));
  }
  Item_type get itm {
    return Item_type(delta.copyAndAppendField(location, "itm", 13));
  }
  Case_type get cas {
    return Case_type(delta.copyAndAppendField(location, "cas", 14));
  }
  Chooser_type get cho {
    return Chooser_type(delta.copyAndAppendField(location, "cho", 15));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

}

class Chooser_Choice_oneof extends delta.Location {
  Chooser_Choice_oneof(List<delta.Locator> location) : super(location);
  delta.String_scalar get str {
    return delta.String_scalar(delta.copyAndAppendField(location, "str", 1));
  }
  delta.Double_scalar get dbl {
    return delta.Double_scalar(delta.copyAndAppendField(location, "dbl", 2));
  }
  Item_type get itm {
    return Item_type(delta.copyAndAppendField(location, "itm", 3));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

}

