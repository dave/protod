///
//  Generated code. Do not modify.
//  source: pdelta_tests/tests.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Person_Type extends $pb.ProtobufEnum {
  static const Person_Type Null = Person_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Null');
  static const Person_Type Alpha = Person_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Alpha');
  static const Person_Type Bravo = Person_Type._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Bravo');
  static const Person_Type Charlie = Person_Type._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Charlie');

  static const $core.List<Person_Type> values = <Person_Type> [
    Null,
    Alpha,
    Bravo,
    Charlie,
  ];

  static final $core.Map<$core.int, Person_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Person_Type valueOf($core.int value) => _byValue[value];

  const Person_Type._($core.int v, $core.String n) : super(v, n);
}

