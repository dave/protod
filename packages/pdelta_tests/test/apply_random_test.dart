import 'dart:convert';
import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart' as delta;
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  init();
  test("cases_apply_random", () async {
    final lines = await File(assetPath("cases_apply_random.json")).readAsLines();
    final cases = lines.map((String str) {
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
      a.mergeFromProto3Json(jsonDecode(str), typeRegistry: typeRegistry);
      return a;
    });
    var p = Person()..name = "a";
    cases.forEach((ApplyTestCase info) {
      delta.apply(info.op, p);
      final expected = delta.unpack(info.expected);
      expect(toObject(p), toObject(expected), reason: info.name);
    });
  });
}
