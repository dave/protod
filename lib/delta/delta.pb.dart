///
//  Generated code. Do not modify.
//  source: delta/delta.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/any.pb.dart' as $0;

import 'delta.pbenum.dart';

export 'delta.pbenum.dart';

enum Op_Value {
  scalar, 
  enum_5, 
  message, 
  object, 
  delta, 
  index_, 
  key, 
  notSet
}

class Op extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Op_Value> _Op_ValueByTag = {
    4 : Op_Value.scalar,
    5 : Op_Value.enum_5,
    6 : Op_Value.message,
    7 : Op_Value.object,
    8 : Op_Value.delta,
    9 : Op_Value.index_,
    10 : Op_Value.key,
    0 : Op_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Op', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7, 8, 9, 10])
    ..e<Op_Type>(1, 'type', $pb.PbFieldType.OE, defaultOrMaker: Op_Type.Null, valueOf: Op_Type.valueOf, enumValues: Op_Type.values)
    ..pc<Locator>(2, 'location', $pb.PbFieldType.PM, subBuilder: Locator.create)
    ..pc<Op>(3, 'ops', $pb.PbFieldType.PM, subBuilder: Op.create)
    ..aOM<Scalar>(4, 'scalar', subBuilder: Scalar.create)
    ..a<$core.int>(5, 'enum', $pb.PbFieldType.O3)
    ..aOM<$0.Any>(6, 'message', subBuilder: $0.Any.create)
    ..aOM<Object>(7, 'object', subBuilder: Object.create)
    ..aOM<Delta>(8, 'delta', subBuilder: Delta.create)
    ..aInt64(9, 'index')
    ..aOM<Key>(10, 'key', subBuilder: Key.create)
    ..hasRequiredFields = false
  ;

  Op._() : super();
  factory Op() => create();
  factory Op.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Op.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Op clone() => Op()..mergeFromMessage(this);
  Op copyWith(void Function(Op) updates) => super.copyWith((message) => updates(message as Op));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Op create() => Op._();
  Op createEmptyInstance() => create();
  static $pb.PbList<Op> createRepeated() => $pb.PbList<Op>();
  @$core.pragma('dart2js:noInline')
  static Op getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Op>(create);
  static Op _defaultInstance;

  Op_Value whichValue() => _Op_ValueByTag[$_whichOneof(0)];
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Op_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Op_Type v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Locator> get location => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Op> get ops => $_getList(2);

