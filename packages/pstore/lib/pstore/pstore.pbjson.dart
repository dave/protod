///
//  Generated code. Do not modify.
//  source: pstore/pstore.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use payloadDescriptor instead')
const Payload$json = const {
  '1': 'Payload',
  '3': const [Payload_Get$json, Payload_Edit$json, Payload_Refresh$json],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Get$json = const {
  '1': 'Get',
  '3': const [Payload_Get_Request$json, Payload_Get_Response$json],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Get_Request$json = const {
  '1': 'Request',
  '2': const [
    const {'1': 'documentType', '3': 1, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'documentId', '3': 2, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'create', '3': 3, '4': 1, '5': 8, '10': 'create'},
  ],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Get_Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 3, '10': 'state'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'value'},
  ],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Edit$json = const {
  '1': 'Edit',
  '3': const [Payload_Edit_Request$json, Payload_Edit_Response$json],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Edit_Request$json = const {
  '1': 'Request',
  '2': const [
    const {'1': 'documentType', '3': 1, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'documentId', '3': 2, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'stateId', '3': 3, '4': 1, '5': 9, '10': 'stateId'},
    const {'1': 'state', '3': 4, '4': 1, '5': 3, '10': 'state'},
    const {'1': 'op', '3': 5, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op'},
  ],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Edit_Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 3, '10': 'state'},
    const {'1': 'op', '3': 2, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op'},
  ],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Refresh$json = const {
  '1': 'Refresh',
  '3': const [Payload_Refresh_Request$json],
};

@$core.Deprecated('Use payloadDescriptor instead')
const Payload_Refresh_Request$json = const {
  '1': 'Request',
  '2': const [
    const {'1': 'documentType', '3': 1, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'documentId', '3': 2, '4': 1, '5': 9, '10': 'documentId'},
  ],
};

/// Descriptor for `Payload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payloadDescriptor = $convert.base64Decode('CgdQYXlsb2FkGroBCgNHZXQaZQoHUmVxdWVzdBIiCgxkb2N1bWVudFR5cGUYASABKAlSDGRvY3VtZW50VHlwZRIeCgpkb2N1bWVudElkGAIgASgJUgpkb2N1bWVudElkEhYKBmNyZWF0ZRgDIAEoCFIGY3JlYXRlGkwKCFJlc3BvbnNlEhQKBXN0YXRlGAEgASgDUgVzdGF0ZRIqCgV2YWx1ZRgCIAEoCzIULmdvb2dsZS5wcm90b2J1Zi5BbnlSBXZhbHVlGuABCgRFZGl0GpkBCgdSZXF1ZXN0EiIKDGRvY3VtZW50VHlwZRgBIAEoCVIMZG9jdW1lbnRUeXBlEh4KCmRvY3VtZW50SWQYAiABKAlSCmRvY3VtZW50SWQSGAoHc3RhdGVJZBgDIAEoCVIHc3RhdGVJZBIUCgVzdGF0ZRgEIAEoA1IFc3RhdGUSGgoCb3AYBSABKAsyCi5wZGVsdGEuT3BSAm9wGjwKCFJlc3BvbnNlEhQKBXN0YXRlGAEgASgDUgVzdGF0ZRIaCgJvcBgCIAEoCzIKLnBkZWx0YS5PcFICb3AaWAoHUmVmcmVzaBpNCgdSZXF1ZXN0EiIKDGRvY3VtZW50VHlwZRgBIAEoCVIMZG9jdW1lbnRUeXBlEh4KCmRvY3VtZW50SWQYAiABKAlSCmRvY3VtZW50SWQ=');
