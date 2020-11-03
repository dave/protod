///
//  Generated code. Do not modify.
//  source: pmsg/pmsg.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/any.pb.dart' as $0;

class Bundle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Bundle', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pmsg'), createEmptyInstance: create)
    ..m<$core.String, $0.Any>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messages', entryClassName: 'Bundle.MessagesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: $0.Any.create, packageName: const $pb.PackageName('pmsg'))
    ..hasRequiredFields = false
  ;

  Bundle._() : super();
  factory Bundle() => create();
  factory Bundle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bundle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bundle clone() => Bundle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bundle copyWith(void Function(Bundle) updates) => super.copyWith((message) => updates(message as Bundle)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Bundle create() => Bundle._();
  Bundle createEmptyInstance() => create();
  static $pb.PbList<Bundle> createRepeated() => $pb.PbList<Bundle>();
  @$core.pragma('dart2js:noInline')
  static Bundle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bundle>(create);
  static Bundle _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $0.Any> get messages => $_getMap(0);
}

