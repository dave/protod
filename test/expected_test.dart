import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protod/delta/delta.dart' as delta;
import 'package:protod/delta/delta.pb.dart' as pb;
import 'package:test/test.dart';

import 'cases_transform_test.dart';
import 'expected_cases.dart';
import 'pb/registry.dart' as registry;
import 'pb/tests.op.dart';
import 'pb/tests.pb.dart';

void main() {
  test("TestTransformEditEditIndex", () {
    delta.setDefaultRegistry(registry.types);
    final listD = ["a", "b", "c", "d"];
    final listI = ["0", "1", "2", "3"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var editA = 0; editA < listI.length; editA++) {
      for (var editB = 0; editB < listI.length; editB++) {
        final opA = op.person.alias.index(editA).edit(listD[editA], "X");
        final opB = op.person.alias.index(editB).edit(listD[editB], "Y");
        final descA = "edit$editA";
        final descB = "edit$editB";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        ;
      }
    }
    compareResults(result, expectedTestTransformEditEditIndex);
    ;
  });

  // EditSetIndex
  test("TestTransformEditSetIndex", () {
    final listD = ["a", "b", "c", "d"];
    final listI = ["0", "1", "2", "3"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var edit = 0; edit < listI.length; edit++) {
      for (var set = 0; set < listI.length; set++) {
        final opA = op.person.alias.index(edit).edit(listD[edit], "X");
        final opB = op.person.alias.index(set).set("Y");
        final descA = "edit$edit";
        final descB = "set$set";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformEditSetIndex);
  });

  // EditDeleteIndex
  test("TestTransformEditDeleteIndex", () {
    final listD = ["a", "b", "c", "d"];
    final listX = ["0", "1", "2", "3"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var edit = 0; edit < listX.length; edit++) {
      for (var del = 0; del < listX.length; del++) {
        final opA = op.person.alias.index(edit).edit(listD[edit], "X");
        final opB = op.person.alias.index(del).delete();
        final descA = "edit$edit";
        final descB = "del$del";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformEditDeleteIndex);
  });

  // SetSetIndex
  test("TestTransformSetSetIndex", () {
    final listD = ["a", "b", "c", "d"];
    final listX = ["0", "1", "2", "3"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var setA = 0; setA < listX.length; setA++) {
      for (var setB = 0; setB < listX.length; setB++) {
        final opA = op.person.alias.index(setA).set("X");
        final opB = op.person.alias.index(setB).set("Y");
        final descA = "set$setA";
        final descB = "set$setB";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
      }
    }
    compareResults(result, expectedTestTransformSetSetIndex);
  });

  // EditInsert
  test("TestTransformEditInsert", () {
    final listD = ["a", "b", "c", "d"];
    final listE = ["0", "1", "2", "3"];
    final listI = ["0", "1", "2", "3", "4"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var edit = 0; edit < listE.length; edit++) {
      for (var ins = 0; ins < listI.length; ins++) {
        final opA = op.person.alias.index(edit).edit(listD[edit], "X");
        final opB = op.person.alias.insert(ins, "Y");
        final descA = "edit$edit";
        final descB = "ins$ins";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformEditInsert);
  });

  // SetInsert
  test("TestTransformSetInsert", () {
    final listD = ["a", "b", "c", "d"];
    final listX = ["0", "1", "2", "3"];
    final listI = ["0", "1", "2", "3", "4"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var set = 0; set < listX.length; set++) {
      for (var ins = 0; ins < listI.length; ins++) {
        final opA = op.person.alias.index(set).set("X");
        final opB = op.person.alias.insert(ins, "Y");
        final descA = "set$set";
        final descB = "ins$ins";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformSetInsert);
  });

  // SetDeleteIndex
  test("TestTransformSetDeleteIndex", () {
    final listD = ["a", "b", "c", "d"];
    final listX = ["0", "1", "2", "3"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var set = 0; set < listX.length; set++) {
      for (var del = 0; del < listX.length; del++) {
        final opA = op.person.alias.index(set).set("X");
        final opB = op.person.alias.index(del).delete();
        final descA = "set$set";
        final descB = "del$del";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformSetDeleteIndex);
  });

  // InsertDelete
  test("TestTransformInsertDelete", () {
    final listD = ["a", "b", "c", "d"];
    final listX = ["0", "1", "2", "3"];
    final listI = ["0", "1", "2", "3", "4"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var ins = 0; ins < listI.length; ins++) {
      for (var del = 0; del < listX.length; del++) {
        final opA = op.person.alias.insert(ins, "X");
        final opB = op.person.alias.index(del).delete();
        final descA = "ins$ins";
        final descB = "del$del";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformInsertDelete);
  });

  // DeleteDeleteIndex
  test("TestTransformDeleteDeleteIndex", () {
    final listD = ["a", "b", "c", "d"];
    final listX = ["0", "1", "2", "3"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var delA = 0; delA < listX.length; delA++) {
      for (var delB = 0; delB < listX.length; delB++) {
        final opA = op.person.alias.index(delA).delete();
        final opB = op.person.alias.index(delB).delete();
        final descA = "del$delA";
        final descB = "del$delB";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
      }
    }
    compareResults(result, expectedTestTransformDeleteDeleteIndex);
  });

  // MoveMove
  test("TestTransformMoveMove", () {
    final listD = ["a", "b", "c", "d", "e", "f", "g"];
    final listT = ["0", "1", "2", "3", "4", "5", "6", "7"];
    final listF = ["0", "1", "2", "3", "4", "5", "6"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var fromA = 0; fromA < listF.length; fromA++) {
      for (var toA = 0; toA < listT.length; toA++) {
        for (var fromB = 0; fromB < listF.length; fromB++) {
          for (var toB = 0; toB < listT.length; toB++) {
            final opA = op.person.alias.move(fromA, toA);
            final opB = op.person.alias.move(fromB, toB);
            final descA = "$fromA->$toA";
            final descB = "$fromB->$toB";
            result += testTwoOpsConverge(opA, opB, descA, descB, data);
          }
        }
      }
    }
    compareResults(result, expectedTestTransformMoveMove);
  });

  // MoveInsert
  test("TestTransformMoveInsert", () {
    final listD = ["a", "b", "c", "d", "e"];
    final listT = ["0", "1", "2", "3", "4", "5"];
    final listF = ["0", "1", "2", "3", "4"];
    final listI = ["0", "1", "2", "3", "4", "5"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var from = 0; from < listF.length; from++) {
      for (var to = 0; to < listT.length; to++) {
        for (var ins = 0; ins < listI.length; ins++) {
          final opA = op.person.alias.move(from, to);
          final opB = op.person.alias.insert(ins, "X");
          final descA = "$from->$to";
          final descB = "ins$ins";
          result += testTwoOpsConverge(opA, opB, descA, descB, data);
          result += testTwoOpsConverge(opB, opA, descB, descA, data);
        }
      }
    }
    compareResults(result, expectedTestTransformMoveInsert);
  });

  // InsertInsert
  test("TestTransformInsertInsert", () {
    final listD = ["a", "b", "c", "d"];
    final listI = ["0", "1", "2", "3", "4"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var insA = 0; insA < listI.length; insA++) {
      for (var insB = 0; insB < listI.length; insB++) {
        final opA = op.person.alias.insert(insA, "X");
        final opB = op.person.alias.insert(insB, "Y");
        final descA = "ins$insA";
        final descB = "ins$insB";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
      }
    }
    compareResults(result, expectedTestTransformInsertInsert);
  });

  // MoveDelete
  test("TestTransformMoveDelete", () {
    final listD = ["a", "b", "c", "d", "e", "f", "g"];
    final listT = ["0", "1", "2", "3", "4", "5", "6", "7"];
    final listF = ["0", "1", "2", "3", "4", "5", "6"];
    final listX = ["0", "1", "2", "3", "4", "5", "6"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var from = 0; from < listF.length; from++) {
      for (var to = 0; to < listT.length; to++) {
        for (var del = 0; del < listX.length; del++) {
          final opA = op.person.alias.index(del).delete();
          final opB = op.person.alias.move(from, to);
          final descA = "del$del";
          final descB = "$from->$to";
          result += testTwoOpsConverge(opA, opB, descA, descB, data);
          result += testTwoOpsConverge(opB, opA, descB, descA, data);
        }
      }
    }
    compareResults(result, expectedTestTransformMoveDelete);
  });

  // SetMove
  test("TestTransformMoveSet", () {
    final listD = ["a", "b", "c", "d", "e", "f", "g"];
    final listT = ["0", "1", "2", "3", "4", "5", "6", "7"];
    final listF = ["0", "1", "2", "3", "4", "5", "6"];
    final listS = ["0", "1", "2", "3", "4", "5", "6"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var from = 0; from < listF.length; from++) {
      for (var to = 0; to < listT.length; to++) {
        for (var set = 0; set < listS.length; set++) {
          final opA = op.person.alias.index(set).set("X");
          final opB = op.person.alias.move(from, to);
          final descA = "set$set";
          final descB = "$from->$to";
          result += testTwoOpsConverge(opA, opB, descA, descB, data);
          result += testTwoOpsConverge(opB, opA, descB, descA, data);
        }
      }
    }
    compareResults(result, expectedTestTransformMoveSet);
  });

  // EditMove
  test("TestTransformMoveEdit", () {
    final listD = ["a", "b", "c", "d", "e", "f", "g"];
    final listT = ["0", "1", "2", "3", "4", "5", "6", "7"];
    final listF = ["0", "1", "2", "3", "4", "5", "6"];
    final listS = ["0", "1", "2", "3", "4", "5", "6"];
    var data = Person()..alias.addAll(listD);
    var result = "";
    for (var from = 0; from < listF.length; from++) {
      for (var to = 0; to < listT.length; to++) {
        for (var set = 0; set < listS.length; set++) {
          final opA = op.person.alias.index(set).edit(listD[set], "X");
          final opB = op.person.alias.move(from, to);
          final descA = "edit$set";
          final descB = "$from->$to";
          result += testTwoOpsConverge(opA, opB, descA, descB, data);
          result += testTwoOpsConverge(opB, opA, descB, descA, data);
        }
      }
    }
    compareResults(result, expectedTestTransformMoveEdit);
  });

  // RenameRename
  test("TestTransformRenameRename", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d", 4: "e", 5: "f"};
    final values = ["0", "1", "2", "3", "4", "5"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var fromA = 0; fromA < values.length; fromA++) {
      for (var toA = 0; toA < values.length; toA++) {
        for (var fromB = 0; fromB < values.length; fromB++) {
          for (var toB = 0; toB < values.length; toB++) {
            final opA = op.company.flags.rename(fromA, toA);
            final opB = op.company.flags.rename(fromB, toB);
            final descA = "$fromA->$toA";
            final descB = "$fromB->$toB";
            result += testTwoOpsConverge(opA, opB, descA, descB, data);
          }
        }
      }
    }
    compareResults(result, expectedTestTransformRenameRename);
  });

  // EditEditKey
  test("TestTransformEditEditKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final values = ["0", "1", "2", "3"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var editA = 0; editA < values.length; editA++) {
      for (var editB = 0; editB < values.length; editB++) {
        final opA = op.company.flags.key(editA).edit(mapD[editA], "X");
        final opB = op.company.flags.key(editB).edit(mapD[editB], "Y");
        final descA = "edit$editA";
        final descB = "edit$editB";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
      }
    }
    compareResults(result, expectedTestTransformEditEditKey);
  });

  // EditSetKey
  test("TestTransformEditSetKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final values = ["0", "1", "2", "3"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var edit = 0; edit < values.length; edit++) {
      for (var set = 0; set < values.length; set++) {
        final opA = op.company.flags.key(edit).edit(mapD[edit], "X");
        final opB = op.company.flags.key(set).set("Y");
        final descA = "edit$edit";
        final descB = "set$set";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformEditSetKey);
  });

  // EditDeleteKey
  test("TestTransformEditDeleteKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final values = ["0", "1", "2", "3"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var edit = 0; edit < values.length; edit++) {
      for (var del = 0; del < values.length; del++) {
        final opA = op.company.flags.key(edit).edit(mapD[edit], "X");
        final opB = op.company.flags.key(del).delete();
        final descA = "edit$edit";
        final descB = "del$del";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformEditDeleteKey);
  });

  // EditRename
  test("TestTransformEditRenameKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final editV = ["0", "1", "2", "3"];
    final renameF = ["0", "1", "2", "3"];
    final renameT = ["0", "1", "2", "3", "4", "5"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var edit = 0; edit < editV.length; edit++) {
      for (var from = 0; from < renameF.length; from++) {
        for (var to = 0; to < renameT.length; to++) {
          final opA = op.company.flags.key(edit).edit(mapD[edit], "X");
          final opB = op.company.flags.rename(from, to);
          final descA = "edit$edit";
          final descB = "$from->$to";
          result += testTwoOpsConverge(opA, opB, descA, descB, data);
          result += testTwoOpsConverge(opB, opA, descB, descA, data);
        }
      }
    }
    compareResults(result, expectedTestTransformEditRenameKey);
  });

  // SetRename
  test("TestTransformSetRenameKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final setV = ["0", "1", "2", "3"];
    final renameF = ["0", "1", "2", "3"];
    final renameT = ["0", "1", "2", "3", "4", "5"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var set = 0; set < setV.length; set++) {
      for (var from = 0; from < renameF.length; from++) {
        for (var to = 0; to < renameT.length; to++) {
          final opA = op.company.flags.key(set).set("X");
          final opB = op.company.flags.rename(from, to);
          final descA = "set$set";
          final descB = "$from->$to";
          result += testTwoOpsConverge(opA, opB, descA, descB, data);
          result += testTwoOpsConverge(opB, opA, descB, descA, data);
        }
      }
    }
    compareResults(result, expectedTestTransformSetRenameKey);
  });

  // RenameDelete
  test("TestTransformRenameDelete", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final delV = ["0", "1", "2", "3"];
    final renameF = ["0", "1", "2", "3"];
    final renameT = ["0", "1", "2", "3", "4", "5"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var del = 0; del < delV.length; del++) {
      for (var from = 0; from < renameF.length; from++) {
        for (var to = 0; to < renameT.length; to++) {
          final opA = op.company.flags.key(del).delete();
          final opB = op.company.flags.rename(from, to);
          final descA = "del$del";
          final descB = "$from->$to";
          result += testTwoOpsConverge(opA, opB, descA, descB, data);
          result += testTwoOpsConverge(opB, opA, descB, descA, data);
        }
      }
    }
    compareResults(result, expectedTestTransformRenameDelete);
  });

  // SetSetKey
  test("TestTransformSetSetKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final setV = ["0", "1", "2", "3"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var setA = 0; setA < setV.length; setA++) {
      for (var setB = 0; setB < setV.length; setB++) {
        final opA = op.company.flags.key(setA).set("X");
        final opB = op.company.flags.key(setB).set("Y");
        final descA = "set$setA";
        final descB = "set$setB";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
      }
    }
    compareResults(result, expectedTestTransformSetSetKey);
  });

  // SetDeleteKey
  test("TestTransformSetDeleteKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final values = ["0", "1", "2", "3"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var set = 0; set < values.length; set++) {
      for (var del = 0; del < values.length; del++) {
        final opA = op.company.flags.key(set).set("X");
        final opB = op.company.flags.key(del).delete();
        final descA = "set$set";
        final descB = "del$del";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
        result += testTwoOpsConverge(opB, opA, descB, descA, data);
      }
    }
    compareResults(result, expectedTestTransformSetDeleteKey);
  });

  // DeleteDeleteKey
  test("TestTransformDeleteDeleteKey", () {
    final mapD = {0: "a", 1: "b", 2: "c", 3: "d"};
    final values = ["0", "1", "2", "3"];
    var data = Company()
      ..flags.addAll(
          mapD.map<Int64, String>((key, value) => MapEntry(Int64(key), value)));
    var result = "";
    for (var delA = 0; delA < values.length; delA++) {
      for (var delB = 0; delB < values.length; delB++) {
        final opA = op.company.flags.key(delA).delete();
        final opB = op.company.flags.key(delB).delete();
        final descA = "del$delA";
        final descB = "del$delB";
        result += testTwoOpsConverge(opA, opB, descA, descB, data);
      }
    }
    compareResults(result, expectedTestTransformDeleteDeleteKey);
  });
}

