///
//  Generated code. Do not modify.
//  source: pdelta/pdelta.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Op_Type extends $pb.ProtobufEnum {
  static const Op_Type Null = Op_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Null');
  static const Op_Type Set = Op_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Set');
  static const Op_Type Edit = Op_Type._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Edit');
  static const Op_Type Insert = Op_Type._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Insert');
  static const Op_Type Move = Op_Type._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Move');
  static const Op_Type Rename = Op_Type._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Rename');
  static const Op_Type Delete = Op_Type._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Delete');
  static const Op_Type Compound = Op_Type._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Compound');

  static const $core.List<Op_Type> values = <Op_Type> [
    Null,
    Set,
    Edit,
    Insert,
    Move,
    Rename,
    Delete,
    Compound,
  ];

  static final $core.Map<$core.int, Op_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Op_Type valueOf($core.int value) => _byValue[value];

  const Op_Type._($core.int v, $core.String n) : super(v, n);
}

