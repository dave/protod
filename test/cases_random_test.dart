import 'dart:convert';

import 'package:protod/delta/delta.dart' as delta;
import 'package:test/test.dart';

import 'cases_transform_test.dart';
import 'pb/registry.dart' as registry;
import 'pb/tests.pb.dart';
import 'random_cases.dart';

void main() {
//  test("single", () {
//    delta.setDefaultRegistry(registry.types);
//    const personJson =
//        '{"name":"SAINF","cases":{},"company":{"ceo":{"cases":{"DMQRp":{"flags":{"901":"3xK1Q"}}},"company":{"name":"ymQg2","revenue":-616.0,"flags":{"862":"JcdAg"},"ceo":{"age":772,"cases":{"YVsiL":{"name":"JlE39","flags":{"9":"Nwp5A"}}},"company":{"name":"GDtu8","revenue":677.0,"ceo":{"company":{"flags":{"-116":"rlPbi"},"ceo":{"typeList":["Bravo","Null"]}},"alias":["hoTeL"],"type":"Bravo","typeList":["Charlie","Alpha"],"typeMap":{"zmjyu":"Alpha"}}},"type":"Charlie","typeMap":{}}},"type":"Bravo","typeMap":{"3YRD9":"Charlie"},"embedded":{}}},"type":"Charlie","typeMap":{"JiP9j":"Charlie"},"embedded":{"name":"UzgX7"}}';
//    const opJson =
//        '{"type":"Set","location":[{"field":{"name":"type","number":7}}],"scalar":{"enum":0}}';
//    //{"name":"SAINF","company":{"ceo":{"cases":{"DMQRp":{"flags":{"901":"3xK1Q"}}},"company":{"name":"ymQg2","revenue":-616.0,"flags":{"862":"JcdAg"},"ceo":{"age":772,"cases":{"YVsiL":{"name":"JlE39","flags":{"9":"Nwp5A"}}},"company":{"name":"GDtu8","revenue":677.0,"ceo":{"company":{"flags":{"-116":"rlPbi"},"ceo":{"typeList":["Bravo","Null"]}},"alias":["hoTeL"],"type":"Bravo","typeList":["Charlie","Alpha"],"typeMap":{"zmjyu":"Alpha"}}},"type":"Charlie"}},"type":"Bravo","typeMap":{"3YRD9":"Charlie"},"embedded":{}}},"typeMap":{"JiP9j":"Charlie"},"embedded":{"name":"UzgX7"}}
//    var p = Person();
//    var op = Op();
//    p.mergeFromProto3Json(jsonDecode(personJson), typeRegistry: registry.types);
//    op.mergeFromProto3Json(jsonDecode(opJson), typeRegistry: registry.types);
//    delta.apply(op, p);
//  });
  test("random test", () {
    delta.setDefaultRegistry(registry.types);
    final cases = RANDOM_CASES.split("\n").map((str) {
      var a = RandomTestItem();
      a.mergeFromProto3Json(jsonDecode(str), typeRegistry: registry.types);
      return a;
    });
    var p = Person()..name = "a";
    cases.forEach((RandomTestItem info) {
//      print("before: " +
//          jsonEncode(p.toProto3Json(typeRegistry: registry.types)));
//      print("op    : " +
//          jsonEncode(info.op.toProto3Json(typeRegistry: registry.types)));
//      print("expect: " +
//          jsonEncode(info.expected.toProto3Json(typeRegistry: registry.types)));
      delta.apply(info.op, p);
      expect(toObject(p), toObject(info.expected));
    });
  });
}
