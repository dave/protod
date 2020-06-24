import 'package:protobuf/protobuf.dart' as protobuf;
import 'tests.pb.dart' as tests;

final types = protobuf.TypeRegistry([
  tests.Person(),
  tests.Person_Embed(),
  tests.Company(),
  tests.Case(),
  tests.Item(),
  tests.Chooser(),
]);

