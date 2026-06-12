///
//  Generated code. Do not modify.
//  source: pdelta_tests/tests.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use personDescriptor instead')
const Person$json = const {
  '1': 'Person',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'age', '3': 2, '4': 1, '5': 13, '10': 'age'},
    const {'1': 'cases', '3': 4, '4': 3, '5': 11, '6': '.pdelta_tests.Person.CasesEntry', '10': 'cases'},
    const {'1': 'company', '3': 5, '4': 1, '5': 11, '6': '.pdelta_tests.Company', '10': 'company'},
    const {'1': 'alias', '3': 6, '4': 3, '5': 9, '10': 'alias'},
    const {'1': 'type', '3': 7, '4': 1, '5': 14, '6': '.pdelta_tests.Person.Type', '10': 'type'},
    const {'1': 'typeList', '3': 8, '4': 3, '5': 14, '6': '.pdelta_tests.Person.Type', '10': 'typeList'},
    const {'1': 'typeMap', '3': 9, '4': 3, '5': 11, '6': '.pdelta_tests.Person.TypeMapEntry', '10': 'typeMap'},
    const {'1': 'embedded', '3': 10, '4': 1, '5': 11, '6': '.pdelta_tests.Person.Embed', '10': 'embedded'},
    const {'1': 'str', '3': 11, '4': 1, '5': 9, '9': 0, '10': 'str'},
    const {'1': 'dbl', '3': 12, '4': 1, '5': 1, '9': 0, '10': 'dbl'},
    const {'1': 'itm', '3': 13, '4': 1, '5': 11, '6': '.pdelta_tests.Item', '9': 0, '10': 'itm'},
    const {'1': 'cas', '3': 14, '4': 1, '5': 11, '6': '.pdelta_tests.Case', '9': 0, '10': 'cas'},
    const {'1': 'cho', '3': 15, '4': 1, '5': 11, '6': '.pdelta_tests.Chooser', '9': 0, '10': 'cho'},
    const {'1': 'house', '3': 16, '4': 1, '5': 11, '6': '.pdelta_tests.House', '10': 'house'},
    const {'1': 'shirt', '3': 17, '4': 1, '5': 11, '6': '.pdelta_tests_clothes.Shirt', '10': 'shirt'},
    const {'1': 'pants', '3': 18, '4': 1, '5': 11, '6': '.pants.Pants', '10': 'pants'},
    const {'1': 'double', '3': 19, '4': 1, '5': 11, '6': '.pdelta_tests.Person.Embed.Double', '10': 'double'},
    const {'1': 'sink', '3': 20, '4': 1, '5': 11, '6': '.pdelta_tests.Sink', '10': 'sink'},
  ],
  '3': const [Person_Embed$json, Person_CasesEntry$json, Person_TypeMapEntry$json],
  '4': const [Person_Type$json],
  '8': const [
    const {'1': 'choice'},
  ],
};

@$core.Deprecated('Use personDescriptor instead')
const Person_Embed$json = const {
  '1': 'Embed',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
  '3': const [Person_Embed_Double$json],
};

@$core.Deprecated('Use personDescriptor instead')
const Person_Embed_Double$json = const {
  '1': 'Double',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'bar', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'bar'},
    const {'1': 'baz', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'baz'},
  ],
  '8': const [
    const {'1': 'foo'},
  ],
};

@$core.Deprecated('Use personDescriptor instead')
const Person_CasesEntry$json = const {
  '1': 'CasesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.pdelta_tests.Case', '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use personDescriptor instead')
const Person_TypeMapEntry$json = const {
  '1': 'TypeMapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 14, '6': '.pdelta_tests.Person.Type', '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use personDescriptor instead')
const Person_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'Null', '2': 0},
    const {'1': 'Alpha', '2': 1},
    const {'1': 'Bravo', '2': 2},
    const {'1': 'Charlie', '2': 3},
  ],
};

