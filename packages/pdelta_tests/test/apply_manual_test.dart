import 'dart:convert';
import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart' as delta;
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  init();
  test("cases_apply_manual", () async {
    final cases = (await File(assetPath("cases_apply_manual.json")).readAsLines()).map((String str) {
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
    final solo = cases.any((info) => info.solo ?? false);
    cases.forEach((ApplyTestCase info) {
      if (solo && !(info.solo ?? false)) {
        return;
      }
      var data = delta.unpack(info.data);
      var expected = delta.unpack(info.expected);
      delta.apply(info.op, data);
      expect(toObject(data), toObject(expected), reason: info.name);
    });
  });
}