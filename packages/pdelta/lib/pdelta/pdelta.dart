import 'package:diff_match_patch/diff_match_patch.dart' as diff_match_patch;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:pdelta/pdelta/pdelta.pb.dart' as pb;
import 'package:pdelta/pdelta/pdelta_registry.dart';
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:ptypes/google/protobuf/any.pb.dart' as any;
import 'package:quill_delta/quill_delta.dart' as quill;
import 'package:tuple/tuple.dart';

export 'pdelta.op.dart';
export 'pdelta_transform.dart';

final _defaultTypeRegistry = TypeRegistry();

void registerTypes(Iterable<protobuf.GeneratedMessage> types) {
  _defaultTypeRegistry.add(types);
}

protobuf.GeneratedMessage unpack(any.Any packed, [TypeRegistry reg]) {
  final registry = reg ?? _defaultTypeRegistry;
  if (packed == null || packed.typeUrl == "") {
    throw Exception("typeUrl is empty");
  }
  final name = packed.typeUrl.substring(20);
  final info = registry.lookup(name);
  if (info == null) {
    throw Exception("can't find ${packed.typeUrl} in registry");
  }
  var message = info.createEmptyInstance();
  packed.unpackInto(message);
  return message;
}

pb.Op compound(List<pb.Op> ops) {
  if (ops.length == 0) {
    return nullOp;
  } else if (ops.length == 1) {
    return ops[0];
  } else {
    return pb.Op()
      ..type = pb.Op_Type.Compound
      ..ops.addAll(ops);
  }
}

pb.Op get nullOp => pb.Op()..type = pb.Op_Type.Null;

apply(pb.Op op, protobuf.GeneratedMessage m, [TypeRegistry reg]) {
  if (isNull(op)) {
    return;
  }
  switch (op.type) {
    case pb.Op_Type.Compound:
      op.ops.forEach((o) {
        apply(o, m, reg);
      });
      break;
    case pb.Op_Type.Edit:
      applySetEdit(op, m, reg);
      break;
    case pb.Op_Type.Set:
      applySetEdit(op, m, reg);
      break;
    case pb.Op_Type.Insert:
      applyInsert(op, m, reg);
      break;
    case pb.Op_Type.Move:
      applyMove(op, m);
      break;
    case pb.Op_Type.Rename:
      applyRename(op, m);
      break;
    case pb.Op_Type.Delete:
      applyDelete(op, m);
      break;
  }
}

int getFieldNumber(protobuf.GeneratedMessage message, pb.Field field) {
  final number = message.getTagNumber(field.name);
  if (number != field.number) {
    throw Exception('field name / number mismatch for ${field.name}: expect ${field.number}, found ${number}');
  }
  return number;
}

void initialiseField(protobuf.GeneratedMessage msg, protobuf.FieldInfo field) {
  if (!msg.hasField(field.tagNumber)) {
    if (!field.isRepeated && field.subBuilder != null) {
      msg.setField(field.tagNumber, field.subBuilder());
    } else if (field is protobuf.MapFieldInfo) {
      // TODO: work-around for: https://github.com/dart-lang/protobuf/issues/373
      msg.$_getMap(field.index);
    }
  }
}

Tuple2<dynamic, protobuf.ValueOfFunc> getLocation(
  protobuf.GeneratedMessage m,
  List<pb.Locator> location,
) {
  dynamic current = m;
  protobuf.FieldInfo previousField;
  protobuf.ValueOfFunc currentValueOf;
  pb.Locator previousLocator;
  location.forEach((locator) {
    if (locator.hasField_1()) {
      if (current is protobuf.GeneratedMessage) {
        final msg = current as protobuf.GeneratedMessage;
        final fieldNumber = getFieldNumber(msg, locator.field_1);
        final field = msg.info_.fieldInfo[fieldNumber];
        previousField = field;
        initialiseField(msg, field);
        current = msg.getField(fieldNumber);
        if (field is protobuf.MapFieldInfo) {
          currentValueOf = field.mapEntryBuilderInfo.byIndex[1].valueOf;
        } else {
          currentValueOf = field.valueOf;
        }

        if (current is protobuf.GeneratedMessage) {
          final currentMessage = current as protobuf.GeneratedMessage;
          if (currentMessage.isFrozen && previousLocator != null && previousLocator.hasOneof()) {
            previousLocator.oneof.fields.forEach((field) {
              // clear other oneof items
              final fieldNumber = getFieldNumber(msg, field);
              msg.clearField(fieldNumber);
            });
            if (!field.isRepeated) {
              msg.setField(fieldNumber, field.subBuilder());
            }
            current = msg.getField(fieldNumber);
          }
        }
      } else {
        throw Exception('field locator expected to find message, got ${current.runtimeType}');
      }
    } else if (locator.hasIndex()) {
      if (current is protobuf.PbList) {
        current = current[locator.index.toInt()];
      } else {
        throw Exception('index locator expected to find list, got ${current.runtimeType}');
      }
    } else if (locator.hasKey()) {
      if (current is protobuf.PbMap) {
        final k = valueFromKey(locator.key);
        if (current[k] == null) {
          current[k] = (previousField as protobuf.MapFieldInfo).valueCreator();
        }
        current = current[k];
      } else {
        throw Exception('key locator expected to find map, got ${current.runtimeType}');
      }
    } else if (locator.hasOneof()) {
      // ignore
    } else {
      throw Exception('invalid locator $locator');
    }
    previousLocator = locator;
  });
  return Tuple2(current, currentValueOf);
}

