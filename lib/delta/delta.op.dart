import 'package:protod/delta/delta.dart' as delta;
import 'package:protod/delta/delta.pb.dart' as delta;
import 'package:fixnum/fixnum.dart' as fixnum;

class Double_scalar extends delta.Location {
  Double_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(double value) {
    return delta.set(location, delta.scalarDouble(value));
  }

}

class Double_scalar_list extends delta.Location {
  Double_scalar_list(List<delta.Locator> location) : super(location);
  Double_scalar index(int i) {
    return Double_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, double value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarDouble(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<double> value) {
    return delta.set(location, value);
  }

}

class Double_scalar_bool_map extends delta.Location {
  Double_scalar_bool_map(List<delta.Locator> location) : super(location);
  Double_scalar key(bool key) {
    return Double_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, double> value) {
    return delta.set(location, value);
  }

}

class Double_scalar_int32_map extends delta.Location {
  Double_scalar_int32_map(List<delta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, double> value) {
    return delta.set(location, value);
  }

}

class Double_scalar_int64_map extends delta.Location {
  Double_scalar_int64_map(List<delta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, double> value) {
    return delta.set(location, value);
  }

}

class Double_scalar_uint32_map extends delta.Location {
  Double_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, double> value) {
    return delta.set(location, value);
  }

}

class Double_scalar_uint64_map extends delta.Location {
  Double_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, double> value) {
    return delta.set(location, value);
  }

}

class Double_scalar_string_map extends delta.Location {
  Double_scalar_string_map(List<delta.Locator> location) : super(location);
  Double_scalar key(String key) {
    return Double_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, double> value) {
    return delta.set(location, value);
  }

}

class Float_scalar extends delta.Location {
  Float_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(double value) {
    return delta.set(location, delta.scalarFloat(value));
  }

}

class Float_scalar_list extends delta.Location {
  Float_scalar_list(List<delta.Locator> location) : super(location);
  Float_scalar index(int i) {
    return Float_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, double value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarFloat(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<double> value) {
    return delta.set(location, value);
  }

}

class Float_scalar_bool_map extends delta.Location {
  Float_scalar_bool_map(List<delta.Locator> location) : super(location);
  Float_scalar key(bool key) {
    return Float_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, double> value) {
    return delta.set(location, value);
  }

}

class Float_scalar_int32_map extends delta.Location {
  Float_scalar_int32_map(List<delta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, double> value) {
    return delta.set(location, value);
  }

}

class Float_scalar_int64_map extends delta.Location {
  Float_scalar_int64_map(List<delta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, double> value) {
    return delta.set(location, value);
  }

}

class Float_scalar_uint32_map extends delta.Location {
  Float_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, double> value) {
    return delta.set(location, value);
  }

}

class Float_scalar_uint64_map extends delta.Location {
  Float_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, double> value) {
    return delta.set(location, value);
  }

}

class Float_scalar_string_map extends delta.Location {
  Float_scalar_string_map(List<delta.Locator> location) : super(location);
  Float_scalar key(String key) {
    return Float_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, double> value) {
    return delta.set(location, value);
  }

}

class Int32_scalar extends delta.Location {
  Int32_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarInt32(value));
  }

}

