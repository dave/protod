import 'package:protobuf/protobuf.dart';
import 'pb.pb.dart' as pb;

final types = TypeRegistry([
  pb.Person(),
  pb.Company(),
  pb.Case(),
  pb.Item(),
]);

