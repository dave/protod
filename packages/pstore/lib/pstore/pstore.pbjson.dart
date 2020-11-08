///
//  Generated code. Do not modify.
//  source: pstore/pstore.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const Payload$json = const {
  '1': 'Payload',
  '3': const [Payload_Get$json, Payload_Edit$json, Payload_Refresh$json],
};

const Payload_Get$json = const {
  '1': 'Get',
  '3': const [Payload_Get_Request$json, Payload_Get_Response$json],
};

const Payload_Get_Request$json = const {
  '1': 'Request',
  '2': const [
    const {'1': 'documentType', '3': 1, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'documentId', '3': 2, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'create', '3': 3, '4': 1, '5': 8, '10': 'create'},
  ],
};

const Payload_Get_Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 3, '10': 'state'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'value'},
  ],
};

const Payload_Edit$json = const {
  '1': 'Edit',
  '3': const [Payload_Edit_Request$json, Payload_Edit_Response$json],
};

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

const Payload_Edit_Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 3, '10': 'state'},
    const {'1': 'op', '3': 2, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op'},
  ],
};

const Payload_Refresh$json = const {
  '1': 'Refresh',
  '3': const [Payload_Refresh_Request$json],
};

const Payload_Refresh_Request$json = const {
  '1': 'Request',
  '2': const [
    const {'1': 'documentType', '3': 1, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'documentId', '3': 2, '4': 1, '5': 9, '10': 'documentId'},
  ],
};

