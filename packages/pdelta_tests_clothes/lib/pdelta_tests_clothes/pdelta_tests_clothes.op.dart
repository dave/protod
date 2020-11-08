import 'package:pdelta/pdelta/pdelta.dart' as pdelta;
import 'package:pdelta/pdelta/pdelta.pb.dart' as pdelta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:pdelta/pdelta/pdelta.op.dart' as pkg_pdelta_pdelta_pdelta;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/shirt.pb.dart' as pb;

Op_root_type get op {
  return Op_root_type();
}

class Op_root_type {
  Op_root_type();
  Shirt_type get shirt {
    return Shirt_type([]);
  }
}

class Shirt_type extends pdelta.Location {
  Shirt_type(List<pdelta.Locator> location) : super(location);
  pkg_pdelta_pdelta_pdelta.String_scalar get designer {
    return pkg_pdelta_pdelta_pdelta.String_scalar(pdelta.copyAndAppendField(location, "designer", 1));
  }
  pkg_pdelta_pdelta_pdelta.Uint32_scalar get size {
    return pkg_pdelta_pdelta_pdelta.Uint32_scalar(pdelta.copyAndAppendField(location, "size", 2));
  }
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(pb.Shirt value) {
    return pdelta.set(location, value);
  }

}

class Shirt_list extends pdelta.Location {
  Shirt_list(List<pdelta.Locator> location) : super(location);
  Shirt_type index(int i) {
    return Shirt_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, pb.Shirt value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<pb.Shirt> value) {
    return pdelta.set(location, value);
  }

}

class Shirt_bool_map extends pdelta.Location {
  Shirt_bool_map(List<pdelta.Locator> location) : super(location);
  Shirt_type key(bool key) {
    return Shirt_type(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, pb.Shirt> value) {
    return pdelta.set(location, value);
  }

}

class Shirt_int32_map extends pdelta.Location {
  Shirt_int32_map(List<pdelta.Locator> location) : super(location);
  Shirt_type key(int key) {
    return Shirt_type(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Shirt> value) {
    return pdelta.set(location, value);
  }

}

class Shirt_int64_map extends pdelta.Location {
  Shirt_int64_map(List<pdelta.Locator> location) : super(location);
  Shirt_type key(int key) {
    return Shirt_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Shirt> value) {
    return pdelta.set(location, value);
  }

}

class Shirt_uint32_map extends pdelta.Location {
  Shirt_uint32_map(List<pdelta.Locator> location) : super(location);
  Shirt_type key(int key) {
    return Shirt_type(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, pb.Shirt> value) {
    return pdelta.set(location, value);
  }

}

class Shirt_uint64_map extends pdelta.Location {
  Shirt_uint64_map(List<pdelta.Locator> location) : super(location);
  Shirt_type key(int key) {
    return Shirt_type(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, pb.Shirt> value) {
    return pdelta.set(location, value);
  }

}

class Shirt_string_map extends pdelta.Location {
  Shirt_string_map(List<pdelta.Locator> location) : super(location);
  Shirt_type key(String key) {
    return Shirt_type(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, pb.Shirt> value) {
    return pdelta.set(location, value);
  }

}