String testTwoOpsConverge(
    pb.Op opA, pb.Op opB, String descA, String descB, GeneratedMessage data) {
  // opA has priority
  final opAxpA = delta.transform(opB, opA, false);
  final opBxpA = delta.transform(opA, opB, true);

  final opAxpB = delta.transform(opB, opA, true);
  final opBxpB = delta.transform(opA, opB, false);

  var dataApA = data.clone();
  var dataBpA = data.clone();
  var dataApB = data.clone();
  var dataBpB = data.clone();

  delta.apply(opA, dataApA);
  delta.apply(opBxpA, dataApA);
  delta.apply(opA, dataApB);
  delta.apply(opBxpB, dataApB);

  delta.apply(opB, dataBpA);
  delta.apply(opAxpA, dataBpA);
  delta.apply(opB, dataBpB);
  delta.apply(opAxpB, dataBpB);

  expect(toObject(dataApA), toObject(dataBpA), reason: "dataApA != dataBpA");
  expect(toObject(dataApB), toObject(dataBpB), reason: "dataApB != dataBpB");

  String Function(GeneratedMessage) printer;
  if (data is Person) {
    printer = printAlias;
  } else if (data is Company) {
    printer = printFlags;
  } else {
    throw Exception("");
  }
  var out = "";
  out += "$descA* $descB : ${printer(dataApA)}\n";
  out += "$descA  $descB*: ${printer(dataApB)}\n";
  return out;
}

String printAlias(GeneratedMessage m) {
  final p = m as Person;
  return p.alias.join(" ");
}

String printFlags(GeneratedMessage m) {
  final c = m as Company;
  var keys = c.flags.keys.toList();
  keys.sort();
  var s = "";
  keys.forEach((key) {
    if (s != "") {
      s += " ";
    }
    s += "$key:${c.flags[key]}";
  });
  return s;
}

compareResults(String result, String expected) {
  expected = expected.trim();
  expected = expected.replaceAll("\t", "");
  result = result.trim();
  result = result.replaceAll("\t", "");
  expect(result, expected);
}
