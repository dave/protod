import 'dart:convert';
import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart' as delta;
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:test/test.dart';

import 'cases_transform_test.dart';
import 'pdelta_test.dart';

void main() {
  init();
  test("random test", () async {
    final cases = (await File(assetPath("cases_apply_random.json")).readAsLines()).map((String str) {
      if (str.startsWith("[")) {
        str = str.substring(1);
      }
      if (str.endsWith("]")) {
        str = str.substring(0, str.length - 1);
      }
      if (str.endsWith(",")) {
        str = str.substring(0, str.length - 1);
      }
      var a = ApplyTestItem();
      a.mergeFromProto3Json(jsonDecode(str), typeRegistry: typeRegistry);
      return a;
    });
    var p = Person()..name = "a";
    cases.forEach((ApplyTestItem info) {
      delta.apply(info.op, p);
      expect(toObject(p), toObject(info.expected), reason: info.name);
    });
  });
}
