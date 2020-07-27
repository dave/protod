///
//  Generated code. Do not modify.
//  source: pserver/data.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../delta/delta.pb.dart' as $0;

class Payload_Edit_Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Edit.Request', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'request')
    ..aInt64(3, 'state')
    ..aOM<$0.Op>(4, 'op', subBuilder: $0.Op.create)
    ..hasRequiredFields = false
  ;

  Payload_Edit_Request._() : super();
  factory Payload_Edit_Request() => create();
  factory Payload_Edit_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Edit_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Edit_Request clone() => Payload_Edit_Request()..mergeFromMessage(this);
  Payload_Edit_Request copyWith(void Function(Payload_Edit_Request) updates) => super.copyWith((message) => updates(message as Payload_Edit_Request));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Edit_Request create() => Payload_Edit_Request._();
  Payload_Edit_Request createEmptyInstance() => create();
  static $pb.PbList<Payload_Edit_Request> createRepeated() => $pb.PbList<Payload_Edit_Request>();
  @$core.pragma('dart2js:noInline')
  static Payload_Edit_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Edit_Request>(create);
  static Payload_Edit_Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get request => $_getSZ(1);
  @$pb.TagNumber(2)
  set request($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequest() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequest() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get state => $_getI64(2);
  @$pb.TagNumber(3)
  set state($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasState() => $_has(2);
  @$pb.TagNumber(3)
  void clearState() => clearField(3);

  @$pb.TagNumber(4)
  $0.Op get op => $_getN(3);
  @$pb.TagNumber(4)
  set op($0.Op v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOp() => $_has(3);
  @$pb.TagNumber(4)
  void clearOp() => clearField(4);
  @$pb.TagNumber(4)
  $0.Op ensureOp() => $_ensure(3);
}

class Payload_Edit_Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Edit.Response', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aInt64(1, 'state')
    ..aOM<$0.Op>(2, 'op', subBuilder: $0.Op.create)
    ..hasRequiredFields = false
  ;

  Payload_Edit_Response._() : super();
  factory Payload_Edit_Response() => create();
  factory Payload_Edit_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Edit_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Edit_Response clone() => Payload_Edit_Response()..mergeFromMessage(this);
  Payload_Edit_Response copyWith(void Function(Payload_Edit_Response) updates) => super.copyWith((message) => updates(message as Payload_Edit_Response));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Edit_Response create() => Payload_Edit_Response._();
  Payload_Edit_Response createEmptyInstance() => create();
  static $pb.PbList<Payload_Edit_Response> createRepeated() => $pb.PbList<Payload_Edit_Response>();
  @$core.pragma('dart2js:noInline')
  static Payload_Edit_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Edit_Response>(create);
  static Payload_Edit_Response _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get state => $_getI64(0);
  @$pb.TagNumber(1)
  set state($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);

  @$pb.TagNumber(2)
  $0.Op get op => $_getN(1);
  @$pb.TagNumber(2)
  set op($0.Op v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOp() => clearField(2);
  @$pb.TagNumber(2)
  $0.Op ensureOp() => $_ensure(1);
}

class Payload_Edit extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Edit', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload_Edit._() : super();
  factory Payload_Edit() => create();
  factory Payload_Edit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Edit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Edit clone() => Payload_Edit()..mergeFromMessage(this);
  Payload_Edit copyWith(void Function(Payload_Edit) updates) => super.copyWith((message) => updates(message as Payload_Edit));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Edit create() => Payload_Edit._();
  Payload_Edit createEmptyInstance() => create();
  static $pb.PbList<Payload_Edit> createRepeated() => $pb.PbList<Payload_Edit>();
  @$core.pragma('dart2js:noInline')
  static Payload_Edit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Edit>(create);
  static Payload_Edit _defaultInstance;
}

class Payload_Add_Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Add.Request', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aOS(1, 'request')
    ..hasRequiredFields = false
  ;

  Payload_Add_Request._() : super();
  factory Payload_Add_Request() => create();
  factory Payload_Add_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Add_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Add_Request clone() => Payload_Add_Request()..mergeFromMessage(this);
  Payload_Add_Request copyWith(void Function(Payload_Add_Request) updates) => super.copyWith((message) => updates(message as Payload_Add_Request));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Add_Request create() => Payload_Add_Request._();
  Payload_Add_Request createEmptyInstance() => create();
  static $pb.PbList<Payload_Add_Request> createRepeated() => $pb.PbList<Payload_Add_Request>();
  @$core.pragma('dart2js:noInline')
  static Payload_Add_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Add_Request>(create);
  static Payload_Add_Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get request => $_getSZ(0);
  @$pb.TagNumber(1)
  set request($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);
}

