///
//  Generated code. Do not modify.
//  source: delta/delta.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Op$json = const {
  '1': 'Op',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.delta.Op.Type', '10': 'type'},
    const {'1': 'location', '3': 2, '4': 3, '5': 11, '6': '.delta.Locator', '10': 'location'},
    const {'1': 'ops', '3': 3, '4': 3, '5': 11, '6': '.delta.Op', '10': 'ops'},
    const {'1': 'scalar', '3': 4, '4': 1, '5': 11, '6': '.delta.Scalar', '9': 0, '10': 'scalar'},
    const {'1': 'message', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Any', '9': 0, '10': 'message'},
    const {'1': 'object', '3': 7, '4': 1, '5': 11, '6': '.delta.Object', '9': 0, '10': 'object'},
    const {'1': 'delta', '3': 8, '4': 1, '5': 11, '6': '.delta.Delta', '9': 0, '10': 'delta'},
    const {'1': 'index', '3': 9, '4': 1, '5': 3, '9': 0, '10': 'index'},
    const {'1': 'key', '3': 10, '4': 1, '5': 11, '6': '.delta.Key', '9': 0, '10': 'key'},
  ],
  '4': const [Op_Type$json],
  '8': const [
    const {'1': 'value'},
  ],
};

const Op_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'Null', '2': 0},
    const {'1': 'Set', '2': 1},
    const {'1': 'Edit', '2': 2},
    const {'1': 'Insert', '2': 3},
    const {'1': 'Move', '2': 4},
    const {'1': 'Rename', '2': 5},
    const {'1': 'Delete', '2': 6},
    const {'1': 'Compound', '2': 7},
  ],
};

const Locator$json = const {
  '1': 'Locator',
  '2': const [
    const {'1': 'field', '3': 1, '4': 1, '5': 11, '6': '.delta.Field', '9': 0, '10': 'field'},
    const {'1': 'index', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'index'},
    const {'1': 'key', '3': 3, '4': 1, '5': 11, '6': '.delta.Key', '9': 0, '10': 'key'},
    const {'1': 'oneof', '3': 4, '4': 1, '5': 11, '6': '.delta.Oneof', '9': 0, '10': 'oneof'},
  ],
  '8': const [
    const {'1': 'v'},
  ],
};

const Key$json = const {
  '1': 'Key',
  '2': const [
    const {'1': 'bool', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'bool'},
    const {'1': 'int32', '3': 2, '4': 1, '5': 5, '9': 0, '10': 'int32'},
    const {'1': 'int64', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'int64'},
    const {'1': 'uint32', '3': 4, '4': 1, '5': 13, '9': 0, '10': 'uint32'},
    const {'1': 'uint64', '3': 5, '4': 1, '5': 4, '9': 0, '10': 'uint64'},
    const {'1': 'string', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'string'},
  ],
  '8': const [
    const {'1': 'v'},
  ],
};

const Field$json = const {
  '1': 'Field',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'number', '3': 2, '4': 1, '5': 5, '10': 'number'},
  ],
};

const Oneof$json = const {
  '1': 'Oneof',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'fields', '3': 2, '4': 3, '5': 11, '6': '.delta.Field', '10': 'fields'},
  ],
};

const Scalar$json = const {
  '1': 'Scalar',
  '2': const [
    const {'1': 'double', '3': 1, '4': 1, '5': 1, '9': 0, '10': 'double'},
    const {'1': 'float', '3': 2, '4': 1, '5': 2, '9': 0, '10': 'float'},
    const {'1': 'int32', '3': 3, '4': 1, '5': 5, '9': 0, '10': 'int32'},
    const {'1': 'int64', '3': 4, '4': 1, '5': 3, '9': 0, '10': 'int64'},
    const {'1': 'uint32', '3': 5, '4': 1, '5': 13, '9': 0, '10': 'uint32'},
    const {'1': 'uint64', '3': 6, '4': 1, '5': 4, '9': 0, '10': 'uint64'},
    const {'1': 'sint32', '3': 7, '4': 1, '5': 17, '9': 0, '10': 'sint32'},
    const {'1': 'sint64', '3': 8, '4': 1, '5': 18, '9': 0, '10': 'sint64'},
    const {'1': 'fixed32', '3': 9, '4': 1, '5': 7, '9': 0, '10': 'fixed32'},
    const {'1': 'fixed64', '3': 10, '4': 1, '5': 6, '9': 0, '10': 'fixed64'},
    const {'1': 'sfixed32', '3': 11, '4': 1, '5': 15, '9': 0, '10': 'sfixed32'},
    const {'1': 'sfixed64', '3': 12, '4': 1, '5': 16, '9': 0, '10': 'sfixed64'},
    const {'1': 'bool', '3': 13, '4': 1, '5': 8, '9': 0, '10': 'bool'},
    const {'1': 'string', '3': 14, '4': 1, '5': 9, '9': 0, '10': 'string'},
    const {'1': 'bytes', '3': 15, '4': 1, '5': 12, '9': 0, '10': 'bytes'},
    const {'1': 'enum', '3': 16, '4': 1, '5': 5, '9': 0, '10': 'enum'},
  ],
  '8': const [
    const {'1': 'v'},
  ],
};

