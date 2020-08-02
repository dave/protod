///
//  Generated code. Do not modify.
//  source: pmsg/pmsg.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/any.pb.dart' as $0;

class Bundle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Bundle', package: const $pb.PackageName('pmsg'), createEmptyInstance: create)
    ..m<$core.String, $0.Any>(1, 'messages', entryClassName: 'Bundle.MessagesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: $0.Any.create, packageName: const $pb.PackageName('pmsg'))
    ..hasRequiredFields = false
  ;

  Bundle._() : super();
  factory Bundle() => create();
  factory Bundle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bundle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Bundle clone() => Bundle()..mergeFromMessage(this);
  Bundle copyWith(void Function(Bundle) updates) => super.copyWith((message) => updates(message as Bundle));
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

