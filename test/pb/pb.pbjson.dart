///
//  Generated code. Do not modify.
//  source: pb.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Person$json = const {
  '1': 'Person',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'age', '3': 2, '4': 1, '5': 13, '10': 'age'},
    const {'1': 'cases', '3': 4, '4': 3, '5': 11, '6': '.tests.Person.CasesEntry', '10': 'cases'},
    const {'1': 'company', '3': 5, '4': 1, '5': 11, '6': '.tests.Company', '10': 'company'},
    const {'1': 'alias', '3': 6, '4': 3, '5': 9, '10': 'alias'},
    const {'1': 'type', '3': 7, '4': 1, '5': 14, '6': '.tests.Person.Type', '10': 'type'},
    const {'1': 'typeList', '3': 8, '4': 3, '5': 14, '6': '.tests.Person.Type', '10': 'typeList'},
    const {'1': 'typeMap', '3': 9, '4': 3, '5': 11, '6': '.tests.Person.TypeMapEntry', '10': 'typeMap'},
    const {'1': 'embedded', '3': 10, '4': 1, '5': 11, '6': '.tests.Person.Embed', '10': 'embedded'},
  ],
  '3': const [Person_Embed$json, Person_CasesEntry$json, Person_TypeMapEntry$json],
  '4': const [Person_Type$json],
};

const Person_Embed$json = const {
  '1': 'Embed',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

const Person_CasesEntry$json = const {
  '1': 'CasesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.tests.Case', '10': 'value'},
  ],
  '7': const {'7': true},
};

const Person_TypeMapEntry$json = const {
  '1': 'TypeMapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 14, '6': '.tests.Person.Type', '10': 'value'},
  ],
  '7': const {'7': true},
};

const Person_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'Alpha', '2': 0},
    const {'1': 'Bravo', '2': 1},
    const {'1': 'Charlie', '2': 2},
  ],
};

const Company$json = const {
  '1': 'Company',
  '2': const [
    const {'1': 'name', '3': 11, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'revenue', '3': 12, '4': 1, '5': 2, '10': 'revenue'},
    const {'1': 'flags', '3': 13, '4': 3, '5': 11, '6': '.tests.Company.FlagsEntry', '10': 'flags'},
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
    const {'1': 'items', '3': 22, '4': 3, '5': 11, '6': '.tests.Item', '10': 'items'},
  ],
};

const Item$json = const {
  '1': 'Item',
  '2': const [
    const {'1': 'title', '3': 31, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'done', '3': 34, '4': 1, '5': 8, '10': 'done'},
    const {'1': 'flags', '3': 35, '4': 3, '5': 9, '10': 'flags'},
  ],
};

const Holder$json = const {
  '1': 'Holder',
  '2': const [
    const {'1': 'numbers', '3': 1, '4': 3, '5': 11, '6': '.tests.Holder.NumbersEntry', '10': 'numbers'},
  ],
  '3': const [Holder_NumbersEntry$json],
};

const Holder_NumbersEntry$json = const {
  '1': 'NumbersEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': const {'7': true},
};

const Embedded$json = const {
  '1': 'Embedded',
  '2': const [
    const {'1': 'embeddedLevel0', '3': 1, '4': 1, '5': 9, '10': 'embeddedLevel0'},
  ],
};

const ScopeLevel1$json = const {
  '1': 'ScopeLevel1',
  '2': const [
    const {'1': 't', '3': 1, '4': 1, '5': 11, '6': '.tests.ScopeLevel1.Embedded', '10': 't'},
  ],
  '3': const [ScopeLevel1_Embedded$json, ScopeLevel1_ScopeLevel2$json],
};

const ScopeLevel1_Embedded$json = const {
  '1': 'Embedded',
  '2': const [
    const {'1': 'embeddedLevel1', '3': 1, '4': 1, '5': 9, '10': 'embeddedLevel1'},
  ],
};

const ScopeLevel1_ScopeLevel2$json = const {
  '1': 'ScopeLevel2',
  '2': const [
    const {'1': 't', '3': 1, '4': 1, '5': 11, '6': '.tests.ScopeLevel1.ScopeLevel2.Embedded', '10': 't'},
  ],
  '3': const [ScopeLevel1_ScopeLevel2_Embedded$json, ScopeLevel1_ScopeLevel2_ScopeLevel3$json],
};

const ScopeLevel1_ScopeLevel2_Embedded$json = const {
  '1': 'Embedded',
  '2': const [
    const {'1': 'embeddedLevel2', '3': 1, '4': 1, '5': 9, '10': 'embeddedLevel2'},
  ],
};

const ScopeLevel1_ScopeLevel2_ScopeLevel3$json = const {
  '1': 'ScopeLevel3',
  '2': const [
    const {'1': 't', '3': 1, '4': 1, '5': 11, '6': '.tests.ScopeLevel1.ScopeLevel2.Embedded', '10': 't'},
  ],
};

