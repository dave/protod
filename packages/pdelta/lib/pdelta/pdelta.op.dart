import 'package:pdelta/pdelta/pdelta.dart' as pdelta;
import 'package:pdelta/pdelta/pdelta.pb.dart' as pdelta;
import 'package:fixnum/fixnum.dart' as fixnum;

class Bool_scalar extends pdelta.Location {
  Bool_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(bool value) {
    return pdelta.set(location, pdelta.scalarBool(value));
  }

}

class Bool_list extends pdelta.Location {
  Bool_list(List<pdelta.Locator> location) : super(location);
  Bool_scalar index(int i) {
    return Bool_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, bool value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarBool(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<bool> value) {
    return pdelta.set(location, value);
  }

}

class Bool_bool_map extends pdelta.Location {
  Bool_bool_map(List<pdelta.Locator> location) : super(location);
  Bool_scalar key(bool key) {
    return Bool_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, bool> value) {
    return pdelta.set(location, value);
  }

}

class Bool_int32_map extends pdelta.Location {
  Bool_int32_map(List<pdelta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, bool> value) {
    return pdelta.set(location, value);
  }

}

class Bool_int64_map extends pdelta.Location {
  Bool_int64_map(List<pdelta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, bool> value) {
    return pdelta.set(location, value);
  }

}

class Bool_uint32_map extends pdelta.Location {
  Bool_uint32_map(List<pdelta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, bool> value) {
    return pdelta.set(location, value);
  }

}

class Bool_uint64_map extends pdelta.Location {
  Bool_uint64_map(List<pdelta.Locator> location) : super(location);
  Bool_scalar key(int key) {
    return Bool_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, bool> value) {
    return pdelta.set(location, value);
  }

}

class Bool_string_map extends pdelta.Location {
  Bool_string_map(List<pdelta.Locator> location) : super(location);
  Bool_scalar key(String key) {
    return Bool_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, bool> value) {
    return pdelta.set(location, value);
  }

}

class Bytes_scalar extends pdelta.Location {
  Bytes_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<int> value) {
    return pdelta.set(location, pdelta.scalarBytes(value));
  }

}

class Bytes_list extends pdelta.Location {
  Bytes_list(List<pdelta.Locator> location) : super(location);
  Bytes_scalar index(int i) {
    return Bytes_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, List<int> value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarBytes(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<List<int>> value) {
    return pdelta.set(location, value);
  }

}

class Bytes_bool_map extends pdelta.Location {
  Bytes_bool_map(List<pdelta.Locator> location) : super(location);
  Bytes_scalar key(bool key) {
    return Bytes_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, List<int>> value) {
    return pdelta.set(location, value);
  }

}

class Bytes_int32_map extends pdelta.Location {
  Bytes_int32_map(List<pdelta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, List<int>> value) {
    return pdelta.set(location, value);
  }

}

class Bytes_int64_map extends pdelta.Location {
  Bytes_int64_map(List<pdelta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, List<int>> value) {
    return pdelta.set(location, value);
  }

}

class Bytes_uint32_map extends pdelta.Location {
  Bytes_uint32_map(List<pdelta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, List<int>> value) {
    return pdelta.set(location, value);
  }

}

class Bytes_uint64_map extends pdelta.Location {
  Bytes_uint64_map(List<pdelta.Locator> location) : super(location);
  Bytes_scalar key(int key) {
    return Bytes_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, List<int>> value) {
    return pdelta.set(location, value);
  }

}

class Bytes_string_map extends pdelta.Location {
  Bytes_string_map(List<pdelta.Locator> location) : super(location);
  Bytes_scalar key(String key) {
    return Bytes_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, List<int>> value) {
    return pdelta.set(location, value);
  }

}

class Double_scalar extends pdelta.Location {
  Double_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(double value) {
    return pdelta.set(location, pdelta.scalarDouble(value));
  }

}

class Double_list extends pdelta.Location {
  Double_list(List<pdelta.Locator> location) : super(location);
  Double_scalar index(int i) {
    return Double_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, double value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarDouble(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<double> value) {
    return pdelta.set(location, value);
  }

}

class Double_bool_map extends pdelta.Location {
  Double_bool_map(List<pdelta.Locator> location) : super(location);
  Double_scalar key(bool key) {
    return Double_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, double> value) {
    return pdelta.set(location, value);
  }

}

class Double_int32_map extends pdelta.Location {
  Double_int32_map(List<pdelta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, double> value) {
    return pdelta.set(location, value);
  }

}

class Double_int64_map extends pdelta.Location {
  Double_int64_map(List<pdelta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, double> value) {
    return pdelta.set(location, value);
  }

}

class Double_uint32_map extends pdelta.Location {
  Double_uint32_map(List<pdelta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, double> value) {
    return pdelta.set(location, value);
  }

}

class Double_uint64_map extends pdelta.Location {
  Double_uint64_map(List<pdelta.Locator> location) : super(location);
  Double_scalar key(int key) {
    return Double_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, double> value) {
    return pdelta.set(location, value);
  }

}

class Double_string_map extends pdelta.Location {
  Double_string_map(List<pdelta.Locator> location) : super(location);
  Double_scalar key(String key) {
    return Double_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, double> value) {
    return pdelta.set(location, value);
  }

}

class Fixed32_scalar extends pdelta.Location {
  Fixed32_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarFixed32(value));
  }

}

