import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:protod/delta.pb.dart' as delta;

import 'google/protobuf/any.pb.dart' as any;

export 'delta.types.dart';

protobuf.TypeRegistry _defaultTypeRegistry;

setDefaultRegistry(protobuf.TypeRegistry r) {
  _defaultTypeRegistry = r;
}

apply(delta.Delta d, protobuf.GeneratedMessage m, [protobuf.TypeRegistry r]) {
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

dynamic getKey(delta.Key k) {
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
  } else if (k.hasStr()) {
    return k.str;
  }
}

dynamic scalarFromAny(any.Any any) {
  if (any.typeUrl != 'type.googleapis.com/delta.Scalar') {
    throw Exception('wrong type ${any.typeUrl}');
  }
  final s = any.unpackInto(delta.Scalar());
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

delta.Delta editValue(dynamic value, Locator locator) {
  List<delta.Locator> loc = [];
  locator.location.forEach((element) {
    switch (element.runtimeType) {
      case Field:
        final field = element as Field;
        loc.add(
          delta.Locator()
            ..field_1 = (delta.Field()
              ..name = field.name
              ..number = field.number),
        );
        break;
      case Index:
        final index = element as Index;
        loc.add(delta.Locator()..index = fixnum.Int64(index.index));
        break;
      case Key:
        final key = element as Key;
        switch (key.key.runtimeType) {
          case int:
            final k = key.key as int;
            loc.add(delta.Locator()..key = (delta.Key()..int32 = k));
            break;
          case fixnum.Int32:
            final k = key.key as fixnum.Int32;
            loc.add(delta.Locator()..key = (delta.Key()..int32 = k.toInt()));
            break;
          case fixnum.Int64:
            final k = key.key as fixnum.Int64;
            loc.add(delta.Locator()..key = (delta.Key()..int64 = k));
            break;
          case String:
            final k = key.key as String;
            loc.add(delta.Locator()..key = (delta.Key()..str = k));
            break;
        }
        break;
      case KeyUint32:
        final key = element as KeyUint32;
        loc.add(delta.Locator()..key = (delta.Key()..uint32 = key.key.toInt()));
        break;
      case KeyUint64:
        final key = element as KeyUint64;
        loc.add(delta.Locator()..key = (delta.Key()..uint64 = key.key));
        break;
    }
  });
  return delta.Delta()
    ..type = delta.Delta_Type.Edit
    ..value = toAny(value)
    ..location.addAll(loc);
}

any.Any toAny(dynamic value) {
  if (value is protobuf.GeneratedMessage) {
    return any.Any.pack(value);
  }
  protobuf.GeneratedMessage m;
  if (value is List<int>) {
    m = delta.Scalar()..bytes = value;
  } else {
    switch (value.runtimeType) {
      case String:
        m = delta.Scalar()..string = value;
        break;
      case double:
        m = delta.Scalar()..double_1 = value;
        break;
      case int:
        m = delta.Scalar()..int64 = fixnum.Int64(value);
        break;
      case bool:
        m = delta.Scalar()..bool_13 = value;
        break;
    }
  }
  if (m == null) {
    throw new Exception('unknown type ${value.runtimeType}');
  }
  return any.Any.pack(m);
}

abstract class Locator {
  List<Indexer> location;
  Locator(this.location);
}

abstract class Indexer {}

class Field extends Indexer {
  String name;
  int number;
  Field(this.name, this.number);
}

class Index extends Indexer {
  int index;
  Index(this.index);
}

class Key extends Indexer {
  dynamic key;
  Key(this.key);
}

class KeyUint32 extends Indexer {
  fixnum.Int64 key;
  KeyUint32(this.key);
}

class KeyUint64 extends Indexer {
  fixnum.Int64 key;
  KeyUint64(this.key);
}