String applyDeltaToString(String value, quill.Delta dlt) {
  final prevDelta = quill.Delta()..insert(value ?? "");
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
}

dynamic getValue(dynamic previous, pb.Op op, TypeRegistry r, protobuf.ValueOfFunc valueOf) {
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
    } else if (scalar.hasEnum_16()) {
      return valueOf(scalar.enum_16);
    } else {
      //			//case *Scalar_Sint32, *Scalar_Sint64:
      //			//case *Scalar_Fixed32, *Scalar_Fixed64:
      //			//case *Scalar_Sfixed32, *Scalar_Sfixed64:
      throw Exception('unsupported scalar ${scalar.runtimeType} in getValue');
    }
  } else if (op.hasDelta()) {
    final prevString = previous as String;
    final dlt = quillFromDelta(op.delta.quill);
    final newString = applyDeltaToString(prevString, dlt);
    return newString;
  } else if (op.hasMessage()) {
    final info = r.lookup(op.message.typeUrl.substring(20));
    if (info == null) {
      throw Exception('no type registered for ${op.message.typeUrl}');
    }
    return op.message.unpackInto(info.createEmptyInstance());
  } else if (op.hasFragment()) {
    return fromFragment(op.fragment, r);
  } else {
    //	*Op_Index
    //	*Op_Key
    throw Exception('invalid operation ${op.runtimeType}');
  }
}

dynamic fromFragment(pb.Fragment fragment, TypeRegistry r) {
  final message = unpack(fragment.message, r);
  final fieldNumber = getFieldNumber(message, fragment.field_1);
  return message.getField(fieldNumber);
}

