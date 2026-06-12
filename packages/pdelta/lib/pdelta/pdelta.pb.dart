///
//  Generated code. Do not modify.
//  source: pdelta/pdelta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'package:ptypes/google/protobuf/any.pb.dart' as $0;
import 'package:ptypes/google/protobuf/struct.pb.dart' as $1;

import 'pdelta.pbenum.dart';

export 'pdelta.pbenum.dart';

enum Op_Value {
  scalar, 
  message, 
  fragment, 
  delta, 
  index_, 
  key, 
  notSet
}

class Op extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Op_Value> _Op_ValueByTag = {
    4 : Op_Value.scalar,
    6 : Op_Value.message,
    7 : Op_Value.fragment,
    8 : Op_Value.delta,
    9 : Op_Value.index_,
    10 : Op_Value.key,
    0 : Op_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Op', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..oo(0, [4, 6, 7, 8, 9, 10])
    ..e<Op_Type>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Op_Type.Null, valueOf: Op_Type.valueOf, enumValues: Op_Type.values)
    ..pc<Locator>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'location', $pb.PbFieldType.PM, subBuilder: Locator.create)
    ..pc<Op>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ops', $pb.PbFieldType.PM, subBuilder: Op.create)
    ..aOM<Scalar>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scalar', subBuilder: Scalar.create)
    ..aOM<$0.Any>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', subBuilder: $0.Any.create)
    ..aOM<Fragment>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fragment', subBuilder: Fragment.create)
    ..aOM<Delta>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'delta', subBuilder: Delta.create)
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'index')
    ..aOM<Key>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', subBuilder: Key.create)
    ..hasRequiredFields = false
  ;

  Op._() : super();
  factory Op({
    Op_Type? type,
    $core.Iterable<Locator>? location,
    $core.Iterable<Op>? ops,
    Scalar? scalar,
    $0.Any? message,
    Fragment? fragment,
    Delta? delta,
    $fixnum.Int64? index,
    Key? key,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (location != null) {
      _result.location.addAll(location);
    }
    if (ops != null) {
      _result.ops.addAll(ops);
    }
    if (scalar != null) {
      _result.scalar = scalar;
    }
    if (message != null) {
      _result.message = message;
    }
    if (fragment != null) {
      _result.fragment = fragment;
    }
    if (delta != null) {
      _result.delta = delta;
    }
    if (index != null) {
      _result.index = index;
    }
    if (key != null) {
      _result.key = key;
    }
    return _result;
  }
  factory Op.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Op.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Op clone() => Op()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Op copyWith(void Function(Op) updates) => super.copyWith((message) => updates(message as Op)) as Op; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Op create() => Op._();
  Op createEmptyInstance() => create();
  static $pb.PbList<Op> createRepeated() => $pb.PbList<Op>();
  @$core.pragma('dart2js:noInline')
  static Op getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Op>(create);
  static Op? _defaultInstance;

  Op_Value whichValue() => _Op_ValueByTag[$_whichOneof(0)]!;
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

  @$pb.TagNumber(6)
  $0.Any get message => $_getN(4);
  @$pb.TagNumber(6)
  set message($0.Any v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
  @$pb.TagNumber(6)
  $0.Any ensureMessage() => $_ensure(4);

  @$pb.TagNumber(7)
  Fragment get fragment => $_getN(5);
  @$pb.TagNumber(7)
  set fragment(Fragment v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasFragment() => $_has(5);
  @$pb.TagNumber(7)
  void clearFragment() => clearField(7);
  @$pb.TagNumber(7)
  Fragment ensureFragment() => $_ensure(5);

  @$pb.TagNumber(8)
  Delta get delta => $_getN(6);
  @$pb.TagNumber(8)
  set delta(Delta v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasDelta() => $_has(6);
  @$pb.TagNumber(8)
  void clearDelta() => clearField(8);
  @$pb.TagNumber(8)
  Delta ensureDelta() => $_ensure(6);

  @$pb.TagNumber(9)
  $fixnum.Int64 get index => $_getI64(7);
  @$pb.TagNumber(9)
  set index($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasIndex() => $_has(7);
  @$pb.TagNumber(9)
  void clearIndex() => clearField(9);

  @$pb.TagNumber(10)
  Key get key => $_getN(8);
  @$pb.TagNumber(10)
  set key(Key v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasKey() => $_has(8);
  @$pb.TagNumber(10)
  void clearKey() => clearField(10);
  @$pb.TagNumber(10)
  Key ensureKey() => $_ensure(8);
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Locator', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<Field>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'field', subBuilder: Field.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'index')
    ..aOM<Key>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', subBuilder: Key.create)
    ..aOM<Oneof>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oneof', subBuilder: Oneof.create)
    ..hasRequiredFields = false
  ;

  Locator._() : super();
  factory Locator({
    Field? field_1,
    $fixnum.Int64? index,
    Key? key,
    Oneof? oneof,
  }) {
    final _result = create();
    if (field_1 != null) {
      _result.field_1 = field_1;
    }
    if (index != null) {
      _result.index = index;
    }
    if (key != null) {
      _result.key = key;
    }
    if (oneof != null) {
      _result.oneof = oneof;
    }
    return _result;
  }
  factory Locator.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Locator.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Locator clone() => Locator()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Locator copyWith(void Function(Locator) updates) => super.copyWith((message) => updates(message as Locator)) as Locator; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Locator create() => Locator._();
  Locator createEmptyInstance() => create();
  static $pb.PbList<Locator> createRepeated() => $pb.PbList<Locator>();
  @$core.pragma('dart2js:noInline')
  static Locator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Locator>(create);
  static Locator? _defaultInstance;

  Locator_V whichV() => _Locator_VByTag[$_whichOneof(0)]!;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Key', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bool')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int32', $pb.PbFieldType.O3)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int64')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uint32', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uint64', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'string')
    ..hasRequiredFields = false
  ;

  Key._() : super();
  factory Key({
    $core.bool? bool_1,
    $core.int? int32,
    $fixnum.Int64? int64,
    $core.int? uint32,
    $fixnum.Int64? uint64,
    $core.String? string,
  }) {
    final _result = create();
    if (bool_1 != null) {
      _result.bool_1 = bool_1;
    }
    if (int32 != null) {
      _result.int32 = int32;
    }
    if (int64 != null) {
      _result.int64 = int64;
    }
    if (uint32 != null) {
      _result.uint32 = uint32;
    }
    if (uint64 != null) {
      _result.uint64 = uint64;
    }
    if (string != null) {
      _result.string = string;
    }
    return _result;
  }
  factory Key.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Key.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Key clone() => Key()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Key copyWith(void Function(Key) updates) => super.copyWith((message) => updates(message as Key)) as Key; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Key create() => Key._();
  Key createEmptyInstance() => create();
  static $pb.PbList<Key> createRepeated() => $pb.PbList<Key>();
  @$core.pragma('dart2js:noInline')
  static Key getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Key>(create);
  static Key? _defaultInstance;

  Key_V whichV() => _Key_VByTag[$_whichOneof(0)]!;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Field', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'number', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageFullName')
    ..hasRequiredFields = false
  ;

  Field._() : super();
  factory Field({
    $core.String? name,
    $core.int? number,
    $core.String? messageFullName,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (number != null) {
      _result.number = number;
    }
    if (messageFullName != null) {
      _result.messageFullName = messageFullName;
    }
    return _result;
  }
  factory Field.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Field.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Field clone() => Field()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Field copyWith(void Function(Field) updates) => super.copyWith((message) => updates(message as Field)) as Field; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Field create() => Field._();
  Field createEmptyInstance() => create();
  static $pb.PbList<Field> createRepeated() => $pb.PbList<Field>();
  @$core.pragma('dart2js:noInline')
  static Field getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Field>(create);
  static Field? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get messageFullName => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageFullName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessageFullName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageFullName() => clearField(3);
}

class Oneof extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oneof', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<Field>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fields', $pb.PbFieldType.PM, subBuilder: Field.create)
    ..hasRequiredFields = false
  ;

  Oneof._() : super();
  factory Oneof({
    $core.String? name,
    $core.Iterable<Field>? fields,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (fields != null) {
      _result.fields.addAll(fields);
    }
    return _result;
  }
  factory Oneof.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Oneof.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Oneof clone() => Oneof()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Oneof copyWith(void Function(Oneof) updates) => super.copyWith((message) => updates(message as Oneof)) as Oneof; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Oneof create() => Oneof._();
  Oneof createEmptyInstance() => create();
  static $pb.PbList<Oneof> createRepeated() => $pb.PbList<Oneof>();
  @$core.pragma('dart2js:noInline')
  static Oneof getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Oneof>(create);
  static Oneof? _defaultInstance;

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
  enum_16, 
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
    16 : Scalar_V.enum_16,
    0 : Scalar_V.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Scalar', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'double', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'float', $pb.PbFieldType.OF)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int32', $pb.PbFieldType.O3)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int64')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uint32', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uint64', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sint32', $pb.PbFieldType.OS3)
    ..a<$fixnum.Int64>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sint64', $pb.PbFieldType.OS6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixed32', $pb.PbFieldType.OF3)
    ..a<$fixnum.Int64>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixed64', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sfixed32', $pb.PbFieldType.OSF3)
    ..a<$fixnum.Int64>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sfixed64', $pb.PbFieldType.OSF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bool')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'string')
    ..a<$core.List<$core.int>>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bytes', $pb.PbFieldType.OY)
    ..a<$core.int>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enum', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Scalar._() : super();
  factory Scalar({
    $core.double? double_1,
    $core.double? float,
    $core.int? int32,
    $fixnum.Int64? int64,
    $core.int? uint32,
    $fixnum.Int64? uint64,
    $core.int? sint32,
    $fixnum.Int64? sint64,
    $core.int? fixed32,
    $fixnum.Int64? fixed64,
    $core.int? sfixed32,
    $fixnum.Int64? sfixed64,
    $core.bool? bool_13,
    $core.String? string,
    $core.List<$core.int>? bytes,
    $core.int? enum_16,
  }) {
    final _result = create();
    if (double_1 != null) {
      _result.double_1 = double_1;
    }
    if (float != null) {
      _result.float = float;
    }
    if (int32 != null) {
      _result.int32 = int32;
    }
    if (int64 != null) {
      _result.int64 = int64;
    }
    if (uint32 != null) {
      _result.uint32 = uint32;
    }
    if (uint64 != null) {
      _result.uint64 = uint64;
    }
    if (sint32 != null) {
      _result.sint32 = sint32;
    }
    if (sint64 != null) {
      _result.sint64 = sint64;
    }
    if (fixed32 != null) {
      _result.fixed32 = fixed32;
    }
    if (fixed64 != null) {
      _result.fixed64 = fixed64;
    }
    if (sfixed32 != null) {
      _result.sfixed32 = sfixed32;
    }
    if (sfixed64 != null) {
      _result.sfixed64 = sfixed64;
    }
    if (bool_13 != null) {
      _result.bool_13 = bool_13;
    }
    if (string != null) {
      _result.string = string;
    }
    if (bytes != null) {
      _result.bytes = bytes;
    }
    if (enum_16 != null) {
      _result.enum_16 = enum_16;
    }
    return _result;
  }
  factory Scalar.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Scalar.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Scalar clone() => Scalar()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Scalar copyWith(void Function(Scalar) updates) => super.copyWith((message) => updates(message as Scalar)) as Scalar; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Scalar create() => Scalar._();
  Scalar createEmptyInstance() => create();
  static $pb.PbList<Scalar> createRepeated() => $pb.PbList<Scalar>();
  @$core.pragma('dart2js:noInline')
  static Scalar getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Scalar>(create);
  static Scalar? _defaultInstance;

  Scalar_V whichV() => _Scalar_VByTag[$_whichOneof(0)]!;
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

  @$pb.TagNumber(16)
  $core.int get enum_16 => $_getIZ(15);
  @$pb.TagNumber(16)
  set enum_16($core.int v) { $_setSignedInt32(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasEnum_16() => $_has(15);
  @$pb.TagNumber(16)
  void clearEnum_16() => clearField(16);
}

enum Delta_V {
  quill, 
  notSet
}

class Delta extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Delta_V> _Delta_VByTag = {
    1 : Delta_V.quill,
    0 : Delta_V.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Delta', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<QuillDelta>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quill', subBuilder: QuillDelta.create)
    ..hasRequiredFields = false
  ;

  Delta._() : super();
  factory Delta({
    QuillDelta? quill,
  }) {
    final _result = create();
    if (quill != null) {
      _result.quill = quill;
    }
    return _result;
  }
  factory Delta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Delta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Delta clone() => Delta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Delta copyWith(void Function(Delta) updates) => super.copyWith((message) => updates(message as Delta)) as Delta; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Delta create() => Delta._();
  Delta createEmptyInstance() => create();
  static $pb.PbList<Delta> createRepeated() => $pb.PbList<Delta>();
  @$core.pragma('dart2js:noInline')
  static Delta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Delta>(create);
  static Delta? _defaultInstance;

  Delta_V whichV() => _Delta_VByTag[$_whichOneof(0)]!;
  void clearV() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  QuillDelta get quill => $_getN(0);
  @$pb.TagNumber(1)
  set quill(QuillDelta v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuill() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuill() => clearField(1);
  @$pb.TagNumber(1)
  QuillDelta ensureQuill() => $_ensure(0);
}

class QuillDelta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuillDelta', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..pc<Quill>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ops', $pb.PbFieldType.PM, subBuilder: Quill.create)
    ..hasRequiredFields = false
  ;

  QuillDelta._() : super();
  factory QuillDelta({
    $core.Iterable<Quill>? ops,
  }) {
    final _result = create();
    if (ops != null) {
      _result.ops.addAll(ops);
    }
    return _result;
  }
  factory QuillDelta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuillDelta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuillDelta clone() => QuillDelta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuillDelta copyWith(void Function(QuillDelta) updates) => super.copyWith((message) => updates(message as QuillDelta)) as QuillDelta; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuillDelta create() => QuillDelta._();
  QuillDelta createEmptyInstance() => create();
  static $pb.PbList<QuillDelta> createRepeated() => $pb.PbList<QuillDelta>();
  @$core.pragma('dart2js:noInline')
  static QuillDelta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuillDelta>(create);
  static QuillDelta? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Quill', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insert')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retain')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'delete')
    ..aOM<$1.Struct>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attributes', subBuilder: $1.Struct.create)
    ..hasRequiredFields = false
  ;

  Quill._() : super();
  factory Quill({
    $core.String? insert,
    $fixnum.Int64? retain,
    $fixnum.Int64? delete,
    $1.Struct? attributes,
  }) {
    final _result = create();
    if (insert != null) {
      _result.insert = insert;
    }
    if (retain != null) {
      _result.retain = retain;
    }
    if (delete != null) {
      _result.delete = delete;
    }
    if (attributes != null) {
      _result.attributes = attributes;
    }
    return _result;
  }
  factory Quill.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Quill.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Quill clone() => Quill()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Quill copyWith(void Function(Quill) updates) => super.copyWith((message) => updates(message as Quill)) as Quill; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Quill create() => Quill._();
  Quill createEmptyInstance() => create();
  static $pb.PbList<Quill> createRepeated() => $pb.PbList<Quill>();
  @$core.pragma('dart2js:noInline')
  static Quill getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Quill>(create);
  static Quill? _defaultInstance;

  Quill_V whichV() => _Quill_VByTag[$_whichOneof(0)]!;
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
  $1.Struct get attributes => $_getN(3);
  @$pb.TagNumber(4)
  set attributes($1.Struct v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAttributes() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttributes() => clearField(4);
  @$pb.TagNumber(4)
  $1.Struct ensureAttributes() => $_ensure(3);
}

class Fragment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Fragment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta'), createEmptyInstance: create)
    ..aOM<Field>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'field', subBuilder: Field.create)
    ..aOM<$0.Any>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', subBuilder: $0.Any.create)
    ..hasRequiredFields = false
  ;

  Fragment._() : super();
  factory Fragment({
    Field? field_1,
    $0.Any? message,
  }) {
    final _result = create();
    if (field_1 != null) {
      _result.field_1 = field_1;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory Fragment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Fragment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Fragment clone() => Fragment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Fragment copyWith(void Function(Fragment) updates) => super.copyWith((message) => updates(message as Fragment)) as Fragment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Fragment create() => Fragment._();
  Fragment createEmptyInstance() => create();
  static $pb.PbList<Fragment> createRepeated() => $pb.PbList<Fragment>();
  @$core.pragma('dart2js:noInline')
  static Fragment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fragment>(create);
  static Fragment? _defaultInstance;

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
  $0.Any get message => $_getN(1);
  @$pb.TagNumber(2)
  set message($0.Any v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
  @$pb.TagNumber(2)
  $0.Any ensureMessage() => $_ensure(1);
}