class Int32_scalar_list extends delta.Location {
  Int32_scalar_list(List<delta.Locator> location) : super(location);
  Int32_scalar index(int i) {
    return Int32_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarInt32(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<int> value) {
    return delta.set(location, value);
  }

}

class Int32_scalar_bool_map extends delta.Location {
  Int32_scalar_bool_map(List<delta.Locator> location) : super(location);
  Int32_scalar key(bool key) {
    return Int32_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, int> value) {
    return delta.set(location, value);
  }

}

class Int32_scalar_int32_map extends delta.Location {
  Int32_scalar_int32_map(List<delta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Int32_scalar_int64_map extends delta.Location {
  Int32_scalar_int64_map(List<delta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Int32_scalar_uint32_map extends delta.Location {
  Int32_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Int32_scalar_uint64_map extends delta.Location {
  Int32_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Int32_scalar_string_map extends delta.Location {
  Int32_scalar_string_map(List<delta.Locator> location) : super(location);
  Int32_scalar key(String key) {
    return Int32_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, int> value) {
    return delta.set(location, value);
  }

}

class Int64_scalar extends delta.Location {
  Int64_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarInt64(fixnum.Int64(value)));
  }

}

class Int64_scalar_list extends delta.Location {
  Int64_scalar_list(List<delta.Locator> location) : super(location);
  Int64_scalar index(int i) {
    return Int64_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarInt64(fixnum.Int64(value)));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Int64_scalar_bool_map extends delta.Location {
  Int64_scalar_bool_map(List<delta.Locator> location) : super(location);
  Int64_scalar key(bool key) {
    return Int64_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Int64_scalar_int32_map extends delta.Location {
  Int64_scalar_int32_map(List<delta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Int64_scalar_int64_map extends delta.Location {
  Int64_scalar_int64_map(List<delta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Int64_scalar_uint32_map extends delta.Location {
  Int64_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Int64_scalar_uint64_map extends delta.Location {
  Int64_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Int64_scalar_string_map extends delta.Location {
  Int64_scalar_string_map(List<delta.Locator> location) : super(location);
  Int64_scalar key(String key) {
    return Int64_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Uint32_scalar extends delta.Location {
  Uint32_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarUint32(value));
  }

}

class Uint32_scalar_list extends delta.Location {
  Uint32_scalar_list(List<delta.Locator> location) : super(location);
  Uint32_scalar index(int i) {
    return Uint32_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarUint32(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<int> value) {
    return delta.set(location, value);
  }

}

class Uint32_scalar_bool_map extends delta.Location {
  Uint32_scalar_bool_map(List<delta.Locator> location) : super(location);
  Uint32_scalar key(bool key) {
    return Uint32_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, int> value) {
    return delta.set(location, value);
  }

}

class Uint32_scalar_int32_map extends delta.Location {
  Uint32_scalar_int32_map(List<delta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Uint32_scalar_int64_map extends delta.Location {
  Uint32_scalar_int64_map(List<delta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Uint32_scalar_uint32_map extends delta.Location {
  Uint32_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Uint32_scalar_uint64_map extends delta.Location {
  Uint32_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Uint32_scalar_string_map extends delta.Location {
  Uint32_scalar_string_map(List<delta.Locator> location) : super(location);
  Uint32_scalar key(String key) {
    return Uint32_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, int> value) {
    return delta.set(location, value);
  }

}

class Uint64_scalar extends delta.Location {
  Uint64_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarUint64(fixnum.Int64(value)));
  }

}

class Uint64_scalar_list extends delta.Location {
  Uint64_scalar_list(List<delta.Locator> location) : super(location);
  Uint64_scalar index(int i) {
    return Uint64_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarUint64(fixnum.Int64(value)));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Uint64_scalar_bool_map extends delta.Location {
  Uint64_scalar_bool_map(List<delta.Locator> location) : super(location);
  Uint64_scalar key(bool key) {
    return Uint64_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Uint64_scalar_int32_map extends delta.Location {
  Uint64_scalar_int32_map(List<delta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Uint64_scalar_int64_map extends delta.Location {
  Uint64_scalar_int64_map(List<delta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Uint64_scalar_uint32_map extends delta.Location {
  Uint64_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Uint64_scalar_uint64_map extends delta.Location {
  Uint64_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Uint64_scalar_string_map extends delta.Location {
  Uint64_scalar_string_map(List<delta.Locator> location) : super(location);
  Uint64_scalar key(String key) {
    return Uint64_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sint32_scalar extends delta.Location {
  Sint32_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarSint32(value));
  }

}

class Sint32_scalar_list extends delta.Location {
  Sint32_scalar_list(List<delta.Locator> location) : super(location);
  Sint32_scalar index(int i) {
    return Sint32_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarSint32(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<int> value) {
    return delta.set(location, value);
  }

}

class Sint32_scalar_bool_map extends delta.Location {
  Sint32_scalar_bool_map(List<delta.Locator> location) : super(location);
  Sint32_scalar key(bool key) {
    return Sint32_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, int> value) {
    return delta.set(location, value);
  }

}

class Sint32_scalar_int32_map extends delta.Location {
  Sint32_scalar_int32_map(List<delta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Sint32_scalar_int64_map extends delta.Location {
  Sint32_scalar_int64_map(List<delta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Sint32_scalar_uint32_map extends delta.Location {
  Sint32_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Sint32_scalar_uint64_map extends delta.Location {
  Sint32_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Sint32_scalar_string_map extends delta.Location {
  Sint32_scalar_string_map(List<delta.Locator> location) : super(location);
  Sint32_scalar key(String key) {
    return Sint32_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, int> value) {
    return delta.set(location, value);
  }

}

class Sint64_scalar extends delta.Location {
  Sint64_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarSint64(fixnum.Int64(value)));
  }

}

class Sint64_scalar_list extends delta.Location {
  Sint64_scalar_list(List<delta.Locator> location) : super(location);
  Sint64_scalar index(int i) {
    return Sint64_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarSint64(fixnum.Int64(value)));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sint64_scalar_bool_map extends delta.Location {
  Sint64_scalar_bool_map(List<delta.Locator> location) : super(location);
  Sint64_scalar key(bool key) {
    return Sint64_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sint64_scalar_int32_map extends delta.Location {
  Sint64_scalar_int32_map(List<delta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sint64_scalar_int64_map extends delta.Location {
  Sint64_scalar_int64_map(List<delta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sint64_scalar_uint32_map extends delta.Location {
  Sint64_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sint64_scalar_uint64_map extends delta.Location {
  Sint64_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sint64_scalar_string_map extends delta.Location {
  Sint64_scalar_string_map(List<delta.Locator> location) : super(location);
  Sint64_scalar key(String key) {
    return Sint64_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Fixed32_scalar extends delta.Location {
  Fixed32_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarFixed32(value));
  }

}

class Fixed32_scalar_list extends delta.Location {
  Fixed32_scalar_list(List<delta.Locator> location) : super(location);
  Fixed32_scalar index(int i) {
    return Fixed32_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarFixed32(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<int> value) {
    return delta.set(location, value);
  }

}

class Fixed32_scalar_bool_map extends delta.Location {
  Fixed32_scalar_bool_map(List<delta.Locator> location) : super(location);
  Fixed32_scalar key(bool key) {
    return Fixed32_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, int> value) {
    return delta.set(location, value);
  }

}

class Fixed32_scalar_int32_map extends delta.Location {
  Fixed32_scalar_int32_map(List<delta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Fixed32_scalar_int64_map extends delta.Location {
  Fixed32_scalar_int64_map(List<delta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Fixed32_scalar_uint32_map extends delta.Location {
  Fixed32_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Fixed32_scalar_uint64_map extends delta.Location {
  Fixed32_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Fixed32_scalar_string_map extends delta.Location {
  Fixed32_scalar_string_map(List<delta.Locator> location) : super(location);
  Fixed32_scalar key(String key) {
    return Fixed32_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, int> value) {
    return delta.set(location, value);
  }

}

class Fixed64_scalar extends delta.Location {
  Fixed64_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarFixed64(fixnum.Int64(value)));
  }

}

class Fixed64_scalar_list extends delta.Location {
  Fixed64_scalar_list(List<delta.Locator> location) : super(location);
  Fixed64_scalar index(int i) {
    return Fixed64_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarFixed64(fixnum.Int64(value)));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Fixed64_scalar_bool_map extends delta.Location {
  Fixed64_scalar_bool_map(List<delta.Locator> location) : super(location);
  Fixed64_scalar key(bool key) {
    return Fixed64_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Fixed64_scalar_int32_map extends delta.Location {
  Fixed64_scalar_int32_map(List<delta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Fixed64_scalar_int64_map extends delta.Location {
  Fixed64_scalar_int64_map(List<delta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Fixed64_scalar_uint32_map extends delta.Location {
  Fixed64_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Fixed64_scalar_uint64_map extends delta.Location {
  Fixed64_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Fixed64_scalar_string_map extends delta.Location {
  Fixed64_scalar_string_map(List<delta.Locator> location) : super(location);
  Fixed64_scalar key(String key) {
    return Fixed64_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sfixed32_scalar extends delta.Location {
  Sfixed32_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarSfixed32(value));
  }

}

class Sfixed32_scalar_list extends delta.Location {
  Sfixed32_scalar_list(List<delta.Locator> location) : super(location);
  Sfixed32_scalar index(int i) {
    return Sfixed32_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarSfixed32(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<int> value) {
    return delta.set(location, value);
  }

}

class Sfixed32_scalar_bool_map extends delta.Location {
  Sfixed32_scalar_bool_map(List<delta.Locator> location) : super(location);
  Sfixed32_scalar key(bool key) {
    return Sfixed32_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, int> value) {
    return delta.set(location, value);
  }

}

class Sfixed32_scalar_int32_map extends delta.Location {
  Sfixed32_scalar_int32_map(List<delta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Sfixed32_scalar_int64_map extends delta.Location {
  Sfixed32_scalar_int64_map(List<delta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Sfixed32_scalar_uint32_map extends delta.Location {
  Sfixed32_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, int> value) {
    return delta.set(location, value);
  }

}

class Sfixed32_scalar_uint64_map extends delta.Location {
  Sfixed32_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, int> value) {
    return delta.set(location, value);
  }

}

class Sfixed32_scalar_string_map extends delta.Location {
  Sfixed32_scalar_string_map(List<delta.Locator> location) : super(location);
  Sfixed32_scalar key(String key) {
    return Sfixed32_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, int> value) {
    return delta.set(location, value);
  }

}

class Sfixed64_scalar extends delta.Location {
  Sfixed64_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(int value) {
    return delta.set(location, delta.scalarSfixed64(fixnum.Int64(value)));
  }

}

class Sfixed64_scalar_list extends delta.Location {
  Sfixed64_scalar_list(List<delta.Locator> location) : super(location);
  Sfixed64_scalar index(int i) {
    return Sfixed64_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, int value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarSfixed64(fixnum.Int64(value)));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sfixed64_scalar_bool_map extends delta.Location {
  Sfixed64_scalar_bool_map(List<delta.Locator> location) : super(location);
  Sfixed64_scalar key(bool key) {
    return Sfixed64_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sfixed64_scalar_int32_map extends delta.Location {
  Sfixed64_scalar_int32_map(List<delta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sfixed64_scalar_int64_map extends delta.Location {
  Sfixed64_scalar_int64_map(List<delta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sfixed64_scalar_uint32_map extends delta.Location {
  Sfixed64_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sfixed64_scalar_uint64_map extends delta.Location {
  Sfixed64_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Sfixed64_scalar_string_map extends delta.Location {
  Sfixed64_scalar_string_map(List<delta.Locator> location) : super(location);
  Sfixed64_scalar key(String key) {
    return Sfixed64_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, fixnum.Int64> value) {
    return delta.set(location, value);
  }

}

class Bool_scalar extends delta.Location {
  Bool_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(bool value) {
    return delta.set(location, delta.scalarBool(value));
  }

}

class Bool_scalar_list extends delta.Location {
  Bool_scalar_list(List<delta.Locator> location) : super(location);
  Bool_scalar index(int i) {
    return Bool_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, bool value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarBool(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<bool> value) {
    return delta.set(location, value);
  }

}

class Bool_scalar_bool_map extends delta.Location {
  Bool_scalar_bool_map(List<delta.Locator> location) : super(location);
  Bool_scalar key(bool key) {
    return Bool_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, bool> value) {
    return delta.set(location, value);
  }

}

class Bool_scalar_int32_map extends delta.Location {
  Bool_scalar_int32_map(List<delta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, bool> value) {
    return delta.set(location, value);
  }

}

class Bool_scalar_int64_map extends delta.Location {
  Bool_scalar_int64_map(List<delta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, bool> value) {
    return delta.set(location, value);
  }

}

class Bool_scalar_uint32_map extends delta.Location {
  Bool_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, bool> value) {
    return delta.set(location, value);
  }

}

class Bool_scalar_uint64_map extends delta.Location {
  Bool_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, bool> value) {
    return delta.set(location, value);
  }

}

class Bool_scalar_string_map extends delta.Location {
  Bool_scalar_string_map(List<delta.Locator> location) : super(location);
  Bool_scalar key(String key) {
    return Bool_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, bool> value) {
    return delta.set(location, value);
  }

}

class String_scalar extends delta.Location {
  String_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(String value) {
    return delta.set(location, delta.scalarString(value));
  }

  delta.Op edit(String from, String to) {
    return delta.edit(location, from, to);
  }

}

class String_scalar_list extends delta.Location {
  String_scalar_list(List<delta.Locator> location) : super(location);
  String_scalar index(int i) {
    return String_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, String value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarString(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<String> value) {
    return delta.set(location, value);
  }

}

class String_scalar_bool_map extends delta.Location {
  String_scalar_bool_map(List<delta.Locator> location) : super(location);
  String_scalar key(bool key) {
    return String_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, String> value) {
    return delta.set(location, value);
  }

}

class String_scalar_int32_map extends delta.Location {
  String_scalar_int32_map(List<delta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, String> value) {
    return delta.set(location, value);
  }

}

class String_scalar_int64_map extends delta.Location {
  String_scalar_int64_map(List<delta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, String> value) {
    return delta.set(location, value);
  }

}

class String_scalar_uint32_map extends delta.Location {
  String_scalar_uint32_map(List<delta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, String> value) {
    return delta.set(location, value);
  }

}

class String_scalar_uint64_map extends delta.Location {
  String_scalar_uint64_map(List<delta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, String> value) {
    return delta.set(location, value);
  }

}

class String_scalar_string_map extends delta.Location {
  String_scalar_string_map(List<delta.Locator> location) : super(location);
  String_scalar key(String key) {
    return String_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, String> value) {
    return delta.set(location, value);
  }

}

class Bytes_scalar extends delta.Location {
  Bytes_scalar(List<delta.Locator> location) : super(location);
  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<int> value) {
    return delta.set(location, delta.scalarBytes(value));
  }

}

class Bytes_scalar_list extends delta.Location {
  Bytes_scalar_list(List<delta.Locator> location) : super(location);
  Bytes_scalar index(int i) {
    return Bytes_scalar(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  delta.Op insert(int index, List<int> value) {
    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarBytes(value));
  }

  delta.Op move(int from, int to) {
    return delta.move(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(List<List<int>> value) {
    return delta.set(location, value);
  }

}

class Bytes_scalar_bool_map extends delta.Location {
  Bytes_scalar_bool_map(List<delta.Locator> location) : super(location);
  Bytes_scalar key(bool key) {
    return Bytes_scalar(delta.copyAndAppendKeyBool(location, key));
  }
  delta.Op rename(bool from, bool to) {
    return delta.rename(delta.copyAndAppendKeyBool(location, from), delta.keyBool(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<bool, List<int>> value) {
    return delta.set(location, value);
  }

}

class Bytes_scalar_int32_map extends delta.Location {
  Bytes_scalar_int32_map(List<delta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(delta.copyAndAppendKeyInt32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt32(location, from), delta.keyInt32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, List<int>> value) {
    return delta.set(location, value);
  }

}

class Bytes_scalar_int64_map extends delta.Location {
  Bytes_scalar_int64_map(List<delta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, List<int>> value) {
    return delta.set(location, value);
  }

}

class Bytes_scalar_uint32_map extends delta.Location {
  Bytes_scalar_uint32_map(List<delta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(delta.copyAndAppendKeyUint32(location, key));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint32(location, from), delta.keyUint32(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<int, List<int>> value) {
    return delta.set(location, value);
  }

}

class Bytes_scalar_uint64_map extends delta.Location {
  Bytes_scalar_uint64_map(List<delta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(delta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  delta.Op rename(int from, int to) {
    return delta.rename(delta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), delta.keyUint64(fixnum.Int64(to)));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<fixnum.Int64, List<int>> value) {
    return delta.set(location, value);
  }

}

class Bytes_scalar_string_map extends delta.Location {
  Bytes_scalar_string_map(List<delta.Locator> location) : super(location);
  Bytes_scalar key(String key) {
    return Bytes_scalar(delta.copyAndAppendKeyString(location, key));
  }
  delta.Op rename(String from, String to) {
    return delta.rename(delta.copyAndAppendKeyString(location, from), delta.keyString(to));
  }

  delta.Op delete() {
    return delta.delete(location);
  }

  delta.Op set(Map<String, List<int>> value) {
    return delta.set(location, value);
  }

}

