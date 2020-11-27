import 'dart:convert';
import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart';
import 'package:pdelta/pdelta/pdelta_reduce.dart';
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  init();
  test("cases_reduce_manual", () async {
    final lines = await File(assetPath("cases_reduce_manual.json")).readAsLines();
    lines.forEach((String str) {
      if (str.startsWith("[")) {
        str = str.substring(1);
      }
      if (str.endsWith("]")) {
        str = str.substring(0, str.length - 1);
      }
      if (str.endsWith(",")) {
        str = str.substring(0, str.length - 1);
      }
      var info = ReduceTestCase();
      info.mergeFromProto3Json(jsonDecode(str), typeRegistry: typeRegistry);
      try {
        final compoundOp = info.op;
        final opMerged = reduce(compoundOp);
        expect(toObject(opMerged), toObject(info.reduced), reason: info.name);
      } catch (ex) {
        print(info.name);
        throw ex;
      }
    });
  });

}