/// Descriptor for `Person`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List personDescriptor = $convert.base64Decode('CgZQZXJzb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIQCgNhZ2UYAiABKA1SA2FnZRI1CgVjYXNlcxgEIAMoCzIfLnBkZWx0YV90ZXN0cy5QZXJzb24uQ2FzZXNFbnRyeVIFY2FzZXMSLwoHY29tcGFueRgFIAEoCzIVLnBkZWx0YV90ZXN0cy5Db21wYW55Ugdjb21wYW55EhQKBWFsaWFzGAYgAygJUgVhbGlhcxItCgR0eXBlGAcgASgOMhkucGRlbHRhX3Rlc3RzLlBlcnNvbi5UeXBlUgR0eXBlEjUKCHR5cGVMaXN0GAggAygOMhkucGRlbHRhX3Rlc3RzLlBlcnNvbi5UeXBlUgh0eXBlTGlzdBI7Cgd0eXBlTWFwGAkgAygLMiEucGRlbHRhX3Rlc3RzLlBlcnNvbi5UeXBlTWFwRW50cnlSB3R5cGVNYXASNgoIZW1iZWRkZWQYCiABKAsyGi5wZGVsdGFfdGVzdHMuUGVyc29uLkVtYmVkUghlbWJlZGRlZBISCgNzdHIYCyABKAlIAFIDc3RyEhIKA2RibBgMIAEoAUgAUgNkYmwSJgoDaXRtGA0gASgLMhIucGRlbHRhX3Rlc3RzLkl0ZW1IAFIDaXRtEiYKA2NhcxgOIAEoCzISLnBkZWx0YV90ZXN0cy5DYXNlSABSA2NhcxIpCgNjaG8YDyABKAsyFS5wZGVsdGFfdGVzdHMuQ2hvb3NlckgAUgNjaG8SKQoFaG91c2UYECABKAsyEy5wZGVsdGFfdGVzdHMuSG91c2VSBWhvdXNlEjEKBXNoaXJ0GBEgASgLMhsucGRlbHRhX3Rlc3RzX2Nsb3RoZXMuU2hpcnRSBXNoaXJ0EiIKBXBhbnRzGBIgASgLMgwucGFudHMuUGFudHNSBXBhbnRzEjkKBmRvdWJsZRgTIAEoCzIhLnBkZWx0YV90ZXN0cy5QZXJzb24uRW1iZWQuRG91YmxlUgZkb3VibGUSJgoEc2luaxgUIAEoCzISLnBkZWx0YV90ZXN0cy5TaW5rUgRzaW5rGmgKBUVtYmVkEhIKBG5hbWUYASABKAlSBG5hbWUaSwoGRG91YmxlEhIKBG5hbWUYASABKAlSBG5hbWUSEgoDYmFyGAIgASgJSABSA2JhchISCgNiYXoYAyABKANIAFIDYmF6QgUKA2ZvbxpMCgpDYXNlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EigKBXZhbHVlGAIgASgLMhIucGRlbHRhX3Rlc3RzLkNhc2VSBXZhbHVlOgI4ARpVCgxUeXBlTWFwRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSLwoFdmFsdWUYAiABKA4yGS5wZGVsdGFfdGVzdHMuUGVyc29uLlR5cGVSBXZhbHVlOgI4ASIzCgRUeXBlEggKBE51bGwQABIJCgVBbHBoYRABEgkKBUJyYXZvEAISCwoHQ2hhcmxpZRADQggKBmNob2ljZQ==');
@$core.Deprecated('Use sinkDescriptor instead')
const Sink$json = const {
  '1': 'Sink',
  '2': const [
    const {'1': 'blob', '3': 1, '4': 1, '5': 12, '10': 'blob'},
    const {'1': 'sint', '3': 2, '4': 1, '5': 17, '10': 'sint'},
    const {'1': 'sfixed', '3': 3, '4': 1, '5': 16, '10': 'sfixed'},
    const {'1': 'fixed', '3': 4, '4': 1, '5': 7, '10': 'fixed'},
    const {'1': 'ulong', '3': 5, '4': 1, '5': 4, '10': 'ulong'},
    const {'1': 'boolMap', '3': 6, '4': 3, '5': 11, '6': '.pdelta_tests.Sink.BoolMapEntry', '10': 'boolMap'},
    const {'1': 'uintMap', '3': 7, '4': 3, '5': 11, '6': '.pdelta_tests.Sink.UintMapEntry', '10': 'uintMap'},
    const {'1': 'dblList', '3': 8, '4': 3, '5': 1, '10': 'dblList'},
    const {'1': 'boolList', '3': 9, '4': 3, '5': 8, '10': 'boolList'},
  ],
  '3': const [Sink_BoolMapEntry$json, Sink_UintMapEntry$json],
};

@$core.Deprecated('Use sinkDescriptor instead')
const Sink_BoolMapEntry$json = const {
  '1': 'BoolMapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 8, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use sinkDescriptor instead')