  @$pb.TagNumber(4)
  Scalar get scalar => $_getN(3);
  @$pb.TagNumber(4)
  set scalar(Scalar v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasScalar() => $_has(3);
  @$pb.TagNumber(4)
  void clearScalar() => clearField(4);
  @$pb.TagNumber(4)
  Scalar ensureScalar() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get enum_5 => $_getIZ(4);
  @$pb.TagNumber(5)
  set enum_5($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnum_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnum_5() => clearField(5);

  @$pb.TagNumber(6)
  $0.Any get message => $_getN(5);
  @$pb.TagNumber(6)
  set message($0.Any v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
  @$pb.TagNumber(6)
  $0.Any ensureMessage() => $_ensure(5);

  @$pb.TagNumber(7)
  Object get object => $_getN(6);
  @$pb.TagNumber(7)
  set object(Object v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasObject() => $_has(6);
  @$pb.TagNumber(7)
  void clearObject() => clearField(7);
  @$pb.TagNumber(7)
  Object ensureObject() => $_ensure(6);

  @$pb.TagNumber(8)
  Delta get delta => $_getN(7);
  @$pb.TagNumber(8)
  set delta(Delta v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasDelta() => $_has(7);
  @$pb.TagNumber(8)
  void clearDelta() => clearField(8);
  @$pb.TagNumber(8)
  Delta ensureDelta() => $_ensure(7);

  @$pb.TagNumber(9)
  $fixnum.Int64 get index => $_getI64(8);
  @$pb.TagNumber(9)
  set index($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIndex() => $_has(8);
  @$pb.TagNumber(9)
  void clearIndex() => clearField(9);

  @$pb.TagNumber(10)
  Key get key => $_getN(9);
  @$pb.TagNumber(10)
  set key(Key v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasKey() => $_has(9);
  @$pb.TagNumber(10)
  void clearKey() => clearField(10);
  @$pb.TagNumber(10)
  Key ensureKey() => $_ensure(9);
}

enum Locator_V {
  field_1, 
  index_, 
  key, 
  oneof, 
  notSet
}

class Locator extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Locator_V> _Locator_VByTag = {
    1 : Locator_V.field_1,
    2 : Locator_V.index_,
    3 : Locator_V.key,
    4 : Locator_V.oneof,
    0 : Locator_V.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Locator', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<Field>(1, 'field', subBuilder: Field.create)
    ..aInt64(2, 'index')
    ..aOM<Key>(3, 'key', subBuilder: Key.create)
    ..aOM<Oneof>(4, 'oneof', subBuilder: Oneof.create)
    ..hasRequiredFields = false
  ;

  Locator._() : super();
  factory Locator() => create();
  factory Locator.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Locator.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Locator clone() => Locator()..mergeFromMessage(this);
  Locator copyWith(void Function(Locator) updates) => super.copyWith((message) => updates(message as Locator));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Locator create() => Locator._();
  Locator createEmptyInstance() => create();
  static $pb.PbList<Locator> createRepeated() => $pb.PbList<Locator>();
  @$core.pragma('dart2js:noInline')
  static Locator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Locator>(create);
  static Locator _defaultInstance;

  Locator_V whichV() => _Locator_VByTag[$_whichOneof(0)];
  void clearV() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Field get field_1 => $_getN(0);
  @$pb.TagNumber(1)
  set field_1(Field v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => clearField(1);
  @$pb.TagNumber(1)
  Field ensureField_1() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get index => $_getI64(1);
  @$pb.TagNumber(2)
  set index($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => clearField(2);

  @$pb.TagNumber(3)
  Key get key => $_getN(2);
  @$pb.TagNumber(3)
  set key(Key v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearKey() => clearField(3);
  @$pb.TagNumber(3)
  Key ensureKey() => $_ensure(2);

  @$pb.TagNumber(4)
  Oneof get oneof => $_getN(3);
  @$pb.TagNumber(4)
  set oneof(Oneof v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOneof() => $_has(3);
  @$pb.TagNumber(4)
  void clearOneof() => clearField(4);
  @$pb.TagNumber(4)
  Oneof ensureOneof() => $_ensure(3);
}

enum Key_V {
  bool_1, 
  int32, 
  int64, 
  uint32, 
  uint64, 
  string, 
  notSet
}

class Key extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Key_V> _Key_VByTag = {
    1 : Key_V.bool_1,
    2 : Key_V.int32,
    3 : Key_V.int64,
    4 : Key_V.uint32,
    5 : Key_V.uint64,
    6 : Key_V.string,
    0 : Key_V.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Key', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..aOB(1, 'bool')
    ..a<$core.int>(2, 'int32', $pb.PbFieldType.O3)
    ..aInt64(3, 'int64')
    ..a<$core.int>(4, 'uint32', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, 'uint64', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, 'string')
    ..hasRequiredFields = false
  ;

  Key._() : super();
  factory Key() => create();
  factory Key.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Key.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Key clone() => Key()..mergeFromMessage(this);
  Key copyWith(void Function(Key) updates) => super.copyWith((message) => updates(message as Key));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Key create() => Key._();
  Key createEmptyInstance() => create();
  static $pb.PbList<Key> createRepeated() => $pb.PbList<Key>();
  @$core.pragma('dart2js:noInline')
  static Key getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Key>(create);
  static Key _defaultInstance;

  Key_V whichV() => _Key_VByTag[$_whichOneof(0)];
  void clearV() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.bool get bool_1 => $_getBF(0);
  @$pb.TagNumber(1)
  set bool_1($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBool_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearBool_1() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get int32 => $_getIZ(1);
  @$pb.TagNumber(2)
  set int32($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInt32() => $_has(1);
  @$pb.TagNumber(2)
  void clearInt32() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get int64 => $_getI64(2);
  @$pb.TagNumber(3)
  set int64($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInt64() => $_has(2);
  @$pb.TagNumber(3)
  void clearInt64() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get uint32 => $_getIZ(3);
  @$pb.TagNumber(4)
  set uint32($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUint32() => $_has(3);
  @$pb.TagNumber(4)
  void clearUint32() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get uint64 => $_getI64(4);
  @$pb.TagNumber(5)
  set uint64($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUint64() => $_has(4);
  @$pb.TagNumber(5)
  void clearUint64() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get string => $_getSZ(5);
  @$pb.TagNumber(6)
  set string($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasString() => $_has(5);
  @$pb.TagNumber(6)
  void clearString() => clearField(6);
}

class Field extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Field', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(2, 'number', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Field._() : super();
  factory Field() => create();
  factory Field.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Field.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Field clone() => Field()..mergeFromMessage(this);
  Field copyWith(void Function(Field) updates) => super.copyWith((message) => updates(message as Field));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Field create() => Field._();
  Field createEmptyInstance() => create();
  static $pb.PbList<Field> createRepeated() => $pb.PbList<Field>();
  @$core.pragma('dart2js:noInline')
  static Field getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Field>(create);
  static Field _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get number => $_getIZ(1);
  @$pb.TagNumber(2)
  set number($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => clearField(2);
}

class Oneof extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Oneof', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..pc<Field>(2, 'fields', $pb.PbFieldType.PM, subBuilder: Field.create)
    ..hasRequiredFields = false
  ;

  Oneof._() : super();
  factory Oneof() => create();
  factory Oneof.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Oneof.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Oneof clone() => Oneof()..mergeFromMessage(this);
  Oneof copyWith(void Function(Oneof) updates) => super.copyWith((message) => updates(message as Oneof));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Oneof create() => Oneof._();
  Oneof createEmptyInstance() => create();
  static $pb.PbList<Oneof> createRepeated() => $pb.PbList<Oneof>();
  @$core.pragma('dart2js:noInline')
  static Oneof getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Oneof>(create);
  static Oneof _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Field> get fields => $_getList(1);
}

enum Scalar_V {
  double_1, 
  float, 
  int32, 
  int64, 
  uint32, 
  uint64, 
  sint32, 
  sint64, 
  fixed32, 
  fixed64, 
  sfixed32, 
  sfixed64, 
  bool_13, 
  string, 
  bytes, 
  notSet
}

class Scalar extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Scalar_V> _Scalar_VByTag = {
    1 : Scalar_V.double_1,
    2 : Scalar_V.float,
    3 : Scalar_V.int32,
    4 : Scalar_V.int64,
    5 : Scalar_V.uint32,
    6 : Scalar_V.uint64,
    7 : Scalar_V.sint32,
    8 : Scalar_V.sint64,
    9 : Scalar_V.fixed32,
    10 : Scalar_V.fixed64,
    11 : Scalar_V.sfixed32,
    12 : Scalar_V.sfixed64,
    13 : Scalar_V.bool_13,
    14 : Scalar_V.string,
    15 : Scalar_V.bytes,
    0 : Scalar_V.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Scalar', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
    ..a<$core.double>(1, 'double', $pb.PbFieldType.OD)
    ..a<$core.double>(2, 'float', $pb.PbFieldType.OF)
    ..a<$core.int>(3, 'int32', $pb.PbFieldType.O3)
    ..aInt64(4, 'int64')
    ..a<$core.int>(5, 'uint32', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(6, 'uint64', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, 'sint32', $pb.PbFieldType.OS3)
    ..a<$fixnum.Int64>(8, 'sint64', $pb.PbFieldType.OS6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(9, 'fixed32', $pb.PbFieldType.OF3)
    ..a<$fixnum.Int64>(10, 'fixed64', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(11, 'sfixed32', $pb.PbFieldType.OSF3)
    ..a<$fixnum.Int64>(12, 'sfixed64', $pb.PbFieldType.OSF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(13, 'bool')
    ..aOS(14, 'string')
    ..a<$core.List<$core.int>>(15, 'bytes', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Scalar._() : super();
  factory Scalar() => create();
  factory Scalar.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Scalar.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Scalar clone() => Scalar()..mergeFromMessage(this);
  Scalar copyWith(void Function(Scalar) updates) => super.copyWith((message) => updates(message as Scalar));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Scalar create() => Scalar._();
  Scalar createEmptyInstance() => create();
  static $pb.PbList<Scalar> createRepeated() => $pb.PbList<Scalar>();
  @$core.pragma('dart2js:noInline')
  static Scalar getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Scalar>(create);
  static Scalar _defaultInstance;

  Scalar_V whichV() => _Scalar_VByTag[$_whichOneof(0)];
  void clearV() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.double get double_1 => $_getN(0);
  @$pb.TagNumber(1)
  set double_1($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDouble_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearDouble_1() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get float => $_getN(1);
  @$pb.TagNumber(2)
  set float($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFloat() => $_has(1);
  @$pb.TagNumber(2)
  void clearFloat() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get int32 => $_getIZ(2);
  @$pb.TagNumber(3)
  set int32($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInt32() => $_has(2);
  @$pb.TagNumber(3)
  void clearInt32() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get int64 => $_getI64(3);
  @$pb.TagNumber(4)
  set int64($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInt64() => $_has(3);
  @$pb.TagNumber(4)
  void clearInt64() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get uint32 => $_getIZ(4);
  @$pb.TagNumber(5)
  set uint32($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUint32() => $_has(4);
  @$pb.TagNumber(5)
  void clearUint32() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get uint64 => $_getI64(5);
  @$pb.TagNumber(6)
  set uint64($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUint64() => $_has(5);
  @$pb.TagNumber(6)
  void clearUint64() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get sint32 => $_getIZ(6);
  @$pb.TagNumber(7)
  set sint32($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSint32() => $_has(6);
  @$pb.TagNumber(7)
  void clearSint32() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get sint64 => $_getI64(7);
  @$pb.TagNumber(8)
  set sint64($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSint64() => $_has(7);
  @$pb.TagNumber(8)
  void clearSint64() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get fixed32 => $_getIZ(8);
  @$pb.TagNumber(9)
  set fixed32($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFixed32() => $_has(8);
  @$pb.TagNumber(9)
  void clearFixed32() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get fixed64 => $_getI64(9);
  @$pb.TagNumber(10)
  set fixed64($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasFixed64() => $_has(9);
  @$pb.TagNumber(10)
  void clearFixed64() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get sfixed32 => $_getIZ(10);
  @$pb.TagNumber(11)
  set sfixed32($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSfixed32() => $_has(10);
  @$pb.TagNumber(11)
  void clearSfixed32() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get sfixed64 => $_getI64(11);
  @$pb.TagNumber(12)
  set sfixed64($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSfixed64() => $_has(11);
  @$pb.TagNumber(12)
  void clearSfixed64() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get bool_13 => $_getBF(12);
  @$pb.TagNumber(13)
  set bool_13($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBool_13() => $_has(12);
  @$pb.TagNumber(13)
  void clearBool_13() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get string => $_getSZ(13);
  @$pb.TagNumber(14)
  set string($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasString() => $_has(13);
  @$pb.TagNumber(14)
  void clearString() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<$core.int> get bytes => $_getN(14);
  @$pb.TagNumber(15)
  set bytes($core.List<$core.int> v) { $_setBytes(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasBytes() => $_has(14);
  @$pb.TagNumber(15)
  void clearBytes() => clearField(15);
}

class Delta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Delta', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..pc<Quill>(1, 'ops', $pb.PbFieldType.PM, subBuilder: Quill.create)
    ..hasRequiredFields = false
  ;

  Delta._() : super();
  factory Delta() => create();
  factory Delta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Delta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Delta clone() => Delta()..mergeFromMessage(this);
  Delta copyWith(void Function(Delta) updates) => super.copyWith((message) => updates(message as Delta));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Delta create() => Delta._();
  Delta createEmptyInstance() => create();
  static $pb.PbList<Delta> createRepeated() => $pb.PbList<Delta>();
  @$core.pragma('dart2js:noInline')
  static Delta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Delta>(create);
  static Delta _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Quill> get ops => $_getList(0);
}

enum Quill_V {
  insert, 
  retain, 
  delete, 
  notSet
}

class Quill extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Quill_V> _Quill_VByTag = {
    1 : Quill_V.insert,
    2 : Quill_V.retain,
    3 : Quill_V.delete,
    0 : Quill_V.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Quill', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, 'insert')
    ..aInt64(2, 'retain')
    ..aInt64(3, 'delete')
    ..aOM<Object>(4, 'attributes', subBuilder: Object.create)
    ..hasRequiredFields = false
  ;

  Quill._() : super();
  factory Quill() => create();
  factory Quill.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Quill.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Quill clone() => Quill()..mergeFromMessage(this);
  Quill copyWith(void Function(Quill) updates) => super.copyWith((message) => updates(message as Quill));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Quill create() => Quill._();
  Quill createEmptyInstance() => create();
  static $pb.PbList<Quill> createRepeated() => $pb.PbList<Quill>();
  @$core.pragma('dart2js:noInline')
  static Quill getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Quill>(create);
  static Quill _defaultInstance;

  Quill_V whichV() => _Quill_VByTag[$_whichOneof(0)];
  void clearV() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get insert => $_getSZ(0);
  @$pb.TagNumber(1)
  set insert($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsert() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsert() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get retain => $_getI64(1);
  @$pb.TagNumber(2)
  set retain($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRetain() => $_has(1);
  @$pb.TagNumber(2)
  void clearRetain() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get delete => $_getI64(2);
  @$pb.TagNumber(3)
  set delete($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDelete() => $_has(2);
  @$pb.TagNumber(3)
  void clearDelete() => clearField(3);

  @$pb.TagNumber(4)
  Object get attributes => $_getN(3);
  @$pb.TagNumber(4)
  set attributes(Object v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAttributes() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttributes() => clearField(4);
  @$pb.TagNumber(4)
  Object ensureAttributes() => $_ensure(3);
}

enum Object_V {
  scalar, 
  message, 
  list, 
  mapBool, 
  mapInt32, 
  mapInt64, 
  mapUint32, 
  mapUint64, 
  mapString, 
  notSet
}

class Object extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Object_V> _Object_VByTag = {
    1 : Object_V.scalar,
    2 : Object_V.message,
    3 : Object_V.list,
    4 : Object_V.mapBool,
    5 : Object_V.mapInt32,
    6 : Object_V.mapInt64,
    7 : Object_V.mapUint32,
    8 : Object_V.mapUint64,
    9 : Object_V.mapString,
    0 : Object_V.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Object', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9])
    ..aOM<Scalar>(1, 'scalar', subBuilder: Scalar.create)
    ..aOM<$0.Any>(2, 'message', subBuilder: $0.Any.create)
    ..aOM<List_>(3, 'list', subBuilder: List_.create)
    ..aOM<MapBool>(4, 'mapBool', protoName: 'mapBool', subBuilder: MapBool.create)
    ..aOM<MapInt32>(5, 'mapInt32', protoName: 'mapInt32', subBuilder: MapInt32.create)
    ..aOM<MapInt64>(6, 'mapInt64', protoName: 'mapInt64', subBuilder: MapInt64.create)
    ..aOM<MapUint32>(7, 'mapUint32', protoName: 'mapUint32', subBuilder: MapUint32.create)
    ..aOM<MapUint64>(8, 'mapUint64', protoName: 'mapUint64', subBuilder: MapUint64.create)
    ..aOM<MapString>(9, 'mapString', protoName: 'mapString', subBuilder: MapString.create)
    ..hasRequiredFields = false
  ;

  Object._() : super();
  factory Object() => create();
  factory Object.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Object.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Object clone() => Object()..mergeFromMessage(this);
  Object copyWith(void Function(Object) updates) => super.copyWith((message) => updates(message as Object));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Object create() => Object._();
  Object createEmptyInstance() => create();
  static $pb.PbList<Object> createRepeated() => $pb.PbList<Object>();
  @$core.pragma('dart2js:noInline')
  static Object getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Object>(create);
  static Object _defaultInstance;

  Object_V whichV() => _Object_VByTag[$_whichOneof(0)];
  void clearV() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Scalar get scalar => $_getN(0);
  @$pb.TagNumber(1)
  set scalar(Scalar v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasScalar() => $_has(0);
  @$pb.TagNumber(1)
  void clearScalar() => clearField(1);
  @$pb.TagNumber(1)
  Scalar ensureScalar() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Any get message => $_getN(1);
  @$pb.TagNumber(2)
  set message($0.Any v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
  @$pb.TagNumber(2)
  $0.Any ensureMessage() => $_ensure(1);

  @$pb.TagNumber(3)
  List_ get list => $_getN(2);
  @$pb.TagNumber(3)
  set list(List_ v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasList() => $_has(2);
  @$pb.TagNumber(3)
  void clearList() => clearField(3);
  @$pb.TagNumber(3)
  List_ ensureList() => $_ensure(2);

  @$pb.TagNumber(4)
  MapBool get mapBool => $_getN(3);
  @$pb.TagNumber(4)
  set mapBool(MapBool v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMapBool() => $_has(3);
  @$pb.TagNumber(4)
  void clearMapBool() => clearField(4);
  @$pb.TagNumber(4)
  MapBool ensureMapBool() => $_ensure(3);

  @$pb.TagNumber(5)
  MapInt32 get mapInt32 => $_getN(4);
  @$pb.TagNumber(5)
  set mapInt32(MapInt32 v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMapInt32() => $_has(4);
  @$pb.TagNumber(5)
  void clearMapInt32() => clearField(5);
  @$pb.TagNumber(5)
  MapInt32 ensureMapInt32() => $_ensure(4);

  @$pb.TagNumber(6)
  MapInt64 get mapInt64 => $_getN(5);
  @$pb.TagNumber(6)
  set mapInt64(MapInt64 v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMapInt64() => $_has(5);
  @$pb.TagNumber(6)
  void clearMapInt64() => clearField(6);
  @$pb.TagNumber(6)
  MapInt64 ensureMapInt64() => $_ensure(5);

  @$pb.TagNumber(7)
  MapUint32 get mapUint32 => $_getN(6);
  @$pb.TagNumber(7)
  set mapUint32(MapUint32 v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasMapUint32() => $_has(6);
  @$pb.TagNumber(7)
  void clearMapUint32() => clearField(7);
  @$pb.TagNumber(7)
  MapUint32 ensureMapUint32() => $_ensure(6);

  @$pb.TagNumber(8)
  MapUint64 get mapUint64 => $_getN(7);
  @$pb.TagNumber(8)
  set mapUint64(MapUint64 v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasMapUint64() => $_has(7);
  @$pb.TagNumber(8)
  void clearMapUint64() => clearField(8);
  @$pb.TagNumber(8)
  MapUint64 ensureMapUint64() => $_ensure(7);

  @$pb.TagNumber(9)
  MapString get mapString => $_getN(8);
  @$pb.TagNumber(9)
  set mapString(MapString v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasMapString() => $_has(8);
  @$pb.TagNumber(9)
  void clearMapString() => clearField(9);
  @$pb.TagNumber(9)
  MapString ensureMapString() => $_ensure(8);
}

class MapBool extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapBool', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..m<$core.bool, Object>(1, 'map', entryClassName: 'MapBool.MapEntry', keyFieldType: $pb.PbFieldType.OB, valueFieldType: $pb.PbFieldType.OM, valueCreator: Object.create, packageName: const $pb.PackageName('delta'))
    ..hasRequiredFields = false
  ;

  MapBool._() : super();
  factory MapBool() => create();
  factory MapBool.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapBool.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapBool clone() => MapBool()..mergeFromMessage(this);
  MapBool copyWith(void Function(MapBool) updates) => super.copyWith((message) => updates(message as MapBool));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapBool create() => MapBool._();
  MapBool createEmptyInstance() => create();
  static $pb.PbList<MapBool> createRepeated() => $pb.PbList<MapBool>();
  @$core.pragma('dart2js:noInline')
  static MapBool getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapBool>(create);
  static MapBool _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.bool, Object> get map => $_getMap(0);
}

class MapInt32 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapInt32', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..m<$core.int, Object>(1, 'map', entryClassName: 'MapInt32.MapEntry', keyFieldType: $pb.PbFieldType.O3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Object.create, packageName: const $pb.PackageName('delta'))
    ..hasRequiredFields = false
  ;

  MapInt32._() : super();
  factory MapInt32() => create();
  factory MapInt32.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapInt32.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapInt32 clone() => MapInt32()..mergeFromMessage(this);
  MapInt32 copyWith(void Function(MapInt32) updates) => super.copyWith((message) => updates(message as MapInt32));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapInt32 create() => MapInt32._();
  MapInt32 createEmptyInstance() => create();
  static $pb.PbList<MapInt32> createRepeated() => $pb.PbList<MapInt32>();
  @$core.pragma('dart2js:noInline')
  static MapInt32 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapInt32>(create);
  static MapInt32 _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.int, Object> get map => $_getMap(0);
}

class MapInt64 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapInt64', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..m<$fixnum.Int64, Object>(1, 'map', entryClassName: 'MapInt64.MapEntry', keyFieldType: $pb.PbFieldType.O6, valueFieldType: $pb.PbFieldType.OM, valueCreator: Object.create, packageName: const $pb.PackageName('delta'))
    ..hasRequiredFields = false
  ;

  MapInt64._() : super();
  factory MapInt64() => create();
  factory MapInt64.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapInt64.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapInt64 clone() => MapInt64()..mergeFromMessage(this);
  MapInt64 copyWith(void Function(MapInt64) updates) => super.copyWith((message) => updates(message as MapInt64));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapInt64 create() => MapInt64._();
  MapInt64 createEmptyInstance() => create();
  static $pb.PbList<MapInt64> createRepeated() => $pb.PbList<MapInt64>();
  @$core.pragma('dart2js:noInline')
  static MapInt64 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapInt64>(create);
  static MapInt64 _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$fixnum.Int64, Object> get map => $_getMap(0);
}

class MapUint32 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapUint32', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..m<$core.int, Object>(1, 'map', entryClassName: 'MapUint32.MapEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Object.create, packageName: const $pb.PackageName('delta'))
    ..hasRequiredFields = false
  ;

  MapUint32._() : super();
  factory MapUint32() => create();
  factory MapUint32.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapUint32.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapUint32 clone() => MapUint32()..mergeFromMessage(this);
  MapUint32 copyWith(void Function(MapUint32) updates) => super.copyWith((message) => updates(message as MapUint32));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapUint32 create() => MapUint32._();
  MapUint32 createEmptyInstance() => create();
  static $pb.PbList<MapUint32> createRepeated() => $pb.PbList<MapUint32>();
  @$core.pragma('dart2js:noInline')
  static MapUint32 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapUint32>(create);
  static MapUint32 _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.int, Object> get map => $_getMap(0);
}

class MapUint64 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapUint64', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..m<$fixnum.Int64, Object>(1, 'map', entryClassName: 'MapUint64.MapEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OM, valueCreator: Object.create, packageName: const $pb.PackageName('delta'))
    ..hasRequiredFields = false
  ;

  MapUint64._() : super();
  factory MapUint64() => create();
  factory MapUint64.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapUint64.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapUint64 clone() => MapUint64()..mergeFromMessage(this);
  MapUint64 copyWith(void Function(MapUint64) updates) => super.copyWith((message) => updates(message as MapUint64));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapUint64 create() => MapUint64._();
  MapUint64 createEmptyInstance() => create();
  static $pb.PbList<MapUint64> createRepeated() => $pb.PbList<MapUint64>();
  @$core.pragma('dart2js:noInline')
  static MapUint64 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapUint64>(create);
  static MapUint64 _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$fixnum.Int64, Object> get map => $_getMap(0);
}

class MapString extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapString', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..m<$core.String, Object>(1, 'map', entryClassName: 'MapString.MapEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Object.create, packageName: const $pb.PackageName('delta'))
    ..hasRequiredFields = false
  ;

  MapString._() : super();
  factory MapString() => create();
  factory MapString.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapString.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapString clone() => MapString()..mergeFromMessage(this);
  MapString copyWith(void Function(MapString) updates) => super.copyWith((message) => updates(message as MapString));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapString create() => MapString._();
  MapString createEmptyInstance() => create();
  static $pb.PbList<MapString> createRepeated() => $pb.PbList<MapString>();
  @$core.pragma('dart2js:noInline')
  static MapString getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapString>(create);
  static MapString _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, Object> get map => $_getMap(0);
}

class List_ extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('List', package: const $pb.PackageName('delta'), createEmptyInstance: create)
    ..pc<Object>(1, 'list', $pb.PbFieldType.PM, subBuilder: Object.create)
    ..hasRequiredFields = false
  ;

  List_._() : super();
  factory List_() => create();
  factory List_.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory List_.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  List_ clone() => List_()..mergeFromMessage(this);
  List_ copyWith(void Function(List_) updates) => super.copyWith((message) => updates(message as List_));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static List_ create() => List_._();
  List_ createEmptyInstance() => create();
  static $pb.PbList<List_> createRepeated() => $pb.PbList<List_>();
  @$core.pragma('dart2js:noInline')
  static List_ getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<List_>(create);
  static List_ _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Object> get list => $_getList(0);
}

