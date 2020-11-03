import 'package:protod/delta/delta.dart' as delta;
import 'package:protod/delta/delta.pb.dart' as delta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protod/delta/delta.op.dart' as delta;
import '../tests2/tests2.op.dart' as tests2;
import '../tests2/tests3/tests3.op.dart' as tests3;
import 'tests1.pb.dart' as pb;
import 'tests.pb.dart' as pb;

Op_root_type get op {
  return Op_root_type();
}

class Op_root_type {
  Op_root_type();
  Case_type get case_ {
    return Case_type([]);
  }
  Chooser_type get chooser {
    return Chooser_type([]);
  }
  Chooser_Choice_oneof get chooser_choice {
    return Chooser_Choice_oneof([]);
  }
  Company_type get company {
    return Company_type([]);
  }
  House_type get house {
    return House_type([]);
  }
  Item_type get item {
    return Item_type([]);
  }
  Person_type get person {
    return Person_type([]);
  }
  Person_Choice_oneof get person_choice {
    return Person_Choice_oneof([]);
  }
  Person_Embed_type get person_embed {
    return Person_Embed_type([]);
  }
  Person_Embed_Double_type get person_embed_double {
    return Person_Embed_Double_type([]);
  }
  Person_Embed_Double_Foo_oneof get person_embed_double_foo {
    return Person_Embed_Double_Foo_oneof([]);
  }
}

