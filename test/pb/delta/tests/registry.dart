import 'package:protobuf/protobuf.dart';
import 'tests.pb.dart' as tests;

final types = TypeRegistry([
  tests.Person(),
  tests.Person_Embed(),
  tests.Company(),
  tests.Case(),
  tests.Item(),
  tests.Chooser(),
]);

