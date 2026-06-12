import 'package:pdelta/pdelta/pdelta.dart';
import 'package:pdelta/pdelta/pdelta.pb.dart' as pb;
import 'package:pdelta/pdelta/pdelta_behaviour.dart';
import 'package:pdelta/pdelta/pdelta_reduce_generated.dart';
import 'package:pdelta/pdelta/pdelta_shifters.dart';
import 'package:ptypes/google/protobuf/any.pb.dart' as any;

// This file is a port of reduce.go - keep the two in sync.
//
// The pairwise _reduce function takes two operations that happen in series, and converts to 0, 1 or 2 operations.
// The returned list is in application order, so:
// [] (cancelled):        the operations cancelled each other out (e.g. move i->j, move j->i)
// [op] (merged):         the operations could be merged (e.g. set, edit)
// [first, second]:       either the operations were transposed (with the property that
//                        transform(first, op1) == op2), or they could not be reduced or re-ordered, in which case
//                        first == op1 and second == op2.

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
    return nullOp;
  }

  // A single pass of _reducePass can miss reductions: when the bubbling operation absorbs a later operation by
  // merging, the merged result is never re-compared against the operations it already bubbled past (e.g. a set
  // of the root absorbed late in a pass makes every earlier operation redundant, but those operations have
  // already been emitted into the transformed prefix). Each pass either strictly reduces the number of
  // operations or finds nothing new, so we simply re-run passes until the count stops shrinking.
  var out = _reducePass(ops);
  while (out.length > 1) {
    final next = _reducePass(out);
    if (next.length >= out.length) {
      break;
    }
    out = next;
  }
  return compound(out);
}

List<pb.Op> _reducePass(List<pb.Op> input) {
  // We can only reduce operations that happen subsequently, so in the diagram below we can reduce op1 and op2 with
  // no problems. However, if they are independent, the result of the reduction is still two operations. This means
  // we can't then reduce op1 and op3 (and later operations) because they are not subsequent:
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
  //                    \
  //                     \
  //                      \ <- op3
  //                       \
  //                        \
  //                         o
  //
  // However, when reduce can't merge op1 and op2, it re-orders them by transforming them into op2x and op1x. We can
  // then reduce op1x and op3, because they are now subsequent. So we take the first operation and bubble it towards
  // the end of the list: each pairwise reduce either cancels both operations, merges them into one, or emits the
  // first returned operation into the transformed prefix and continues bubbling the second. When a pair can't be
  // merged or re-ordered, _reduce returns the operations unchanged in their original order - so the loop below
  // doesn't need to treat that case specially. Once the current operation has bubbled past every other operation,
  // it belongs before the previously completed operations in out, and we repeat with the transformed prefix.
  var inList = List<pb.Op>.from(input);
  final out = <pb.Op>[];
  while (inList.isNotEmpty) {
    var current = inList[0];
    var rest = inList.sublist(1);
    final transformed = <pb.Op>[];
    var cancelled = false;
    while (rest.isNotEmpty && !cancelled) {
      final next = rest[0];
      rest = rest.sublist(1);
      final result = _reduce(current, next);
      if (result.length == 0) {
        cancelled = true;
      } else if (result.length == 1) {
        current = result[0];
      } else {
        transformed.add(result[0]);
        current = result[1];
      }
    }
    if (cancelled) {
      // current and next annihilated each other. The transformed prefix and the untouched remainder must be
      // re-processed from the start, because the cancellation may enable new merges between them.
      inList = [...transformed, ...rest];
      continue;
    }
    out.insert(0, current);
    inList = transformed;
  }
  return out;
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
  if (splitCommonOneofAncestor(op1.location, op2.location).isNotEmpty) {
    // op1 and op2 have a common oneof ancestor, and are acting on separate oneof root values. We can't reduce or
    // transpose the operations.
    return rUnchanged(op1, op2);
  }
  return reduceGenerated(op1, op2);
}

