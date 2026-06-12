package pdelta

import (
	"github.com/golang/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
)

// op1    | op2
// -------|--------------------------------------------
// EDIT   | EDIT*, SET*, INSERT, MOVE, DELETE*, RENAME*
// SET    | EDIT*, SET*, INSERT, MOVE, DELETE*, RENAME*
// INSERT | EDIT, SET*, INSERT, MOVE*, DELETE*, RENAME
// MOVE   | EDIT, SET, INSERT, MOVE*, DELETE*, RENAME
// DELETE | EDIT, SET, INSERT, MOVE, DELETE, RENAME
// RENAME | EDIT, SET, INSERT, MOVE, DELETE, RENAME

func Reduce(op *Op) *Op {
	ops := op.Flatten()
	if len(ops) == 0 {
		return nil
	}

	// A single pass of reducePass can miss reductions: when the bubbling operation absorbs a later operation by
	// merging, the merged result is never re-compared against the operations it already bubbled past (e.g. a set
	// of the root absorbed late in a pass makes every earlier operation redundant, but those operations have
	// already been emitted into the transformed prefix). Each pass either strictly reduces the number of
	// operations or finds nothing new, so we simply re-run passes until the count stops shrinking.
	out := reducePass(ops)
	for len(out) > 1 {
		next := reducePass(out)
		if len(next) >= len(out) {
			break
		}
		out = next
	}
	return Compound(out...)
}

func reducePass(in []*Op) []*Op {

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
	// rebased later operation (op2x) into the transformed prefix and continues bubbling the rebased earlier operation
	// (op1x). When a pair can't be merged or re-ordered (R_UNCHANGED), reduce returns op1x == op2 and op2x == op1,
	// which keeps the effective order unchanged - so the loop below doesn't need to treat that case specially. Once
	// the current operation has bubbled past every other operation, it belongs before the previously completed
	// operations in out, and we repeat with the transformed prefix.

	var out []*Op
	for len(in) > 0 {
		current := in[0]
		rest := in[1:]
		var transformed []*Op
		cancelled := false
		for len(rest) > 0 && !cancelled {
			next := rest[0]
			rest = rest[1:]
			outcome, op1x, op2x := reduce(current, next)
			switch outcome {
			case R_CANCELLED:
				cancelled = true
			case R_MERGED:
				current = op1x
			default:
				transformed = append(transformed, op2x)
				current = op1x
			}
		}
		if cancelled {
			// current and next annihilated each other. The transformed prefix and the untouched remainder must be
			// re-processed from the start, because the cancellation may enable new merges between them.
			in = append(transformed, rest...)
			continue
		}
		out = append([]*Op{current}, out...)
		in = transformed
	}
	return out
}

