///
//  Generated code. Do not modify.
//  source: pstore/pstore.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/any.pb.dart' as $0;
import '../delta/delta.pb.dart' as $1;

class Payload_Get_Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Get.Request', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', protoName: 'documentType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentId', protoName: 'documentId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'create')
    ..hasRequiredFields = false
  ;

  Payload_Get_Request._() : super();
  factory Payload_Get_Request() => create();
  factory Payload_Get_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Get_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Get_Request clone() => Payload_Get_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Get_Request copyWith(void Function(Payload_Get_Request) updates) => super.copyWith((message) => updates(message as Payload_Get_Request)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Get_Request create() => Payload_Get_Request._();
  Payload_Get_Request createEmptyInstance() => create();
  static $pb.PbList<Payload_Get_Request> createRepeated() => $pb.PbList<Payload_Get_Request>();
  @$core.pragma('dart2js:noInline')
  static Payload_Get_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Get_Request>(create);
  static Payload_Get_Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get create_3 => $_getBF(2);
  @$pb.TagNumber(3)
  set create_3($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreate_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreate_3() => clearField(3);
}

class Payload_Get_Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Get.Response', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOM<$0.Any>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', subBuilder: $0.Any.create)
    ..hasRequiredFields = false
  ;

  Payload_Get_Response._() : super();
  factory Payload_Get_Response() => create();
  factory Payload_Get_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Get_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Get_Response clone() => Payload_Get_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Get_Response copyWith(void Function(Payload_Get_Response) updates) => super.copyWith((message) => updates(message as Payload_Get_Response)); // ignore: deprecated_member_use
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

  @$pb.TagNumber(2)
  $0.Any get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($0.Any v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  $0.Any ensureValue() => $_ensure(1);
}

class Payload_Get extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Get', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload_Get._() : super();
  factory Payload_Get() => create();
  factory Payload_Get.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Get.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Get clone() => Payload_Get()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Get copyWith(void Function(Payload_Get) updates) => super.copyWith((message) => updates(message as Payload_Get)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Get create() => Payload_Get._();
  Payload_Get createEmptyInstance() => create();
  static $pb.PbList<Payload_Get> createRepeated() => $pb.PbList<Payload_Get>();
  @$core.pragma('dart2js:noInline')
  static Payload_Get getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Get>(create);
  static Payload_Get _defaultInstance;
}

class Payload_Edit_Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Edit.Request', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', protoName: 'documentType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentId', protoName: 'documentId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stateId', protoName: 'stateId')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOM<$1.Op>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op', subBuilder: $1.Op.create)
    ..hasRequiredFields = false
  ;

  Payload_Edit_Request._() : super();
  factory Payload_Edit_Request() => create();
  factory Payload_Edit_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Edit_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Edit_Request clone() => Payload_Edit_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Edit_Request copyWith(void Function(Payload_Edit_Request) updates) => super.copyWith((message) => updates(message as Payload_Edit_Request)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Edit_Request create() => Payload_Edit_Request._();
  Payload_Edit_Request createEmptyInstance() => create();
  static $pb.PbList<Payload_Edit_Request> createRepeated() => $pb.PbList<Payload_Edit_Request>();
  @$core.pragma('dart2js:noInline')
  static Payload_Edit_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Edit_Request>(create);
  static Payload_Edit_Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get stateId => $_getSZ(2);
  @$pb.TagNumber(3)
  set stateId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStateId() => $_has(2);
  @$pb.TagNumber(3)
  void clearStateId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get state => $_getI64(3);
  @$pb.TagNumber(4)
  set state($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);

  @$pb.TagNumber(5)
  $1.Op get op => $_getN(4);
  @$pb.TagNumber(5)
  set op($1.Op v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOp() => $_has(4);
  @$pb.TagNumber(5)
  void clearOp() => clearField(5);
  @$pb.TagNumber(5)
  $1.Op ensureOp() => $_ensure(4);
}

class Payload_Edit_Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Edit.Response', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOM<$1.Op>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op', subBuilder: $1.Op.create)
    ..hasRequiredFields = false
  ;

  Payload_Edit_Response._() : super();
  factory Payload_Edit_Response() => create();
  factory Payload_Edit_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Edit_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Edit_Response clone() => Payload_Edit_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Edit_Response copyWith(void Function(Payload_Edit_Response) updates) => super.copyWith((message) => updates(message as Payload_Edit_Response)); // ignore: deprecated_member_use
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
  $1.Op get op => $_getN(1);
  @$pb.TagNumber(2)
  set op($1.Op v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOp() => clearField(2);
  @$pb.TagNumber(2)
  $1.Op ensureOp() => $_ensure(1);
}

class Payload_Edit extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Edit', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload_Edit._() : super();
  factory Payload_Edit() => create();
  factory Payload_Edit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Edit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Edit clone() => Payload_Edit()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Edit copyWith(void Function(Payload_Edit) updates) => super.copyWith((message) => updates(message as Payload_Edit)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Edit create() => Payload_Edit._();
  Payload_Edit createEmptyInstance() => create();
  static $pb.PbList<Payload_Edit> createRepeated() => $pb.PbList<Payload_Edit>();
  @$core.pragma('dart2js:noInline')
  static Payload_Edit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Edit>(create);
  static Payload_Edit _defaultInstance;
}

class Payload_Refresh_Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Refresh.Request', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', protoName: 'documentType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentId', protoName: 'documentId')
    ..hasRequiredFields = false
  ;

  Payload_Refresh_Request._() : super();
  factory Payload_Refresh_Request() => create();
  factory Payload_Refresh_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Refresh_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Refresh_Request clone() => Payload_Refresh_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Refresh_Request copyWith(void Function(Payload_Refresh_Request) updates) => super.copyWith((message) => updates(message as Payload_Refresh_Request)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Refresh_Request create() => Payload_Refresh_Request._();
  Payload_Refresh_Request createEmptyInstance() => create();
  static $pb.PbList<Payload_Refresh_Request> createRepeated() => $pb.PbList<Payload_Refresh_Request>();
  @$core.pragma('dart2js:noInline')
  static Payload_Refresh_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Refresh_Request>(create);
  static Payload_Refresh_Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentId() => clearField(2);
}

class Payload_Refresh extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload.Refresh', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload_Refresh._() : super();
  factory Payload_Refresh() => create();
  factory Payload_Refresh.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload_Refresh.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload_Refresh clone() => Payload_Refresh()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload_Refresh copyWith(void Function(Payload_Refresh) updates) => super.copyWith((message) => updates(message as Payload_Refresh)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload_Refresh create() => Payload_Refresh._();
  Payload_Refresh createEmptyInstance() => create();
  static $pb.PbList<Payload_Refresh> createRepeated() => $pb.PbList<Payload_Refresh>();
  @$core.pragma('dart2js:noInline')
  static Payload_Refresh getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload_Refresh>(create);
  static Payload_Refresh _defaultInstance;
}

class Payload extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Payload', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pstore'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Payload._() : super();
  factory Payload() => create();
  factory Payload.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payload.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payload clone() => Payload()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payload copyWith(void Function(Payload) updates) => super.copyWith((message) => updates(message as Payload)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload create() => Payload._();
  Payload createEmptyInstance() => create();
  static $pb.PbList<Payload> createRepeated() => $pb.PbList<Payload>();
  @$core.pragma('dart2js:noInline')
  static Payload getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload>(create);
  static Payload _defaultInstance;
}

