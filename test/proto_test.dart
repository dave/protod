import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart';

import 'pb/pb.pb.dart';

setMapByField(GeneratedMessage message, int field, dynamic key, dynamic value) {
  var map = message.getField(field) as PbMap;
  map[key] = value;
}

void main() {
  // this test passes:
  test("empty map", () {
    var holder = Holder()
      ..numbers.clear(); // holder.numbers map is initialised but empty
    setMapByField(holder, 1, "a", 1);
    expect(holder.numbers["a"], 1);
  });

  // this test fails:
  test("null map", () {
    var holder = Holder(); // holder.numbers map is not initialised
    setMapByField(holder, 1, "a", 1);
    expect(holder.numbers["a"], 1);
  });
}
