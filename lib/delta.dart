import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:protod/delta.pb.dart' as pb;
import 'package:quill_delta/quill_delta.dart' as quill;

import 'google/protobuf/any.pb.dart' as any;

export 'delta.types.dart';

protobuf.TypeRegistry _defaultTypeRegistry;

setDefaultRegistry(protobuf.TypeRegistry r) {
  _defaultTypeRegistry = r;
}

apply(pb.Op op, protobuf.GeneratedMessage m, [protobuf.TypeRegistry r]) {
  switch (op.type) {
    case pb.Op_Type.Edit:
      applyEdit(op, m, r);
      break;
    case pb.Op_Type.Insert:
      applyInsert(op, m, r);
      break;
    case pb.Op_Type.Move:
      applyMove(op, m, r);
      break;
    case pb.Op_Type.Delete:
      applyDelete(op, m, r);
      break;
  }
}

int getFieldNumber(protobuf.GeneratedMessage message, pb.Field field) {
  final number = message.getTagNumber(field.name);
  if (number != field.number) {
    throw Exception('field name / number mismatch');
  }
  return number;
}

getLocation(protobuf.GeneratedMessage m, List<pb.Locator> location) {
  dynamic current = m;
  location.forEach((locator) {
    if (locator.hasField_1()) {
      if (current is protobuf.GeneratedMessage) {
        current = current.getField(getFieldNumber(current, locator.field_1));
      } else {
        throw Exception(
            'field locator expected to find message, got ${current.runtimeType}');
      }
    } else if (locator.hasIndex()) {
      if (current is protobuf.PbList) {
        current = current[locator.index.toInt()];
      } else {
        throw Exception(
            'index locator expected to find list, got ${current.runtimeType}');
      }
    } else if (locator.hasKey()) {
      if (current is protobuf.PbMap) {
        current = current[valueFromKey(locator.key)];
      } else {
        throw Exception(
            'key locator expected to find map, got ${current.runtimeType}');
      }
    }
  });
  return current;
}

dynamic getValue(dynamic previous, pb.Op op, protobuf.TypeRegistry r) {
  if (op.hasScalar()) {
    final scalar = op.scalar;
    if (scalar.hasFloat()) {
      return scalar.float;
    } else if (scalar.hasDouble_1()) {
      return scalar.double_1;
    } else if (scalar.hasInt32()) {
      return scalar.int32;
    } else if (scalar.hasInt64()) {
      return scalar.int64;
    } else if (scalar.hasUint32()) {
      return scalar.uint32;
    } else if (scalar.hasUint64()) {
      return scalar.uint64;
    } else if (scalar.hasBool_13()) {
      return scalar.bool_13;
    } else if (scalar.hasString()) {
      return scalar.string;
    } else if (scalar.hasBytes()) {
      return scalar.bytes;
    } else {
      //			//case *Scalar_Sint32, *Scalar_Sint64:
      //			//case *Scalar_Fixed32, *Scalar_Fixed64:
      //			//case *Scalar_Sfixed32, *Scalar_Sfixed64:
      throw Exception('unsupported scalar ${scalar.runtimeType} in getValue');
    }
  } else if (op.hasDelta()) {
    final prevString = previous as String;
    var dlt = quill.Delta();
    op.delta.ops.forEach((q) {
      if (q.hasInsert()) {
        dlt.insert(q.insert);
      } else if (q.hasRetain()) {
        dlt.retain(q.retain.toInt());
      } else if (q.hasDelete()) {
        dlt.delete(q.delete.toInt());
      }
    });
    final prevDelta = quill.Delta()..insert(prevString);
    final out = prevDelta.compose(dlt);
    String outString;
    out.toList().forEach((op) {
      // TODO: Is there a better way of applying the delta to prevString?
      if (!op.isInsert) {
        throw new Exception('non insert operation found after applying delta');
      }
      outString += op.data;
    });
    return outString;
  } else if (op.hasMessage()) {
    final info = r.lookup(op.message.typeUrl.substring(20));
    if (info == null) {
      throw Exception('no type registered for ${op.message.typeUrl}');
    }
    return op.message.unpackInto(info.createEmptyInstance());
  } else {
    //	*Op_Index
    //	*Op_Key
    throw Exception('invalid operation ${op.runtimeType}');
  }
}

applyEdit(pb.Op op, protobuf.GeneratedMessage input,
    [protobuf.TypeRegistry r]) {
  if (r == null) {
    r = _defaultTypeRegistry;
  }
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parent = getLocation(input, parentLocator);
  if (itemLocator.hasField_1()) {
    if (parent is protobuf.GeneratedMessage) {
      final field = getFieldNumber(parent, itemLocator.field_1);
      final value = getValue(parent.getField(field), op, r);
      parent.setField(field, value);
    } else {
      throw Exception("can't apply field locator to ${parent.runtimeType}");
    }
  } else if (itemLocator.hasIndex()) {
    if (parent is protobuf.PbList) {
      final index = itemLocator.index.toInt();
      final value = getValue(parent[index], op, r);
      parent[index] = value;
    } else {
      throw Exception("can't apply list locator to ${parent.runtimeType}");
    }
  } else if (itemLocator.hasKey()) {
    if (parent is protobuf.PbMap) {
      final key = valueFromKey(itemLocator.key);
      final value = getValue(parent[key], op, r);
      parent[key] = value;
    } else {
      throw Exception("can't apply map locator to ${parent.runtimeType}");
    }
  }
}

