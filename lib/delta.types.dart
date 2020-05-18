import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protod/delta.dart' as delta;
import 'package:protod/delta.pb.dart' as pb;

class Double_scalar extends delta.Location {
  Double_scalar(List<pb.Locator> location) : super(location);
}

class Double_scalar_repeated extends delta.Location {
  Double_scalar_repeated(List<pb.Locator> location) : super(location);
  Double_scalar Index(int i) {
    return Double_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Double_scalar Index64(fixnum.Int64 i) {
    return Double_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Double_scalar_bool_map extends delta.Location {
  Double_scalar_bool_map(List<pb.Locator> location) : super(location);
  Double_scalar Key(bool k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Double_scalar_int32_map extends delta.Location {
  Double_scalar_int32_map(List<pb.Locator> location) : super(location);
  Double_scalar Key(int k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Double_scalar_int64_map extends delta.Location {
  Double_scalar_int64_map(List<pb.Locator> location) : super(location);
  Double_scalar Key(int k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Double_scalar Key64(fixnum.Int64 k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Double_scalar_uint32_map extends delta.Location {
  Double_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Double_scalar Key(int k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Double_scalar_uint64_map extends delta.Location {
  Double_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Double_scalar Key(int k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Double_scalar Key64(fixnum.Int64 k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Double_scalar_string_map extends delta.Location {
  Double_scalar_string_map(List<pb.Locator> location) : super(location);
  Double_scalar Key(String k) {
    return Double_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Float_scalar extends delta.Location {
  Float_scalar(List<pb.Locator> location) : super(location);
}

class Float_scalar_repeated extends delta.Location {
  Float_scalar_repeated(List<pb.Locator> location) : super(location);
  Float_scalar Index(int i) {
    return Float_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Float_scalar Index64(fixnum.Int64 i) {
    return Float_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Float_scalar_bool_map extends delta.Location {
  Float_scalar_bool_map(List<pb.Locator> location) : super(location);
  Float_scalar Key(bool k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Float_scalar_int32_map extends delta.Location {
  Float_scalar_int32_map(List<pb.Locator> location) : super(location);
  Float_scalar Key(int k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Float_scalar_int64_map extends delta.Location {
  Float_scalar_int64_map(List<pb.Locator> location) : super(location);
  Float_scalar Key(int k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Float_scalar Key64(fixnum.Int64 k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Float_scalar_uint32_map extends delta.Location {
  Float_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Float_scalar Key(int k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Float_scalar_uint64_map extends delta.Location {
  Float_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Float_scalar Key(int k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Float_scalar Key64(fixnum.Int64 k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Float_scalar_string_map extends delta.Location {
  Float_scalar_string_map(List<pb.Locator> location) : super(location);
  Float_scalar Key(String k) {
    return Float_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Int32_scalar extends delta.Location {
  Int32_scalar(List<pb.Locator> location) : super(location);
}

class Int32_scalar_repeated extends delta.Location {
  Int32_scalar_repeated(List<pb.Locator> location) : super(location);
  Int32_scalar Index(int i) {
    return Int32_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Int32_scalar Index64(fixnum.Int64 i) {
    return Int32_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Int32_scalar_bool_map extends delta.Location {
  Int32_scalar_bool_map(List<pb.Locator> location) : super(location);
  Int32_scalar Key(bool k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Int32_scalar_int32_map extends delta.Location {
  Int32_scalar_int32_map(List<pb.Locator> location) : super(location);
  Int32_scalar Key(int k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Int32_scalar_int64_map extends delta.Location {
  Int32_scalar_int64_map(List<pb.Locator> location) : super(location);
  Int32_scalar Key(int k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Int32_scalar Key64(fixnum.Int64 k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Int32_scalar_uint32_map extends delta.Location {
  Int32_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Int32_scalar Key(int k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Int32_scalar_uint64_map extends delta.Location {
  Int32_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Int32_scalar Key(int k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Int32_scalar Key64(fixnum.Int64 k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Int32_scalar_string_map extends delta.Location {
  Int32_scalar_string_map(List<pb.Locator> location) : super(location);
  Int32_scalar Key(String k) {
    return Int32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Int64_scalar extends delta.Location {
  Int64_scalar(List<pb.Locator> location) : super(location);
}

class Int64_scalar_repeated extends delta.Location {
  Int64_scalar_repeated(List<pb.Locator> location) : super(location);
  Int64_scalar Index(int i) {
    return Int64_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Int64_scalar Index64(fixnum.Int64 i) {
    return Int64_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Int64_scalar_bool_map extends delta.Location {
  Int64_scalar_bool_map(List<pb.Locator> location) : super(location);
  Int64_scalar Key(bool k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Int64_scalar_int32_map extends delta.Location {
  Int64_scalar_int32_map(List<pb.Locator> location) : super(location);
  Int64_scalar Key(int k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Int64_scalar_int64_map extends delta.Location {
  Int64_scalar_int64_map(List<pb.Locator> location) : super(location);
  Int64_scalar Key(int k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Int64_scalar Key64(fixnum.Int64 k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Int64_scalar_uint32_map extends delta.Location {
  Int64_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Int64_scalar Key(int k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Int64_scalar_uint64_map extends delta.Location {
  Int64_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Int64_scalar Key(int k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Int64_scalar Key64(fixnum.Int64 k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Int64_scalar_string_map extends delta.Location {
  Int64_scalar_string_map(List<pb.Locator> location) : super(location);
  Int64_scalar Key(String k) {
    return Int64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Uint32_scalar extends delta.Location {
  Uint32_scalar(List<pb.Locator> location) : super(location);
}

class Uint32_scalar_repeated extends delta.Location {
  Uint32_scalar_repeated(List<pb.Locator> location) : super(location);
  Uint32_scalar Index(int i) {
    return Uint32_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Uint32_scalar Index64(fixnum.Int64 i) {
    return Uint32_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Uint32_scalar_bool_map extends delta.Location {
  Uint32_scalar_bool_map(List<pb.Locator> location) : super(location);
  Uint32_scalar Key(bool k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Uint32_scalar_int32_map extends delta.Location {
  Uint32_scalar_int32_map(List<pb.Locator> location) : super(location);
  Uint32_scalar Key(int k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Uint32_scalar_int64_map extends delta.Location {
  Uint32_scalar_int64_map(List<pb.Locator> location) : super(location);
  Uint32_scalar Key(int k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Uint32_scalar Key64(fixnum.Int64 k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Uint32_scalar_uint32_map extends delta.Location {
  Uint32_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Uint32_scalar Key(int k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Uint32_scalar_uint64_map extends delta.Location {
  Uint32_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Uint32_scalar Key(int k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Uint32_scalar Key64(fixnum.Int64 k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Uint32_scalar_string_map extends delta.Location {
  Uint32_scalar_string_map(List<pb.Locator> location) : super(location);
  Uint32_scalar Key(String k) {
    return Uint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Uint64_scalar extends delta.Location {
  Uint64_scalar(List<pb.Locator> location) : super(location);
}

class Uint64_scalar_repeated extends delta.Location {
  Uint64_scalar_repeated(List<pb.Locator> location) : super(location);
  Uint64_scalar Index(int i) {
    return Uint64_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Uint64_scalar Index64(fixnum.Int64 i) {
    return Uint64_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Uint64_scalar_bool_map extends delta.Location {
  Uint64_scalar_bool_map(List<pb.Locator> location) : super(location);
  Uint64_scalar Key(bool k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Uint64_scalar_int32_map extends delta.Location {
  Uint64_scalar_int32_map(List<pb.Locator> location) : super(location);
  Uint64_scalar Key(int k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Uint64_scalar_int64_map extends delta.Location {
  Uint64_scalar_int64_map(List<pb.Locator> location) : super(location);
  Uint64_scalar Key(int k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Uint64_scalar Key64(fixnum.Int64 k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Uint64_scalar_uint32_map extends delta.Location {
  Uint64_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Uint64_scalar Key(int k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Uint64_scalar_uint64_map extends delta.Location {
  Uint64_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Uint64_scalar Key(int k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Uint64_scalar Key64(fixnum.Int64 k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Uint64_scalar_string_map extends delta.Location {
  Uint64_scalar_string_map(List<pb.Locator> location) : super(location);
  Uint64_scalar Key(String k) {
    return Uint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Sint32_scalar extends delta.Location {
  Sint32_scalar(List<pb.Locator> location) : super(location);
}

class Sint32_scalar_repeated extends delta.Location {
  Sint32_scalar_repeated(List<pb.Locator> location) : super(location);
  Sint32_scalar Index(int i) {
    return Sint32_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Sint32_scalar Index64(fixnum.Int64 i) {
    return Sint32_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Sint32_scalar_bool_map extends delta.Location {
  Sint32_scalar_bool_map(List<pb.Locator> location) : super(location);
  Sint32_scalar Key(bool k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Sint32_scalar_int32_map extends delta.Location {
  Sint32_scalar_int32_map(List<pb.Locator> location) : super(location);
  Sint32_scalar Key(int k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Sint32_scalar_int64_map extends delta.Location {
  Sint32_scalar_int64_map(List<pb.Locator> location) : super(location);
  Sint32_scalar Key(int k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Sint32_scalar Key64(fixnum.Int64 k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Sint32_scalar_uint32_map extends delta.Location {
  Sint32_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Sint32_scalar Key(int k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Sint32_scalar_uint64_map extends delta.Location {
  Sint32_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Sint32_scalar Key(int k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Sint32_scalar Key64(fixnum.Int64 k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Sint32_scalar_string_map extends delta.Location {
  Sint32_scalar_string_map(List<pb.Locator> location) : super(location);
  Sint32_scalar Key(String k) {
    return Sint32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Sint64_scalar extends delta.Location {
  Sint64_scalar(List<pb.Locator> location) : super(location);
}

class Sint64_scalar_repeated extends delta.Location {
  Sint64_scalar_repeated(List<pb.Locator> location) : super(location);
  Sint64_scalar Index(int i) {
    return Sint64_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Sint64_scalar Index64(fixnum.Int64 i) {
    return Sint64_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Sint64_scalar_bool_map extends delta.Location {
  Sint64_scalar_bool_map(List<pb.Locator> location) : super(location);
  Sint64_scalar Key(bool k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Sint64_scalar_int32_map extends delta.Location {
  Sint64_scalar_int32_map(List<pb.Locator> location) : super(location);
  Sint64_scalar Key(int k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Sint64_scalar_int64_map extends delta.Location {
  Sint64_scalar_int64_map(List<pb.Locator> location) : super(location);
  Sint64_scalar Key(int k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Sint64_scalar Key64(fixnum.Int64 k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Sint64_scalar_uint32_map extends delta.Location {
  Sint64_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Sint64_scalar Key(int k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Sint64_scalar_uint64_map extends delta.Location {
  Sint64_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Sint64_scalar Key(int k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Sint64_scalar Key64(fixnum.Int64 k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Sint64_scalar_string_map extends delta.Location {
  Sint64_scalar_string_map(List<pb.Locator> location) : super(location);
  Sint64_scalar Key(String k) {
    return Sint64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Fixed32_scalar extends delta.Location {
  Fixed32_scalar(List<pb.Locator> location) : super(location);
}

class Fixed32_scalar_repeated extends delta.Location {
  Fixed32_scalar_repeated(List<pb.Locator> location) : super(location);
  Fixed32_scalar Index(int i) {
    return Fixed32_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Fixed32_scalar Index64(fixnum.Int64 i) {
    return Fixed32_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Fixed32_scalar_bool_map extends delta.Location {
  Fixed32_scalar_bool_map(List<pb.Locator> location) : super(location);
  Fixed32_scalar Key(bool k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Fixed32_scalar_int32_map extends delta.Location {
  Fixed32_scalar_int32_map(List<pb.Locator> location) : super(location);
  Fixed32_scalar Key(int k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Fixed32_scalar_int64_map extends delta.Location {
  Fixed32_scalar_int64_map(List<pb.Locator> location) : super(location);
  Fixed32_scalar Key(int k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Fixed32_scalar Key64(fixnum.Int64 k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Fixed32_scalar_uint32_map extends delta.Location {
  Fixed32_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Fixed32_scalar Key(int k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Fixed32_scalar_uint64_map extends delta.Location {
  Fixed32_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Fixed32_scalar Key(int k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Fixed32_scalar Key64(fixnum.Int64 k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Fixed32_scalar_string_map extends delta.Location {
  Fixed32_scalar_string_map(List<pb.Locator> location) : super(location);
  Fixed32_scalar Key(String k) {
    return Fixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Fixed64_scalar extends delta.Location {
  Fixed64_scalar(List<pb.Locator> location) : super(location);
}

class Fixed64_scalar_repeated extends delta.Location {
  Fixed64_scalar_repeated(List<pb.Locator> location) : super(location);
  Fixed64_scalar Index(int i) {
    return Fixed64_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Fixed64_scalar Index64(fixnum.Int64 i) {
    return Fixed64_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Fixed64_scalar_bool_map extends delta.Location {
  Fixed64_scalar_bool_map(List<pb.Locator> location) : super(location);
  Fixed64_scalar Key(bool k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Fixed64_scalar_int32_map extends delta.Location {
  Fixed64_scalar_int32_map(List<pb.Locator> location) : super(location);
  Fixed64_scalar Key(int k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Fixed64_scalar_int64_map extends delta.Location {
  Fixed64_scalar_int64_map(List<pb.Locator> location) : super(location);
  Fixed64_scalar Key(int k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Fixed64_scalar Key64(fixnum.Int64 k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Fixed64_scalar_uint32_map extends delta.Location {
  Fixed64_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Fixed64_scalar Key(int k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Fixed64_scalar_uint64_map extends delta.Location {
  Fixed64_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Fixed64_scalar Key(int k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Fixed64_scalar Key64(fixnum.Int64 k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Fixed64_scalar_string_map extends delta.Location {
  Fixed64_scalar_string_map(List<pb.Locator> location) : super(location);
  Fixed64_scalar Key(String k) {
    return Fixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Sfixed32_scalar extends delta.Location {
  Sfixed32_scalar(List<pb.Locator> location) : super(location);
}

class Sfixed32_scalar_repeated extends delta.Location {
  Sfixed32_scalar_repeated(List<pb.Locator> location) : super(location);
  Sfixed32_scalar Index(int i) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Sfixed32_scalar Index64(fixnum.Int64 i) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Sfixed32_scalar_bool_map extends delta.Location {
  Sfixed32_scalar_bool_map(List<pb.Locator> location) : super(location);
  Sfixed32_scalar Key(bool k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Sfixed32_scalar_int32_map extends delta.Location {
  Sfixed32_scalar_int32_map(List<pb.Locator> location) : super(location);
  Sfixed32_scalar Key(int k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Sfixed32_scalar_int64_map extends delta.Location {
  Sfixed32_scalar_int64_map(List<pb.Locator> location) : super(location);
  Sfixed32_scalar Key(int k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Sfixed32_scalar Key64(fixnum.Int64 k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Sfixed32_scalar_uint32_map extends delta.Location {
  Sfixed32_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Sfixed32_scalar Key(int k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Sfixed32_scalar_uint64_map extends delta.Location {
  Sfixed32_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Sfixed32_scalar Key(int k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Sfixed32_scalar Key64(fixnum.Int64 k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Sfixed32_scalar_string_map extends delta.Location {
  Sfixed32_scalar_string_map(List<pb.Locator> location) : super(location);
  Sfixed32_scalar Key(String k) {
    return Sfixed32_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Sfixed64_scalar extends delta.Location {
  Sfixed64_scalar(List<pb.Locator> location) : super(location);
}

class Sfixed64_scalar_repeated extends delta.Location {
  Sfixed64_scalar_repeated(List<pb.Locator> location) : super(location);
  Sfixed64_scalar Index(int i) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Sfixed64_scalar Index64(fixnum.Int64 i) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Sfixed64_scalar_bool_map extends delta.Location {
  Sfixed64_scalar_bool_map(List<pb.Locator> location) : super(location);
  Sfixed64_scalar Key(bool k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Sfixed64_scalar_int32_map extends delta.Location {
  Sfixed64_scalar_int32_map(List<pb.Locator> location) : super(location);
  Sfixed64_scalar Key(int k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Sfixed64_scalar_int64_map extends delta.Location {
  Sfixed64_scalar_int64_map(List<pb.Locator> location) : super(location);
  Sfixed64_scalar Key(int k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Sfixed64_scalar Key64(fixnum.Int64 k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Sfixed64_scalar_uint32_map extends delta.Location {
  Sfixed64_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Sfixed64_scalar Key(int k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Sfixed64_scalar_uint64_map extends delta.Location {
  Sfixed64_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Sfixed64_scalar Key(int k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Sfixed64_scalar Key64(fixnum.Int64 k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Sfixed64_scalar_string_map extends delta.Location {
  Sfixed64_scalar_string_map(List<pb.Locator> location) : super(location);
  Sfixed64_scalar Key(String k) {
    return Sfixed64_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Bool_scalar extends delta.Location {
  Bool_scalar(List<pb.Locator> location) : super(location);
}

class Bool_scalar_repeated extends delta.Location {
  Bool_scalar_repeated(List<pb.Locator> location) : super(location);
  Bool_scalar Index(int i) {
    return Bool_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Bool_scalar Index64(fixnum.Int64 i) {
    return Bool_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Bool_scalar_bool_map extends delta.Location {
  Bool_scalar_bool_map(List<pb.Locator> location) : super(location);
  Bool_scalar Key(bool k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Bool_scalar_int32_map extends delta.Location {
  Bool_scalar_int32_map(List<pb.Locator> location) : super(location);
  Bool_scalar Key(int k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Bool_scalar_int64_map extends delta.Location {
  Bool_scalar_int64_map(List<pb.Locator> location) : super(location);
  Bool_scalar Key(int k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Bool_scalar Key64(fixnum.Int64 k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Bool_scalar_uint32_map extends delta.Location {
  Bool_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Bool_scalar Key(int k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Bool_scalar_uint64_map extends delta.Location {
  Bool_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Bool_scalar Key(int k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Bool_scalar Key64(fixnum.Int64 k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Bool_scalar_string_map extends delta.Location {
  Bool_scalar_string_map(List<pb.Locator> location) : super(location);
  Bool_scalar Key(String k) {
    return Bool_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class String_scalar extends delta.Location {
  String_scalar(List<pb.Locator> location) : super(location);
}

class String_scalar_repeated extends delta.Location {
  String_scalar_repeated(List<pb.Locator> location) : super(location);
  String_scalar Index(int i) {
    return String_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  String_scalar Index64(fixnum.Int64 i) {
    return String_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class String_scalar_bool_map extends delta.Location {
  String_scalar_bool_map(List<pb.Locator> location) : super(location);
  String_scalar Key(bool k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class String_scalar_int32_map extends delta.Location {
  String_scalar_int32_map(List<pb.Locator> location) : super(location);
  String_scalar Key(int k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class String_scalar_int64_map extends delta.Location {
  String_scalar_int64_map(List<pb.Locator> location) : super(location);
  String_scalar Key(int k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  String_scalar Key64(fixnum.Int64 k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class String_scalar_uint32_map extends delta.Location {
  String_scalar_uint32_map(List<pb.Locator> location) : super(location);
  String_scalar Key(int k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class String_scalar_uint64_map extends delta.Location {
  String_scalar_uint64_map(List<pb.Locator> location) : super(location);
  String_scalar Key(int k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  String_scalar Key64(fixnum.Int64 k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class String_scalar_string_map extends delta.Location {
  String_scalar_string_map(List<pb.Locator> location) : super(location);
  String_scalar Key(String k) {
    return String_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

class Bytes_scalar extends delta.Location {
  Bytes_scalar(List<pb.Locator> location) : super(location);
}

class Bytes_scalar_repeated extends delta.Location {
  Bytes_scalar_repeated(List<pb.Locator> location) : super(location);
  Bytes_scalar Index(int i) {
    return Bytes_scalar([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
  }
  Bytes_scalar Index64(fixnum.Int64 i) {
    return Bytes_scalar([...location]..add(pb.Locator()..index = i));
  }
}

class Bytes_scalar_bool_map extends delta.Location {
  Bytes_scalar_bool_map(List<pb.Locator> location) : super(location);
  Bytes_scalar Key(bool k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..bool_1 = k)));
  }
}

class Bytes_scalar_int32_map extends delta.Location {
  Bytes_scalar_int32_map(List<pb.Locator> location) : super(location);
  Bytes_scalar Key(int k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int32 = k)));
  }
}

class Bytes_scalar_int64_map extends delta.Location {
  Bytes_scalar_int64_map(List<pb.Locator> location) : super(location);
  Bytes_scalar Key(int k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(k))));
  }
  Bytes_scalar Key64(fixnum.Int64 k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..int64 = k)));
  }
}

class Bytes_scalar_uint32_map extends delta.Location {
  Bytes_scalar_uint32_map(List<pb.Locator> location) : super(location);
  Bytes_scalar Key(int k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint32 = k)));
  }
}

class Bytes_scalar_uint64_map extends delta.Location {
  Bytes_scalar_uint64_map(List<pb.Locator> location) : super(location);
  Bytes_scalar Key(int k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = fixnum.Int64(k))));
  }
  Bytes_scalar Key64(fixnum.Int64 k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..uint64 = k)));
  }
}

class Bytes_scalar_string_map extends delta.Location {
  Bytes_scalar_string_map(List<pb.Locator> location) : super(location);
  Bytes_scalar Key(String k) {
    return Bytes_scalar([...location]..add(pb.Locator()..key = (pb.Key()..string = k)));
  }
}

