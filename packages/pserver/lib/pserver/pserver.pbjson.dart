///
//  Generated code. Do not modify.
//  source: pserver/pserver.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use snapshotDescriptor instead')
const Snapshot$json = const {
  '1': 'Snapshot',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 3, '10': 'state'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.pserver.Blob', '10': 'value'},
  ],
};

/// Descriptor for `Snapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List snapshotDescriptor = $convert.base64Decode('CghTbmFwc2hvdBIUCgVzdGF0ZRgBIAEoA1IFc3RhdGUSIwoFdmFsdWUYAiABKAsyDS5wc2VydmVyLkJsb2JSBXZhbHVl');
@$core.Deprecated('Use stateDescriptor instead')
const State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 3, '10': 'state'},
    const {'1': 'op', '3': 2, '4': 1, '5': 11, '6': '.pserver.Blob', '10': 'op'},
  ],
};

/// Descriptor for `State`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stateDescriptor = $convert.base64Decode('CgVTdGF0ZRIUCgVzdGF0ZRgBIAEoA1IFc3RhdGUSHQoCb3AYAiABKAsyDS5wc2VydmVyLkJsb2JSAm9w');
@$core.Deprecated('Use blobDescriptor instead')
const Blob$json = const {
  '1': 'Blob',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Blob`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blobDescriptor = $convert.base64Decode('CgRCbG9iEhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');
