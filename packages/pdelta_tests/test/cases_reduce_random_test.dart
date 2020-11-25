import 'dart:convert';
import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart';
import 'package:pdelta/pdelta/pdelta_reduce.dart';
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:test/test.dart';

import 'cases_transform_test.dart';
import 'helpers.dart';

void main() {
  init();
  test("reduce_random_test", () async {
    //final lines = ['{"name":"nominally-right-drum","data":{"name":"Vzw22","age":927,"cases":{"0CmB2":{},"tDN4m":{}},"company":{"name":"LCtBo","revenue":-816,"flags":{"-21":"M8Cay","383":"x1gDU","978":"Cj55R"},"ceo":{"name":"FhuuU","age":1019,"cases":{"5Fi3e":{"items":[{}],"flags":{"582":"MKAAz"}}},"company":{},"alias":["XnBlQ","HHnav"],"type":"Charlie","typeList":["Charlie","Alpha"],"typeMap":{"faMlY":"Charlie"},"dbl":-264,"shirt":{},"pants":{"style":"ErhWq","length":619,"waist":88},"double":{"name":"5ooIi","baz":"-567"}}},"alias":["G2Mbp","eN0dD","H8oOJ"],"type":"Bravo","typeList":["Bravo","Charlie","Bravo","Alpha","Charlie"],"itm":{"flags":["3vm6d"]},"house":{"name":"qoK4Q","number":1019},"shirt":{},"pants":{"style":"CWIur","length":186},"double":{"name":"1BS2H"}},"op1":{"type":"Insert","location":[{"field":{"name":"cases","number":4,"messageFullName":"pdelta_tests.Person"}},{"key":{"string":"tDN4m"}},{"field":{"name":"items","number":22,"messageFullName":"pdelta_tests.Case"}},{"index":"0"}],"message":{"@type":"type.googleapis.com/pdelta_tests.Item"}},"op2":{"type":"Set","location":[{"field":{"name":"cases","number":4,"messageFullName":"pdelta_tests.Person"}},{"key":{"string":"tDN4m"}},{"field":{"name":"items","number":22,"messageFullName":"pdelta_tests.Case"}},{"index":"0"}],"message":{"@type":"type.googleapis.com/pdelta_tests.Item","title":"Ym8ut","done":true}},"reduced":{"type":"Insert","location":[{"field":{"name":"cases","number":4,"messageFullName":"pdelta_tests.Person"}},{"key":{"string":"tDN4m"}},{"field":{"name":"items","number":22,"messageFullName":"pdelta_tests.Case"}},{"index":"0"}],"message":{"@type":"type.googleapis.com/pdelta_tests.Item","title":"Ym8ut","done":true}}},'];
    final lines = await File(assetPath("cases_reduce_random.json")).readAsLines();
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
      var info = ReduceTestItem();
      info.mergeFromProto3Json(jsonDecode(str), typeRegistry: typeRegistry);
      try {
        final data1 = info.data.clone();
        final data2 = info.data.clone();
        final compoundOp = compound([info.op1, info.op2]);
        final opMerged = reduce(compoundOp);
        expect(toObject(opMerged), toObject(info.reduced), reason: info.name);
        apply(info.op1, data1);
        apply(info.op2, data1);
        apply(opMerged, data2);
        expect(toObject(data1), toObject(data2), reason: info.name);
      } catch (ex) {
        print(info.name);
        throw ex;
      }
    });
  });

}
