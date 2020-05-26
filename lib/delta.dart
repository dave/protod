import 'package:diff_match_patch/diff_match_patch.dart' as diff_match_patch;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:protod/delta.pb.dart' as pb;
import 'package:quill_delta/quill_delta.dart' as quill;

import 'google/protobuf/any.pb.dart' as any;

export 'delta.op.dart';

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
    var outString = "";
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
  } else if (op.hasObject()) {
    return fromObject(op.object, r);
  } else {
    //	*Op_Index
    //	*Op_Key
    throw Exception('invalid operation ${op.runtimeType}');
  }
}

dynamic fromObject(pb.Object value, protobuf.TypeRegistry r) {
  if (value.hasScalar()) {
    return valueFromScalar(value.scalar);
  } else if (value.hasMessage()) {
    final info = r.lookup(value.message.typeUrl.substring(20));
    if (info == null) {
      throw Exception('no type registered for ${value.message.typeUrl}');
    }
    return value.message.unpackInto(info.createEmptyInstance());
  } else if (value.hasList()) {
    var list = [];
    value.list.list.forEach((element) {
      list.add(fromObject(element, r));
    });
    return list;
  } else if (value.hasMapBool()) {
    var map = Map();
    value.mapBool.map.forEach((key, value) {
      map[key] = fromObject(value, r);
    });
    return map;
  } else if (value.hasMapInt32()) {
    var map = Map();
    value.mapInt32.map.forEach((key, value) {
      map[key] = fromObject(value, r);
    });
    return map;
  } else if (value.hasMapInt64()) {
    var map = Map();
    value.mapInt64.map.forEach((key, value) {
      map[key] = fromObject(value, r);
    });
    return map;
  } else if (value.hasMapUint32()) {
    var map = Map();
    value.mapUint32.map.forEach((key, value) {
      map[key] = fromObject(value, r);
    });
    return map;
  } else if (value.hasMapUint64()) {
    var map = Map();
    value.mapUint64.map.forEach((key, value) {
      map[key] = fromObject(value, r);
    });
    return map;
  } else if (value.hasMapString()) {
    var map = Map();
    value.mapString.map.forEach((key, value) {
      map[key] = fromObject(value, r);
    });
    return map;
  } else {
    throw Exception("no value in fromObject");
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
      if (parent.info_.fieldInfo[field].isRepeated) {
        var valueList = value as List;
        var fieldList = parent.getField(field) as protobuf.PbList;
        fieldList.clear();
        valueList.forEach((element) {
          fieldList.add(element);
        });
      } else if (parent.info_.fieldInfo[field].isMapField) {
        var valueMap = value as Map;
        var fieldMap = parent.getField(field) as protobuf.PbMap;
        fieldMap.clear();
        valueMap.forEach((key, value) {
          fieldMap[key] = value;
        });
      } else {
        parent.setField(field, value);
      }
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
      if (index == parent.length) {
        final value = getValue(null, op, r);
        parent.add(value);
      } else {
        final value = getValue(parent[index], op, r);
        parent.insert(index, value);
      }
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
      final to = valueFromKey(op.key);
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

pb.Op edit(List<pb.Locator> location, String from, String to) {
  final diffs = diff_match_patch.diff(from, to);
  diff_match_patch.cleanupSemantic(diffs);
  var delta = pb.Delta();
  diffs.forEach((diff) {
    switch (diff.operation) {
      case diff_match_patch.DIFF_DELETE:
        delta.ops.add(pb.Quill()..delete = fixnum.Int64(diff.text.length));
        break;
      case diff_match_patch.DIFF_EQUAL:
        delta.ops.add(pb.Quill()..retain = fixnum.Int64(diff.text.length));
        break;
      case diff_match_patch.DIFF_INSERT:
        delta.ops.add(pb.Quill()..insert = diff.text);
    }
  });
  return pb.Op()
    ..type = pb.Op_Type.Edit
    ..location.addAll(location)
    ..delta = delta;
}

pb.Op replace(List<pb.Locator> location, dynamic value) {
  var op = pb.Op()
    ..type = pb.Op_Type.Edit
    ..location.addAll(location);

  if (value is pb.Scalar) {
    op.scalar = value;
  } else if (value is protobuf.GeneratedMessage) {
    op.message = any.Any.pack(value);
  } else {
    op.object = getObject(value);
  }

  return op;
}

pb.Op delete(List<pb.Locator> location) {
  return pb.Op()
    ..type = pb.Op_Type.Delete
    ..location.addAll(location);
}

pb.Op insert(List<pb.Locator> location, dynamic value) {
  var op = pb.Op()
    ..type = pb.Op_Type.Insert
    ..location.addAll(location);

  if (value is pb.Scalar) {
    op.scalar = value;
  } else if (value is protobuf.GeneratedMessage) {
    op.message = any.Any.pack(value);
  } else {
    op.object = getObject(value);
  }

  return op;
}

pb.Op moveMap(List<pb.Locator> location, pb.Key to) {
  return pb.Op()
    ..type = pb.Op_Type.Move
    ..location.addAll(location)
    ..key = to;
}

pb.Op moveList(List<pb.Locator> location, fixnum.Int64 to) {
  return pb.Op()
    ..type = pb.Op_Type.Move
    ..location.addAll(location)
    ..index = to;
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

pb.Key keyString(String key) {
  return pb.Key()..string = key;
}

pb.Key keyBool(bool key) {
  return pb.Key()..bool_1 = key;
}

pb.Key keyInt32(int key) {
  return pb.Key()..int32 = key;
}

pb.Key keyInt64(fixnum.Int64 key) {
  return pb.Key()..int64 = key;
}

pb.Key keyUint32(int key) {
  return pb.Key()..uint32 = key;
}

pb.Key keyUint64(fixnum.Int64 key) {
  return pb.Key()..uint64 = key;
}

pb.Scalar scalarDouble(double value) {
  return pb.Scalar()..double_1 = value;
}

pb.Scalar scalarFloat(double value) {
  return pb.Scalar()..float = value;
}

pb.Scalar scalarInt32(int value) {
  return pb.Scalar()..int32 = value;
}

pb.Scalar scalarInt64(fixnum.Int64 value) {
  return pb.Scalar()..int64 = value;
}

pb.Scalar scalarUint32(int value) {
  return pb.Scalar()..uint32 = value;
}

pb.Scalar scalarUint64(fixnum.Int64 value) {
  return pb.Scalar()..uint64 = value;
}

pb.Scalar scalarSint32(int value) {
  return pb.Scalar()..sint32 = value;
}

pb.Scalar scalarSint64(fixnum.Int64 value) {
  return pb.Scalar()..sint64 = value;
}

pb.Scalar scalarFixed32(int value) {
  return pb.Scalar()..fixed32 = value;
}

pb.Scalar scalarFixed64(fixnum.Int64 value) {
  return pb.Scalar()..fixed64 = value;
}

pb.Scalar scalarSfixed32(int value) {
  return pb.Scalar()..sfixed32 = value;
}

pb.Scalar scalarSfixed64(fixnum.Int64 value) {
  return pb.Scalar()..sfixed64 = value;
}

pb.Scalar scalarBool(bool value) {
  return pb.Scalar()..bool_13 = value;
}

pb.Scalar scalarString(String value) {
  return pb.Scalar()..string = value;
}

pb.Scalar scalarBytes(List<int> value) {
  return pb.Scalar()..bytes = value;
}

List<pb.Locator> copyAndAppendField(
    List<pb.Locator> location, String name, int number) {
  return [...location]..add(newLocatorField(name, number));
}

List<pb.Locator> copyAndAppendIndex(
    List<pb.Locator> location, fixnum.Int64 index) {
  return [...location]..add(newLocatorIndex(index));
}

List<pb.Locator> copyAndAppendKeyString(List<pb.Locator> location, String key) {
  return [...location]..add(newLocatorKeyString(key));
}

List<pb.Locator> copyAndAppendKeyBool(List<pb.Locator> location, bool key) {
  return [...location]..add(newLocatorKeyBool(key));
}

List<pb.Locator> copyAndAppendKeyInt32(List<pb.Locator> location, int key) {
  return [...location]..add(newLocatorKeyInt32(key));
}

List<pb.Locator> copyAndAppendKeyInt64(
    List<pb.Locator> location, fixnum.Int64 key) {
  return [...location]..add(newLocatorKeyInt64(key));
}

List<pb.Locator> copyAndAppendKeyUint32(List<pb.Locator> location, int key) {
  return [...location]..add(newLocatorKeyUint32(key));
}

List<pb.Locator> copyAndAppendKeyUint64(
    List<pb.Locator> location, fixnum.Int64 key) {
  return [...location]..add(newLocatorKeyUint64(key));
}

pb.Locator newLocatorField(String name, int number) {
  return pb.Locator()
    ..field_1 = (pb.Field()
      ..name = name
      ..number = number);
}

pb.Locator newLocatorIndex(fixnum.Int64 index) {
  return pb.Locator()..index = index;
}

pb.Locator newLocatorKeyString(String key) {
  return pb.Locator()..key = (pb.Key()..string = key);
}

pb.Locator newLocatorKeyBool(bool key) {
  return pb.Locator()..key = (pb.Key()..bool_1 = key);
}

pb.Locator newLocatorKeyInt32(int key) {
  return pb.Locator()..key = (pb.Key()..int32 = key);
}

pb.Locator newLocatorKeyInt64(fixnum.Int64 key) {
  return pb.Locator()..key = (pb.Key()..int64 = key);
}

pb.Locator newLocatorKeyUint32(int key) {
  return pb.Locator()..key = (pb.Key()..uint32 = key);
}

pb.Locator newLocatorKeyUint64(fixnum.Int64 key) {
  return pb.Locator()..key = (pb.Key()..uint64 = key);
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

pb.Object getObject(dynamic value) {
  if (value is List) {
    var ob = pb.Object();
    ob.list = pb.List_();
    value.forEach((element) {
      ob.list.list.add(getObject(element));
    });
    return ob;
  } else if (value is Map) {
    final key = value.keys.first;
    var ob = pb.Object();
    Map map;
    if (key is bool) {
      ob.mapBool = pb.MapBool();
      map = ob.mapBool.map;
    } else if (key is int) {
      ob.mapInt64 = pb.MapInt64();
      map = ob.mapInt64.map;
    } else if (key is fixnum.Int32) {
      ob.mapInt32 = pb.MapInt32();
      map = ob.mapInt32.map;
    } else if (key is fixnum.Int64) {
      ob.mapInt64 = pb.MapInt64();
      map = ob.mapInt64.map;
    } else if (key is String) {
      ob.mapString = pb.MapString();
      map = ob.mapString.map;
    } else {
      throw Exception("invalid map key ${key.runtimeType} in getObject");
    }
    value.forEach((key, value) {
      map[key] = getObject(value);
    });
    return ob;
  } else if (value is protobuf.GeneratedMessage) {
    return pb.Object()..message = any.Any.pack(value);
  } else if (isScalar(value)) {
    return pb.Object()..scalar = getScalar(value);
  }
  throw Exception("invalid type ${value.runtimeType} in getObject");
}

pb.Scalar getScalar(dynamic value) {
  if (value is int) {
    return pb.Scalar()..int64 = fixnum.Int64(value);
  } else if (value is fixnum.Int64) {
    return pb.Scalar()..int64 = value;
  } else if (value is fixnum.Int32) {
    return pb.Scalar()..int32 = value.toInt();
  } else if (value is String) {
    return pb.Scalar()..string = value;
  } else if (value is double) {
    return pb.Scalar()..double_1 = value;
  } else if (value is bool) {
    return pb.Scalar()..bool_13 = value;
  } else if (value is List<int>) {
    return pb.Scalar()..bytes = value;
  }
  throw Exception("unknown type ${value.runtimeType} in getScalar");
}
