import 'package:pdelta/pdelta/pdelta.dart' as pdelta;
import 'package:pdelta/pdelta/pdelta.pb.dart' as pdelta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:pdelta/pdelta/pdelta.op.dart' as pkg_pdelta_pdelta_pdelta;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/pdelta_tests_clothes.op.dart' as pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/pants/pants.op.dart' as pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants;
import 'package:pdelta_tests/pdelta_tests/house.pb.dart' as pb;
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart' as pb;
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart' as pkg_pdelta_tests_pdelta_tests_pdelta_tests;
import 'package:pdelta_tests/pdelta_tests/house.pb.dart' as pkg_pdelta_tests_pdelta_tests_pdelta_tests;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/shirt.pb.dart' as pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/pants/pants.pb.dart' as pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants;

Op_root_type get op {
  _init();
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

class Case_type extends pdelta.Location {
  Case_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get name {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Case", "name", 21));
  }
  Item_list get items {
    return Item_list(pdelta.copyAndAppendField(location, "pdelta_tests.Case", "items", 22));
  }
  pkg_pdelta_pdelta_pdelta.String_int64_map get flags {
    return pkg_pdelta_pdelta_pdelta.String_int64_map(pdelta.copyAndAppendField(location, "pdelta_tests.Case", "flags", 23));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Case value) {
    return pdelta.set(location, value);
  }

}

class Case_list extends pdelta.Location {
  Case_list(List<pdelta.Locator> location) : super(location);
  Case_type index(int i) {
    return Case_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Case value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Case> value) {
    return pdelta.set(location, value);
  }

}

class Case_bool_map extends pdelta.Location {
  Case_bool_map(List<pdelta.Locator> location) : super(location);
  Case_type key(bool key) {
    return Case_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Case> value) {
    return pdelta.set(location, value);
  }

}

class Case_int32_map extends pdelta.Location {
  Case_int32_map(List<pdelta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Case> value) {
    return pdelta.set(location, value);
  }

}

class Case_int64_map extends pdelta.Location {
  Case_int64_map(List<pdelta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Case> value) {
    return pdelta.set(location, value);
  }

}

class Case_uint32_map extends pdelta.Location {
  Case_uint32_map(List<pdelta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Case> value) {
    return pdelta.set(location, value);
  }

}

class Case_uint64_map extends pdelta.Location {
  Case_uint64_map(List<pdelta.Locator> location) : super(location);
  Case_type key(int key) {
    return Case_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Case> value) {
    return pdelta.set(location, value);
  }

}

class Case_string_map extends pdelta.Location {
  Case_string_map(List<pdelta.Locator> location) : super(location);
  Case_type key(String key) {
    return Case_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Case> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_type extends pdelta.Location {
  Chooser_type(List<pdelta.Locator> location) : super(location);
  Chooser_Choice_oneof get choice {
    return Chooser_Choice_oneof(pdelta.copyAndAppendOneof(location, "choice", [pdelta.Field()..messageFullName="pdelta_tests.Chooser"..name="str"..number=1, pdelta.Field()..messageFullName="pdelta_tests.Chooser"..name="dbl"..number=2, pdelta.Field()..messageFullName="pdelta_tests.Chooser"..name="itm"..number=3]));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Chooser value) {
    return pdelta.set(location, value);
  }

}

class Chooser_list extends pdelta.Location {
  Chooser_list(List<pdelta.Locator> location) : super(location);
  Chooser_type index(int i) {
    return Chooser_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Chooser value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Chooser> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_bool_map extends pdelta.Location {
  Chooser_bool_map(List<pdelta.Locator> location) : super(location);
  Chooser_type key(bool key) {
    return Chooser_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Chooser> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_int32_map extends pdelta.Location {
  Chooser_int32_map(List<pdelta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Chooser> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_int64_map extends pdelta.Location {
  Chooser_int64_map(List<pdelta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Chooser> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_uint32_map extends pdelta.Location {
  Chooser_uint32_map(List<pdelta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Chooser> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_uint64_map extends pdelta.Location {
  Chooser_uint64_map(List<pdelta.Locator> location) : super(location);
  Chooser_type key(int key) {
    return Chooser_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Chooser> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_string_map extends pdelta.Location {
  Chooser_string_map(List<pdelta.Locator> location) : super(location);
  Chooser_type key(String key) {
    return Chooser_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Chooser> value) {
    return pdelta.set(location, value);
  }

}

class Chooser_Choice_oneof extends pdelta.Location {
  Chooser_Choice_oneof(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get str {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Chooser", "str", 1));
  }
  pkg_pdelta_pdelta_pdelta.Double_scalar get dbl {
    return pkg_pdelta_pdelta_pdelta.Double_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Chooser", "dbl", 2));
  }
  Item_type get itm {
    return Item_type(pdelta.copyAndAppendField(location, "pdelta_tests.Chooser", "itm", 3));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

}

class Company_type extends pdelta.Location {
  Company_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get name {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Company", "name", 11));
  }
  pkg_pdelta_pdelta_pdelta.Float_scalar get revenue {
    return pkg_pdelta_pdelta_pdelta.Float_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Company", "revenue", 12));
  }
  pkg_pdelta_pdelta_pdelta.String_int64_map get flags {
    return pkg_pdelta_pdelta_pdelta.String_int64_map(pdelta.copyAndAppendField(location, "pdelta_tests.Company", "flags", 13));
  }
  Person_type get ceo {
    return Person_type(pdelta.copyAndAppendField(location, "pdelta_tests.Company", "ceo", 14));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Company value) {
    return pdelta.set(location, value);
  }

}

class Company_list extends pdelta.Location {
  Company_list(List<pdelta.Locator> location) : super(location);
  Company_type index(int i) {
    return Company_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Company value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Company> value) {
    return pdelta.set(location, value);
  }

}

class Company_bool_map extends pdelta.Location {
  Company_bool_map(List<pdelta.Locator> location) : super(location);
  Company_type key(bool key) {
    return Company_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Company> value) {
    return pdelta.set(location, value);
  }

}

class Company_int32_map extends pdelta.Location {
  Company_int32_map(List<pdelta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Company> value) {
    return pdelta.set(location, value);
  }

}

class Company_int64_map extends pdelta.Location {
  Company_int64_map(List<pdelta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Company> value) {
    return pdelta.set(location, value);
  }

}

class Company_uint32_map extends pdelta.Location {
  Company_uint32_map(List<pdelta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Company> value) {
    return pdelta.set(location, value);
  }

}

class Company_uint64_map extends pdelta.Location {
  Company_uint64_map(List<pdelta.Locator> location) : super(location);
  Company_type key(int key) {
    return Company_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Company> value) {
    return pdelta.set(location, value);
  }

}

class Company_string_map extends pdelta.Location {
  Company_string_map(List<pdelta.Locator> location) : super(location);
  Company_type key(String key) {
    return Company_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Company> value) {
    return pdelta.set(location, value);
  }

}

class House_type extends pdelta.Location {
  House_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get name {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.House", "name", 1));
  }
  pkg_pdelta_pdelta_pdelta.Uint32_scalar get number {
    return pkg_pdelta_pdelta_pdelta.Uint32_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.House", "number", 2));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.House value) {
    return pdelta.set(location, value);
  }

}

class House_list extends pdelta.Location {
  House_list(List<pdelta.Locator> location) : super(location);
  House_type index(int i) {
    return House_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.House value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.House> value) {
    return pdelta.set(location, value);
  }

}

class House_bool_map extends pdelta.Location {
  House_bool_map(List<pdelta.Locator> location) : super(location);
  House_type key(bool key) {
    return House_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.House> value) {
    return pdelta.set(location, value);
  }

}

class House_int32_map extends pdelta.Location {
  House_int32_map(List<pdelta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.House> value) {
    return pdelta.set(location, value);
  }

}

class House_int64_map extends pdelta.Location {
  House_int64_map(List<pdelta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.House> value) {
    return pdelta.set(location, value);
  }

}

class House_uint32_map extends pdelta.Location {
  House_uint32_map(List<pdelta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.House> value) {
    return pdelta.set(location, value);
  }

}

class House_uint64_map extends pdelta.Location {
  House_uint64_map(List<pdelta.Locator> location) : super(location);
  House_type key(int key) {
    return House_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.House> value) {
    return pdelta.set(location, value);
  }

}

class House_string_map extends pdelta.Location {
  House_string_map(List<pdelta.Locator> location) : super(location);
  House_type key(String key) {
    return House_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.House> value) {
    return pdelta.set(location, value);
  }

}

class Item_type extends pdelta.Location {
  Item_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get title {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Item", "title", 31));
  }
  pkg_pdelta_pdelta_pdelta.Bool_scalar get done {
    return pkg_pdelta_pdelta_pdelta.Bool_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Item", "done", 34));
  }
  pkg_pdelta_pdelta_pdelta.String_list get flags {
    return pkg_pdelta_pdelta_pdelta.String_list(pdelta.copyAndAppendField(location, "pdelta_tests.Item", "flags", 35));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Item value) {
    return pdelta.set(location, value);
  }

}

class Item_list extends pdelta.Location {
  Item_list(List<pdelta.Locator> location) : super(location);
  Item_type index(int i) {
    return Item_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Item value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Item> value) {
    return pdelta.set(location, value);
  }

}

class Item_bool_map extends pdelta.Location {
  Item_bool_map(List<pdelta.Locator> location) : super(location);
  Item_type key(bool key) {
    return Item_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Item> value) {
    return pdelta.set(location, value);
  }

}

class Item_int32_map extends pdelta.Location {
  Item_int32_map(List<pdelta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Item> value) {
    return pdelta.set(location, value);
  }

}

class Item_int64_map extends pdelta.Location {
  Item_int64_map(List<pdelta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Item> value) {
    return pdelta.set(location, value);
  }

}

class Item_uint32_map extends pdelta.Location {
  Item_uint32_map(List<pdelta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Item> value) {
    return pdelta.set(location, value);
  }

}

class Item_uint64_map extends pdelta.Location {
  Item_uint64_map(List<pdelta.Locator> location) : super(location);
  Item_type key(int key) {
    return Item_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Item> value) {
    return pdelta.set(location, value);
  }

}

class Item_string_map extends pdelta.Location {
  Item_string_map(List<pdelta.Locator> location) : super(location);
  Item_type key(String key) {
    return Item_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Item> value) {
    return pdelta.set(location, value);
  }

}

class Person_type extends pdelta.Location {
  Person_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get name {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "name", 1));
  }
  pkg_pdelta_pdelta_pdelta.Uint32_scalar get age {
    return pkg_pdelta_pdelta_pdelta.Uint32_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "age", 2));
  }
  Case_string_map get cases {
    return Case_string_map(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "cases", 4));
  }
  Company_type get company {
    return Company_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "company", 5));
  }
  pkg_pdelta_pdelta_pdelta.String_list get alias {
    return pkg_pdelta_pdelta_pdelta.String_list(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "alias", 6));
  }
  Person_Type_enum get type {
    return Person_Type_enum(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "type", 7));
  }
  Person_Type_list get typeList {
    return Person_Type_list(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "typeList", 8));
  }
  Person_Type_string_map get typeMap {
    return Person_Type_string_map(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "typeMap", 9));
  }
  Person_Embed_type get embedded {
    return Person_Embed_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "embedded", 10));
  }
  Person_Choice_oneof get choice {
    return Person_Choice_oneof(pdelta.copyAndAppendOneof(location, "choice", [pdelta.Field()..messageFullName="pdelta_tests.Person"..name="str"..number=11, pdelta.Field()..messageFullName="pdelta_tests.Person"..name="dbl"..number=12, pdelta.Field()..messageFullName="pdelta_tests.Person"..name="itm"..number=13, pdelta.Field()..messageFullName="pdelta_tests.Person"..name="cas"..number=14, pdelta.Field()..messageFullName="pdelta_tests.Person"..name="cho"..number=15]));
  }
  House_type get house {
    return House_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "house", 16));
  }
  pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes.Shirt_type get shirt {
    return pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes.Shirt_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "shirt", 17));
  }
  pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants.Pants_type get pants {
    return pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants.Pants_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "pants", 18));
  }
  Person_Embed_Double_type get double {
    return Person_Embed_Double_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "double", 19));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Person value) {
    return pdelta.set(location, value);
  }

}