// reduce takes two operations that happen in series, and converts to 0, 1 or 2 operations:
//
//	A -> o                                          A -> o
//	      \                                             / .
//	       \                                           /   .
//	        \ <- op1                          op2x -> /     . <- op1
//	         \                                       /       .
//	          \                                     /         .
//	           o <- B1   =>   reduce   =>    B2 -> o           o <- B1
//	          /                                     \         .
//	         /                                       \       .
//	        / <- op2                          op1x -> \     . <- op2
//	       /                                           \   .
//	      /                                             \ .
//	C -> o                                          C -> o
//
// four outcomes:
// 1) R_CANCELLED: the operations cancelled each other out (e.g. move i->j, move j->i): op1x: nil, op2x: nil
// 2) R_MERGED: the operations could be merged (e.g. set, edit): op1x: combined operation, op2x: nil, states B2 == C
// 3) R_TRANSPOSED: the operations were reversed: op1x != nil, op2x: rebased operation, with the property that transform(op2x, op1) == op2
// 4) R_UNCHANGED: the operations could not be reduced or reversed: op1x == op2, op2x == op1
func reduce(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {

	op1IsNull, op2IsNull := IsNull(op1), IsNull(op2)
	switch {
	case op1IsNull && op2IsNull:
		return R_CANCELLED, nil, nil
	case op1IsNull:
		return R_MERGED, proto.Clone(op2).(*Op), nil
	case op2IsNull:
		return R_MERGED, proto.Clone(op1).(*Op), nil
	}

	if found, _ := SplitCommonOneofAncestor(op1.Location, op2.Location, true); found {
		// op1 and op2 have a common oneof ancestor, and are acting on separate oneof root values. We can't reduce or
		// transpose the operations.
		return rUnchanged(op1, op2)
	}

	return op1.reduce(op2)
}

type ReduceOutcome string

const (
	R_CANCELLED  ReduceOutcome = "cancelled"
	R_MERGED     ReduceOutcome = "merged"
	R_TRANSPOSED ReduceOutcome = "transposed"
	R_UNCHANGED  ReduceOutcome = "unchanged"
)

func rIndependent(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {

	// op1 and op2 are not acting on the same value, or the values don't conflict.
	op1behaviour := GetBehaviour(op1)
	op2behaviour := GetBehaviour(op2)

	if (op1.Type == Op_Set || op1.Type == Op_Insert) && TreeRelationship(op1.Location, op2.Location) == TREE_ANCESTOR {
		// op1 is a set or insert operation, and op2 is acting on a descendent. We can just apply op2 to the value and
		// use that in the set / insert:

		// op1.Value can be:
		// &Op_Scalar (impossible because scalars don't have descendents)
		// &Op_Message
		// &Op_Object

		switch value := op1.Value.(type) {
		case *Op_Scalar:
			panic("invalid operation (scalars shouldn't have descendents)")
		case *Op_Fragment:
			msg := MustUnmarshalAny(value.Fragment.Message)
			op2new := proto.Clone(op2).(*Op)
			op2new.Location = append([]*Locator{{V: &Locator_Field{Field: value.Fragment.Field}}}, op2new.Location[len(op1.Location):]...)
			if err := Apply(op2new, msg); err != nil {
				panic(err)
			}
			msgProtoReflect := protoreflect.ValueOfMessage(msg.ProtoReflect()).Message()
			field := getField(value.Fragment.Field, msgProtoReflect)
			out := proto.Clone(op1).(*Op)
			out.Value = &Op_Fragment{Fragment: getFragmentFromProto(msgProtoReflect.Mutable(field), value.Fragment.Field)}
			return R_MERGED, out, nil

		case *Op_Message:
			msg := MustUnmarshalAny(value.Message)
			op2new := proto.Clone(op2).(*Op)
			op2new.Location = op2new.Location[len(op1.Location):]
			if err := Apply(op2new, msg); err != nil {
				panic(err)
			}
			out := proto.Clone(op1).(*Op)
			out.Value = &Op_Message{Message: MustMarshalAny(msg)}
			return R_MERGED, out, nil
		}
	}

	// TODO: Why is this not a generated rInsertIndexEditIndex?
	if op1.Type == Op_Insert {
		// op1 inserted a value, and op2 is acting on that value or a descendent. We can't reduce the
		// operations.
		switch TreeRelationship(op1.Location, op2.Location) {
		case TREE_ANCESTOR, TREE_EQUAL:
			return rUnchanged(op1, op2)
		}
	}

	if op1behaviour.ItemIsDeleted && op1behaviour.LocatorType != INDEX && TreeRelationship(op1.Location, op2.Location) == TREE_ANCESTOR {

		// To understand the "op1behaviour.LocatorType != INDEX" clause above, consider the following:
		//
		// If op1 deletes at an index then op2.Location might seem to be matching, but it's not a descendent... e.g.:
		// COMPOUND(
		// 	 DELETE(cases/["a"]/items/0)
		//	 SET(cases/["a"]/items/0/title, "d")
		// )
		// ... the item at index 0 was removed so no subsequent operation can affect it. So the operations are actually
		// independent and can be transposed.

		// Op2 is acting on a value that is a descendent of a value that op1 deleted. We can't merge or transpose.
		return rUnchanged(op1, op2)
	}

	if op2behaviour.ItemIsDeleted && TreeRelationship(op1.Location, op2.Location) == TREE_DESCENDENT {
		// Op1 is acting on a value that is a descendent of a value that op2 deleted. We can remove op1.
		return R_MERGED, proto.Clone(op2).(*Op), nil
	}

	if op2behaviour.ValueIsLocation && op2behaviour.ValueIsDeleted && TreeRelationship(op1.Location, op2.To()) == TREE_DESCENDENT {
		// Op1 is acting on a value that is a descendent of a value that op2 deleted. We can remove op1.
		return R_MERGED, proto.Clone(op2).(*Op), nil
	}

	if op1.Type == Op_Rename {
		switch TreeRelationship(op1.To(), op2.Location) {
		case TREE_EQUAL, TREE_ANCESTOR:
			// Op2 is acting on a value that has had it's key renamed by Op1. We can transpose the operations, but the
			// key must be updated
			op1x = proto.Clone(op1).(*Op)
			op2x = proto.Clone(op2).(*Op)

			keyIndex := len(op1.Location) - 1
			keyValue := op1.Item().GetKey()
			op2x.SetKeyAt(keyIndex, keyValue)

			return R_TRANSPOSED, op1x, op2x
		}
		switch TreeRelationship(op1.Location, op2.Location) {
		case TREE_EQUAL, TREE_ANCESTOR:
			// Op2 is acting on an empty value that op1 just moved the value away from. We can't reduce or transpose,
			// so we must return the operations unchanged.
			return rUnchanged(op1, op2)
		}
	}

	if op2.Type == Op_Rename {
		switch TreeRelationship(op1.Location, op2.Location) {
		case TREE_EQUAL, TREE_DESCENDENT:
			// TREE_EQUAL was previously not handled here and fell through to rTransposed, which swapped the
			// operations without updating the key in op1 - so op1 would act on a key that doesn't exist yet.
			// We can't transpose with a key update either, because op1 might create the key that op2 is renaming
			// (set creates missing keys, and even an insert-only quill edit creates the key it edits), so if op2
			// is moved to before op1 it will fail.
			// op2 is renaming a value that is an ancestor of the value that op1 affected.
			// XXX NO!!! [We can transpose but we must update the key in op1].
			// We can't transpose because if op1 is a set it might create the key that op2 is renaming, so if op2 is
			// moved to before op1 it will fail. THIS IS NOT GOOD.

			//op1x = proto.Clone(op1).(*Op)
			//op2x = proto.Clone(op2).(*Op)
			//keyIndex := len(op2.Location) - 1
			//keyValue := proto.Clone(op2).(*Op).Value.(*Op_Key).Key
			//op1x.SetKeyAt(keyIndex, keyValue)
			//return R_TRANSPOSED, op1x, op2x

			return rUnchanged(op1, op2)
		}
	}

	useOp1IndexShifter := op1behaviour.IndexShifter != nil && TreeRelationship(op1.Parent(), op2.Location) == TREE_ANCESTOR
	useOp2IndexShifter := op2behaviour.IndexShifter != nil && TreeRelationship(op2.Parent(), op1.Location) == TREE_ANCESTOR
	if useOp1IndexShifter || useOp2IndexShifter {
		//var op1x, op2x *Op
		op1x = proto.Clone(op1).(*Op)
		op2x = proto.Clone(op2).(*Op)
		op2xItemPriority, op2xValuePriority := DISABLED, DISABLED

		if useOp1IndexShifter {
			// The component of op2's location that we're shifting is only op2's own item locator (a gap for
			// inserts) when op2 acts directly on op1's list. When op2 acts deeper - its location passes through an
			// element of op1's list - that component is a reference to a concrete element, so it must be tracked
			// with the VALUE target.
			target := VALUE
			if len(op2.Location) == len(op1.Location) {
				target = op2behaviour.ShiftTarget()
			}
			shifter := op1behaviour.IndexShifter(op1, DISABLED, REVERSE, target)
			index := len(op1.Location) - 1
			value := op2.GetIndexAt(index)
			var shifted int64
			shifted, op2xItemPriority = shifter(value)
			op2x.SetIndexAt(index, shifted)
			if op2behaviour.ValueIsLocation && TreeRelationship(op1.Parent(), op2.Parent()) == TREE_EQUAL {
				// If op1 and op2 both act on values within the same list (have the same parent), AND op2 has a location at
				// it's value, then we update the location using the location shifter. Example is two moves which are
				// acting on different values within a list.
				locationShifter := op1behaviour.IndexShifter(op1, DISABLED, REVERSE, LOCATION)
				shifted, op2xValuePriority = locationShifter(op2.ToIndex())
				op2x.SetToIndex(shifted)
			} else {
				op2xValuePriority = op2xItemPriority
			}
		}

		//} else {
		//	op2xItemPriority = LOSER
		//	op2xValuePriority = LOSER
		//}

		if useOp2IndexShifter {

			// The shifters only consult priority at the contested gap. For a move that gap is its destination (to)
			// index, and for an insert it is its item index. In both cases the contest was recorded in step one when
			// op2's gap index was shifted backwards across op1: that tag is op2xValuePriority (for non-move op2,
			// op2xValuePriority was set equal to op2xItemPriority above). So the priority for rebasing op1 forward
			// across op2x is the reverse of op2xValuePriority.
			op1xPriority := reversePriority(op2xValuePriority)

			// See the matching comment in the useOp1IndexShifter block: op1's own shift target only applies when
			// op1 acts directly on op2's list; deeper locations are element references and use VALUE.
			target := VALUE
			if len(op1.Location) == len(op2.Location) {
				target = op1behaviour.ShiftTarget()
			}
			shifter := op2behaviour.IndexShifter(op2x, op1xPriority, NORMAL, target)
			index := len(op2.Location) - 1
			value := op1.GetIndexAt(index)
			shifted, _ := shifter(value)
			op1x.SetIndexAt(index, shifted)
			if op1behaviour.ValueIsLocation && TreeRelationship(op2.Parent(), op1.Parent()) == TREE_EQUAL {
				// If op1 and op2 both act on values within the same list (have the same parent), AND op1 has a location
				// at its value, then we update the location using the location shifter. Example is two moves which are
				// acting on different values within a list. The to index is a gap index in the same coordinate space
				// as op1's item index (the original list), and op2x is in that coordinate space too, so it can be
				// shifted directly.
				locationShifter := op2behaviour.IndexShifter(op2x, op1xPriority, NORMAL, LOCATION)
				shifted, _ = locationShifter(op1.ToIndex())
				op1x.SetToIndex(shifted)
			}
		}
		return R_TRANSPOSED, op1x, op2x
	}

	return rTransposed(op1, op2)
}
func rUnchanged(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {

	// When the operations can't be transposed, we must return op1x and op2x such that op1 == op2x and op2 == op1x.

	//              A -> o
	//                  / \
	//                 /   \
	//        op2x -> /     \ <- op1 (FOR UNCHANGED OPERATIONS, op2x == op1)
	//               /       \
	//              /         \
	//       Bx -> o           o <- B
	//              \         /
	//               \       /
	//        op1x -> \     / <- op2 (FOR UNCHANGED OPERATIONS, op1x == op2)
	//                 \   /
	//                  \ /
	//              C -> o

	// Swapping the order here is intentional and required!
	op1x = proto.Clone(op2).(*Op)
	op2x = proto.Clone(op1).(*Op)
	return R_UNCHANGED, op1x, op2x
}
func rTransposed(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	op1x = proto.Clone(op1).(*Op)
	op2x = proto.Clone(op2).(*Op)
	return R_TRANSPOSED, op1x, op2x
}

func rEditEdit(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Used by:
	// rEditFieldEditField
	// rEditIndexEditIndex
	// rEditKeyEditKey

	// e.g. EDIT A d1, EDIT A d2 => EDIT A d3 (use quill to merge d1 and d2)

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	// Two delta edits operating on the same value - use Quill library to merge the operations.
	op1Quill := op1.Value.(*Op_Delta).Delta.V.(*Delta_Quill).Quill.Quill()
	op2Quill := op2.Value.(*Op_Delta).Delta.V.(*Delta_Quill).Quill.Quill()
	newQuill := op1Quill.Compose(*op2Quill)
	out := proto.Clone(op2).(*Op)
	out.Value = &Op_Delta{Delta: &Delta{V: &Delta_Quill{Quill: DeltaFromQuill(newQuill)}}}
	return R_MERGED, out, nil
}
func rEditFieldEditField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditEdit(op1, op2)
}
func rEditIndexEditIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditEdit(op1, op2)
}
func rEditKeyEditKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditEdit(op1, op2)
}

func rMoveIndexMoveIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {

	// e.g. MOVE A to B, MOVE B to A => null
	// e.g. MOVE A to B, MOVE B to C => MOVE A to C

	if TreeRelationship(op1.Parent(), op2.Parent()) != TREE_EQUAL {
		return rIndependent(op1, op2)
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

	op1From := op1.ItemIndex()
	op1To := op1.ToIndex()
	op2From := op2.ItemIndex()
	op2To := op2.ToIndex()
	var op1ToInOp2Context int64
	if op1From < op1To {
		// Remember the index that the to index points to in the resultant list is toIndex-1 because it's shifted
		// backwards by the removal of the value from earlier in the list. So we decrement toIndex.
		op1ToInOp2Context = op1To - 1
	} else {
		op1ToInOp2Context = op1To
	}

	if op1ToInOp2Context == op2From {
		// operations are moving the same value, so can be reduced to one operation:
		op2ToInResultingList := op2To
		if op2From < op2To {
			op2ToInResultingList = op2To - 1
		}

		op2ToInOp1Context := op2ToInResultingList
		if op1From < op2ToInResultingList {
			op2ToInOp1Context = op2ToInResultingList + 1
		}

		if op2ToInOp1Context == op1From {
			// e.g. MOVE A to B, MOVE B to A => null
			return R_CANCELLED, nil, nil
		}

		// e.g. MOVE A to B, MOVE B to C => MOVE A to C
		out := proto.Clone(op1).(*Op)
		out.SetToIndex(op2ToInOp1Context)
		return R_MERGED, out, nil
	}

	// operations act on different values, so can be swapped, but we need to shift the indexes
	// i think this can all be handled by rIndependent
	return rIndependent(op1, op2)

	//op2FromShifter := moveShifter(op1From, op1To, DISABLED, REVERSE, VALUE)
	//op2ToShifter := moveShifter(op1From, op1To, DISABLED, REVERSE, LOCATION)
	//op2xFrom, _ := op2FromShifter(op2From)
	//op2xTo, _ := op2ToShifter(op2To)
	//op2x = proto.Clone(op2).(*Op)
	//op2x.SetItemIndex(op2xFrom)
	//op2x.SetToIndex(op2xTo)
	//
	//op1FromShifter := moveShifter(op2xFrom, op2xTo, DISABLED, REVERSE, VALUE)
	//op1ToShifter := moveShifter(op2xFrom, op2xTo, DISABLED, REVERSE, LOCATION)
	//op1xFrom, _ := op1FromShifter(op1From)
	//op1xTo, _ := op1ToShifter(op1To)
	//op1x = proto.Clone(op1).(*Op)
	//op1x.SetItemIndex(op1xFrom)
	//op1x.SetToIndex(op1xTo)

	//return R_TRANSPOSED, op1x, op2x

}

func rEditSet(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Used by:
	// rEditFieldSetField
	// rEditIndexSetIndex
	// rEditKeySetKey

	// e.g. EDIT A, SET A => SET A

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return R_MERGED, proto.Clone(op2).(*Op), nil
}
func rEditFieldSetField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditSet(op1, op2)
}
func rEditIndexSetIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditSet(op1, op2)
}
func rEditKeySetKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditSet(op1, op2)
}