class Fixed32_list extends pdelta.Location {
  Fixed32_list(List<pdelta.Locator> location) : super(location);
  Fixed32_scalar index(int i) {
    return Fixed32_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarFixed32(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<int> value) {
    return pdelta.set(location, value);
  }

}

class Fixed32_bool_map extends pdelta.Location {
  Fixed32_bool_map(List<pdelta.Locator> location) : super(location);
  Fixed32_scalar key(bool key) {
    return Fixed32_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, int> value) {
    return pdelta.set(location, value);
  }

}

class Fixed32_int32_map extends pdelta.Location {
  Fixed32_int32_map(List<pdelta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Fixed32_int64_map extends pdelta.Location {
  Fixed32_int64_map(List<pdelta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Fixed32_uint32_map extends pdelta.Location {
  Fixed32_uint32_map(List<pdelta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Fixed32_uint64_map extends pdelta.Location {
  Fixed32_uint64_map(List<pdelta.Locator> location) : super(location);
  Fixed32_scalar key(int key) {
    return Fixed32_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Fixed32_string_map extends pdelta.Location {
  Fixed32_string_map(List<pdelta.Locator> location) : super(location);
  Fixed32_scalar key(String key) {
    return Fixed32_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, int> value) {
    return pdelta.set(location, value);
  }

}

class Fixed64_scalar extends pdelta.Location {
  Fixed64_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarFixed64(fixnum.Int64(value)));
  }

}

class Fixed64_list extends pdelta.Location {
  Fixed64_list(List<pdelta.Locator> location) : super(location);
  Fixed64_scalar index(int i) {
    return Fixed64_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarFixed64(fixnum.Int64(value)));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Fixed64_bool_map extends pdelta.Location {
  Fixed64_bool_map(List<pdelta.Locator> location) : super(location);
  Fixed64_scalar key(bool key) {
    return Fixed64_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Fixed64_int32_map extends pdelta.Location {
  Fixed64_int32_map(List<pdelta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Fixed64_int64_map extends pdelta.Location {
  Fixed64_int64_map(List<pdelta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Fixed64_uint32_map extends pdelta.Location {
  Fixed64_uint32_map(List<pdelta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Fixed64_uint64_map extends pdelta.Location {
  Fixed64_uint64_map(List<pdelta.Locator> location) : super(location);
  Fixed64_scalar key(int key) {
    return Fixed64_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Fixed64_string_map extends pdelta.Location {
  Fixed64_string_map(List<pdelta.Locator> location) : super(location);
  Fixed64_scalar key(String key) {
    return Fixed64_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Float_scalar extends pdelta.Location {
  Float_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(double value) {
    return pdelta.set(location, pdelta.scalarFloat(value));
  }

}

class Float_list extends pdelta.Location {
  Float_list(List<pdelta.Locator> location) : super(location);
  Float_scalar index(int i) {
    return Float_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, double value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarFloat(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<double> value) {
    return pdelta.set(location, value);
  }

}

class Float_bool_map extends pdelta.Location {
  Float_bool_map(List<pdelta.Locator> location) : super(location);
  Float_scalar key(bool key) {
    return Float_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, double> value) {
    return pdelta.set(location, value);
  }

}

class Float_int32_map extends pdelta.Location {
  Float_int32_map(List<pdelta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, double> value) {
    return pdelta.set(location, value);
  }

}

class Float_int64_map extends pdelta.Location {
  Float_int64_map(List<pdelta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, double> value) {
    return pdelta.set(location, value);
  }

}

class Float_uint32_map extends pdelta.Location {
  Float_uint32_map(List<pdelta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, double> value) {
    return pdelta.set(location, value);
  }

}

class Float_uint64_map extends pdelta.Location {
  Float_uint64_map(List<pdelta.Locator> location) : super(location);
  Float_scalar key(int key) {
    return Float_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, double> value) {
    return pdelta.set(location, value);
  }

}

class Float_string_map extends pdelta.Location {
  Float_string_map(List<pdelta.Locator> location) : super(location);
  Float_scalar key(String key) {
    return Float_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, double> value) {
    return pdelta.set(location, value);
  }

}

class Int32_scalar extends pdelta.Location {
  Int32_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarInt32(value));
  }

}

class Int32_list extends pdelta.Location {
  Int32_list(List<pdelta.Locator> location) : super(location);
  Int32_scalar index(int i) {
    return Int32_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarInt32(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<int> value) {
    return pdelta.set(location, value);
  }

}

class Int32_bool_map extends pdelta.Location {
  Int32_bool_map(List<pdelta.Locator> location) : super(location);
  Int32_scalar key(bool key) {
    return Int32_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, int> value) {
    return pdelta.set(location, value);
  }

}

class Int32_int32_map extends pdelta.Location {
  Int32_int32_map(List<pdelta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Int32_int64_map extends pdelta.Location {
  Int32_int64_map(List<pdelta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Int32_uint32_map extends pdelta.Location {
  Int32_uint32_map(List<pdelta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Int32_uint64_map extends pdelta.Location {
  Int32_uint64_map(List<pdelta.Locator> location) : super(location);
  Int32_scalar key(int key) {
    return Int32_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Int32_string_map extends pdelta.Location {
  Int32_string_map(List<pdelta.Locator> location) : super(location);
  Int32_scalar key(String key) {
    return Int32_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, int> value) {
    return pdelta.set(location, value);
  }

}

class Int64_scalar extends pdelta.Location {
  Int64_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarInt64(fixnum.Int64(value)));
  }

}

class Int64_list extends pdelta.Location {
  Int64_list(List<pdelta.Locator> location) : super(location);
  Int64_scalar index(int i) {
    return Int64_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarInt64(fixnum.Int64(value)));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Int64_bool_map extends pdelta.Location {
  Int64_bool_map(List<pdelta.Locator> location) : super(location);
  Int64_scalar key(bool key) {
    return Int64_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Int64_int32_map extends pdelta.Location {
  Int64_int32_map(List<pdelta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Int64_int64_map extends pdelta.Location {
  Int64_int64_map(List<pdelta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Int64_uint32_map extends pdelta.Location {
  Int64_uint32_map(List<pdelta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Int64_uint64_map extends pdelta.Location {
  Int64_uint64_map(List<pdelta.Locator> location) : super(location);
  Int64_scalar key(int key) {
    return Int64_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Int64_string_map extends pdelta.Location {
  Int64_string_map(List<pdelta.Locator> location) : super(location);
  Int64_scalar key(String key) {
    return Int64_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed32_scalar extends pdelta.Location {
  Sfixed32_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarSfixed32(value));
  }

}

class Sfixed32_list extends pdelta.Location {
  Sfixed32_list(List<pdelta.Locator> location) : super(location);
  Sfixed32_scalar index(int i) {
    return Sfixed32_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarSfixed32(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<int> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed32_bool_map extends pdelta.Location {
  Sfixed32_bool_map(List<pdelta.Locator> location) : super(location);
  Sfixed32_scalar key(bool key) {
    return Sfixed32_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, int> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed32_int32_map extends pdelta.Location {
  Sfixed32_int32_map(List<pdelta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed32_int64_map extends pdelta.Location {
  Sfixed32_int64_map(List<pdelta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed32_uint32_map extends pdelta.Location {
  Sfixed32_uint32_map(List<pdelta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed32_uint64_map extends pdelta.Location {
  Sfixed32_uint64_map(List<pdelta.Locator> location) : super(location);
  Sfixed32_scalar key(int key) {
    return Sfixed32_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed32_string_map extends pdelta.Location {
  Sfixed32_string_map(List<pdelta.Locator> location) : super(location);
  Sfixed32_scalar key(String key) {
    return Sfixed32_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, int> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed64_scalar extends pdelta.Location {
  Sfixed64_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarSfixed64(fixnum.Int64(value)));
  }

}

class Sfixed64_list extends pdelta.Location {
  Sfixed64_list(List<pdelta.Locator> location) : super(location);
  Sfixed64_scalar index(int i) {
    return Sfixed64_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarSfixed64(fixnum.Int64(value)));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed64_bool_map extends pdelta.Location {
  Sfixed64_bool_map(List<pdelta.Locator> location) : super(location);
  Sfixed64_scalar key(bool key) {
    return Sfixed64_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed64_int32_map extends pdelta.Location {
  Sfixed64_int32_map(List<pdelta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed64_int64_map extends pdelta.Location {
  Sfixed64_int64_map(List<pdelta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed64_uint32_map extends pdelta.Location {
  Sfixed64_uint32_map(List<pdelta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed64_uint64_map extends pdelta.Location {
  Sfixed64_uint64_map(List<pdelta.Locator> location) : super(location);
  Sfixed64_scalar key(int key) {
    return Sfixed64_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sfixed64_string_map extends pdelta.Location {
  Sfixed64_string_map(List<pdelta.Locator> location) : super(location);
  Sfixed64_scalar key(String key) {
    return Sfixed64_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sint32_scalar extends pdelta.Location {
  Sint32_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarSint32(value));
  }

}

class Sint32_list extends pdelta.Location {
  Sint32_list(List<pdelta.Locator> location) : super(location);
  Sint32_scalar index(int i) {
    return Sint32_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarSint32(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<int> value) {
    return pdelta.set(location, value);
  }

}

class Sint32_bool_map extends pdelta.Location {
  Sint32_bool_map(List<pdelta.Locator> location) : super(location);
  Sint32_scalar key(bool key) {
    return Sint32_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, int> value) {
    return pdelta.set(location, value);
  }

}

class Sint32_int32_map extends pdelta.Location {
  Sint32_int32_map(List<pdelta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Sint32_int64_map extends pdelta.Location {
  Sint32_int64_map(List<pdelta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Sint32_uint32_map extends pdelta.Location {
  Sint32_uint32_map(List<pdelta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Sint32_uint64_map extends pdelta.Location {
  Sint32_uint64_map(List<pdelta.Locator> location) : super(location);
  Sint32_scalar key(int key) {
    return Sint32_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Sint32_string_map extends pdelta.Location {
  Sint32_string_map(List<pdelta.Locator> location) : super(location);
  Sint32_scalar key(String key) {
    return Sint32_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, int> value) {
    return pdelta.set(location, value);
  }

}

class Sint64_scalar extends pdelta.Location {
  Sint64_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarSint64(fixnum.Int64(value)));
  }

}

class Sint64_list extends pdelta.Location {
  Sint64_list(List<pdelta.Locator> location) : super(location);
  Sint64_scalar index(int i) {
    return Sint64_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarSint64(fixnum.Int64(value)));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sint64_bool_map extends pdelta.Location {
  Sint64_bool_map(List<pdelta.Locator> location) : super(location);
  Sint64_scalar key(bool key) {
    return Sint64_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sint64_int32_map extends pdelta.Location {
  Sint64_int32_map(List<pdelta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sint64_int64_map extends pdelta.Location {
  Sint64_int64_map(List<pdelta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sint64_uint32_map extends pdelta.Location {
  Sint64_uint32_map(List<pdelta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sint64_uint64_map extends pdelta.Location {
  Sint64_uint64_map(List<pdelta.Locator> location) : super(location);
  Sint64_scalar key(int key) {
    return Sint64_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Sint64_string_map extends pdelta.Location {
  Sint64_string_map(List<pdelta.Locator> location) : super(location);
  Sint64_scalar key(String key) {
    return Sint64_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class String_scalar extends pdelta.Location {
  String_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op edit(String from, String to) {
    return pdelta.edit(location, from, to);
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(String value) {
    return pdelta.set(location, pdelta.scalarString(value));
  }

}

class String_list extends pdelta.Location {
  String_list(List<pdelta.Locator> location) : super(location);
  String_scalar index(int i) {
    return String_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, String value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarString(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<String> value) {
    return pdelta.set(location, value);
  }

}

class String_bool_map extends pdelta.Location {
  String_bool_map(List<pdelta.Locator> location) : super(location);
  String_scalar key(bool key) {
    return String_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, String> value) {
    return pdelta.set(location, value);
  }

}

class String_int32_map extends pdelta.Location {
  String_int32_map(List<pdelta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, String> value) {
    return pdelta.set(location, value);
  }

}

class String_int64_map extends pdelta.Location {
  String_int64_map(List<pdelta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, String> value) {
    return pdelta.set(location, value);
  }

}

class String_uint32_map extends pdelta.Location {
  String_uint32_map(List<pdelta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, String> value) {
    return pdelta.set(location, value);
  }

}

class String_uint64_map extends pdelta.Location {
  String_uint64_map(List<pdelta.Locator> location) : super(location);
  String_scalar key(int key) {
    return String_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, String> value) {
    return pdelta.set(location, value);
  }

}

class String_string_map extends pdelta.Location {
  String_string_map(List<pdelta.Locator> location) : super(location);
  String_scalar key(String key) {
    return String_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, String> value) {
    return pdelta.set(location, value);
  }

}

class Uint32_scalar extends pdelta.Location {
  Uint32_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarUint32(value));
  }

}

class Uint32_list extends pdelta.Location {
  Uint32_list(List<pdelta.Locator> location) : super(location);
  Uint32_scalar index(int i) {
    return Uint32_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarUint32(value));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<int> value) {
    return pdelta.set(location, value);
  }

}

class Uint32_bool_map extends pdelta.Location {
  Uint32_bool_map(List<pdelta.Locator> location) : super(location);
  Uint32_scalar key(bool key) {
    return Uint32_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, int> value) {
    return pdelta.set(location, value);
  }

}

class Uint32_int32_map extends pdelta.Location {
  Uint32_int32_map(List<pdelta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Uint32_int64_map extends pdelta.Location {
  Uint32_int64_map(List<pdelta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Uint32_uint32_map extends pdelta.Location {
  Uint32_uint32_map(List<pdelta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, int> value) {
    return pdelta.set(location, value);
  }

}

class Uint32_uint64_map extends pdelta.Location {
  Uint32_uint64_map(List<pdelta.Locator> location) : super(location);
  Uint32_scalar key(int key) {
    return Uint32_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, int> value) {
    return pdelta.set(location, value);
  }

}

class Uint32_string_map extends pdelta.Location {
  Uint32_string_map(List<pdelta.Locator> location) : super(location);
  Uint32_scalar key(String key) {
    return Uint32_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, int> value) {
    return pdelta.set(location, value);
  }

}

class Uint64_scalar extends pdelta.Location {
  Uint64_scalar(List<pdelta.Locator> location) : super(location);
  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(int value) {
    return pdelta.set(location, pdelta.scalarUint64(fixnum.Int64(value)));
  }

}

class Uint64_list extends pdelta.Location {
  Uint64_list(List<pdelta.Locator> location) : super(location);
  Uint64_scalar index(int i) {
    return Uint64_scalar(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
  }
  pdelta.Op insert(int index, int value) {
    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarUint64(fixnum.Int64(value)));
  }

  pdelta.Op move(int from, int to) {
    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(List<fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Uint64_bool_map extends pdelta.Location {
  Uint64_bool_map(List<pdelta.Locator> location) : super(location);
  Uint64_scalar key(bool key) {
    return Uint64_scalar(pdelta.copyAndAppendKeyBool(location, key));
  }
  pdelta.Op rename(bool from, bool to) {
    return pdelta.rename(pdelta.copyAndAppendKeyBool(location, from), pdelta.keyBool(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<bool, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Uint64_int32_map extends pdelta.Location {
  Uint64_int32_map(List<pdelta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(pdelta.copyAndAppendKeyInt32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt32(location, from), pdelta.keyInt32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Uint64_int64_map extends pdelta.Location {
  Uint64_int64_map(List<pdelta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Uint64_uint32_map extends pdelta.Location {
  Uint64_uint32_map(List<pdelta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(pdelta.copyAndAppendKeyUint32(location, key));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint32(location, from), pdelta.keyUint32(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<int, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Uint64_uint64_map extends pdelta.Location {
  Uint64_uint64_map(List<pdelta.Locator> location) : super(location);
  Uint64_scalar key(int key) {
    return Uint64_scalar(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(key)));
  }
  pdelta.Op rename(int from, int to) {
    return pdelta.rename(pdelta.copyAndAppendKeyUint64(location, fixnum.Int64(from)), pdelta.keyUint64(fixnum.Int64(to)));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<fixnum.Int64, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

class Uint64_string_map extends pdelta.Location {
  Uint64_string_map(List<pdelta.Locator> location) : super(location);
  Uint64_scalar key(String key) {
    return Uint64_scalar(pdelta.copyAndAppendKeyString(location, key));
  }
  pdelta.Op rename(String from, String to) {
    return pdelta.rename(pdelta.copyAndAppendKeyString(location, from), pdelta.keyString(to));
  }

  pdelta.Op delete() {
    return pdelta.delete(location);
  }

  pdelta.Op set(Map<String, fixnum.Int64> value) {
    return pdelta.set(location, value);
  }

}