class Case_type extends delta.Location {
  Case_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 21));
  }
  Item_list get items {
    return Item_list(delta.copyAndAppendField(location, "items", 22));
  }
  delta.String_int64_map get flags {
    return delta.String_int64_map(delta.copyAndAppendField(location, "flags", 23));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Case_list extends delta.Location {
  Case_list(List<delta.Locator> location) : super(location);
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

class Case_bool_map extends delta.Location {
  Case_bool_map(List<delta.Locator> location) : super(location);
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

class Case_int32_map extends delta.Location {
  Case_int32_map(List<delta.Locator> location) : super(location);
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

class Case_int64_map extends delta.Location {
  Case_int64_map(List<delta.Locator> location) : super(location);
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

class Case_uint32_map extends delta.Location {
  Case_uint32_map(List<delta.Locator> location) : super(location);
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

class Case_uint64_map extends delta.Location {
  Case_uint64_map(List<delta.Locator> location) : super(location);
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

class Case_string_map extends delta.Location {
  Case_string_map(List<delta.Locator> location) : super(location);
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

class Chooser_type extends delta.Location {
  Chooser_type(List<delta.Locator> location) : super(location);
  Chooser_Choice_oneof get choice {
    return Chooser_Choice_oneof(delta.copyAndAppendOneof(location, "choice", [delta.Field()..name="str"..number=1, delta.Field()..name="dbl"..number=2, delta.Field()..name="itm"..number=3]));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Chooser_list extends delta.Location {
  Chooser_list(List<delta.Locator> location) : super(location);
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

class Chooser_bool_map extends delta.Location {
  Chooser_bool_map(List<delta.Locator> location) : super(location);
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

class Chooser_int32_map extends delta.Location {
  Chooser_int32_map(List<delta.Locator> location) : super(location);
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

class Chooser_int64_map extends delta.Location {
  Chooser_int64_map(List<delta.Locator> location) : super(location);
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

class Chooser_uint32_map extends delta.Location {
  Chooser_uint32_map(List<delta.Locator> location) : super(location);
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

class Chooser_uint64_map extends delta.Location {
  Chooser_uint64_map(List<delta.Locator> location) : super(location);
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

class Chooser_string_map extends delta.Location {
  Chooser_string_map(List<delta.Locator> location) : super(location);
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

class Company_type extends delta.Location {
  Company_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 11));
  }
  delta.Float_scalar get revenue {
    return delta.Float_scalar(delta.copyAndAppendField(location, "revenue", 12));
  }
  delta.String_int64_map get flags {
    return delta.String_int64_map(delta.copyAndAppendField(location, "flags", 13));
  }
  Person_type get ceo {
    return Person_type(delta.copyAndAppendField(location, "ceo", 14));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Company_list extends delta.Location {
  Company_list(List<delta.Locator> location) : super(location);
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

class Company_bool_map extends delta.Location {
  Company_bool_map(List<delta.Locator> location) : super(location);
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

class Company_int32_map extends delta.Location {
  Company_int32_map(List<delta.Locator> location) : super(location);
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

class Company_int64_map extends delta.Location {
  Company_int64_map(List<delta.Locator> location) : super(location);
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

class Company_uint32_map extends delta.Location {
  Company_uint32_map(List<delta.Locator> location) : super(location);
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

class Company_uint64_map extends delta.Location {
  Company_uint64_map(List<delta.Locator> location) : super(location);
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

class Company_string_map extends delta.Location {
  Company_string_map(List<delta.Locator> location) : super(location);
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

class House_type extends delta.Location {
  House_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  delta.Uint32_scalar get number {
    return delta.Uint32_scalar(delta.copyAndAppendField(location, "number", 2));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class House_list extends delta.Location {
  House_list(List<delta.Locator> location) : super(location);
  House_type index(int i) {
    return House_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.House value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.House> value) {
    return delta.set(location, value);
  }

}

class House_bool_map extends delta.Location {
  House_bool_map(List<delta.Locator> location) : super(location);
  House_type key(bool key) {
    return House_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.House> value) {
    return delta.set(location, value);
  }

}

class House_int32_map extends delta.Location {
  House_int32_map(List<delta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.House> value) {
    return delta.set(location, value);
  }

}

class House_int64_map extends delta.Location {
  House_int64_map(List<delta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.House> value) {
    return delta.set(location, value);
  }

}

class House_uint32_map extends delta.Location {
  House_uint32_map(List<delta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.House> value) {
    return delta.set(location, value);
  }

}

class House_uint64_map extends delta.Location {
  House_uint64_map(List<delta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.House> value) {
    return delta.set(location, value);
  }

}

class House_string_map extends delta.Location {
  House_string_map(List<delta.Locator> location) : super(location);
  House_type key(String key) {
    return House_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.House> value) {
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
  delta.String_list get flags {
    return delta.String_list(delta.copyAndAppendField(location, "flags", 35));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Item_list extends delta.Location {
  Item_list(List<delta.Locator> location) : super(location);
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

class Item_bool_map extends delta.Location {
  Item_bool_map(List<delta.Locator> location) : super(location);
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

class Item_int32_map extends delta.Location {
  Item_int32_map(List<delta.Locator> location) : super(location);
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

class Item_int64_map extends delta.Location {
  Item_int64_map(List<delta.Locator> location) : super(location);
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

class Item_uint32_map extends delta.Location {
  Item_uint32_map(List<delta.Locator> location) : super(location);
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

class Item_uint64_map extends delta.Location {
  Item_uint64_map(List<delta.Locator> location) : super(location);
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

class Item_string_map extends delta.Location {
  Item_string_map(List<delta.Locator> location) : super(location);
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

class Person_type extends delta.Location {
  Person_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  delta.Uint32_scalar get age {
    return delta.Uint32_scalar(delta.copyAndAppendField(location, "age", 2));
  }
  Case_string_map get cases {
    return Case_string_map(delta.copyAndAppendField(location, "cases", 4));
  }
  Company_type get company {
    return Company_type(delta.copyAndAppendField(location, "company", 5));
  }
  delta.String_list get alias {
    return delta.String_list(delta.copyAndAppendField(location, "alias", 6));
  }
  Person_Type_enum get type {
    return Person_Type_enum(delta.copyAndAppendField(location, "type", 7));
  }
  Person_Type_list get typeList {
    return Person_Type_list(delta.copyAndAppendField(location, "typeList", 8));
  }
  Person_Type_string_map get typeMap {
    return Person_Type_string_map(delta.copyAndAppendField(location, "typeMap", 9));
  }
  Person_Embed_type get embedded {
    return Person_Embed_type(delta.copyAndAppendField(location, "embedded", 10));
  }
  Person_Choice_oneof get choice {
    return Person_Choice_oneof(delta.copyAndAppendOneof(location, "choice", [delta.Field()..name="str"..number=11, delta.Field()..name="dbl"..number=12, delta.Field()..name="itm"..number=13, delta.Field()..name="cas"..number=14, delta.Field()..name="cho"..number=15]));
  }
  House_type get house {
    return House_type(delta.copyAndAppendField(location, "house", 16));
  }
  tests2.Shirt_type get shirt {
    return tests2.Shirt_type(delta.copyAndAppendField(location, "shirt", 17));
  }
  tests3.Pants_type get pants {
    return tests3.Pants_type(delta.copyAndAppendField(location, "pants", 18));
  }
  Person_Embed_Double_type get double {
    return Person_Embed_Double_type(delta.copyAndAppendField(location, "double", 19));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Person_list extends delta.Location {
  Person_list(List<delta.Locator> location) : super(location);
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

class Person_bool_map extends delta.Location {
  Person_bool_map(List<delta.Locator> location) : super(location);
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

class Person_int32_map extends delta.Location {
  Person_int32_map(List<delta.Locator> location) : super(location);
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

class Person_int64_map extends delta.Location {
  Person_int64_map(List<delta.Locator> location) : super(location);
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

class Person_uint32_map extends delta.Location {
  Person_uint32_map(List<delta.Locator> location) : super(location);
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

class Person_uint64_map extends delta.Location {
  Person_uint64_map(List<delta.Locator> location) : super(location);
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

class Person_string_map extends delta.Location {
  Person_string_map(List<delta.Locator> location) : super(location);
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

class Person_Embed_type extends delta.Location {
  Person_Embed_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Person_Embed_list extends delta.Location {
  Person_Embed_list(List<delta.Locator> location) : super(location);
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

class Person_Embed_bool_map extends delta.Location {
  Person_Embed_bool_map(List<delta.Locator> location) : super(location);
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

class Person_Embed_int32_map extends delta.Location {
  Person_Embed_int32_map(List<delta.Locator> location) : super(location);
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

class Person_Embed_int64_map extends delta.Location {
  Person_Embed_int64_map(List<delta.Locator> location) : super(location);
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

class Person_Embed_uint32_map extends delta.Location {
  Person_Embed_uint32_map(List<delta.Locator> location) : super(location);
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

class Person_Embed_uint64_map extends delta.Location {
  Person_Embed_uint64_map(List<delta.Locator> location) : super(location);
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

class Person_Embed_string_map extends delta.Location {
  Person_Embed_string_map(List<delta.Locator> location) : super(location);
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

class Person_Embed_Double_type extends delta.Location {
  Person_Embed_Double_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get name {
    return delta.String_scalar(delta.copyAndAppendField(location, "name", 1));
  }
  Person_Embed_Double_Foo_oneof get foo {
    return Person_Embed_Double_Foo_oneof(delta.copyAndAppendOneof(location, "foo", [delta.Field()..name="bar"..number=2, delta.Field()..name="baz"..number=3]));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_list extends delta.Location {
  Person_Embed_Double_list(List<delta.Locator> location) : super(location);
  Person_Embed_Double_type index(int i) {
    return Person_Embed_Double_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Person_Embed_Double value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Person_Embed_Double> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_bool_map extends delta.Location {
  Person_Embed_Double_bool_map(List<delta.Locator> location) : super(location);
  Person_Embed_Double_type key(bool key) {
    return Person_Embed_Double_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Person_Embed_Double> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_int32_map extends delta.Location {
  Person_Embed_Double_int32_map(List<delta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person_Embed_Double> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_int64_map extends delta.Location {
  Person_Embed_Double_int64_map(List<delta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person_Embed_Double> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_uint32_map extends delta.Location {
  Person_Embed_Double_uint32_map(List<delta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Person_Embed_Double> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_uint64_map extends delta.Location {
  Person_Embed_Double_uint64_map(List<delta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Person_Embed_Double> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_string_map extends delta.Location {
  Person_Embed_Double_string_map(List<delta.Locator> location) : super(location);
  Person_Embed_Double_type key(String key) {
    return Person_Embed_Double_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Person_Embed_Double> value) {
    return delta.set(location, value);
  }

}

class Person_Embed_Double_Foo_oneof extends delta.Location {
  Person_Embed_Double_Foo_oneof(List<delta.Locator> location) : super(location);
  delta.String_scalar get bar {
    return delta.String_scalar(delta.copyAndAppendField(location, "bar", 2));
  }
  delta.Int64_scalar get baz {
    return delta.Int64_scalar(delta.copyAndAppendField(location, "baz", 3));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

}

class Person_Type_enum extends delta.Location {
  Person_Type_enum(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, delta.scalarEnum(value));
  }

}

class Person_Type_list extends delta.Location {
  Person_Type_list(List<delta.Locator> location) : super(location);
  Person_Type_enum index(int i) {
    return Person_Type_enum(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
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

class Person_Type_bool_map extends delta.Location {
  Person_Type_bool_map(List<delta.Locator> location) : super(location);
  Person_Type_enum key(bool key) {
    return Person_Type_enum(delta.copyAndAppendKeyBool(location, key));
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

class Person_Type_int32_map extends delta.Location {
  Person_Type_int32_map(List<delta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(delta.copyAndAppendKeyInt32(location, key));
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

class Person_Type_int64_map extends delta.Location {
  Person_Type_int64_map(List<delta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
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

class Person_Type_uint32_map extends delta.Location {
  Person_Type_uint32_map(List<delta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(delta.copyAndAppendKeyUint32(location, key));
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

class Person_Type_uint64_map extends delta.Location {
  Person_Type_uint64_map(List<delta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
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

class Person_Type_string_map extends delta.Location {
  Person_Type_string_map(List<delta.Locator> location) : super(location);
  Person_Type_enum key(String key) {
    return Person_Type_enum(delta.copyAndAppendKeyString(location, key));
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