class Payload_Add_Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Add.Response', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  Payload_Add_Response._() : super();
  factory Payload_Add_Response() => create();
  factory Payload_Add_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Add_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Add_Response clone() => Payload_Add_Response()..mergeFromMessage(this);
  Payload_Add_Response copyWith(void Function(Payload_Add_Response) updates) => super.copyWith((message) => updates(message as Payload_Add_Response));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Add_Response create() => Payload_Add_Response._();
  Payload_Add_Response createEmptyInstance() => create();
  static $pb.PbList<Payload_Add_Response> createRepeated() => $pb.PbList<Payload_Add_Response>();
  @$core.pragma('dart2js:noInline')
  static Payload_Add_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Add_Response>(create);
  static Payload_Add_Response _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class Payload_Add extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Add', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload_Add._() : super();
  factory Payload_Add() => create();
  factory Payload_Add.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Add.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Add clone() => Payload_Add()..mergeFromMessage(this);
  Payload_Add copyWith(void Function(Payload_Add) updates) => super.copyWith((message) => updates(message as Payload_Add));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Add create() => Payload_Add._();
  Payload_Add createEmptyInstance() => create();
  static $pb.PbList<Payload_Add> createRepeated() => $pb.PbList<Payload_Add>();
  @$core.pragma('dart2js:noInline')
  static Payload_Add getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Add>(create);
  static Payload_Add _defaultInstance;
}

class Payload_Get_Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Get.Request', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  Payload_Get_Request._() : super();
  factory Payload_Get_Request() => create();
  factory Payload_Get_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Get_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Get_Request clone() => Payload_Get_Request()..mergeFromMessage(this);
  Payload_Get_Request copyWith(void Function(Payload_Get_Request) updates) => super.copyWith((message) => updates(message as Payload_Get_Request));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Get_Request create() => Payload_Get_Request._();
  Payload_Get_Request createEmptyInstance() => create();
  static $pb.PbList<Payload_Get_Request> createRepeated() => $pb.PbList<Payload_Get_Request>();
  @$core.pragma('dart2js:noInline')
  static Payload_Get_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Get_Request>(create);
  static Payload_Get_Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class Payload_Get_Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Get.Response', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aInt64(1, 'state')
    ..hasRequiredFields = false
  ;

  Payload_Get_Response._() : super();
  factory Payload_Get_Response() => create();
  factory Payload_Get_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Get_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Get_Response clone() => Payload_Get_Response()..mergeFromMessage(this);
  Payload_Get_Response copyWith(void Function(Payload_Get_Response) updates) => super.copyWith((message) => updates(message as Payload_Get_Response));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Get_Response create() => Payload_Get_Response._();
  Payload_Get_Response createEmptyInstance() => create();
  static $pb.PbList<Payload_Get_Response> createRepeated() => $pb.PbList<Payload_Get_Response>();
  @$core.pragma('dart2js:noInline')
  static Payload_Get_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Get_Response>(create);
  static Payload_Get_Response _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get state => $_getI64(0);
  @$pb.TagNumber(1)
  set state($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);
}