func rEditDelete(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Used by:
	// rEditFieldDeleteField
	// rEditIndexDeleteIndex
	// rEditKeyDeleteKey

	// e.g. EDIT A, DELETE A => DELETE A

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return R_MERGED, proto.Clone(op2).(*Op), nil
}
func rEditFieldDeleteField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditDelete(op1, op2)
}
func rEditIndexDeleteIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditDelete(op1, op2)
}
func rEditKeyDeleteKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rEditDelete(op1, op2)
}

func rEditKeyRenameKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {

	// e.g. EDIT A, RENAME B to A => RENAME B to A

	if TreeRelationship(op1.Location, op2.To()) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return R_MERGED, proto.Clone(op2).(*Op), nil
}

func rSetEdit(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Used by:
	// rSetFieldEditField
	// rSetIndexEditIndex
	// rSetKeyEditKey

	// e.g. SET A v1, EDIT A d1 => SET A v2 (use quill to calculate v2)

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	// op2 makes a change to a string that op1 just created. We can apply the edit to the original value and remove the
	// edit.
	value := op1.Value.(*Op_Scalar).Scalar.V.(*Scalar_String_).String_
	dlt := op2.Value.(*Op_Delta).Delta.V.(*Delta_Quill).Quill.Quill()
	newValue := applyDeltaToString(value, dlt)
	out := proto.Clone(op1).(*Op)
	out.Value = &Op_Scalar{Scalar: &Scalar{V: &Scalar_String_{String_: newValue}}}
	return R_MERGED, out, nil
}
func rSetFieldEditField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetEdit(op1, op2)
}
func rSetIndexEditIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetEdit(op1, op2)
}
func rSetKeyEditKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) { return rSetEdit(op1, op2) }

