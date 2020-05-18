import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:protod/delta.pb.dart' as pb;

import 'google/protobuf/any.pb.dart' as any;

export 'delta.types.dart';

protobuf.TypeRegistry _defaultTypeRegistry;

setDefaultRegistry(protobuf.TypeRegistry r) {
  _defaultTypeRegistry = r;
}

apply(pb.Delta d, protobuf.GeneratedMessage m, [protobuf.TypeRegistry r]) {
  if (r == null) {
    r = _defaultTypeRegistry;
  }
  final last = d.location.removeLast();

  dynamic current = m;

  d.location.forEach((element) {
    if (element.hasField_1()) {
      final message = current as protobuf.GeneratedMessage;
      final number = message.getTagNumber(element.field_1.name);
      if (number != element.field_1.number) {
        throw Exception(
            'protobuf field name / number mismatch ${element.field_1.name}/${element.field_1.number} but ${number}.');
      }
      current = message.getField(number);
    } else if (element.hasIndex()) {
      final list = current as protobuf.PbList;
      current = list[element.index.toInt()];
    } else if (element.hasKey()) {
      final map = current as protobuf.PbMap;
      current = map[getKey(element.key)];
    }
  });

  dynamic newValue;
  if (d.value.typeUrl == 'type.googleapis.com/delta.Scalar') {
    newValue = scalarFromAny(d.value);
  } else {
    final builderInfo = r.lookup(d.value.typeUrl.substring(20));
    if (builderInfo == null) {
      throw Exception('no builderinfo for ${d.value.typeUrl}');
    }
    newValue = d.value.unpackInto(builderInfo.createEmptyInstance());
  }

  if (last.hasField_1()) {
    final message = current as protobuf.GeneratedMessage;
    final number = message.getTagNumber(last.field_1.name);
    if (number != last.field_1.number) {
      throw Exception(
          'protobuf field name / number mismatch ${last.field_1.name}/${last.field_1.number} but ${number}.');
    }
    message.setField(number, newValue);
  } else if (last.hasIndex()) {
    final list = current as protobuf.PbList;
    list[last.index.toInt()] = newValue;
  } else if (last.hasKey()) {
    final map = current as protobuf.PbMap;
    map[getKey(last.key)] = newValue;
  }
}

dynamic getKey(pb.Key k) {
  if (k.hasBool_1()) {
    return k.bool_1;
  } else if (k.hasInt32()) {
    return k.int32;
  } else if (k.hasInt64()) {
    return k.int64;
  } else if (k.hasUint32()) {
    return k.uint32;
  } else if (k.hasUint64()) {
    return k.uint64;
  } else if (k.hasString()) {
    return k.string;
  }
}

dynamic scalarFromAny(any.Any any) {
  if (any.typeUrl != 'type.googleapis.com/delta.Scalar') {
    throw Exception('wrong type ${any.typeUrl}');
  }
  final s = any.unpackInto(pb.Scalar());
  if (s.hasBool_13()) {
    return s.bool_13;
  } else if (s.hasBytes()) {
    return s.bytes;
  } else if (s.hasDouble_1()) {
    return s.double_1;
  } else if (s.hasFixed32()) {
    return s.fixed32;
  } else if (s.hasFixed64()) {
    return s.fixed64;
  } else if (s.hasFloat()) {
    return s.float;
  } else if (s.hasInt32()) {
    return s.int32;
  } else if (s.hasInt64()) {
    return s.int64;
  } else if (s.hasSfixed32()) {
    return s.sfixed32;
  } else if (s.hasSfixed64()) {
    return s.sfixed64;
  } else if (s.hasSint32()) {
    return s.sint32;
  } else if (s.hasSint64()) {
    return s.sint64;
  } else if (s.hasString()) {
    return s.string;
  } else if (s.hasUint32()) {
    return s.uint32;
  } else if (s.hasUint64()) {
    return s.uint64;
  }
}

pb.Delta edit(dynamic value, Location location) {
  return pb.Delta()
    ..type = pb.Delta_Type.Edit
    ..value = toAny(value)
    ..location.addAll(location.location);
}

any.Any toAny(dynamic value) {
  if (value is protobuf.GeneratedMessage) {
    return any.Any.pack(value);
  }
  protobuf.GeneratedMessage m;
  if (value is List<int>) {
    m = pb.Scalar()..bytes = value;
  } else {
    switch (value.runtimeType) {
      case String:
        m = pb.Scalar()..string = value;
        break;
      case double:
        m = pb.Scalar()..double_1 = value;
        break;
      case int:
        m = pb.Scalar()..int64 = fixnum.Int64(value);
        break;
      case bool:
        m = pb.Scalar()..bool_13 = value;
        break;
    }
  }
  if (m == null) {
    throw new Exception('unknown type ${value.runtimeType}');
  }
  return any.Any.pack(m);
}

abstract class Location {
  List<pb.Locator> location;
  Location(this.location);
}
