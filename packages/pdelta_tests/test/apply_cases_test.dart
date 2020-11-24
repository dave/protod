import 'dart:convert';
import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart' as delta;
import 'package:test/test.dart';
import 'package:pdelta_tests/pdelta_tests/registry.dart' as registry;
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';

import 'cases_transform_test.dart';

void main() async {
  delta.setDefaultRegistry(registry.types);
  final cases = (await File("../cases_apply.json").readAsLines()).map((String str) {
    if (str.startsWith("[")) {
      str = str.substring(1);
    }
    if (str.endsWith("]")) {
      str = str.substring(0, str.length - 1);
    }
    if (str.endsWith(",")) {
      str = str.substring(0, str.length - 1);
    }
    var a = ApplyTestCase();
    a.mergeFromProto3Json(jsonDecode(str), typeRegistry: registry.types);
    return a;
  });
  final solo = cases.any((info) => info.solo ?? false);
  cases.forEach((ApplyTestCase info) {
    if (solo && !(info.solo ?? false)) {
      return;
    }
    test(info.name, () {
      print(info.name);
      var data = delta.unpack(info.data);
      var expected = delta.unpack(info.expected);
      delta.apply(info.op, data);
      expect(toObject(data), toObject(expected));
    });
  });
}
