import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart';

import 'pb/pb.pb.dart';

setNumber(Holder holder) {
  var map = holder.getField(1) as PbMap;
  Map<String, int> m = {"a": 1};
  map.addAll(m);
}

void main() {
  test("empty map", () {
    var holder = Holder();
    setNumber(holder);
    expect(holder.numbers["a"], 1);
  });
  test("not empty map", () {
    var holder = Holder()..numbers["b"] = 2;
    setNumber(holder);
    expect(holder.numbers["a"], 1);
  });
}