applyInsert(pb.Op op, protobuf.GeneratedMessage input,
    [protobuf.TypeRegistry r]) {
  if (r == null) {
    r = _defaultTypeRegistry;
  }
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parent = getLocation(input, parentLocator);
  if (itemLocator.hasField_1()) {
    throw Exception("can't insert with a field locator");
  } else if (itemLocator.hasIndex()) {
    if (parent is protobuf.PbList) {
      final index = itemLocator.index.toInt();
      final value = getValue(parent[index], op, r);
      parent.insert(index, value);
    } else {
      throw Exception(
          "can't insert with list locator in ${parent.runtimeType}");
    }
  } else if (itemLocator.hasKey()) {
    if (parent is protobuf.PbMap) {
      final key = valueFromKey(itemLocator.key);
      final value = getValue(parent[key], op, r);
      parent[key] = value;
    } else {
      throw Exception("can't insert with map locator in ${parent.runtimeType}");
    }
  }
}

applyMove(pb.Op op, protobuf.GeneratedMessage input,
    [protobuf.TypeRegistry r]) {
  if (r == null) {
    r = _defaultTypeRegistry;
  }
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parent = getLocation(input, parentLocator);
  if (itemLocator.hasField_1()) {
    throw Exception("can't move with a field locator");
  } else if (itemLocator.hasIndex()) {
    if (parent is protobuf.PbList) {
      final from = itemLocator.index.toInt();
      if (!op.hasIndex()) {
        throw Exception("can't move in list with ${op.runtimeType} value");
      }
      final to = op.index.toInt();
      final item = parent.removeAt(from);
      parent.insert(to, item);
    } else {
      throw Exception(
          "can't insert with list locator in ${parent.runtimeType}");
    }
  } else if (itemLocator.hasKey()) {
    if (parent is protobuf.PbMap) {
      final from = valueFromKey(itemLocator.key);
      if (!op.hasKey()) {
        throw Exception("can't move in map with ${op.runtimeType} value");
      }
      final to = op.key;
      final item = parent.remove(from);
      parent[to] = item;
    } else {
      throw Exception("can't insert with map locator in ${parent.runtimeType}");
    }
  }
}

applyDelete(pb.Op op, protobuf.GeneratedMessage input,
    [protobuf.TypeRegistry r]) {
  if (r == null) {
    r = _defaultTypeRegistry;
  }
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parent = getLocation(input, parentLocator);
  if (itemLocator.hasField_1()) {
    if (parent is protobuf.GeneratedMessage) {
      final field = getFieldNumber(parent, itemLocator.field_1);
      parent.clearField(field);
    } else {
      throw Exception("can't delete field locator from ${parent.runtimeType}");
    }
  } else if (itemLocator.hasIndex()) {
    if (parent is protobuf.PbList) {
      final index = itemLocator.index.toInt();
      parent.removeAt(index);
    } else {
      throw Exception("can't delete list locator from ${parent.runtimeType}");
    }
  } else if (itemLocator.hasKey()) {
    if (parent is protobuf.PbMap) {
      final key = valueFromKey(itemLocator.key);
      parent.remove(key);
    } else {
      throw Exception("can't delete map locator from ${parent.runtimeType}");
    }
  }
}

dynamic valueFromKey(pb.Key k) {
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

pb.Op edit(Location location, dynamic value) {
  var op = pb.Op()
    ..type = pb.Op_Type.Edit
    ..location.addAll(location.location);

  if (isScalar(value)) {
    op.scalar = getScalar(value);
  } else if (value is protobuf.GeneratedMessage) {
    op.message = any.Any.pack(value);
  } else {
    throw Exception('invalid type ${value.runtimeType} in edit');
  }

  return op;
}

pb.Op insert(Location location, dynamic value) {
  var op = pb.Op()
    ..type = pb.Op_Type.Insert
    ..location.addAll(location.location);

  if (isScalar(value)) {
    op.scalar = getScalar(value);
  } else if (value is protobuf.GeneratedMessage) {
    op.message = any.Any.pack(value);
  } else {
    throw Exception('invalid type ${value.runtimeType} in insert');
  }

  return op;
}

bool isScalar(dynamic v) {
  return v is int ||
      v is fixnum.Int32 ||
      v is fixnum.Int64 ||
      v is String ||
      v is double ||
      v is bool ||
      v is List<int>;
}

pb.Scalar getScalar(dynamic v) {
  if (v is int) {
    return pb.Scalar()..int64 = fixnum.Int64(v);
  } else if (v is fixnum.Int32) {
    return pb.Scalar()..int32 = v.toInt();
  } else if (v is fixnum.Int64) {
    return pb.Scalar()..int64 = v;
  } else if (v is String) {
    return pb.Scalar()..string = v;
  } else if (v is double) {
    return pb.Scalar()..double_1 = v;
  } else if (v is bool) {
    return pb.Scalar()..bool_13 = v;
  } else if (v is List<int>) {
    return pb.Scalar()..bytes = v;
  } else {
    throw Exception('invalid type for scalar ${v.runtimeType}');
  }
  ;
}

abstract class Location {
  List<pb.Locator> location;
  Location(this.location);
}

dynamic valueFromScalar(pb.Scalar s) {
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
