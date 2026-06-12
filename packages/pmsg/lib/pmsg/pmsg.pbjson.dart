///
//  Generated code. Do not modify.
//  source: pmsg/pmsg.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use bundleDescriptor instead')
const Bundle$json = const {
  '1': 'Bundle',
  '2': const [
    const {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.pmsg.Bundle.MessagesEntry', '10': 'messages'},
  ],
  '3': const [Bundle_MessagesEntry$json],
};

@$core.Deprecated('Use bundleDescriptor instead')
const Bundle_MessagesEntry$json = const {
  '1': 'MessagesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Bundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bundleDescriptor = $convert.base64Decode('CgZCdW5kbGUSNgoIbWVzc2FnZXMYASADKAsyGi5wbXNnLkJ1bmRsZS5NZXNzYWdlc0VudHJ5UghtZXNzYWdlcxpRCg1NZXNzYWdlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EioKBXZhbHVlGAIgASgLMhQuZ29vZ2xlLnByb3RvYnVmLkFueVIFdmFsdWU6AjgB');
