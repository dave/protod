import 'package:pdelta/pdelta/pdelta.dart';
import 'package:pdelta/pdelta/pdelta.pb.dart' as pb;
import 'package:pdelta/pdelta/pdelta_behaviour.dart';
import 'package:pdelta/pdelta/pdelta_reduce_generated.dart';
import 'package:ptypes/google/protobuf/any.pb.dart' as any;

// op1    | op2
// -------|--------------------------------------------
// EDIT   | EDIT*, SET*, INSERT, MOVE, DELETE*, RENAME*
// SET    | EDIT*, SET*, INSERT, MOVE, DELETE*, RENAME*
// INSERT | EDIT, SET*, INSERT, MOVE*, DELETE*, RENAME
// MOVE   | EDIT, SET, INSERT, MOVE*, DELETE*, RENAME
// DELETE | EDIT, SET, INSERT, MOVE, DELETE, RENAME
// RENAME | EDIT, SET, INSERT, MOVE, DELETE, RENAME

pb.Op reduce(pb.Op op) {
  final ops = flatten(op);
  if (ops.length == 0) {
    return null;
  }
  if (ops.length == 1) {
    return ops[0];
  }
  if (ops.length == 2) {
    return compound(_reduce(ops[0], ops[1]));
  }
  //
  //              A -> o
  //                  / \
  //                 /   \
  //        op2x -> /     \ <- op1
  //               /       \
  //              /         \
  //       Bx -> o           o <- B
  //              \         /
  //               \       /
  //        op1x -> \     / <- op2
  //                 \   /
  //                  \ /
  //              C -> o
  //
  // TODO more that 2 operations -> more complicated...
  throw Exception("not implemented");
}

List<pb.Op> _reduce(pb.Op op1, pb.Op op2) {
  final op1IsNull = isNull(op1);
  final op2IsNull = isNull(op2);
  if (op1IsNull && op2IsNull) {
    return [];
  }
  if (op1IsNull) {
    return [op2.clone()];
  }
  if (op2IsNull) {
    return [op1.clone()];
  }
  return reduceGenerated(op1, op2);
}

List<pb.Op> rIndependent(pb.Op op1, pb.Op op2) {
  // op1 and op2 are not acting on the same value, or the values don't conflict.
  // final op1Behaviour = getBehaviour(op1);
  final op2Behaviour = getBehaviour(op2);

  if (op1.type == pb.Op_Type.Set && treeRelationship(op1.location, op2.location) == TreeRelationshipType.ANCESTOR) {
    // op1 is a set operation, and op2 is acting on a descendent. We can just apply op2 to the value and use that
    // in the set:

    // op1.Value can be:
    // &Op_Scalar (impossible because scalars don't have descendents)
    // &Op_Message
    // &Op_Object

    if (op1.hasScalar()) {
      throw Exception("invalid operation (scalars shouldn't have descendents)");
    } else if (op1.hasFragment()) {
      final msg = unpack(op1.fragment.message);
      final op2new = op2.clone();
      final newLocation = op2new.location.sublist(op1.location.length);
      op2new.location
        ..clear()
        ..add(pb.Locator()..field_1 = op1.fragment.field_1)
        ..addAll(newLocation);
      apply(op2new, msg);
      final fieldNumber = getFieldNumber(msg, op1.fragment.field_1);
      final out = op1.clone();
      out.fragment = getFragment(msg.getField(fieldNumber), op1.fragment.field_1);
      return [out];
    } else if (op1.hasMessage()) {
      final msg = unpack(op1.message);
      final op2new = op2.clone();
      final newLocation = op2new.location.sublist(op1.location.length);
      op2new.location
        ..clear()
        ..addAll(newLocation);
      apply(op2new, msg);
      final out = op1.clone();
      out.message = any.Any.pack(msg);
      return [out];
    }
  }

  if (op2Behaviour.itemIsDeleted && treeRelationship(op1.location, op2.location) == TreeRelationshipType.DESCENDENT) {
    // Op1 is acting on a value that is a descendent of a value that op2 deleted. We can remove op1.
    return [op2.clone()];
  }

  if (op2Behaviour.valueIsLocation &&
      op2Behaviour.valueIsDeleted &&
      treeRelationship(op1.location, toLoc(op2)) == TreeRelationshipType.DESCENDENT) {
    // Op1 is acting on a value that is a descendent of a value that op2 deleted. We can remove op1.
    return [op2.clone()];
  }

  // TODO more logic here?

  return [op1.clone(), op2.clone()];
}

List<pb.Op> rEditEdit(pb.Op op1, pb.Op op2) {
  // Used by:
  // rEditFieldEditField
  // rEditIndexEditIndex
  // rEditKeyEditKey

  // e.g. EDIT A d1, EDIT A d2 => EDIT A d3 (use quill to merge d1 and d2)

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  // Two delta edits operating on the same value - use Quill library to merge the operations.
  final op1Quill = quillFromDelta(op1.delta.quill);
  final op2Quill = quillFromDelta(op2.delta.quill);
  final newQuill = op1Quill.compose(op2Quill);
  final out = op2.clone();
  out.delta = pb.Delta()..quill = deltaFromQuill(newQuill);
  return [out];
}

