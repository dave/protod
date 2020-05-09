import 'package:protobuf/protobuf.dart';
import 'pb.pb.dart' as pb;

final types = TypeRegistry([
  pb.Company(),
  pb.Case(),
  pb.Person(),
]);

