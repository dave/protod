///
//  Generated code. Do not modify.
//  source: pb.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Company$json = const {
  '1': 'Company',
  '2': const [
    const {'1': 'name', '3': 11, '4': 1, '5': 9, '10': 'name'},
  ],
};

const Case$json = const {
  '1': 'Case',
  '2': const [
    const {'1': 'name', '3': 12, '4': 1, '5': 9, '10': 'name'},
  ],
};

const Person$json = const {
  '1': 'Person',
  '2': const [
    const {'1': 'name', '3': 13, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'age', '3': 14, '4': 1, '5': 13, '10': 'age'},
    const {'1': 'cases', '3': 15, '4': 3, '5': 11, '6': '.tests.Case', '10': 'cases'},
    const {'1': 'casesStringMap', '3': 16, '4': 3, '5': 11, '6': '.tests.Person.CasesStringMapEntry', '10': 'casesStringMap'},
    const {'1': 'casesIntMap', '3': 17, '4': 3, '5': 11, '6': '.tests.Person.CasesIntMapEntry', '10': 'casesIntMap'},
    const {'1': 'company', '3': 18, '4': 1, '5': 11, '6': '.tests.Company', '10': 'company'},
  ],
  '3': const [Person_CasesStringMapEntry$json, Person_CasesIntMapEntry$json],
};

const Person_CasesStringMapEntry$json = const {
  '1': 'CasesStringMapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.tests.Case', '10': 'value'},
  ],
  '7': const {'7': true},
};

const Person_CasesIntMapEntry$json = const {
  '1': 'CasesIntMapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.tests.Case', '10': 'value'},
  ],
  '7': const {'7': true},
};

