///
//  Generated code. Do not modify.
//  source: tests.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Person_Type extends $pb.ProtobufEnum {
  static const Person_Type Alpha = Person_Type._(0, 'Alpha');
  static const Person_Type Bravo = Person_Type._(1, 'Bravo');
  static const Person_Type Charlie = Person_Type._(2, 'Charlie');

  static const $core.List<Person_Type> values = <Person_Type> [
    Alpha,
    Bravo,
    Charlie,
  ];

  static final $core.Map<$core.int, Person_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Person_Type valueOf($core.int value) => _byValue[value];

  const Person_Type._($core.int v, $core.String n) : super(v, n);
}

