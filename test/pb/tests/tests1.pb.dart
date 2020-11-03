///
//  Generated code. Do not modify.
//  source: tests/tests1.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class House extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('House', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(2, 'number', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  House._() : super();
  factory House() => create();
  factory House.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory House.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  House clone() => House()..mergeFromMessage(this);
  House copyWith(void Function(House) updates) => super.copyWith((message) => updates(message as House));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static House create() => House._();
  House createEmptyInstance() => create();
  static $pb.PbList<House> createRepeated() => $pb.PbList<House>();
  @$core.pragma('dart2js:noInline')
  static House getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<House>(create);
  static House _defaultInstance;

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
  set number($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => clearField(2);
}