func rSetSet(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Used by:
	// rSetFieldSetField
	// rSetIndexSetIndex
	// rSetKeySetKey

	// e.g. SET A v1, SET A v2 => SET A v2

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return R_MERGED, proto.Clone(op2).(*Op), nil
}
func rSetFieldSetField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetSet(op1, op2)
}
func rSetIndexSetIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetSet(op1, op2)
}
func rSetKeySetKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetSet(op1, op2)
}

func rSetDelete(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Used by:
	// rSetFieldDeleteField
	// rSetIndexDeleteIndex
	// rSetKeyDeleteKey

	// e.g. SET A, DELETE A => DELETE A

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return R_MERGED, proto.Clone(op2).(*Op), nil
}
func rSetFieldDeleteField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetDelete(op1, op2)
}
func rSetIndexDeleteIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetDelete(op1, op2)
}
func rSetKeyDeleteKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rSetDelete(op1, op2)
}

func rSetKeyRenameKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// e.g. SET A, RENAME B to A => RENAME B to A

	if TreeRelationship(op1.Location, op2.To()) == TREE_EQUAL {
		// op1 has set a value, but op2 immediately overwrites this. We can ignore the set.
		return R_MERGED, proto.Clone(op2).(*Op), nil
	}

	if TreeRelationship(op1.Location, op2.Location) == TREE_EQUAL {
		//// op1 has set a value, but op2 immediately renames it. we can transpose but we must update the location of the
		//// set
		//op1x = proto.Clone(op1).(*Op)
		//op1x.Location = proto.Clone(op2).(*Op).To()
		//op2x = proto.Clone(op2).(*Op)
		//return R_TRANSPOSED, op1x, op2x

		// NO! This is impossible because the set operation might create the key if it doesn't exist already. If we
		// transpose, the rename operation will fail. MAYBE rename operations shouldn't fail when the key doesn't
		// exist?
		return rUnchanged(op1, op2)
	}

	return rIndependent(op1, op2)
}
func rInsertIndexSetIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// e.g. INSERT A v1, SET A v2 => INSERT A v2

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	out := proto.Clone(op1).(*Op)
	out.Value = proto.Clone(op2).(*Op).Value
	return R_MERGED, out, nil
}
func rInsertIndexMoveIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// e.g. INSERT A, MOVE A to B => INSERT B

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
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
	insertIndex := op1.ItemIndex()
	op2ToIndex := op2.ToIndex()
	op2ToIndexInOriginalContext := op2ToIndex
	if insertIndex < op2ToIndex {
		op2ToIndexInOriginalContext = op2ToIndex - 1
	}

	out := proto.Clone(op1).(*Op)
	out.SetItemIndex(op2ToIndexInOriginalContext)
	return R_MERGED, out, nil
}
func rInsertIndexDeleteIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// e.g. INSERT A, DELETE A => null

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
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

	// TODO: transpose is impossible here

	// TODO: MAYBE we should treat any empty message as null - e.g. if we ever delete, set a value to zero or a message to empty, we scan the tree and delete any empty messages
	// TODO: If so, what to do about empty messages in lists? Hmm (I think this might be OK - we never automatically create a list item if we access it by a missing index)

	return rUnchanged(op1, op2)

	// Naive logic would return nothing:
	// return []*Op{}
}
func rMoveIndexDeleteIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// e.g. MOVE A to B, DELETE B => DELETE A

	if TreeRelationship(op1.Parent(), op2.Parent()) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	// The index of the delete operation is in the context of the list with the move already applied, so if the move is
	// in the backwards direction, we need to shift the index of the delete to get it into the context of the initial
	// list.
	moveFromIndex := op1.ItemIndex()
	moveToIndex := op1.ToIndex()
	moveToIndexInOp2Context := moveToIndex
	if moveFromIndex < moveToIndex {
		moveToIndexInOp2Context = moveToIndex - 1
	}
	deleteIndex := op2.ItemIndex()

	if moveToIndexInOp2Context == op2.ItemIndex() {
		// delete deleted the value that op1 moved - can remove the move operation
		out := proto.Clone(op2).(*Op)
		out.SetItemIndex(moveFromIndex)
		return R_MERGED, out, nil
	}

	// TODO: standard transform logic in here - should be pretty straightforward
	moveShift := moveShifter(moveFromIndex, moveToIndex, DISABLED, REVERSE, VALUE)
	deleteIndexInOp1Context, _ := moveShift(deleteIndex)

	op2x = proto.Clone(op2).(*Op)
	op2x.SetItemIndex(deleteIndexInOp1Context)

	deleteShift := deleteShifter(deleteIndexInOp1Context, NORMAL)
	moveFromIndexInOp2xContext, _ := deleteShift(moveFromIndex)
	moveToIndexInOp2xContext, _ := deleteShift(moveToIndex)

	op1x = proto.Clone(op1).(*Op)
	op1x.SetItemIndex(moveFromIndexInOp2xContext)
	op1x.SetToIndex(moveToIndexInOp2xContext)

	return R_TRANSPOSED, op1x, op2x
}

func rRenameKeyRenameKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// op1 has moved the value from op1.Location and overwritten op1.To().
	// op2 then moves from op2.Location and overwrite op2.To()
	toFrom := TreeRelationship(op1.To(), op2.Location)
	toTo := TreeRelationship(op1.To(), op2.To())
	fromFrom := TreeRelationship(op1.Location, op2.Location)
	fromTo := TreeRelationship(op1.Location, op2.To())
	switch {
	case fromFrom == TREE_EQUAL:
		// op2 is trying to move from the same key that op1 already moved. This will always fail when apply is called.
		// From reduce we can just return the operations unchanged:

		return rUnchanged(op1, op2)

	case toTo == TREE_EQUAL:
		// Op2 is trying to move to the the same location that op1 already overwrote. We can remove op1 but we must
		// replace it with a delete to replicate the rename functionality:

		op1x = &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op1).(*Op).Location,
		}
		op2x = proto.Clone(op2).(*Op)
		return R_TRANSPOSED, op1x, op2x

	case fromTo == TREE_EQUAL && toFrom == TREE_EQUAL:
		// op1 renames A to B (overwriting B), and op2 renames B back to A. The value of A survives the round trip
		// and ends up back at A, and the value that was at B is destroyed. So the pair is equivalent to a single
		// delete of B. Note this is sequential logic, not transform logic: op2 moves the value that op1 placed at
		// B, which is A's original value.
		return R_MERGED, &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op1).(*Op).To(),
		}, nil

	case fromTo == TREE_EQUAL:
		// Op2 is trying to move another value onto the key that op1 moved away from. The operations can't be
		// transposed: if op2 ran first, it would overwrite op1's value before op1 had moved it.
		return rUnchanged(op1, op2)
	case toFrom == TREE_EQUAL:
		// Op2 is trying to move the key that op1 already overwrote. We can reduce, but we must turn op1 into a delete
		// and update the from key:

		op1x = &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op2).(*Op).Location,
		}
		op2x = proto.Clone(op2).(*Op)
		op2x.Location = proto.Clone(op1).(*Op).Location
		return R_TRANSPOSED, op1x, op2x

	default:
		// independent operations
		return rIndependent(op1, op2)
	}

}
func rRenameKeySetKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// op1 has moved the value from op1.Location and overwritten op1.To().
	// op2 then sets the value at op2.Location
	to := TreeRelationship(op1.To(), op2.Location)
	from := TreeRelationship(op1.Location, op2.Location)
	switch {
	case to == TREE_EQUAL:
		// op2 is setting the value that op1 moved to. We can transpose, but op1x must be changed to a delete.
		op1x = &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op1).(*Op).Location,
		}
		op2x = proto.Clone(op2).(*Op)
		return R_TRANSPOSED, op1x, op2x
	case from == TREE_EQUAL:
		// op2 is setting the item that op1 previously moved. We can't merge or transpose.
		return rUnchanged(op1, op2)
	default:
		// independent operations
		return rIndependent(op1, op2)
	}
}
func rRenameKeyDeleteKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// op1 has moved the value from op1.Location and overwritten op1.To().
	// op2 then deletes the value at op2.Location
	to := TreeRelationship(op1.To(), op2.Location)
	from := TreeRelationship(op1.Location, op2.Location)
	switch {
	case to == TREE_EQUAL:
		// op2 is deleting the value that op1 moved. We can transpose, but op1x must be changed to a delete.
		op1x = &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op1).(*Op).Location,
		}
		op2x = proto.Clone(op2).(*Op)
		return R_TRANSPOSED, op1x, op2x
	case from == TREE_EQUAL:
		// op2 is deleting the at the key that op1 previously moved from. This key will be empty. We can ignore the
		// delete.
		return R_MERGED, proto.Clone(op1).(*Op), nil
	default:
		// independent operations
		return rIndependent(op1, op2)
	}
}

