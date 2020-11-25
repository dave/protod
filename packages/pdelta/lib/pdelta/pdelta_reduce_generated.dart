import 'package:pdelta/pdelta/pdelta.dart';
import 'package:pdelta/pdelta/pdelta.pb.dart' as pb;
import 'package:pdelta/pdelta/pdelta_reduce.dart';

List<pb.Op> reduceGenerated(pb.Op op1, pb.Op op2) {
  switch (op1.type) {
  case pb.Op_Type.Edit:
    final op1Item = item(op1);
    if (op1Item.hasField_1()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rEditFieldEditField(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rEditFieldSetField(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rEditFieldDeleteField(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (op1Item.hasIndex()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rEditIndexEditIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rEditIndexSetIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rEditIndexDeleteIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (op1Item.hasKey()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rEditKeyEditKey(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rEditKeySetKey(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rEditKeyDeleteKey(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rEditKeyRenameKey(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else {
      throw Exception('invalid op');
    }
    break;
  case pb.Op_Type.Set:
    final op1Item = item(op1);
    if (op1Item.hasField_1()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rSetFieldEditField(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rSetFieldSetField(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rSetFieldDeleteField(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (op1Item.hasIndex()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rSetIndexEditIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rSetIndexSetIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rSetIndexDeleteIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (op1Item.hasKey()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rSetKeyEditKey(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rSetKeySetKey(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rSetKeyDeleteKey(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rSetKeyRenameKey(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else {
      throw Exception('invalid op');
    }
    break;
  case pb.Op_Type.Insert:
    final op1Item = item(op1);
    if (op1Item.hasIndex()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rInsertIndexSetIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rInsertIndexMoveIndex(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rInsertIndexDeleteIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else {
      throw Exception('invalid op');
    }
    break;
  case pb.Op_Type.Move:
    final op1Item = item(op1);
    if (op1Item.hasIndex()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rMoveIndexMoveIndex(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rMoveIndexDeleteIndex(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else {
      throw Exception('invalid op');
    }
    break;
  case pb.Op_Type.Delete:
    final op1Item = item(op1);
    if (op1Item.hasField_1()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (op1Item.hasIndex()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (op1Item.hasKey()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (op1Item.hasOneof()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else {
      throw Exception('invalid op');
    }
    break;
  case pb.Op_Type.Rename:
    final op1Item = item(op1);
    if (op1Item.hasKey()) {
      switch (op2.type) {
      case pb.Op_Type.Edit:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final op2Item = item(op2);
        if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final op2Item = item(op2);
        if (op2Item.hasField_1()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasIndex()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else if (op2Item.hasOneof()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final op2Item = item(op2);
        if (op2Item.hasKey()) {
          return rIndependent(op1, op2);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else {
      throw Exception('invalid op');
    }
    break;
  default:
    throw Exception('invalid op');
  }
}
