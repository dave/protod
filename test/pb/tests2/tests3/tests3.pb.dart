///
//  Generated code. Do not modify.
//  source: tests2/tests3/tests3.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Pants extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Pants', package: const $pb.PackageName('tests3'), createEmptyInstance: create)
    ..aOS(1, 'style')
    ..a<$core.int>(2, 'length', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, 'waist', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Pants._() : super();
  factory Pants() => create();
  factory Pants.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pants.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Pants clone() => Pants()..mergeFromMessage(this);
  Pants copyWith(void Function(Pants) updates) => super.copyWith((message) => updates(message as Pants));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Pants create() => Pants._();
  Pants createEmptyInstance() => create();
  static $pb.PbList<Pants> createRepeated() => $pb.PbList<Pants>();
  @$core.pragma('dart2js:noInline')
  static Pants getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pants>(create);
  static Pants _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get style => $_getSZ(0);
  @$pb.TagNumber(1)
  set style($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStyle() => $_has(0);
  @$pb.TagNumber(1)
  void clearStyle() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get length => $_getIZ(1);
  @$pb.TagNumber(2)
  set length($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLength() => $_has(1);
  @$pb.TagNumber(2)
  void clearLength() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get waist => $_getIZ(2);
  @$pb.TagNumber(3)
  set waist($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWaist() => $_has(2);
  @$pb.TagNumber(3)
  void clearWaist() => clearField(3);
}