class Person_list extends pdelta.Location {
  Person_list(List<pdelta.Locator> location) : super(location);
  Person_type index(int i) {
    return Person_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Person value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Person> value) {
    return pdelta.set(location, value);
  }

}

class Person_bool_map extends pdelta.Location {
  Person_bool_map(List<pdelta.Locator> location) : super(location);
  Person_type key(bool key) {
    return Person_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Person> value) {
    return pdelta.set(location, value);
  }

}

class Person_int32_map extends pdelta.Location {
  Person_int32_map(List<pdelta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person> value) {
    return pdelta.set(location, value);
  }

}

class Person_int64_map extends pdelta.Location {
  Person_int64_map(List<pdelta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person> value) {
    return pdelta.set(location, value);
  }

}

class Person_uint32_map extends pdelta.Location {
  Person_uint32_map(List<pdelta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person> value) {
    return pdelta.set(location, value);
  }

}

class Person_uint64_map extends pdelta.Location {
  Person_uint64_map(List<pdelta.Locator> location) : super(location);
  Person_type key(int key) {
    return Person_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person> value) {
    return pdelta.set(location, value);
  }

}

class Person_string_map extends pdelta.Location {
  Person_string_map(List<pdelta.Locator> location) : super(location);
  Person_type key(String key) {
    return Person_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Person> value) {
    return pdelta.set(location, value);
  }

}

