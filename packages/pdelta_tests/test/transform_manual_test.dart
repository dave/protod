import 'dart:convert';
import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart' as delta;
import 'package:pdelta/pdelta/pdelta_transform.dart';
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  init();
  test("cases_transform_manual", () async {
    final cases = (await File(assetPath("cases_transform_manual.json")).readAsLines()).map((String str) {
      if (str.startsWith("[")) {
        str = str.substring(1);
      }
      if (str.endsWith("]")) {
        str = str.substring(0, str.length - 1);
      }
      if (str.endsWith(",")) {
        str = str.substring(0, str.length - 1);
      }
      var a = TransformTestCase();
      a.mergeFromProto3Json(jsonDecode(str), typeRegistry: typeRegistry);
      return a;
    });
    final solo = cases.any((info) => info.solo ?? false);
    cases.forEach((TransformTestCase info) {
      if (solo && !(info.solo ?? false)) {
        return;
      }

      var data = delta.unpack(info.data);

      final op2xp1 = transform(info.op1, info.op2, true);
      final op2xp2 = transform(info.op1, info.op2, false);
      final op1xp2 = transform(info.op2, info.op1, true);
      final op1xp1 = transform(info.op2, info.op1, false);

      var data1p1 = data.clone();
      var data1p2 = data.clone();
      var data2p1 = data.clone();
      var data2p2 = data.clone();

      delta.apply(info.op1, data1p1);
      delta.apply(op2xp1, data1p1);

      delta.apply(info.op1, data1p2);
      delta.apply(op2xp2, data1p2);

      delta.apply(info.op2, data2p1);
      delta.apply(op1xp1, data2p1);

      delta.apply(info.op2, data2p2);
      delta.apply(op1xp2, data2p2);

      expect(toObject(data1p1), toObject(data2p1), reason: "data1p1 != data2p1");
      expect(toObject(data1p2), toObject(data2p2), reason: "data1p2 != data2p2");

      if (info.hasExpected()) {
        var expected = delta.unpack(info.expected);
        expect(
          toObject(data1p1),
          toObject(expected),
          reason: "data1p1 != expected",
        );
        expect(
          toObject(data1p2),
          toObject(expected),
          reason: "data1p2 != expected",
        );
      } else {
        var expected1 = delta.unpack(info.expected1);
        var expected2 = delta.unpack(info.expected2);
        expect(
          toObject(data1p1),
          toObject(expected1),
          reason: "data1p1 != expected1",
        );
        expect(
          toObject(data1p2),
          toObject(expected2),
          reason: "data1p2 != expected2",
        );
      }
    });
  });
}
