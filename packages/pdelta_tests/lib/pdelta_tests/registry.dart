import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart' as pkg_pdelta_tests_pdelta_tests_pdelta_tests;
import 'package:pdelta_tests/pdelta_tests/house.pb.dart' as pkg_pdelta_tests_pdelta_tests_pdelta_tests;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/shirt.pb.dart' as pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/pants/pants.pb.dart' as pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants;

final types = protobuf.TypeRegistry([
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Case(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Chooser(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Company(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.House(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Item(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person_Embed(),
  pkg_pdelta_tests_pdelta_tests_pdelta_tests.Person_Embed_Double(),
  pkg_pdelta_tests_clothes_pdelta_tests_clothes_pdelta_tests_clothes.Shirt(),
  pkg_pdelta_tests_clothes_pdelta_tests_clothes_pants_pants.Pants(),
]);

