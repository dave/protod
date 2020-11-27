///
//  Generated code. Do not modify.
//  source: pdelta_tests/tests.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

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
  ],
  '3': const [Person_Embed$json, Person_CasesEntry$json, Person_TypeMapEntry$json],
  '4': const [Person_Type$json],
  '8': const [
    const {'1': 'choice'},
  ],
};

const Person_Embed$json = const {
  '1': 'Embed',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
  '3': const [Person_Embed_Double$json],
};

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

const Person_CasesEntry$json = const {
  '1': 'CasesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.pdelta_tests.Case', '10': 'value'},
  ],
  '7': const {'7': true},
};

const Person_TypeMapEntry$json = const {
  '1': 'TypeMapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 14, '6': '.pdelta_tests.Person.Type', '10': 'value'},
  ],
  '7': const {'7': true},
};

const Person_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'Null', '2': 0},
    const {'1': 'Alpha', '2': 1},
    const {'1': 'Bravo', '2': 2},
    const {'1': 'Charlie', '2': 3},
  ],
};

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

const Company_FlagsEntry$json = const {
  '1': 'FlagsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

const Case$json = const {
  '1': 'Case',
  '2': const [
    const {'1': 'name', '3': 21, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'items', '3': 22, '4': 3, '5': 11, '6': '.pdelta_tests.Item', '10': 'items'},
    const {'1': 'flags', '3': 23, '4': 3, '5': 11, '6': '.pdelta_tests.Case.FlagsEntry', '10': 'flags'},
  ],
  '3': const [Case_FlagsEntry$json],
};

const Case_FlagsEntry$json = const {
  '1': 'FlagsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

const Item$json = const {
  '1': 'Item',
  '2': const [
    const {'1': 'title', '3': 31, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'done', '3': 34, '4': 1, '5': 8, '10': 'done'},
    const {'1': 'flags', '3': 35, '4': 3, '5': 9, '10': 'flags'},
  ],
};

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

const ReduceTestCase$json = const {
  '1': 'ReduceTestCase',
  '2': const [
    const {'1': 'solo', '3': 1, '4': 1, '5': 8, '10': 'solo'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'data', '3': 3, '4': 1, '5': 11, '6': '.pdelta_tests.Person', '10': 'data'},
    const {'1': 'op1', '3': 4, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op1'},
    const {'1': 'op2', '3': 5, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'op2'},
    const {'1': 'reduced', '3': 6, '4': 1, '5': 11, '6': '.pdelta.Op', '10': 'reduced'},
  ],
};

