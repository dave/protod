import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protod/delta.dart' as delta;

class Double_scalar extends delta.Locator {
  Double_scalar(List<delta.Indexer> location) : super(location);
}

class Double_scalar_repeated extends delta.Locator {
  Double_scalar_repeated(List<delta.Indexer> location) : super(location);
  Double_scalar Index(int i) {
    return Double_scalar([...location]..add(delta.Index(i)));
  }
}

class Double_scalar_bool_map extends delta.Locator {
  Double_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Double_scalar Key(bool k) {
    return Double_scalar([...location]..add(delta.Key(k)));
  }
}

class Double_scalar_int32_map extends delta.Locator {
  Double_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Double_scalar Key(int k) {
    return Double_scalar([...location]..add(delta.Key(k)));
  }
}

class Double_scalar_int64_map extends delta.Locator {
  Double_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Double_scalar Key(fixnum.Int64 k) {
    return Double_scalar([...location]..add(delta.Key(k)));
  }
}

class Double_scalar_uint32_map extends delta.Locator {
  Double_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Double_scalar Key(fixnum.Int64 k) {
    return Double_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Double_scalar_uint64_map extends delta.Locator {
  Double_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Double_scalar Key(fixnum.Int64 k) {
    return Double_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Double_scalar_string_map extends delta.Locator {
  Double_scalar_string_map(List<delta.Indexer> location) : super(location);
  Double_scalar Key(String k) {
    return Double_scalar([...location]..add(delta.Key(k)));
  }
}

class Float_scalar extends delta.Locator {
  Float_scalar(List<delta.Indexer> location) : super(location);
}

class Float_scalar_repeated extends delta.Locator {
  Float_scalar_repeated(List<delta.Indexer> location) : super(location);
  Float_scalar Index(int i) {
    return Float_scalar([...location]..add(delta.Index(i)));
  }
}

class Float_scalar_bool_map extends delta.Locator {
  Float_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Float_scalar Key(bool k) {
    return Float_scalar([...location]..add(delta.Key(k)));
  }
}

class Float_scalar_int32_map extends delta.Locator {
  Float_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Float_scalar Key(int k) {
    return Float_scalar([...location]..add(delta.Key(k)));
  }
}

class Float_scalar_int64_map extends delta.Locator {
  Float_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Float_scalar Key(fixnum.Int64 k) {
    return Float_scalar([...location]..add(delta.Key(k)));
  }
}

class Float_scalar_uint32_map extends delta.Locator {
  Float_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Float_scalar Key(fixnum.Int64 k) {
    return Float_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Float_scalar_uint64_map extends delta.Locator {
  Float_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Float_scalar Key(fixnum.Int64 k) {
    return Float_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Float_scalar_string_map extends delta.Locator {
  Float_scalar_string_map(List<delta.Indexer> location) : super(location);
  Float_scalar Key(String k) {
    return Float_scalar([...location]..add(delta.Key(k)));
  }
}

class Int32_scalar extends delta.Locator {
  Int32_scalar(List<delta.Indexer> location) : super(location);
}

class Int32_scalar_repeated extends delta.Locator {
  Int32_scalar_repeated(List<delta.Indexer> location) : super(location);
  Int32_scalar Index(int i) {
    return Int32_scalar([...location]..add(delta.Index(i)));
  }
}

class Int32_scalar_bool_map extends delta.Locator {
  Int32_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Int32_scalar Key(bool k) {
    return Int32_scalar([...location]..add(delta.Key(k)));
  }
}

class Int32_scalar_int32_map extends delta.Locator {
  Int32_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Int32_scalar Key(int k) {
    return Int32_scalar([...location]..add(delta.Key(k)));
  }
}

class Int32_scalar_int64_map extends delta.Locator {
  Int32_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Int32_scalar Key(fixnum.Int64 k) {
    return Int32_scalar([...location]..add(delta.Key(k)));
  }
}

class Int32_scalar_uint32_map extends delta.Locator {
  Int32_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Int32_scalar Key(fixnum.Int64 k) {
    return Int32_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Int32_scalar_uint64_map extends delta.Locator {
  Int32_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Int32_scalar Key(fixnum.Int64 k) {
    return Int32_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Int32_scalar_string_map extends delta.Locator {
  Int32_scalar_string_map(List<delta.Indexer> location) : super(location);
  Int32_scalar Key(String k) {
    return Int32_scalar([...location]..add(delta.Key(k)));
  }
}

class Int64_scalar extends delta.Locator {
  Int64_scalar(List<delta.Indexer> location) : super(location);
}

class Int64_scalar_repeated extends delta.Locator {
  Int64_scalar_repeated(List<delta.Indexer> location) : super(location);
  Int64_scalar Index(int i) {
    return Int64_scalar([...location]..add(delta.Index(i)));
  }
}

class Int64_scalar_bool_map extends delta.Locator {
  Int64_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Int64_scalar Key(bool k) {
    return Int64_scalar([...location]..add(delta.Key(k)));
  }
}

class Int64_scalar_int32_map extends delta.Locator {
  Int64_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Int64_scalar Key(int k) {
    return Int64_scalar([...location]..add(delta.Key(k)));
  }
}

class Int64_scalar_int64_map extends delta.Locator {
  Int64_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Int64_scalar Key(fixnum.Int64 k) {
    return Int64_scalar([...location]..add(delta.Key(k)));
  }
}

class Int64_scalar_uint32_map extends delta.Locator {
  Int64_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Int64_scalar Key(fixnum.Int64 k) {
    return Int64_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Int64_scalar_uint64_map extends delta.Locator {
  Int64_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Int64_scalar Key(fixnum.Int64 k) {
    return Int64_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Int64_scalar_string_map extends delta.Locator {
  Int64_scalar_string_map(List<delta.Indexer> location) : super(location);
  Int64_scalar Key(String k) {
    return Int64_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint32_scalar extends delta.Locator {
  Uint32_scalar(List<delta.Indexer> location) : super(location);
}

class Uint32_scalar_repeated extends delta.Locator {
  Uint32_scalar_repeated(List<delta.Indexer> location) : super(location);
  Uint32_scalar Index(int i) {
    return Uint32_scalar([...location]..add(delta.Index(i)));
  }
}

class Uint32_scalar_bool_map extends delta.Locator {
  Uint32_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Uint32_scalar Key(bool k) {
    return Uint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint32_scalar_int32_map extends delta.Locator {
  Uint32_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Uint32_scalar Key(int k) {
    return Uint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint32_scalar_int64_map extends delta.Locator {
  Uint32_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Uint32_scalar Key(fixnum.Int64 k) {
    return Uint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint32_scalar_uint32_map extends delta.Locator {
  Uint32_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Uint32_scalar Key(fixnum.Int64 k) {
    return Uint32_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Uint32_scalar_uint64_map extends delta.Locator {
  Uint32_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Uint32_scalar Key(fixnum.Int64 k) {
    return Uint32_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Uint32_scalar_string_map extends delta.Locator {
  Uint32_scalar_string_map(List<delta.Indexer> location) : super(location);
  Uint32_scalar Key(String k) {
    return Uint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint64_scalar extends delta.Locator {
  Uint64_scalar(List<delta.Indexer> location) : super(location);
}

class Uint64_scalar_repeated extends delta.Locator {
  Uint64_scalar_repeated(List<delta.Indexer> location) : super(location);
  Uint64_scalar Index(int i) {
    return Uint64_scalar([...location]..add(delta.Index(i)));
  }
}

class Uint64_scalar_bool_map extends delta.Locator {
  Uint64_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Uint64_scalar Key(bool k) {
    return Uint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint64_scalar_int32_map extends delta.Locator {
  Uint64_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Uint64_scalar Key(int k) {
    return Uint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint64_scalar_int64_map extends delta.Locator {
  Uint64_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Uint64_scalar Key(fixnum.Int64 k) {
    return Uint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Uint64_scalar_uint32_map extends delta.Locator {
  Uint64_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Uint64_scalar Key(fixnum.Int64 k) {
    return Uint64_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Uint64_scalar_uint64_map extends delta.Locator {
  Uint64_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Uint64_scalar Key(fixnum.Int64 k) {
    return Uint64_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Uint64_scalar_string_map extends delta.Locator {
  Uint64_scalar_string_map(List<delta.Indexer> location) : super(location);
  Uint64_scalar Key(String k) {
    return Uint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint32_scalar extends delta.Locator {
  Sint32_scalar(List<delta.Indexer> location) : super(location);
}

class Sint32_scalar_repeated extends delta.Locator {
  Sint32_scalar_repeated(List<delta.Indexer> location) : super(location);
  Sint32_scalar Index(int i) {
    return Sint32_scalar([...location]..add(delta.Index(i)));
  }
}

class Sint32_scalar_bool_map extends delta.Locator {
  Sint32_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Sint32_scalar Key(bool k) {
    return Sint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint32_scalar_int32_map extends delta.Locator {
  Sint32_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Sint32_scalar Key(int k) {
    return Sint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint32_scalar_int64_map extends delta.Locator {
  Sint32_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Sint32_scalar Key(fixnum.Int64 k) {
    return Sint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint32_scalar_uint32_map extends delta.Locator {
  Sint32_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Sint32_scalar Key(fixnum.Int64 k) {
    return Sint32_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Sint32_scalar_uint64_map extends delta.Locator {
  Sint32_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Sint32_scalar Key(fixnum.Int64 k) {
    return Sint32_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Sint32_scalar_string_map extends delta.Locator {
  Sint32_scalar_string_map(List<delta.Indexer> location) : super(location);
  Sint32_scalar Key(String k) {
    return Sint32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint64_scalar extends delta.Locator {
  Sint64_scalar(List<delta.Indexer> location) : super(location);
}

class Sint64_scalar_repeated extends delta.Locator {
  Sint64_scalar_repeated(List<delta.Indexer> location) : super(location);
  Sint64_scalar Index(int i) {
    return Sint64_scalar([...location]..add(delta.Index(i)));
  }
}

class Sint64_scalar_bool_map extends delta.Locator {
  Sint64_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Sint64_scalar Key(bool k) {
    return Sint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint64_scalar_int32_map extends delta.Locator {
  Sint64_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Sint64_scalar Key(int k) {
    return Sint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint64_scalar_int64_map extends delta.Locator {
  Sint64_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Sint64_scalar Key(fixnum.Int64 k) {
    return Sint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sint64_scalar_uint32_map extends delta.Locator {
  Sint64_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Sint64_scalar Key(fixnum.Int64 k) {
    return Sint64_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Sint64_scalar_uint64_map extends delta.Locator {
  Sint64_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Sint64_scalar Key(fixnum.Int64 k) {
    return Sint64_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Sint64_scalar_string_map extends delta.Locator {
  Sint64_scalar_string_map(List<delta.Indexer> location) : super(location);
  Sint64_scalar Key(String k) {
    return Sint64_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed32_scalar extends delta.Locator {
  Fixed32_scalar(List<delta.Indexer> location) : super(location);
}

class Fixed32_scalar_repeated extends delta.Locator {
  Fixed32_scalar_repeated(List<delta.Indexer> location) : super(location);
  Fixed32_scalar Index(int i) {
    return Fixed32_scalar([...location]..add(delta.Index(i)));
  }
}

class Fixed32_scalar_bool_map extends delta.Locator {
  Fixed32_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Fixed32_scalar Key(bool k) {
    return Fixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed32_scalar_int32_map extends delta.Locator {
  Fixed32_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Fixed32_scalar Key(int k) {
    return Fixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed32_scalar_int64_map extends delta.Locator {
  Fixed32_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Fixed32_scalar Key(fixnum.Int64 k) {
    return Fixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed32_scalar_uint32_map extends delta.Locator {
  Fixed32_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Fixed32_scalar Key(fixnum.Int64 k) {
    return Fixed32_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Fixed32_scalar_uint64_map extends delta.Locator {
  Fixed32_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Fixed32_scalar Key(fixnum.Int64 k) {
    return Fixed32_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Fixed32_scalar_string_map extends delta.Locator {
  Fixed32_scalar_string_map(List<delta.Indexer> location) : super(location);
  Fixed32_scalar Key(String k) {
    return Fixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed64_scalar extends delta.Locator {
  Fixed64_scalar(List<delta.Indexer> location) : super(location);
}

class Fixed64_scalar_repeated extends delta.Locator {
  Fixed64_scalar_repeated(List<delta.Indexer> location) : super(location);
  Fixed64_scalar Index(int i) {
    return Fixed64_scalar([...location]..add(delta.Index(i)));
  }
}

class Fixed64_scalar_bool_map extends delta.Locator {
  Fixed64_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Fixed64_scalar Key(bool k) {
    return Fixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed64_scalar_int32_map extends delta.Locator {
  Fixed64_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Fixed64_scalar Key(int k) {
    return Fixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed64_scalar_int64_map extends delta.Locator {
  Fixed64_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Fixed64_scalar Key(fixnum.Int64 k) {
    return Fixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Fixed64_scalar_uint32_map extends delta.Locator {
  Fixed64_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Fixed64_scalar Key(fixnum.Int64 k) {
    return Fixed64_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Fixed64_scalar_uint64_map extends delta.Locator {
  Fixed64_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Fixed64_scalar Key(fixnum.Int64 k) {
    return Fixed64_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Fixed64_scalar_string_map extends delta.Locator {
  Fixed64_scalar_string_map(List<delta.Indexer> location) : super(location);
  Fixed64_scalar Key(String k) {
    return Fixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed32_scalar extends delta.Locator {
  Sfixed32_scalar(List<delta.Indexer> location) : super(location);
}

class Sfixed32_scalar_repeated extends delta.Locator {
  Sfixed32_scalar_repeated(List<delta.Indexer> location) : super(location);
  Sfixed32_scalar Index(int i) {
    return Sfixed32_scalar([...location]..add(delta.Index(i)));
  }
}

class Sfixed32_scalar_bool_map extends delta.Locator {
  Sfixed32_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Sfixed32_scalar Key(bool k) {
    return Sfixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed32_scalar_int32_map extends delta.Locator {
  Sfixed32_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Sfixed32_scalar Key(int k) {
    return Sfixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed32_scalar_int64_map extends delta.Locator {
  Sfixed32_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Sfixed32_scalar Key(fixnum.Int64 k) {
    return Sfixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed32_scalar_uint32_map extends delta.Locator {
  Sfixed32_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Sfixed32_scalar Key(fixnum.Int64 k) {
    return Sfixed32_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Sfixed32_scalar_uint64_map extends delta.Locator {
  Sfixed32_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Sfixed32_scalar Key(fixnum.Int64 k) {
    return Sfixed32_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Sfixed32_scalar_string_map extends delta.Locator {
  Sfixed32_scalar_string_map(List<delta.Indexer> location) : super(location);
  Sfixed32_scalar Key(String k) {
    return Sfixed32_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed64_scalar extends delta.Locator {
  Sfixed64_scalar(List<delta.Indexer> location) : super(location);
}

class Sfixed64_scalar_repeated extends delta.Locator {
  Sfixed64_scalar_repeated(List<delta.Indexer> location) : super(location);
  Sfixed64_scalar Index(int i) {
    return Sfixed64_scalar([...location]..add(delta.Index(i)));
  }
}

class Sfixed64_scalar_bool_map extends delta.Locator {
  Sfixed64_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Sfixed64_scalar Key(bool k) {
    return Sfixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed64_scalar_int32_map extends delta.Locator {
  Sfixed64_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Sfixed64_scalar Key(int k) {
    return Sfixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed64_scalar_int64_map extends delta.Locator {
  Sfixed64_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Sfixed64_scalar Key(fixnum.Int64 k) {
    return Sfixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Sfixed64_scalar_uint32_map extends delta.Locator {
  Sfixed64_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Sfixed64_scalar Key(fixnum.Int64 k) {
    return Sfixed64_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Sfixed64_scalar_uint64_map extends delta.Locator {
  Sfixed64_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Sfixed64_scalar Key(fixnum.Int64 k) {
    return Sfixed64_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Sfixed64_scalar_string_map extends delta.Locator {
  Sfixed64_scalar_string_map(List<delta.Indexer> location) : super(location);
  Sfixed64_scalar Key(String k) {
    return Sfixed64_scalar([...location]..add(delta.Key(k)));
  }
}

class Bool_scalar extends delta.Locator {
  Bool_scalar(List<delta.Indexer> location) : super(location);
}

class Bool_scalar_repeated extends delta.Locator {
  Bool_scalar_repeated(List<delta.Indexer> location) : super(location);
  Bool_scalar Index(int i) {
    return Bool_scalar([...location]..add(delta.Index(i)));
  }
}

class Bool_scalar_bool_map extends delta.Locator {
  Bool_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Bool_scalar Key(bool k) {
    return Bool_scalar([...location]..add(delta.Key(k)));
  }
}

class Bool_scalar_int32_map extends delta.Locator {
  Bool_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Bool_scalar Key(int k) {
    return Bool_scalar([...location]..add(delta.Key(k)));
  }
}

class Bool_scalar_int64_map extends delta.Locator {
  Bool_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Bool_scalar Key(fixnum.Int64 k) {
    return Bool_scalar([...location]..add(delta.Key(k)));
  }
}

class Bool_scalar_uint32_map extends delta.Locator {
  Bool_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Bool_scalar Key(fixnum.Int64 k) {
    return Bool_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Bool_scalar_uint64_map extends delta.Locator {
  Bool_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Bool_scalar Key(fixnum.Int64 k) {
    return Bool_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Bool_scalar_string_map extends delta.Locator {
  Bool_scalar_string_map(List<delta.Indexer> location) : super(location);
  Bool_scalar Key(String k) {
    return Bool_scalar([...location]..add(delta.Key(k)));
  }
}

class String_scalar extends delta.Locator {
  String_scalar(List<delta.Indexer> location) : super(location);
}

class String_scalar_repeated extends delta.Locator {
  String_scalar_repeated(List<delta.Indexer> location) : super(location);
  String_scalar Index(int i) {
    return String_scalar([...location]..add(delta.Index(i)));
  }
}

class String_scalar_bool_map extends delta.Locator {
  String_scalar_bool_map(List<delta.Indexer> location) : super(location);
  String_scalar Key(bool k) {
    return String_scalar([...location]..add(delta.Key(k)));
  }
}

class String_scalar_int32_map extends delta.Locator {
  String_scalar_int32_map(List<delta.Indexer> location) : super(location);
  String_scalar Key(int k) {
    return String_scalar([...location]..add(delta.Key(k)));
  }
}

class String_scalar_int64_map extends delta.Locator {
  String_scalar_int64_map(List<delta.Indexer> location) : super(location);
  String_scalar Key(fixnum.Int64 k) {
    return String_scalar([...location]..add(delta.Key(k)));
  }
}

class String_scalar_uint32_map extends delta.Locator {
  String_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  String_scalar Key(fixnum.Int64 k) {
    return String_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class String_scalar_uint64_map extends delta.Locator {
  String_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  String_scalar Key(fixnum.Int64 k) {
    return String_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class String_scalar_string_map extends delta.Locator {
  String_scalar_string_map(List<delta.Indexer> location) : super(location);
  String_scalar Key(String k) {
    return String_scalar([...location]..add(delta.Key(k)));
  }
}

class Bytes_scalar extends delta.Locator {
  Bytes_scalar(List<delta.Indexer> location) : super(location);
}

class Bytes_scalar_repeated extends delta.Locator {
  Bytes_scalar_repeated(List<delta.Indexer> location) : super(location);
  Bytes_scalar Index(int i) {
    return Bytes_scalar([...location]..add(delta.Index(i)));
  }
}

class Bytes_scalar_bool_map extends delta.Locator {
  Bytes_scalar_bool_map(List<delta.Indexer> location) : super(location);
  Bytes_scalar Key(bool k) {
    return Bytes_scalar([...location]..add(delta.Key(k)));
  }
}

class Bytes_scalar_int32_map extends delta.Locator {
  Bytes_scalar_int32_map(List<delta.Indexer> location) : super(location);
  Bytes_scalar Key(int k) {
    return Bytes_scalar([...location]..add(delta.Key(k)));
  }
}

class Bytes_scalar_int64_map extends delta.Locator {
  Bytes_scalar_int64_map(List<delta.Indexer> location) : super(location);
  Bytes_scalar Key(fixnum.Int64 k) {
    return Bytes_scalar([...location]..add(delta.Key(k)));
  }
}

class Bytes_scalar_uint32_map extends delta.Locator {
  Bytes_scalar_uint32_map(List<delta.Indexer> location) : super(location);
  Bytes_scalar Key(fixnum.Int64 k) {
    return Bytes_scalar([...location]..add(delta.KeyUint32(k)));
  }
}

class Bytes_scalar_uint64_map extends delta.Locator {
  Bytes_scalar_uint64_map(List<delta.Indexer> location) : super(location);
  Bytes_scalar Key(fixnum.Int64 k) {
    return Bytes_scalar([...location]..add(delta.KeyUint64(k)));
  }
}

class Bytes_scalar_string_map extends delta.Locator {
  Bytes_scalar_string_map(List<delta.Indexer> location) : super(location);
  Bytes_scalar Key(String k) {
    return Bytes_scalar([...location]..add(delta.Key(k)));
  }
}