List<pb.Op> rUnchanged(pb.Op op1, pb.Op op2) {
  // When the operations can't be merged or transposed, we return them unchanged in their original order.
  return [op1.clone(), op2.clone()];
}

List<pb.Op> rTransposed(pb.Op op1, pb.Op op2) {
  // The operations are fully independent, so they can swap places unchanged.
  return [op2.clone(), op1.clone()];
}

List<pb.Op> rIndependent(pb.Op op1, pb.Op op2) {
  // op1 and op2 are not acting on the same value, or the values don't conflict.
  final op1Behaviour = getBehaviour(op1);
  final op2Behaviour = getBehaviour(op2);

  if ((op1.type == pb.Op_Type.Set || op1.type == pb.Op_Type.Insert) &&
      treeRelationship(op1.location, op2.location) == TreeRelationshipType.ANCESTOR) {
    // op1 is a set or insert operation, and op2 is acting on a descendent. We can just apply op2 to the value and
    // use that in the set / insert:

    // op1.Value can be:
    // scalar (impossible because scalars don't have descendents)
    // message
    // fragment

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

  if (op1.type == pb.Op_Type.Insert) {
    // op1 inserted a value, and op2 is acting on that value or a descendent. We can't reduce the operations.
    final rel = treeRelationship(op1.location, op2.location);
    if (rel == TreeRelationshipType.ANCESTOR || rel == TreeRelationshipType.EQUAL) {
      return rUnchanged(op1, op2);
    }
  }

  if (op1Behaviour.itemIsDeleted &&
      op1Behaviour.locatorType != LocatorType.INDEX &&
      treeRelationship(op1.location, op2.location) == TreeRelationshipType.ANCESTOR) {
    // To understand the "op1Behaviour.locatorType != INDEX" clause above, consider the following:
    //
    // If op1 deletes at an index then op2.location might seem to be matching, but it's not a descendent... e.g.:
    // COMPOUND(
    // 	 DELETE(cases/["a"]/items/0)
    //	 SET(cases/["a"]/items/0/title, "d")
    // )
    // ... the item at index 0 was removed so no subsequent operation can affect it. So the operations are actually
    // independent and can be transposed.

    // Op2 is acting on a value that is a descendent of a value that op1 deleted. We can't merge or transpose.
    return rUnchanged(op1, op2);
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

  if (op1.type == pb.Op_Type.Rename) {
    final toRel = treeRelationship(toLoc(op1), op2.location);
    if (toRel == TreeRelationshipType.EQUAL || toRel == TreeRelationshipType.ANCESTOR) {
      // Op2 is acting on a value that has had it's key renamed by Op1. We can transpose the operations, but the
      // key must be updated.
      final op1x = op1.clone();
      final op2x = op2.clone();
      final keyIndex = op1.location.length - 1;
      final keyValue = item(op1).key.clone();
      setKeyAt(op2x, keyIndex, keyValue);
      return [op2x, op1x];
    }
    final fromRel = treeRelationship(op1.location, op2.location);
    if (fromRel == TreeRelationshipType.EQUAL || fromRel == TreeRelationshipType.ANCESTOR) {
      // Op2 is acting on an empty value that op1 just moved the value away from. We can't reduce or transpose,
      // so we must return the operations unchanged.
      return rUnchanged(op1, op2);
    }
  }

  if (op2.type == pb.Op_Type.Rename) {
    final rel = treeRelationship(op1.location, op2.location);
    if (rel == TreeRelationshipType.EQUAL || rel == TreeRelationshipType.DESCENDENT) {
      // op2 is renaming the key of the value that op1 affected (or an ancestor of it). We can't transpose with a
      // key update, because op1 might create the key that op2 is renaming (set creates missing keys, and even an
      // insert-only quill edit creates the key it edits), so if op2 is moved to before op1 it will fail.
      return rUnchanged(op1, op2);
    }
  }

  final useOp1IndexShifter =
      op1Behaviour.indexShifter != null && treeRelationship(parent(op1), op2.location) == TreeRelationshipType.ANCESTOR;
  final useOp2IndexShifter =
      op2Behaviour.indexShifter != null && treeRelationship(parent(op2), op1.location) == TreeRelationshipType.ANCESTOR;
  if (useOp1IndexShifter || useOp2IndexShifter) {
    final op1x = op1.clone();
    final op2x = op2.clone();
    var op2xItemPriority = PriorityType.DISABLED;
    var op2xValuePriority = PriorityType.DISABLED;

    if (useOp1IndexShifter) {
      // The component of op2's location that we're shifting is only op2's own item locator (a gap for
      // inserts) when op2 acts directly on op1's list. When op2 acts deeper - its location passes through an
      // element of op1's list - that component is a reference to a concrete element, so it must be tracked
      // with the VALUE target.
      var target = ShiftTarget.VALUE;
      if (op2.location.length == op1.location.length) {
        target = op2Behaviour.shiftTarget;
      }
      final shifter = op1Behaviour.indexShifter(op1, PriorityType.DISABLED, ShiftDirection.REVERSE, target);
      final index = op1.location.length - 1;
      final value = getIndexAt(op2, index);
      final shifted = shifter(value);
      op2xItemPriority = shifted.priority;
      setIndexAt(op2x, index, shifted.index);
      if (op2Behaviour.valueIsLocation && treeRelationship(parent(op1), parent(op2)) == TreeRelationshipType.EQUAL) {
        // If op1 and op2 both act on values within the same list (have the same parent), AND op2 has a location at
        // it's value, then we update the location using the location shifter. Example is two moves which are
        // acting on different values within a list.
        final locationShifter =
            op1Behaviour.indexShifter(op1, PriorityType.DISABLED, ShiftDirection.REVERSE, ShiftTarget.LOCATION);
        final shiftedTo = locationShifter(toIndex(op2));
        op2xValuePriority = shiftedTo.priority;
        setToIndex(op2x, shiftedTo.index);
      } else {
        op2xValuePriority = op2xItemPriority;
      }
    }

    if (useOp2IndexShifter) {
      // The shifters only consult priority at the contested gap. For a move that gap is its destination (to)
      // index, and for an insert it is its item index. In both cases the contest was recorded in step one when
      // op2's gap index was shifted backwards across op1: that tag is op2xValuePriority (for non-move op2,
      // op2xValuePriority was set equal to op2xItemPriority above). So the priority for rebasing op1 forward
      // across op2x is the reverse of op2xValuePriority.
      final op1xPriority = reversePriority(op2xValuePriority);

      // See the matching comment in the useOp1IndexShifter block: op1's own shift target only applies when
      // op1 acts directly on op2's list; deeper locations are element references and use VALUE.
      var target = ShiftTarget.VALUE;
      if (op1.location.length == op2.location.length) {
        target = op1Behaviour.shiftTarget;
      }
      final shifter = op2Behaviour.indexShifter(op2x, op1xPriority, ShiftDirection.NORMAL, target);
      final index = op2.location.length - 1;
      final value = getIndexAt(op1, index);
      setIndexAt(op1x, index, shifter(value).index);
      if (op1Behaviour.valueIsLocation && treeRelationship(parent(op2), parent(op1)) == TreeRelationshipType.EQUAL) {
        // If op1 and op2 both act on values within the same list (have the same parent), AND op1 has a location
        // at its value, then we update the location using the location shifter. Example is two moves which are
        // acting on different values within a list. The to index is a gap index in the same coordinate space
        // as op1's item index (the original list), and op2x is in that coordinate space too, so it can be
        // shifted directly.
        final locationShifter =
            op2Behaviour.indexShifter(op2x, op1xPriority, ShiftDirection.NORMAL, ShiftTarget.LOCATION);
        setToIndex(op1x, locationShifter(toIndex(op1)).index);
      }
    }
    return [op2x, op1x];
  }

  return rTransposed(op1, op2);
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

  if (op1ToIndexInOp2Context == op2FromIndex) {
    // operations are moving the same value, so can be reduced to one operation:
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

  // operations act on different values, so can be swapped, but we need to shift the indexes. This is all handled
  // by rIndependent.
  return rIndependent(op1, op2);
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

  if (treeRelationship(op1.location, toLoc(op2)) == TreeRelationshipType.EQUAL) {
    // op1 has set a value, but op2 immediately overwrites this. We can ignore the set.
    return [op2.clone()];
  }

  if (treeRelationship(op1.location, op2.location) == TreeRelationshipType.EQUAL) {
    // op1 has set a value, but op2 immediately renames it. We can't transpose, because the set operation might
    // create the key if it doesn't exist already - if we transpose, the rename operation will fail.
    return rUnchanged(op1, op2);
  }

  return rIndependent(op1, op2);
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
  return rUnchanged(op1, op2);

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
  final deleteIndex = itemIndex(op2);

  if (moveToIndexInOp2Context == deleteIndex) {
    // delete deleted the value that op1 moved - can remove the move operation
    final out = op2.clone();
    setItemIndex(out, moveFromIndex);
    return [out];
  }

  final moveShift = moveShifter(moveFromIndex, moveToIndex, PriorityType.DISABLED, ShiftDirection.REVERSE, ShiftTarget.VALUE);
  final deleteIndexInOp1Context = moveShift(deleteIndex).index;

  final op2x = op2.clone();
  setItemIndex(op2x, deleteIndexInOp1Context);

  final deleteShift = deleteShifter(deleteIndexInOp1Context, ShiftDirection.NORMAL);
  final moveFromIndexInOp2xContext = deleteShift(moveFromIndex).index;
  final moveToIndexInOp2xContext = deleteShift(moveToIndex).index;

  final op1x = op1.clone();
  setItemIndex(op1x, moveFromIndexInOp2xContext);
  setToIndex(op1x, moveToIndexInOp2xContext);

  return [op2x, op1x];
}

List<pb.Op> rRenameKeyRenameKey(pb.Op op1, pb.Op op2) {
  // op1 has moved the value from op1.location and overwritten toLoc(op1).
  // op2 then moves from op2.location and overwrites toLoc(op2).
  final toFrom = treeRelationship(toLoc(op1), op2.location);
  final toTo = treeRelationship(toLoc(op1), toLoc(op2));
  final fromFrom = treeRelationship(op1.location, op2.location);
  final fromTo = treeRelationship(op1.location, toLoc(op2));

  if (fromFrom == TreeRelationshipType.EQUAL) {
    // op2 is trying to move from the same key that op1 already moved. This will always fail when apply is called.
    // From reduce we can just return the operations unchanged:
    return rUnchanged(op1, op2);
  } else if (toTo == TreeRelationshipType.EQUAL) {
    // Op2 is trying to move to the the same location that op1 already overwrote. We can remove op1 but we must
    // replace it with a delete to replicate the rename functionality:
    final op1x = pb.Op()
      ..type = pb.Op_Type.Delete
      ..location.addAll(op1.clone().location);
    final op2x = op2.clone();
    return [op2x, op1x];
  } else if (fromTo == TreeRelationshipType.EQUAL && toFrom == TreeRelationshipType.EQUAL) {
    // op1 renames A to B (overwriting B), and op2 renames B back to A. The value of A survives the round trip
    // and ends up back at A, and the value that was at B is destroyed. So the pair is equivalent to a single
    // delete of B. Note this is sequential logic, not transform logic: op2 moves the value that op1 placed at
    // B, which is A's original value.
    final out = pb.Op()
      ..type = pb.Op_Type.Delete
      ..location.addAll(toLoc(op1));
    return [out];
  } else if (fromTo == TreeRelationshipType.EQUAL) {
    // Op2 is trying to move another value onto the key that op1 moved away from. The operations can't be
    // transposed: if op2 ran first, it would overwrite op1's value before op1 had moved it.
    return rUnchanged(op1, op2);
  } else if (toFrom == TreeRelationshipType.EQUAL) {
    // Op2 is trying to move the key that op1 already overwrote. We can reduce, but we must turn op1 into a delete
    // and update the from key:
    final op1x = pb.Op()
      ..type = pb.Op_Type.Delete
      ..location.addAll(op2.clone().location);
    final op2x = op2.clone();
    op2x.location
      ..clear()
      ..addAll(op1.clone().location);
    return [op2x, op1x];
  } else {
    // independent operations
    return rIndependent(op1, op2);
  }
}

List<pb.Op> rRenameKeySetKey(pb.Op op1, pb.Op op2) {
  // op1 has moved the value from op1.location and overwritten toLoc(op1).
  // op2 then sets the value at op2.location.
  final to = treeRelationship(toLoc(op1), op2.location);
  final from = treeRelationship(op1.location, op2.location);
  if (to == TreeRelationshipType.EQUAL) {
    // op2 is setting the value that op1 moved to. We can transpose, but op1x must be changed to a delete.
    final op1x = pb.Op()
      ..type = pb.Op_Type.Delete
      ..location.addAll(op1.clone().location);
    final op2x = op2.clone();
    return [op2x, op1x];
  } else if (from == TreeRelationshipType.EQUAL) {
    // op2 is setting the item that op1 previously moved. We can't merge or transpose.
    return rUnchanged(op1, op2);
  } else {
    // independent operations
    return rIndependent(op1, op2);
  }
}

List<pb.Op> rRenameKeyDeleteKey(pb.Op op1, pb.Op op2) {
  // op1 has moved the value from op1.location and overwritten toLoc(op1).
  // op2 then deletes the value at op2.location.
  final to = treeRelationship(toLoc(op1), op2.location);
  final from = treeRelationship(op1.location, op2.location);
  if (to == TreeRelationshipType.EQUAL) {
    // op2 is deleting the value that op1 moved. We can transpose, but op1x must be changed to a delete.
    final op1x = pb.Op()
      ..type = pb.Op_Type.Delete
      ..location.addAll(op1.clone().location);
    final op2x = op2.clone();
    return [op2x, op1x];
  } else if (from == TreeRelationshipType.EQUAL) {
    // op2 is deleting the at the key that op1 previously moved from. This key will be empty. We can ignore the
    // delete.
    return [op1.clone()];
  } else {
    // independent operations
    return rIndependent(op1, op2);
  }
}

List<pb.Op> rDeleteFieldEditField(pb.Op op1, pb.Op op2) {
  if (treeRelationship(op1.location, op2.location) == TreeRelationshipType.EQUAL) {
    // op2 is editing a value that was previously deleted by op1. Operations can't be merged or transposed.
    return rUnchanged(op1, op2);
  }
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteFieldSetField(pb.Op op1, pb.Op op2) {
  final rel = treeRelationship(op1.location, op2.location);
  if (rel == TreeRelationshipType.EQUAL || rel == TreeRelationshipType.DESCENDENT) {
    // EQUAL: Op2 has set a value that Op1 previously deleted. We can ignore the delete.
    // DESCENDENT: Op2 has set a value that is an ancestor of a value that Op1 previously deleted. We can
    // ignore the delete.
    return [op2.clone()];
  } else if (rel == TreeRelationshipType.ANCESTOR) {
    // Op2 has set a value that is a descendent of a value that Op1 previously deleted. We cannot combine the
    // operations, and they cannot be swapped.
    return rUnchanged(op1, op2);
  }
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteDelete(pb.Op op1, pb.Op op2) {
  // Used by:
  // rDeleteFieldDeleteField
  // rDeleteKeyDeleteKey
  // rDeleteOneofDeleteOneof
  final rel = treeRelationship(op1.location, op2.location);
  if (rel == TreeRelationshipType.EQUAL) {
    // op2 is deleting a value that was previously deleted by op1. Operations can be merged to a single delete.
    return [op1.clone()];
  } else if (rel == TreeRelationshipType.ANCESTOR) {
    // op2 is inside a value that was deleted by op1. Second delete may create an empty item, so operations can't
    // be merged or transposed.
    return rUnchanged(op1, op2);
  } else if (rel == TreeRelationshipType.DESCENDENT) {
    // op2 is deleting an ancestor of a value that was deleted by op1. Operations can be merged to a single delete
    // at op2.
    return [op2.clone()];
  }
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteFieldDeleteField(pb.Op op1, pb.Op op2) {
  return rDeleteDelete(op1, op2);
}

List<pb.Op> rDeleteKeyDeleteKey(pb.Op op1, pb.Op op2) {
  return rDeleteDelete(op1, op2);
}

List<pb.Op> rDeleteOneofDeleteOneof(pb.Op op1, pb.Op op2) {
  return rDeleteDelete(op1, op2);
}

List<pb.Op> rDeleteIndexDeleteIndex(pb.Op op1, pb.Op op2) {
  // This is distinct from rDeleteDelete because deletes at the same index operate on separate values
  final rel = treeRelationship(op1.location, op2.location);
  if (rel == TreeRelationshipType.EQUAL) {
    // op2 is deleting at an index that was previously deleted by op1. Operations are independent.
    return rIndependent(op1, op2);
  } else if (rel == TreeRelationshipType.ANCESTOR) {
    // op2 is deleting inside a value that was deleted by op1. Second delete may create an empty item, so
    // operations can't be merged or transposed.
    return rUnchanged(op1, op2);
  } else if (rel == TreeRelationshipType.DESCENDENT) {
    // op2 is deleting an ancestor of a value that was deleted by op1. Operations can be merged to a single delete
    // at op2.
    return [op2.clone()];
  }
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteIndexEditIndex(pb.Op op1, pb.Op op2) {
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteIndexSetIndex(pb.Op op1, pb.Op op2) {
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteIndexInsertIndex(pb.Op op1, pb.Op op2) {
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteIndexMoveIndex(pb.Op op1, pb.Op op2) {
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteKeyEditKey(pb.Op op1, pb.Op op2) {
  // Mirrors rDeleteFieldEditField: unlike list indexes, a delete and an edit at the same key act on the same
  // value (the edit may re-create the deleted key), so the operations can't be merged or transposed.
  if (treeRelationship(op1.location, op2.location) == TreeRelationshipType.EQUAL) {
    return rUnchanged(op1, op2);
  }
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteKeySetKey(pb.Op op1, pb.Op op2) {
  // Mirrors rDeleteFieldSetField.
  final rel = treeRelationship(op1.location, op2.location);
  if (rel == TreeRelationshipType.EQUAL || rel == TreeRelationshipType.DESCENDENT) {
    // op2 sets the value (or an ancestor of the value) that op1 deleted, so the delete is redundant.
    return [op2.clone()];
  } else if (rel == TreeRelationshipType.ANCESTOR) {
    // op2 sets a value inside the value that op1 deleted. The set may re-create the deleted tree, so the
    // operations can't be merged or transposed.
    return rUnchanged(op1, op2);
  }
  return rIndependent(op1, op2);
}

List<pb.Op> rDeleteKeyRenameKey(pb.Op op1, pb.Op op2) {
  final from = treeRelationship(op1.location, op2.location);
  final to = treeRelationship(op1.location, toLoc(op2));
  if (from == TreeRelationshipType.EQUAL) {
    // op2 is renaming the key that op1 deleted. This will always fail when apply is called, so we can just
    // return the operations unchanged.
    return rUnchanged(op1, op2);
  } else if (to == TreeRelationshipType.EQUAL) {
    // op2 renames another key onto the key that op1 deleted. The rename overwrites its destination anyway, so
    // the delete is redundant.
    return [op2.clone()];
  } else {
    return rIndependent(op1, op2);
  }
}
