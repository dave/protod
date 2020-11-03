import 'package:protod/delta/delta.dart' as delta;
import 'package:protod/delta/delta.pb.dart' as delta;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protod/delta/delta.op.dart' as delta;
import 'tests3.pb.dart' as pb;

Op_root_type get op {
  return Op_root_type();
}

class Op_root_type {
  Op_root_type();
  Pants_type get pants {
    return Pants_type([]);
  }
}

class Pants_type extends delta.Location {
  Pants_type(List<delta.Locator> location) : super(location);
  delta.String_scalar get style {
    return delta.String_scalar(delta.copyAndAppendField(location, "style", 1));
  }
  delta.Uint32_scalar get length {
    return delta.Uint32_scalar(delta.copyAndAppendField(location, "length", 2));
  }
  delta.Uint32_scalar get waist {
    return delta.Uint32_scalar(delta.copyAndAppendField(location, "waist", 3));
  }
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set( value) {
    return delta.set(location, value);
  }

}

class Pants_list extends delta.Location {
  Pants_list(List<delta.Locator> location) : super(location);
  Pants_type index(int i) {
    return Pants_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, pb.Pants value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<pb.Pants> value) {
    return delta.set(location, value);
  }

}

class Pants_bool_map extends delta.Location {
  Pants_bool_map(List<delta.Locator> location) : super(location);
  Pants_type key(bool key) {
    return Pants_type(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, pb.Pants> value) {
    return delta.set(location, value);
  }

}

class Pants_int32_map extends delta.Location {
  Pants_int32_map(List<delta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Pants> value) {
    return delta.set(location, value);
  }

}

class Pants_int64_map extends delta.Location {
  Pants_int64_map(List<delta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Pants> value) {
    return delta.set(location, value);
  }

}

class Pants_uint32_map extends delta.Location {
  Pants_uint32_map(List<delta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, pb.Pants> value) {
    return delta.set(location, value);
  }

}

class Pants_uint64_map extends delta.Location {
  Pants_uint64_map(List<delta.Locator> location) : super(location);
  Pants_type key(int key) {
    return Pants_type(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, pb.Pants> value) {
    return delta.set(location, value);
  }

}

class Pants_string_map extends delta.Location {
  Pants_string_map(List<delta.Locator> location) : super(location);
  Pants_type key(String key) {
    return Pants_type(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, pb.Pants> value) {
    return delta.set(location, value);
  }

}

