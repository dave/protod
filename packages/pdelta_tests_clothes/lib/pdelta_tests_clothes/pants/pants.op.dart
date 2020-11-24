import 'package:pdelta/pdelta/pdelta.dart' as pdelta;
import 'package:pdelta/pdelta/pdelta.pb.dart' as pdelta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:pdelta/pdelta/pdelta.op.dart' as pkg_pdelta_pdelta_pdelta;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/pants/pants.pb.dart' as pb;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/pants/pants.pb.dart' as pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants;

Op_root_type get op {
  _init();
  return Op_root_type();
}

class Op_root_type {
  Op_root_type();
  Pants_type get pants {
    return Pants_type([]);
  }
}

class Pants_type extends pdelta.Location {
  Pants_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get style {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "pants.Pants", "style", 1));
  }
  pkg_pdelta_pdelta_pdelta.Uint32_scalar get length {
    return pkg_pdelta_pdelta_pdelta.Uint32_scalar(pdelta.copyAndAppendField(location, "pants.Pants", "length", 2));
  }
  pkg_pdelta_pdelta_pdelta.Uint32_scalar get waist {
    return pkg_pdelta_pdelta_pdelta.Uint32_scalar(pdelta.copyAndAppendField(location, "pants.Pants", "waist", 3));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Pants value) {
    return pdelta.set(location, value);
  }

}

class Pants_list extends pdelta.Location {
  Pants_list(List<pdelta.Locator> location) : super(location);
  Pants_type index(int i) {
    return Pants_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Pants value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Pants> value) {
    return pdelta.set(location, value);
  }

}

class Pants_bool_map extends pdelta.Location {
  Pants_bool_map(List<pdelta.Locator> location) : super(location);
  Pants_type key(bool key) {
    return Pants_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Pants> value) {
    return pdelta.set(location, value);
  }

}

class Pants_int32_map extends pdelta.Location {
  Pants_int32_map(List<pdelta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Pants> value) {
    return pdelta.set(location, value);
  }

}

class Pants_int64_map extends pdelta.Location {
  Pants_int64_map(List<pdelta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Pants> value) {
    return pdelta.set(location, value);
  }

}

class Pants_uint32_map extends pdelta.Location {
  Pants_uint32_map(List<pdelta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Pants> value) {
    return pdelta.set(location, value);
  }

}

class Pants_uint64_map extends pdelta.Location {
  Pants_uint64_map(List<pdelta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Pants> value) {
    return pdelta.set(location, value);
  }

}

class Pants_string_map extends pdelta.Location {
  Pants_string_map(List<pdelta.Locator> location) : super(location);
  Pants_type key(String key) {
    return Pants_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Pants> value) {
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
    pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants.Pants(),
  ]);
}

final typeRegistry = protobuf.TypeRegistry([
  pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants.Pants(),
]);