List<pb.Op> rEditFieldEditField(pb.Op op1, pb.Op op2) {
  return rEditEdit(op1, op2);
}

List<pb.Op> rEditIndexEditIndex(pb.Op op1, pb.Op op2) {
  return rEditEdit(op1, op2);
}

List<pb.Op> rEditKeyEditKey(pb.Op op1, pb.Op op2) {
  return rEditEdit(op1, op2);
}

List<pb.Op> rMoveIndexMoveIndex(pb.Op op1, pb.Op op2) {
  // e.g. MOVE A to B, MOVE B to A => null
  // e.g. MOVE A to B, MOVE B to C => MOVE A to C

  if (treeRelationship(parent(op1), parent(op2)) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  // This function is complicated by the fact that the To index in a move is in the context of the original list.
  // e.g. consider this list:
  //
  // Original list:
  // Values : A B C D
  // Indexes: 0 1 2 3
  //
  // MOVE(1, 3)
  //
  // Resultant list:
  // Values : A C B D
  // Indexes: 0 1 2 3
  //
  // An operation to move B to between C and D is MOVE(1, 3), however in the resultant list the index of the moved
  // value is 2, because values after B in the original list are shifted back by the removal of B.

  final op1FromIndex = itemIndex(op1);
  final op1ToIndex = toIndex(op1);
  final op2FromIndex = itemIndex(op2);
  final op2ToIndex = toIndex(op2);
  // If op1FromIndex < op1ToIndex: Remember the index that the to index points to in the resultant list is toIndex-1
  // because it's shifted backwards by the removal of the value from earlier in the list. So we decrement toIndex.
  final op1ToIndexInOp2Context = op1FromIndex < op1ToIndex ? (op1ToIndex - 1) : op1ToIndex;

  if (op1ToIndexInOp2Context != op2FromIndex) {
    return [op1.clone(), op2.clone()];
  }

  final op2ToIndexInResultingList = op2FromIndex < op2ToIndex ? (op2ToIndex - 1) : op2ToIndex;
  final op2ToIndexInOp1Context =
      op1FromIndex < op2ToIndexInResultingList ? (op2ToIndexInResultingList + 1) : op2ToIndexInResultingList;

  if (op2ToIndexInOp1Context == op1FromIndex) {
    // e.g. MOVE A to B, MOVE B to A => null
    return [];
  }

  // e.g. MOVE A to B, MOVE B to C => MOVE A to C
  final out = op1.clone();
  setToIndex(out, op2ToIndexInOp1Context);
  return [out];
}

List<pb.Op> rEditSet(pb.Op op1, pb.Op op2) {
  // Used by:
  // rEditFieldSetField
  // rEditIndexSetIndex
  // rEditKeySetKey

  // e.g. EDIT A, SET A => SET A

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  return [op2.clone()];
}

List<pb.Op> rEditFieldSetField(pb.Op op1, pb.Op op2) {
  return rEditSet(op1, op2);
}

List<pb.Op> rEditIndexSetIndex(pb.Op op1, pb.Op op2) {
  return rEditSet(op1, op2);
}

List<pb.Op> rEditKeySetKey(pb.Op op1, pb.Op op2) {
  return rEditSet(op1, op2);
}

List<pb.Op> rEditDelete(pb.Op op1, pb.Op op2) {
  // Used by:
  // rEditFieldDeleteField
  // rEditIndexDeleteIndex
  // rEditKeyDeleteKey

  // e.g. EDIT A, DELETE A => DELETE A

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  return [op2.clone()];
}

List<pb.Op> rEditFieldDeleteField(pb.Op op1, pb.Op op2) {
  return rEditDelete(op1, op2);
}

List<pb.Op> rEditIndexDeleteIndex(pb.Op op1, pb.Op op2) {
  return rEditDelete(op1, op2);
}

List<pb.Op> rEditKeyDeleteKey(pb.Op op1, pb.Op op2) {
  return rEditDelete(op1, op2);
}

List<pb.Op> rEditKeyRenameKey(pb.Op op1, pb.Op op2) {
  // e.g. EDIT A, RENAME B to A => RENAME B to A

  if (treeRelationship(op1.location, toLoc(op2)) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  return [op2.clone()];
}

List<pb.Op> rSetEdit(pb.Op op1, pb.Op op2) {
  // Used by:
  // rSetFieldEditField
  // rSetIndexEditIndex
  // rSetKeyEditKey

  // e.g. SET A v1, EDIT A d1 => SET A v2 (use quill to calculate v2)

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  // op2 makes a change to a string that op1 just created. We can apply the edit to the original value and remove the
  // edit.
  final value = op1.scalar.string;
  final dlt = quillFromDelta(op2.delta.quill);
  final newValue = applyDeltaToString(value, dlt);
  final out = op1.clone();
  out.scalar = pb.Scalar()..string = newValue;
  return [out];
}

List<pb.Op> rSetFieldEditField(pb.Op op1, pb.Op op2) {
  return rSetEdit(op1, op2);
}

List<pb.Op> rSetIndexEditIndex(pb.Op op1, pb.Op op2) {
  return rSetEdit(op1, op2);
}

List<pb.Op> rSetKeyEditKey(pb.Op op1, pb.Op op2) {
  return rSetEdit(op1, op2);
}

List<pb.Op> rSetSet(pb.Op op1, pb.Op op2) {
  // Used by:
  // rSetFieldSetField
  // rSetIndexSetIndex
  // rSetKeySetKey

  // e.g. SET A v1, SET A v2 => SET A v2

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  return [op2.clone()];
}

List<pb.Op> rSetFieldSetField(pb.Op op1, pb.Op op2) {
  return rSetSet(op1, op2);
}

List<pb.Op> rSetIndexSetIndex(pb.Op op1, pb.Op op2) {
  return rSetSet(op1, op2);
}

List<pb.Op> rSetKeySetKey(pb.Op op1, pb.Op op2) {
  return rSetSet(op1, op2);
}

List<pb.Op> rSetDelete(pb.Op op1, pb.Op op2) {
  // Used by:
  // rSetFieldDeleteField
  // rSetIndexDeleteIndex
  // rSetKeyDeleteKey

  // e.g. SET A, DELETE A => DELETE A

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  return [op2.clone()];
}

List<pb.Op> rSetFieldDeleteField(pb.Op op1, pb.Op op2) {
  return rSetDelete(op1, op2);
}

List<pb.Op> rSetIndexDeleteIndex(pb.Op op1, pb.Op op2) {
  return rSetDelete(op1, op2);
}

List<pb.Op> rSetKeyDeleteKey(pb.Op op1, pb.Op op2) {
  return rSetDelete(op1, op2);
}

List<pb.Op> rSetKeyRenameKey(pb.Op op1, pb.Op op2) {
  // e.g. SET A, RENAME B to A => RENAME B to A

  if (treeRelationship(op1.location, toLoc(op2)) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }
  return [op2.clone()];
}

List<pb.Op> rInsertIndexSetIndex(pb.Op op1, pb.Op op2) {
  // e.g. INSERT A v1, SET A v2 => INSERT A v2

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  final out = op1.clone();
  copyValue(op2.clone(), out);
  return [out];
}

List<pb.Op> rInsertIndexMoveIndex(pb.Op op1, pb.Op op2) {
  // e.g. INSERT A, MOVE A to B => INSERT B

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  // Two operations:
  // 0 1 2 3 4
  // A B C D
  // insert(0, "x")
  // x A B C D
  // move(0, 3)
  // A B x C D

  // Merged operation:
  // 0 1 2 3 4
  // A B C D
  // insert(2, "x")
  // A B x C D

  // The index of the move operation is in the context of the list with the insert already applied, so if the insert
  // location is before the move to location, then shifter by 1. The index of the merged operation needs to be in the
  // context of the list before the insert operation was applied, so we shift the index by 1.
  final insertIndex = itemIndex(op1);
  final op2ToIndex = toIndex(op2);
  final op2ToIndexInOriginalContext = insertIndex < op2ToIndex ? (op2ToIndex - 1) : op2ToIndex;
  final out = op1.clone();
  setItemIndex(out, op2ToIndexInOriginalContext);
  return [out];
}

List<pb.Op> rInsertIndexDeleteIndex(pb.Op op1, pb.Op op2) {
  // e.g. INSERT A, DELETE A => null

  if (treeRelationship(op1.location, op2.location) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  // This is not actually correct, because the insert operation will create the parent if it doesn't already exist.
  // The delete operation will reverse the insert but not the creation of the parent. Perhaps operations should fail
  // if the parent doesn't exist? This would without a doubt be less convenient in general use. Here's an example:
  //
  // op1: INSERT(cases/["a"]/items/0, message[tests.Item])
  // op2: DELETE(cases/["a"]/items/0)
  // merged: NIL
  // before: {"name":"b"}
  // want: {"name":"b", "cases":{"a":{}}}
  // got: {"name":"b"}
  //
  // So, we return both operations unchanged:
  return [op1.clone(), op2.clone()];

  // Naive logic would return nothing:
  // return [];
}

List<pb.Op> rMoveIndexDeleteIndex(pb.Op op1, pb.Op op2) {
  // e.g. MOVE A to B, DELETE B => DELETE A

  if (treeRelationship(parent(op1), parent(op2)) != TreeRelationshipType.EQUAL) {
    return rIndependent(op1, op2);
  }

  // The index of the delete operation is in the context of the list with the move already applied, so if the move is
  // in the backwards direction, we need to shift the index of the delete to get it into the context of the initial
  // list.
  final moveFromIndex = itemIndex(op1);
  final moveToIndex = toIndex(op1);
  final moveToIndexInOp2Context = moveFromIndex < moveToIndex ? (moveToIndex - 1) : moveToIndex;

  if (moveToIndexInOp2Context == itemIndex(op2)) {
    final out = op2.clone();
    setItemIndex(out, moveFromIndex);
    return [out];
  }

  return [op1.clone(), op2.clone()];
}