applySetEdit(pb.Op o, protobuf.GeneratedMessage input, [TypeRegistry reg]) {
  final registry = reg ?? _defaultTypeRegistry;
  var op = o.clone();
  if (op.location.length == 0) {
    input.clear();
    final value = getValue(
      input,
      op,
      registry,
      null,
    );
    input.mergeFromMessage(value);
    return;
  }
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parentLocationResult = getLocation(input, parentLocator);
  final parent = parentLocationResult.item1;
  final valueOf = parentLocationResult.item2;
  if (itemLocator.hasField_1()) {
    if (parent is protobuf.GeneratedMessage) {
      final field = getFieldNumber(parent, itemLocator.field_1);
      final value = getValue(
        parent.getField(field),
        op,
        registry,
        parent.info_.valueOfFunc(field),
      );
      final fi = parent.info_.fieldInfo[field];
      if (fi.isRepeated) {
        var valueList = value as List;
        var fieldList = parent.getField(field) as protobuf.PbList;
        fieldList.clear();
        valueList.forEach((element) {
          if (element is protobuf.ProtobufEnum) {
            fieldList.add(fi.valueOf(element.value));
          } else {
            fieldList.add(element);
          }
        });
      } else if (fi.isMapField) {
        var valueMap = value as Map;
        if (!parent.hasField(field)) {
          // TODO: work-around for: https://github.com/dart-lang/protobuf/issues/373
          parent.$_getMap((fi as protobuf.MapFieldInfo).index);
        }
        var fieldMap = parent.getField(field) as protobuf.PbMap;
        final mfi = fi as protobuf.MapFieldInfo;
        fieldMap.clear();
        valueMap.forEach((key, value) {
          if (value is protobuf.ProtobufEnum) {
            fieldMap[key] = mfi.mapEntryBuilderInfo.fieldInfo[2].valueOf(value.value);
          } else {
            fieldMap[key] = value;
          }
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
      final value = getValue(
        parent[index],
        op,
        registry,
        valueOf,
      );
      parent[index] = value;
    } else {
      throw Exception("can't apply list locator to ${parent.runtimeType}");
    }
  } else if (itemLocator.hasKey()) {
    if (parent is protobuf.PbMap) {
      final key = valueFromKey(itemLocator.key);
      final value = getValue(
        parent[key],
        op,
        registry,
        valueOf,
      );
      parent[key] = value;
    } else {
      throw Exception("can't apply map locator to ${parent.runtimeType}");
    }
  } else {
    throw Exception("invalid op");
  }
}

applyInsert(pb.Op o, protobuf.GeneratedMessage input, [TypeRegistry reg]) {
  final registry = reg ?? _defaultTypeRegistry;
  var op = o.clone();
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parentLocationResult = getLocation(input, parentLocator);
  final parent = parentLocationResult.item1;
  final valueOf = parentLocationResult.item2;
  if (itemLocator.hasField_1()) {
    throw Exception("can't insert with a field locator");
  } else if (itemLocator.hasIndex()) {
    if (parent is protobuf.PbList) {
      final index = itemLocator.index.toInt();
      final previous = index < parent.length ? parent[index] : null;
      final value = getValue(
        previous,
        op,
        registry,
        valueOf,
      );
      if (index < parent.length) {
        parent.insert(index, value);
      } else {
        parent.add(value);
      }
    } else {
      throw Exception("can't insert with list locator in ${parent.runtimeType}");
    }
  } else if (itemLocator.hasKey()) {
    throw Exception("can't insert with a key locator");
  } else {
    throw Exception("invalid op");
  }
}

applyMove(pb.Op o, protobuf.GeneratedMessage input) {
  var op = o.clone();
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parentLocationResult = getLocation(input, parentLocator);
  final parent = parentLocationResult.item1;
  if (itemLocator.hasField_1()) {
    throw Exception("can't move with a field locator");
  } else if (itemLocator.hasIndex()) {
    if (parent is protobuf.PbList) {
      if (!op.hasIndex()) {
        throw Exception("can't move in list with ${op.runtimeType} value");
      }
      final from = itemLocator.index.toInt();
      var to = op.index.toInt();
      if (to > from) {
        // the index in the "to" location is in the frame of reference of the original list. If moving forward,
        // that location is shifted backwards by the removal of the value that we're moving, so we decrement "to".
        to--;
      }
      if (from == to) {
        return null;
      }
      final item = parent.removeAt(from);
      if (to >= parent.length) {
        parent.add(item);
      } else {
        parent.insert(to, item);
      }
    } else {
      throw Exception("can't insert with list locator in ${parent.runtimeType}");
    }
  } else if (itemLocator.hasKey()) {
    throw Exception("can't move with a key locator");
  } else {
    throw Exception("invalid op");
  }
}

applyRename(pb.Op o, protobuf.GeneratedMessage input) {
  var op = o.clone();
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parentLocationResult = getLocation(input, parentLocator);
  final parent = parentLocationResult.item1;
  if (itemLocator.hasField_1()) {
    throw Exception("can't rename with a field locator");
  } else if (itemLocator.hasIndex()) {
    throw Exception("can't rename with a index locator");
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
  } else {
    throw Exception("invalid op");
  }
}

applyDelete(pb.Op o, protobuf.GeneratedMessage input) {
  var op = o.clone();
  if (op.location.length == 0) {
    input.clear();
    return;
  }
  final itemLocator = op.location.removeLast();
  final parentLocator = op.location;
  final parentLocationResult = getLocation(input, parentLocator);
  final parent = parentLocationResult.item1;
  if (itemLocator.hasField_1()) {
    if (parent is protobuf.GeneratedMessage) {
      final field = getFieldNumber(parent, itemLocator.field_1);

      // TODO: Does this break anything else?
      // First create the field before deleting. This ensures that if this is the descendent of a oneof field that
      // the other oneof root values are deleted. If not, we have problems in the Reduce function.
      final fieldInfo = parent.info_.fieldInfo[field];
      if (fieldInfo.isRepeated) {
        // not needed for repeated fields
      } else if (fieldInfo.isMapField) {
        // not needed for map fields
      } else {
        parent.setField(field, parent.getDefaultForField(field));
      }

      // finally clear the field
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
  } else if (itemLocator.hasOneof()) {
    if (parent is protobuf.GeneratedMessage) {
      itemLocator.oneof.fields.forEach((pb.Field f) {
        final field = getFieldNumber(parent, f);
        parent.clearField(field);
      });
    } else {
      throw Exception("can't delete oneof locator from ${parent.runtimeType}");
    }
  } else {
    throw Exception("invalid op");
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
  var q = pb.QuillDelta();
  diffs.forEach((diff) {
    switch (diff.operation) {
      case diff_match_patch.DIFF_DELETE:
        q.ops.add(pb.Quill()..delete = fixnum.Int64(diff.text.length));
        break;
      case diff_match_patch.DIFF_EQUAL:
        q.ops.add(pb.Quill()..retain = fixnum.Int64(diff.text.length));
        break;
      case diff_match_patch.DIFF_INSERT:
        q.ops.add(pb.Quill()..insert = diff.text ?? "");
    }
  });
  return pb.Op()
    ..type = pb.Op_Type.Edit
    ..location.addAll(location)
    ..delta = (pb.Delta()..quill = q);
}

pb.Op root(dynamic value) {
  return set([], value);
}

pb.Op set(List<pb.Locator> location, dynamic value, [TypeRegistry reg]) {
  if (value == null) {
    throw Exception("null value used in set operation");
  }

  var op = pb.Op()..type = pb.Op_Type.Set;

  if (location != null) {
    op.location.addAll(location);
  }

  if (value is pb.Scalar) {
    op.scalar = value;
  } else if (value is protobuf.GeneratedMessage) {
    op.message = any.Any.pack(value);
  } else if (value is protobuf.ProtobufEnum) {
    op.scalar = pb.Scalar()..enum_16 = value.value;
  } else {
    pb.Field field = null;
    if (location != null && location.length > 0 && location[location.length - 1].hasField_1()) {
      field = location[location.length - 1].field_1;
    }
    op.fragment = getFragment(value, field, reg);
  }

  return op;
}

pb.Op delete(List<pb.Locator> location) {
  return pb.Op()
    ..type = pb.Op_Type.Delete
    ..location.addAll(location);
}

pb.Op insert(List<pb.Locator> location, dynamic value) {
  if (value == null) {
    throw Exception("null value used in set operation");
  }

  var op = pb.Op()
    ..type = pb.Op_Type.Insert
    ..location.addAll(location);

  if (value is pb.Scalar) {
    op.scalar = value;
  } else if (value is protobuf.GeneratedMessage) {
    op.message = any.Any.pack(value);
  } else if (value is protobuf.ProtobufEnum) {
    op.scalar = pb.Scalar()..enum_16 = value.value;
  } else {
    // this is impossible - insert operation only happens at list child,
    // where type is always scalar, enum or message.
    throw Exception("insert operation called with invalid value");
  }

  return op;
}

pb.Op rename(List<pb.Locator> location, pb.Key to) {
  return pb.Op()
    ..type = pb.Op_Type.Rename
    ..location.addAll(location)
    ..key = to;
}

pb.Op move(List<pb.Locator> location, fixnum.Int64 to) {
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
      v is List<int> ||
      v is protobuf.ProtobufEnum;
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

pb.Scalar scalarEnum(protobuf.ProtobufEnum value) {
  return pb.Scalar()..enum_16 = value.value;
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

List<pb.Locator> copyAndAppendOneof(
  List<pb.Locator> location,
  String name,
  List<pb.Field> fields,
) {
  return [...location]..add(newLocatorOneof(name, fields));
}

List<pb.Locator> copyAndAppendField(List<pb.Locator> location, String messageFullName, String name, int number) {
  return [...location]..add(newLocatorField(messageFullName, name, number));
}

List<pb.Locator> copyAndAppendIndex(List<pb.Locator> location, fixnum.Int64 index) {
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

List<pb.Locator> copyAndAppendKeyInt64(List<pb.Locator> location, fixnum.Int64 key) {
  return [...location]..add(newLocatorKeyInt64(key));
}

List<pb.Locator> copyAndAppendKeyUint32(List<pb.Locator> location, int key) {
  return [...location]..add(newLocatorKeyUint32(key));
}

List<pb.Locator> copyAndAppendKeyUint64(List<pb.Locator> location, fixnum.Int64 key) {
  return [...location]..add(newLocatorKeyUint64(key));
}

pb.Locator newLocatorOneof(String name, List<pb.Field> fields) {
  return pb.Locator()
    ..oneof = (pb.Oneof()
      ..name = name
      ..fields.addAll(fields));
}

pb.Locator newLocatorField(String messageFullName, String name, int number) {
  return pb.Locator()
    ..field_1 = (pb.Field()
      ..messageFullName = messageFullName
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
  } else if (s.hasEnum_16()) {
    return protobuf.ProtobufEnum(s.enum_16, "");
  }
}

pb.Fragment getFragment(dynamic value, pb.Field field, [TypeRegistry reg]) {
  final registry = reg ?? _defaultTypeRegistry;
  final info = registry.lookup(field.messageFullName);
  if (info == null) {
    throw Exception("can't find ${field.messageFullName} in registry");
  }
  final message = info.createEmptyInstance();
  final fieldNumber = getFieldNumber(message, field);
  initialiseField(message, message.info_.fieldInfo[fieldNumber]);
  if (value is List) {
    (message.getField(fieldNumber) as protobuf.PbList).addAll(value);
  } else if (value is Map) {
    (message.getField(fieldNumber) as protobuf.PbMap).addAll(value);
  } else {
    message.setField(fieldNumber, value);
  }

  return pb.Fragment()
    ..field_1 = field
    ..message = any.Any.pack(message);
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
  } else if (value is protobuf.ProtobufEnum) {
    return pb.Scalar()..enum_16 = value.value;
  }
  throw Exception("unknown type ${value.runtimeType} in getScalar");
}

List<pb.Locator> toLoc(pb.Op o) {
  final op = o.clone();
  if (op.type != pb.Op_Type.Move && op.type != pb.Op_Type.Rename) {
    return [];
  }
  final tup = pop(op);
  final path = tup.item1;
  final itm = tup.item2;
  if (itm.hasIndex()) {
    path.add(pb.Locator()..index = op.index);
    return path;
  } else if (itm.hasKey()) {
    path.add(pb.Locator()..key = op.key);
    return path;
  } else {
    throw Exception("invalid op");
  }
}

List<pb.Locator> parent(pb.Op op) {
  return pop(op).item1;
}

pb.Locator item(pb.Op op) {
  return pop(op).item2;
}

Tuple2<List<pb.Locator>, pb.Locator> pop(pb.Op o) {
  if (o == null || o.location.length == 0) {
    // TODO: work out if this breaks anything. In order for operations that act on the root node to be transformed
    // TODO: correctly, we need to consider them as Field locations. We must be able to do a type switch on item.V
    return Tuple2(null, pb.Locator()..field_1 = pb.Field());
  }
  var op = o.clone();
  final last = op.location.removeLast();
  return Tuple2(op.location, last);
}

//Tuple2<List<pb.Locator>, pb.Locator> pop(List<pb.Locator> v) {
//  if (v == null || v.length == 0) {
//    // TODO: work out if this breaks anything. In order for operations that act on the root node to be transformed
//    // TODO: correctly, we need to consider them as Field locations. We must be able to do a type switch on item.V
//    return Tuple2(null, pb.Locator()..field_1 = pb.Field());
//  }
//  final last = v.removeLast();
//  return Tuple2(v, last);
//}

List<pb.Locator> splitCommonOneofAncestor(
  List<pb.Locator> p1,
  List<pb.Locator> p2,
) {
  // Searches the locations for a "oneof" ancestor that they both share. Only returns non-null if they use different
  // oneof values. e.g.:
  // Op().Chooser().Choice().Dbl().Set(2), Op().Chooser().Choice().Str().Set("a") => true, Op().Chooser().Choice()
  // but
  // Op().Chooser().Choice().Dbl().Set(2), Op().Chooser().Choice().Dbl().Set(3) => false, nil
  // ... the second example is false because both ops are acting on the same value inside the oneof.

  // first search both locations for a oneof - if none is found, return false. Also we can easily
  // check if the index of the first oneof is identical. If not, they can't have a common oneof
  // ancestor.
  var foundP1 = -1;
  var foundP2 = -1;
  for (var i = 0; i < p1.length; i++) {
    if (p1[i].hasOneof()) {
      foundP1 = i;
      break;
    }
  }
  for (var i = 0; i < p2.length; i++) {
    if (p2[i].hasOneof()) {
      foundP2 = i;
      break;
    }
  }
  if (foundP1 == -1 || foundP2 == -1 || foundP1 != foundP2) {
    return [];
  }

  for (var i = 0; i < p1.length && i < p2.length; i++) {
    final l1 = p1[i];
    final l2 = p2[i];
    if (l1 != l2) {
      return [];
    }
    if (!l1.hasOneof()) {
      // we know they're equal, so only need to investigate one of them
      continue;
    }
    // we've found a common oneof among the ancestors! however, we need to investigate the next locators because if
    // they're identical we can just continue.
    final hasNext1 = i < p1.length - 1;
    final hasNext2 = i < p2.length - 1;
    if (!hasNext1 && !hasNext2) {
      // the only operations that finish at a oneof locator are operations that delete the whole oneof. We can
      // continue of this is the case.
      continue;
    } else if (!hasNext1 || !hasNext2) {
      // one of the operations is deleting the whole oneof, and one is manipulating inside. this deserves special
      // attention so we return true.
      return p1.sublist(0, i + 1);
    } else if (hasNext1 && hasNext2) {
      final next1 = p1[i + 1];
      final next2 = p2[i + 1];
      if (next1 == next2) {
        // both operations are acting on the same value in the oneof. We can ignore this and continue searching
        // the ancestors for more oneofs.
        continue;
      }
      return p1.sublist(0, i + 1);
    } else {
      // impossible
    }
  }
  return [];
}

enum TreeRelationshipType {
  NONE,
  EQUAL,
  ANCESTOR,
  DESCENDENT,
}

TreeRelationshipType treeRelationship(
  List<pb.Locator> p1,
  List<pb.Locator> p2,
) {
  final ancestor = isAncestor(p1, p2);
  final descendent = isAncestor(p2, p1);
  if (ancestor && descendent) {
    return TreeRelationshipType.EQUAL;
  } else if (ancestor) {
    return TreeRelationshipType.ANCESTOR;
  } else if (descendent) {
    return TreeRelationshipType.DESCENDENT;
  } else {
    return TreeRelationshipType.NONE;
  }
}

bool isAncestor(List<pb.Locator> ancestor, List<pb.Locator> descendent) {
  if (ancestor.length > descendent.length) {
    return false;
  }
  for (var i = 0; i < ancestor.length; i++) {
    final al = ancestor[i];
    final dl = descendent[i];
    if (al != dl) {
      return false;
    }
  }
  return true;
}

int itemIndex(pb.Op op) {
  return item(op).index.toInt();
}

setItemIndex(pb.Op op, int i) {
  op.location[op.location.length - 1].index = fixnum.Int64(i);
}

setIndexAt(pb.Op op, int locationIndex, int valueIndex) {
  op.location[locationIndex].index = fixnum.Int64(valueIndex);
}

int getIndexAt(pb.Op op, int locationIndex) {
  return op.location[locationIndex].index.toInt();
}

setKeyAt(pb.Op op, int index, pb.Key key) {
  op.location[index] = (pb.Locator()..key = key);
}

pb.Key getKeyAt(pb.Op op, int index) {
  return op.location[index].key;
}

int toIndex(pb.Op op) {
  return op.index.toInt();
}

setToIndex(pb.Op op, int i) {
  op.index = fixnum.Int64(i);
}

quill.Delta quillFromDelta(pb.QuillDelta d) {
  var dlt = quill.Delta();
  d.ops.forEach((q) {
    if (q.hasInsert()) {
      dlt.insert(q.insert);
    } else if (q.hasRetain()) {
      dlt.retain(q.retain.toInt());
    } else if (q.hasDelete()) {
      dlt.delete(q.delete.toInt());
    }
  });
  return dlt;
}

pb.QuillDelta deltaFromQuill(quill.Delta q) {
  var dlt = pb.QuillDelta();
  q.toList().forEach((op) {
    if (op.isInsert) {
      dlt.ops.add(pb.Quill()..insert = op.data ?? "");
    } else if (op.isDelete) {
      dlt.ops.add(pb.Quill()..delete = fixnum.Int64(op.length));
    } else if (op.isRetain) {
      dlt.ops.add(pb.Quill()..retain = fixnum.Int64(op.length));
    } else {
      throw Exception("invalid quill delta");
    }
  });
  return dlt;
}

bool isNull(pb.Op op) {
  return op == null || op.type == pb.Op_Type.Null || _isNullMove(op);
}

bool _isNullMove(pb.Op op) {
  if (op.type != pb.Op_Type.Move && op.type != pb.Op_Type.Rename) {
    return false;
  }
  final itm = item(op);
  if (itm.hasIndex()) {
    final from = itm.index;
    final to = op.index;
    return from == to || from == to - 1;
  } else if (itm.hasKey()) {
    final from = itm.key;
    final to = op.key;
    return from == to;
  } else {
    throw Exception("invalid op");
  }
}