class Payload_Get extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload.Get', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload_Get._() : super();
  factory Payload_Get() => create();
  factory Payload_Get.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Get.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload_Get clone() => Payload_Get()..mergeFromMessage(this);
  Payload_Get copyWith(void Function(Payload_Get) updates) => super.copyWith((message) => updates(message as Payload_Get));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Get create() => Payload_Get._();
  Payload_Get createEmptyInstance() => create();
  static $pb.PbList<Payload_Get> createRepeated() => $pb.PbList<Payload_Get>();
  @$core.pragma('dart2js:noInline')
  static Payload_Get getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Get>(create);
  static Payload_Get _defaultInstance;
}

class Payload extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payload', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload._() : super();
  factory Payload() => create();
  factory Payload.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payload clone() => Payload()..mergeFromMessage(this);
  Payload copyWith(void Function(Payload) updates) => super.copyWith((message) => updates(message as Payload));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload create() => Payload._();
  Payload createEmptyInstance() => create();
  static $pb.PbList<Payload> createRepeated() => $pb.PbList<Payload>();
  @$core.pragma('dart2js:noInline')
  static Payload getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload>(create);
  static Payload _defaultInstance;
}

class Snapshot extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Snapshot', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aOS(1, 'request')
    ..aInt64(2, 'state')
    ..aOM<Blob>(3, 'value', subBuilder: Blob.create)
    ..hasRequiredFields = false
  ;

  Snapshot._() : super();
  factory Snapshot() => create();
  factory Snapshot.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Snapshot.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Snapshot clone() => Snapshot()..mergeFromMessage(this);
  Snapshot copyWith(void Function(Snapshot) updates) => super.copyWith((message) => updates(message as Snapshot));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Snapshot create() => Snapshot._();
  Snapshot createEmptyInstance() => create();
  static $pb.PbList<Snapshot> createRepeated() => $pb.PbList<Snapshot>();
  @$core.pragma('dart2js:noInline')
  static Snapshot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Snapshot>(create);
  static Snapshot _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get request => $_getSZ(0);
  @$pb.TagNumber(1)
  set request($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get state => $_getI64(1);
  @$pb.TagNumber(2)
  set state($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  Blob get value => $_getN(2);
  @$pb.TagNumber(3)
  set value(Blob v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
  @$pb.TagNumber(3)
  Blob ensureValue() => $_ensure(2);
}

class State extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('State', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..aOS(1, 'request')
    ..aInt64(2, 'state')
    ..aOM<Blob>(3, 'op', subBuilder: Blob.create)
    ..hasRequiredFields = false
  ;

  State._() : super();
  factory State() => create();
  factory State.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory State.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  State clone() => State()..mergeFromMessage(this);
  State copyWith(void Function(State) updates) => super.copyWith((message) => updates(message as State));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static State create() => State._();
  State createEmptyInstance() => create();
  static $pb.PbList<State> createRepeated() => $pb.PbList<State>();
  @$core.pragma('dart2js:noInline')
  static State getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<State>(create);
  static State _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get request => $_getSZ(0);
  @$pb.TagNumber(1)
  set request($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get state => $_getI64(1);
  @$pb.TagNumber(2)
  set state($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  Blob get op => $_getN(2);
  @$pb.TagNumber(3)
  set op(Blob v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOp() => $_has(2);
  @$pb.TagNumber(3)
  void clearOp() => clearField(3);
  @$pb.TagNumber(3)
  Blob ensureOp() => $_ensure(2);
}

class Blob extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Blob', package: const $pb.PackageName('pserver'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Blob._() : super();
  factory Blob() => create();
  factory Blob.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Blob.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Blob clone() => Blob()..mergeFromMessage(this);
  Blob copyWith(void Function(Blob) updates) => super.copyWith((message) => updates(message as Blob));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Blob create() => Blob._();
  Blob createEmptyInstance() => create();
  static $pb.PbList<Blob> createRepeated() => $pb.PbList<Blob>();
  @$core.pragma('dart2js:noInline')
  static Blob getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Blob>(create);
  static Blob _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