const Delta$json = const {
  '1': 'Delta',
  '2': const [
    const {'1': 'quill', '3': 1, '4': 1, '5': 11, '6': '.delta.QuillDelta', '9': 0, '10': 'quill'},
  ],
  '8': const [
    const {'1': 'v'},
  ],
};

const QuillDelta$json = const {
  '1': 'QuillDelta',
  '2': const [
    const {'1': 'ops', '3': 1, '4': 3, '5': 11, '6': '.delta.Quill', '10': 'ops'},
  ],
};

const Quill$json = const {
  '1': 'Quill',
  '2': const [
    const {'1': 'insert', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'insert'},
    const {'1': 'retain', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'retain'},
    const {'1': 'delete', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'delete'},
    const {'1': 'attributes', '3': 4, '4': 1, '5': 11, '6': '.delta.Object', '10': 'attributes'},
  ],
  '8': const [
    const {'1': 'v'},
  ],
};

const Object$json = const {
  '1': 'Object',
  '2': const [
    const {'1': 'scalar', '3': 1, '4': 1, '5': 11, '6': '.delta.Scalar', '9': 0, '10': 'scalar'},
    const {'1': 'message', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any', '9': 0, '10': 'message'},
    const {'1': 'list', '3': 3, '4': 1, '5': 11, '6': '.delta.List', '9': 0, '10': 'list'},
    const {'1': 'mapBool', '3': 4, '4': 1, '5': 11, '6': '.delta.MapBool', '9': 0, '10': 'mapBool'},
    const {'1': 'mapInt32', '3': 5, '4': 1, '5': 11, '6': '.delta.MapInt32', '9': 0, '10': 'mapInt32'},
    const {'1': 'mapInt64', '3': 6, '4': 1, '5': 11, '6': '.delta.MapInt64', '9': 0, '10': 'mapInt64'},
    const {'1': 'mapUint32', '3': 7, '4': 1, '5': 11, '6': '.delta.MapUint32', '9': 0, '10': 'mapUint32'},
    const {'1': 'mapUint64', '3': 8, '4': 1, '5': 11, '6': '.delta.MapUint64', '9': 0, '10': 'mapUint64'},
    const {'1': 'mapString', '3': 9, '4': 1, '5': 11, '6': '.delta.MapString', '9': 0, '10': 'mapString'},
  ],
  '8': const [
    const {'1': 'v'},
  ],
};

const MapBool$json = const {
  '1': 'MapBool',
  '2': const [
    const {'1': 'map', '3': 1, '4': 3, '5': 11, '6': '.delta.MapBool.MapEntry', '10': 'map'},
  ],
  '3': const [MapBool_MapEntry$json],
};

const MapBool_MapEntry$json = const {
  '1': 'MapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 8, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.delta.Object', '10': 'value'},
  ],
  '7': const {'7': true},
};

const MapInt32$json = const {
  '1': 'MapInt32',
  '2': const [
    const {'1': 'map', '3': 1, '4': 3, '5': 11, '6': '.delta.MapInt32.MapEntry', '10': 'map'},
  ],
  '3': const [MapInt32_MapEntry$json],
};

const MapInt32_MapEntry$json = const {
  '1': 'MapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.delta.Object', '10': 'value'},
  ],
  '7': const {'7': true},
};

const MapInt64$json = const {
  '1': 'MapInt64',
  '2': const [
    const {'1': 'map', '3': 1, '4': 3, '5': 11, '6': '.delta.MapInt64.MapEntry', '10': 'map'},
  ],
  '3': const [MapInt64_MapEntry$json],
};

const MapInt64_MapEntry$json = const {
  '1': 'MapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.delta.Object', '10': 'value'},
  ],
  '7': const {'7': true},
};

const MapUint32$json = const {
  '1': 'MapUint32',
  '2': const [
    const {'1': 'map', '3': 1, '4': 3, '5': 11, '6': '.delta.MapUint32.MapEntry', '10': 'map'},
  ],
  '3': const [MapUint32_MapEntry$json],
};

const MapUint32_MapEntry$json = const {
  '1': 'MapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.delta.Object', '10': 'value'},
  ],
  '7': const {'7': true},
};

const MapUint64$json = const {
  '1': 'MapUint64',
  '2': const [
    const {'1': 'map', '3': 1, '4': 3, '5': 11, '6': '.delta.MapUint64.MapEntry', '10': 'map'},
  ],
  '3': const [MapUint64_MapEntry$json],
};

const MapUint64_MapEntry$json = const {
  '1': 'MapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.delta.Object', '10': 'value'},
  ],
  '7': const {'7': true},
};

const MapString$json = const {
  '1': 'MapString',
  '2': const [
    const {'1': 'map', '3': 1, '4': 3, '5': 11, '6': '.delta.MapString.MapEntry', '10': 'map'},
  ],
  '3': const [MapString_MapEntry$json],
};

const MapString_MapEntry$json = const {
  '1': 'MapEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.delta.Object', '10': 'value'},
  ],
  '7': const {'7': true},
};

const List_$json = const {
  '1': 'List',
  '2': const [
    const {'1': 'list', '3': 1, '4': 3, '5': 11, '6': '.delta.Object', '10': 'list'},
  ],
};

