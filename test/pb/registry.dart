import 'package:protobuf/protobuf.dart';
import 'pb.pb.dart' as tests;

final types = TypeRegistry([
  tests.Person(),
  tests.Company(),
  tests.Case(),
  tests.Item(),
]);

