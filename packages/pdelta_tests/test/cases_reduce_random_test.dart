import 'dart:convert';
import 'dart:io';

import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:test/test.dart';

import 'pdelta_test.dart';

void main() async {
  init();
  throw Exception("not implemented");
  final cases = (await File(assetPath("cases_reduce_random.json")).readAsLines()).map((String str) {
    if (str.startsWith("[")) {
      str = str.substring(1);
    }
    if (str.endsWith("]")) {
      str = str.substring(0, str.length - 1);
    }
    if (str.endsWith(",")) {
      str = str.substring(0, str.length - 1);
    }
    var a = ReduceTestItem();
    a.mergeFromProto3Json(jsonDecode(str), typeRegistry: typeRegistry);
    return a;
  });
  cases.forEach((ReduceTestItem info) {
    test(info.name, () {
      throw Exception("not implemented");
      // data1 := proto.Clone(item.Data).(*Person)
      // 		data2 := proto.Clone(item.Data).(*Person)
      // 		opMerged := pdelta.Reduce(pdelta.Compound(item.Op1, item.Op2))
      // 		if !compareProto(item.Reduced, opMerged) {
      // 			t.Fatalf("reduce case %v: expected: %v (%v)\nfound: %v (%v)\n", item.Name, item.Reduced.Debug(), mustJsonPretty(item.Reduced), opMerged.Debug(), mustJsonPretty(opMerged))
      // 		}
      // 		if err := pdelta.Apply(item.Op1, data1); err != nil {
      // 			t.Fatalf("reduce case %v: %v", item.Name, err)
      // 		}
      // 		if err := pdelta.Apply(item.Op2, data1); err != nil {
      // 			t.Fatalf("reduce case %v: %v", item.Name, err)
      // 		}
      // 		if err := pdelta.Apply(opMerged, data2); err != nil {
      // 			t.Fatalf("reduce case %v: %v", item.Name, err)
      // 		}
      // 		if !compareProto(data1, data2) {
      // 			t.Fatalf("reduce case %v: op1: %v\nop2: %v\nreduced: %v\ndata: %v\nexpected: %v\nfound: %v\n", item.Name, item.Op1.Debug(), item.Op2.Debug(), opMerged.Debug(), mustJsonPretty(item.Data), mustJsonPretty(data1), mustJsonPretty(data2))
      // 		}
    });
  });
}