func rDeleteFieldEditField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	switch TreeRelationship(op1.Location, op2.Location) {
	case TREE_EQUAL:
		// op2 is editing a value that was previously deleted by op1. Operations can't be merged or transposed.
		return rUnchanged(op1, op2)
	default:
		return rIndependent(op1, op2)
	}
}
func rDeleteFieldSetField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {

	switch TreeRelationship(op1.Location, op2.Location) {
	case TREE_EQUAL, TREE_DESCENDENT:
		// TREE_EQUAL: Op2 has set a value that Op1 previously deleted. We can ignore the delete.
		// TREE_DESCENDENT: Op2 has set a value that is an ancestor of a value that Op1 previously deleted. We can
		// ignore the delete.
		op2x = proto.Clone(op2).(*Op)
		return R_MERGED, op2x, nil
	case TREE_ANCESTOR:
		// Op2 has set a value that is a descendent of a value that Op1 previously deleted. We cannot combine the
		// operations, and they cannot be swapped.
		return rUnchanged(op1, op2)
	default:
		return rIndependent(op1, op2)
	}
}
func rDeleteDelete(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Used by:
	// rDeleteFieldDeleteField
	// rDeleteKeyDeleteKey
	// rDeleteOneofDeleteOneof
	switch TreeRelationship(op1.Location, op2.Location) {
	case TREE_EQUAL:
		// op2 is deleting a value that was previously deleted by op1. Operations can be merged to a single delete.
		return R_MERGED, proto.Clone(op1).(*Op), nil
	case TREE_ANCESTOR:
		// op2 is inside a value that was deleted by op1. Second delete may create an empty item, so operations can't
		// be merged or transposed.
		return rUnchanged(op1, op2)
	case TREE_DESCENDENT:
		// op2 is deleting an ancestor of a value that was deleted by op1. Operations can be merged to a single delete
		// at op2.
		return R_MERGED, proto.Clone(op2).(*Op), nil
	default:
		return rIndependent(op1, op2)
	}
}
func rDeleteFieldDeleteField(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rDeleteDelete(op1, op2)
}
func rDeleteKeyDeleteKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rDeleteDelete(op1, op2)
}
func rDeleteOneofDeleteOneof(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rDeleteDelete(op1, op2)
}

func rDeleteIndexDeleteIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// This is distinct from rDeleteDelete because deletes at the same index operate on separate values
	switch TreeRelationship(op1.Location, op2.Location) {
	case TREE_EQUAL:
		// op2 is deleting at an index that was previously deleted by op1. Operations are independent.
		return rIndependent(op1, op2)
	case TREE_ANCESTOR:
		// op2 is deleting inside a value that was deleted by op1. Second delete may create an empty item, so
		// operations can't be merged or transposed.
		return rUnchanged(op1, op2)
	case TREE_DESCENDENT:
		// op2 is deleting an ancestor of a value that was deleted by op1. Operations can be merged to a single delete
		// at op2.
		return R_MERGED, proto.Clone(op2).(*Op), nil
	default:
		return rIndependent(op1, op2)
	}
}

func rDeleteIndexEditIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rIndependent(op1, op2)
	//panic("rDeleteIndexEditIndex not implemented")
}
func rDeleteIndexSetIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rIndependent(op1, op2)
	//panic("rDeleteIndexSetIndex not implemented")
}
func rDeleteIndexInsertIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rIndependent(op1, op2)
	//panic("rDeleteIndexInsertIndex not implemented")
}
func rDeleteIndexMoveIndex(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	return rIndependent(op1, op2)
	//panic("rDeleteIndexMoveIndex not implemented")
}
func rDeleteKeyEditKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Mirrors rDeleteFieldEditField: unlike list indexes, a delete and an edit at the same key act on the same
	// value (the edit may re-create the deleted key), so the operations can't be merged or transposed.
	switch TreeRelationship(op1.Location, op2.Location) {
	case TREE_EQUAL:
		return rUnchanged(op1, op2)
	default:
		return rIndependent(op1, op2)
	}
}
func rDeleteKeySetKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	// Mirrors rDeleteFieldSetField.
	switch TreeRelationship(op1.Location, op2.Location) {
	case TREE_EQUAL, TREE_DESCENDENT:
		// op2 sets the value (or an ancestor of the value) that op1 deleted, so the delete is redundant.
		return R_MERGED, proto.Clone(op2).(*Op), nil
	case TREE_ANCESTOR:
		// op2 sets a value inside the value that op1 deleted. The set may re-create the deleted tree, so the
		// operations can't be merged or transposed.
		return rUnchanged(op1, op2)
	default:
		return rIndependent(op1, op2)
	}
}
func rDeleteKeyRenameKey(op1, op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.Location, op2.To())
	switch {
	case from == TREE_EQUAL:
		// op2 is renaming the key that op1 deleted. This will always fail when apply is called, so we can just
		// return the operations unchanged.
		return rUnchanged(op1, op2)
	case to == TREE_EQUAL:
		// op2 renames another key onto the key that op1 deleted. The rename overwrites its destination anyway, so
		// the delete is redundant.
		return R_MERGED, proto.Clone(op2).(*Op), nil
	default:
		return rIndependent(op1, op2)
	}
}
