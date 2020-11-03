///
//  Generated code. Do not modify.
//  source: tests2/tests2.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Shirt extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Shirt', package: const $pb.PackageName('tests2'), createEmptyInstance: create)
    ..aOS(1, 'designer')
    ..a<$core.int>(2, 'size', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Shirt._() : super();
  factory Shirt() => create();
  factory Shirt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Shirt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Shirt clone() => Shirt()..mergeFromMessage(this);
  Shirt copyWith(void Function(Shirt) updates) => super.copyWith((message) => updates(message as Shirt));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Shirt create() => Shirt._();
  Shirt createEmptyInstance() => create();
  static $pb.PbList<Shirt> createRepeated() => $pb.PbList<Shirt>();
  @$core.pragma('dart2js:noInline')
  static Shirt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Shirt>(create);
  static Shirt _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get designer => $_getSZ(0);
  @$pb.TagNumber(1)
  set designer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDesigner() => $_has(0);
  @$pb.TagNumber(1)
  void clearDesigner() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get size => $_getIZ(1);
  @$pb.TagNumber(2)
  set size($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => clearField(2);
}

