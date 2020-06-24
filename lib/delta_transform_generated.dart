import 'package:protod/delta.dart';
import 'package:protod/delta.pb.dart' as pb;

pb.Op _transform(pb.Op t, pb.Op op, bool priority) {
  switch (t.type) {
  case pb.Op_Type.Edit:
    final tItem = last(t);
    if (tItem.hasField_1()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tEditFieldEditField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tEditFieldSetField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tEditFieldDeleteField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (tItem.hasIndex()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tEditIndexEditIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tEditIndexSetIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tEditIndexInsertIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tEditIndexMoveIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tEditIndexDeleteIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (tItem.hasKey()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tEditKeyEditKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tEditKeySetKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tEditKeyDeleteKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tEditKeyRenameKey(t, op, priority);
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
    final tItem = last(t);
    if (tItem.hasField_1()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tSetFieldEditField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tSetFieldSetField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tSetFieldDeleteField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (tItem.hasIndex()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tSetIndexEditIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tSetIndexSetIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tSetIndexInsertIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tSetIndexMoveIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tSetIndexDeleteIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (tItem.hasKey()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tSetKeyEditKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tSetKeySetKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tSetKeyDeleteKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tSetKeyRenameKey(t, op, priority);
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
    final tItem = last(t);
    if (tItem.hasIndex()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tInsertIndexEditIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tInsertIndexSetIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tInsertIndexInsertIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tInsertIndexMoveIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tInsertIndexDeleteIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
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
    final tItem = last(t);
    if (tItem.hasIndex()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tMoveIndexEditIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tMoveIndexSetIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tMoveIndexInsertIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tMoveIndexMoveIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tMoveIndexDeleteIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
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
    final tItem = last(t);
    if (tItem.hasField_1()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tDeleteFieldEditField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tDeleteFieldSetField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tDeleteFieldDeleteField(t, op, priority);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (tItem.hasIndex()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tDeleteIndexEditIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tDeleteIndexSetIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tDeleteIndexInsertIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tDeleteIndexMoveIndex(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tDeleteIndexDeleteIndex(t, op, priority);
        } else if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      default:
        throw Exception('invalid op');
      }
    } else if (tItem.hasKey()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tDeleteKeyEditKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tDeleteKeySetKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tDeleteKeyDeleteKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tDeleteKeyRenameKey(t, op, priority);
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
    final tItem = last(t);
    if (tItem.hasKey()) {
      switch (op.type) {
      case pb.Op_Type.Edit:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tRenameKeyEditKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Set:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tRenameKeySetKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Insert:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Move:
        final opItem = last(op);
        if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Delete:
        final opItem = last(op);
        if (opItem.hasField_1()) {
          return tIndependent(t, op);
        } else if (opItem.hasIndex()) {
          return tIndependent(t, op);
        } else if (opItem.hasKey()) {
          return tRenameKeyDeleteKey(t, op, priority);
        } else {
          throw Exception('invalid op');
        }
        break;
      case pb.Op_Type.Rename:
        final opItem = last(op);
        if (opItem.hasKey()) {
          return tRenameKeyRenameKey(t, op, priority);
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