class Person_Choice_oneof extends pdelta.Location {
  Person_Choice_oneof(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get str {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "str", 11));
  }
  pkg_pdelta_pdelta_pdelta.Double_scalar get dbl {
    return pkg_pdelta_pdelta_pdelta.Double_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "dbl", 12));
  }
  Item_type get itm {
    return Item_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "itm", 13));
  }
  Case_type get cas {
    return Case_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "cas", 14));
  }
  Chooser_type get cho {
    return Chooser_type(pdelta.copyAndAppendField(location, "pdelta_tests.Person", "cho", 15));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

}

class Person_Embed_type extends pdelta.Location {
  Person_Embed_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get name {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person.Embed", "name", 1));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Person_Embed value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_list extends pdelta.Location {
  Person_Embed_list(List<pdelta.Locator> location) : super(location);
  Person_Embed_type index(int i) {
    return Person_Embed_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Person_Embed value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Person_Embed> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_bool_map extends pdelta.Location {
  Person_Embed_bool_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_type key(bool key) {
    return Person_Embed_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Person_Embed> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_int32_map extends pdelta.Location {
  Person_Embed_int32_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person_Embed> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_int64_map extends pdelta.Location {
  Person_Embed_int64_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person_Embed> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_uint32_map extends pdelta.Location {
  Person_Embed_uint32_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person_Embed> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_uint64_map extends pdelta.Location {
  Person_Embed_uint64_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_type key(int key) {
    return Person_Embed_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person_Embed> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_string_map extends pdelta.Location {
  Person_Embed_string_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_type key(String key) {
    return Person_Embed_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Person_Embed> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_type extends pdelta.Location {
  Person_Embed_Double_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get name {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person.Embed.Double", "name", 1));
  }
  Person_Embed_Double_Foo_oneof get foo {
    return Person_Embed_Double_Foo_oneof(pdelta.copyAndAppendOneof(location, "foo", [pdelta.Field()..messageFullName="pdelta_tests.Person.Embed.Double"..name="bar"..number=2, pdelta.Field()..messageFullName="pdelta_tests.Person.Embed.Double"..name="baz"..number=3]));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Person_Embed_Double value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_list extends pdelta.Location {
  Person_Embed_Double_list(List<pdelta.Locator> location) : super(location);
  Person_Embed_Double_type index(int i) {
    return Person_Embed_Double_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Person_Embed_Double value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Person_Embed_Double> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_bool_map extends pdelta.Location {
  Person_Embed_Double_bool_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_Double_type key(bool key) {
    return Person_Embed_Double_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Person_Embed_Double> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_int32_map extends pdelta.Location {
  Person_Embed_Double_int32_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person_Embed_Double> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_int64_map extends pdelta.Location {
  Person_Embed_Double_int64_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person_Embed_Double> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_uint32_map extends pdelta.Location {
  Person_Embed_Double_uint32_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person_Embed_Double> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_uint64_map extends pdelta.Location {
  Person_Embed_Double_uint64_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_Double_type key(int key) {
    return Person_Embed_Double_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person_Embed_Double> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_string_map extends pdelta.Location {
  Person_Embed_Double_string_map(List<pdelta.Locator> location) : super(location);
  Person_Embed_Double_type key(String key) {
    return Person_Embed_Double_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Person_Embed_Double> value) {
    return pdelta.set(location, value);
  }

}

class Person_Embed_Double_Foo_oneof extends pdelta.Location {
  Person_Embed_Double_Foo_oneof(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get bar {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person.Embed.Double", "bar", 2));
  }
  pkg_pdelta_pdelta_pdelta.Int64_scalar get baz {
    return pkg_pdelta_pdelta_pdelta.Int64_scalar(pdelta.copyAndAppendField(location, "pdelta_tests.Person.Embed.Double", "baz", 3));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

}

class Person_Type_enum extends pdelta.Location {
  Person_Type_enum(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Person_Type value) {
    return pdelta.set(location, pdelta.scalarEnum(value));
  }

}

class Person_Type_list extends pdelta.Location {
  Person_Type_list(List<pdelta.Locator> location) : super(location);
  Person_Type_enum index(int i) {
    return Person_Type_enum(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Person_Type value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarEnum(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Person_Type> value) {
    return pdelta.set(location, value);
  }

}

class Person_Type_bool_map extends pdelta.Location {
  Person_Type_bool_map(List<pdelta.Locator> location) : super(location);
  Person_Type_enum key(bool key) {
    return Person_Type_enum(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Person_Type> value) {
    return pdelta.set(location, value);
  }

}

class Person_Type_int32_map extends pdelta.Location {
  Person_Type_int32_map(List<pdelta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person_Type> value) {
    return pdelta.set(location, value);
  }

}

class Person_Type_int64_map extends pdelta.Location {
  Person_Type_int64_map(List<pdelta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person_Type> value) {
    return pdelta.set(location, value);
  }

}

class Person_Type_uint32_map extends pdelta.Location {
  Person_Type_uint32_map(List<pdelta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Person_Type> value) {
    return pdelta.set(location, value);
  }

}

class Person_Type_uint64_map extends pdelta.Location {
  Person_Type_uint64_map(List<pdelta.Locator> location) : super(location);
  Person_Type_enum key(int key) {
    return Person_Type_enum(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Person_Type> value) {
    return pdelta.set(location, value);
  }

}

class Person_Type_string_map extends pdelta.Location {
  Person_Type_string_map(List<pdelta.Locator> location) : super(location);
  Person_Type_enum key(String key) {
    return Person_Type_enum(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Person_Type> value) {
    return pdelta.set(location, value);
  }

}

var _initialised = false;
void _init() {
  if (_initialised) {
    return;
  }
  _initialised = true;
  pdelta.registerTypes([
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.Case(),
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.Chooser(),
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.Company(),
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.House(),
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.Item(),
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person(),
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person_Embed(),
    pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person_Embed_Double(),
    pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes.Shirt(),
    pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants.Pants(),
  ]);
}

final typeRegistry = protobuf.TypeRegistry([
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Case(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Chooser(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Company(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.House(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Item(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person_Embed(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person_Embed_Double(),
  pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes.Shirt(),
  pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants.Pants(),
]);