const Sink_UintMapEntry$json = const {
  '1': 'UintMapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.pdelta_tests.Item', '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Sink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sinkDescriptor = $convert.base64Decode('CgRTaW5rEhIKBGJsb2IYASABKAxSBGJsb2ISEgoEc2ludBgCIAEoEVIEc2ludBIWCgZzZml4ZWQYAyABKBBSBnNmaXhlZBIUCgVmaXhlZBgEIAEoB1IFZml4ZWQSFAoFdWxvbmcYBSABKARSBXVsb25nEjkKB2Jvb2xNYXAYBiADKAsyHy5wZGVsdGFfdGVzdHMuU2luay5Cb29sTWFwRW50cnlSB2Jvb2xNYXASOQoHdWludE1hcBgHIAMoCzIfLnBkZWx0YV90ZXN0cy5TaW5rLlVpbnRNYXBFbnRyeVIHdWludE1hcBIYCgdkYmxMaXN0GAggAygBUgdkYmxMaXN0EhoKCGJvb2xMaXN0GAkgAygIUghib29sTGlzdBo6CgxCb29sTWFwRW50cnkSEAoDa2V5GAEgASgIUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARpOCgxVaW50TWFwRW50cnkSEAoDa2V5GAEgASgNUgNrZXkSKAoFdmFsdWUYAiABKAsyEi5wZGVsdGFfdGVzdHMuSXRlbVIFdmFsdWU6AjgB');
@$core.Deprecated('Use companyDescriptor instead')
const Company$json = const {
  '1': 'Company',
  '2': const [
    const {'1': 'name', '3': 11, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'revenue', '3': 12, '4': 1, '5': 2, '10': 'revenue'},
    const {'1': 'flags', '3': 13, '4': 3, '5': 11, '6': '.pdelta_tests.Company.FlagsEntry', '10': 'flags'},
    const {'1': 'ceo', '3': 14, '4': 1, '5': 11, '6': '.pdelta_tests.Person', '10': 'ceo'},
  ],
  '3': const [Company_FlagsEntry$json],
};

@$core.Deprecated('Use companyDescriptor instead')
const Company_FlagsEntry$json = const {
  '1': 'FlagsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Company`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List companyDescriptor = $convert.base64Decode('CgdDb21wYW55EhIKBG5hbWUYCyABKAlSBG5hbWUSGAoHcmV2ZW51ZRgMIAEoAlIHcmV2ZW51ZRI2CgVmbGFncxgNIAMoCzIgLnBkZWx0YV90ZXN0cy5Db21wYW55LkZsYWdzRW50cnlSBWZsYWdzEiYKA2NlbxgOIAEoCzIULnBkZWx0YV90ZXN0cy5QZXJzb25SA2Nlbxo4CgpGbGFnc0VudHJ5EhAKA2tleRgBIAEoA1IDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use caseDescriptor instead')
const Case$json = const {
  '1': 'Case',
  '2': const [
    const {'1': 'name', '3': 21, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'items', '3': 22, '4': 3, '5': 11, '6': '.pdelta_tests.Item', '10': 'items'},
    const {'1': 'flags', '3': 23, '4': 3, '5': 11, '6': '.pdelta_tests.Case.FlagsEntry', '10': 'flags'},
  ],
  '3': const [Case_FlagsEntry$json],
};

@$core.Deprecated('Use caseDescriptor instead')
const Case_FlagsEntry$json = const {
  '1': 'FlagsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Case`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List caseDescriptor = $convert.base64Decode('CgRDYXNlEhIKBG5hbWUYFSABKAlSBG5hbWUSKAoFaXRlbXMYFiADKAsyEi5wZGVsdGFfdGVzdHMuSXRlbVIFaXRlbXMSMwoFZmxhZ3MYFyADKAsyHS5wZGVsdGFfdGVzdHMuQ2FzZS5GbGFnc0VudHJ5UgVmbGFncxo4CgpGbGFnc0VudHJ5EhAKA2tleRgBIAEoA1IDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use itemDescriptor instead')
const Item$json = const {
  '1': 'Item',
  '2': const [
    const {'1': 'title', '3': 31, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'done', '3': 34, '4': 1, '5': 8, '10': 'done'},
    const {'1': 'flags', '3': 35, '4': 3, '5': 9, '10': 'flags'},
  ],
};

/// Descriptor for `Item`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List itemDescriptor = $convert.base64Decode('CgRJdGVtEhQKBXRpdGxlGB8gASgJUgV0aXRsZRISCgRkb25lGCIgASgIUgRkb25lEhQKBWZsYWdzGCMgAygJUgVmbGFncw==');
@$core.Deprecated('Use chooserDescriptor instead')
const Chooser$json = const {
  '1': 'Chooser',
  '2': const [
    const {'1': 'str', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'str'},
    const {'1': 'dbl', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'dbl'},
    const {'1': 'itm', '3': 3, '4': 1, '5': 11, '6': '.pdelta_tests.Item', '9': 0, '10': 'itm'},
  ],
  '8': const [
    const {'1': 'choice'},
  ],
};

/// Descriptor for `Chooser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chooserDescriptor = $convert.base64Decode('CgdDaG9vc2VyEhIKA3N0chgBIAEoCUgAUgNzdHISEgoDZGJsGAIgASgBSABSA2RibBImCgNpdG0YAyABKAsyEi5wZGVsdGFfdGVzdHMuSXRlbUgAUgNpdG1CCAoGY2hvaWNl');
@$core.Deprecated('Use applyTestCaseDescriptor instead')
const ApplyTestCase$json = const {
  '1': 'ApplyTestCase',
  '2': const [
    const {'1': 'solo', '3': 1, '4': 1, '5': 8, '10': 'solo'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'op', '3': 3, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op'},
    const {'1': 'data', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'data'},
    const {'1': 'expected', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'expected'},
  ],
};

/// Descriptor for `ApplyTestCase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List applyTestCaseDescriptor = $convert.base64Decode('Cg1BcHBseVRlc3RDYXNlEhIKBHNvbG8YASABKAhSBHNvbG8SEgoEbmFtZRgCIAEoCVIEbmFtZRIaCgJvcBgDIAEoCzIKLnBkZWx0YS5PcFICb3ASKAoEZGF0YRgEIAEoCzIULmdvb2dsZS5wcm90b2J1Zi5BbnlSBGRhdGESMAoIZXhwZWN0ZWQYBSABKAsyFC5nb29nbGUucHJvdG9idWYuQW55UghleHBlY3RlZA==');
@$core.Deprecated('Use transformTestCaseDescriptor instead')
const TransformTestCase$json = const {
  '1': 'TransformTestCase',
  '2': const [
    const {'1': 'solo', '3': 1, '4': 1, '5': 8, '10': 'solo'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'op1', '3': 3, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op1'},
    const {'1': 'op2', '3': 4, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op2'},
    const {'1': 'data', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'data'},
    const {'1': 'expected', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'expected'},
    const {'1': 'expected1', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'expected1'},
    const {'1': 'expected2', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'expected2'},
  ],
};

/// Descriptor for `TransformTestCase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transformTestCaseDescriptor = $convert.base64Decode('ChFUcmFuc2Zvcm1UZXN0Q2FzZRISCgRzb2xvGAEgASgIUgRzb2xvEhIKBG5hbWUYAiABKAlSBG5hbWUSHAoDb3AxGAMgASgLMgoucGRlbHRhLk9wUgNvcDESHAoDb3AyGAQgASgLMgoucGRlbHRhLk9wUgNvcDISKAoEZGF0YRgFIAEoCzIULmdvb2dsZS5wcm90b2J1Zi5BbnlSBGRhdGESMAoIZXhwZWN0ZWQYBiABKAsyFC5nb29nbGUucHJvdG9idWYuQW55UghleHBlY3RlZBIyCglleHBlY3RlZDEYByABKAsyFC5nb29nbGUucHJvdG9idWYuQW55UglleHBlY3RlZDESMgoJZXhwZWN0ZWQyGAggASgLMhQuZ29vZ2xlLnByb3RvYnVmLkFueVIJZXhwZWN0ZWQy');
@$core.Deprecated('Use reduceTestCaseDescriptor instead')
const ReduceTestCase$json = const {
  '1': 'ReduceTestCase',
  '2': const [
    const {'1': 'solo', '3': 1, '4': 1, '5': 8, '10': 'solo'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'data', '3': 3, '4': 1, '5': 11, '6': '.pdelta_tests.Person', '10': 'data'},
    const {'1': 'op', '3': 4, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op'},
    const {'1': 'reduced', '3': 5, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'reduced'},
  ],
};

/// Descriptor for `ReduceTestCase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reduceTestCaseDescriptor = $convert.base64Decode('Cg5SZWR1Y2VUZXN0Q2FzZRISCgRzb2xvGAEgASgIUgRzb2xvEhIKBG5hbWUYAiABKAlSBG5hbWUSKAoEZGF0YRgDIAEoCzIULnBkZWx0YV90ZXN0cy5QZXJzb25SBGRhdGESGgoCb3AYBCABKAsyCi5wZGVsdGEuT3BSAm9wEiQKB3JlZHVjZWQYBSABKAsyCi5wZGVsdGEuT3BSB3JlZHVjZWQ=');
@$core.Deprecated('Use shifterTestCaseDescriptor instead')
const ShifterTestCase$json = const {
  '1': 'ShifterTestCase',
  '2': const [
    const {'1': 'solo', '3': 1, '4': 1, '5': 8, '10': 'solo'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'op', '3': 3, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op'},
    const {'1': 'locations', '3': 4, '4': 3, '5': 3, '10': 'locations'},
    const {'1': 'values', '3': 5, '4': 3, '5': 3, '10': 'values'},
  ],
};

/// Descriptor for `ShifterTestCase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shifterTestCaseDescriptor = $convert.base64Decode('Cg9TaGlmdGVyVGVzdENhc2USEgoEc29sbxgBIAEoCFIEc29sbxISCgRuYW1lGAIgASgJUgRuYW1lEhoKAm9wGAMgASgLMgoucGRlbHRhLk9wUgJvcBIcCglsb2NhdGlvbnMYBCADKANSCWxvY2F0aW9ucxIWCgZ2YWx1ZXMYBSADKANSBnZhbHVlcw==');
