package pdelta

import (
	"github.com/golang/protobuf/proto"
)

// Transform takes two operations op1 and op2 that operate on the same state A, and calculates op2x. This may also be
// run with op1 and op2 swapped to calculate op1x. The combined effect of op1+op2x and op2+op1x always converges on the
// same state C.
//
//	       A -> o
//	           / \
//	          /   \
//	  op1 -> /     \ <- op2
//	        /       \
//	       /         \
//	B1 -> o           o <- B2
//	       \         /
//	        \       /
//	 op2x -> \     / <- [op1x]
//	          \   /
//	           \ /
//	       C -> o
//
// To calculate op1x and op2x successfully, one of the input operations must be given priority, and this must be the
// same for the two transforms.
//
// e.g. to give op1 priority:
// op2x := op1.Transform(op2, true)
// op1x := op2.Transform(op1, false)
func (op1 *Op) Transform(op2 *Op, op1priority bool) (op2x *Op) {
	if IsNull(op2) {
		return nil
	}
	if IsNull(op1) {
		return proto.Clone(op2).(*Op)
	}
	if op2.Type == Op_Compound {
		// TODO: more comments here
		var tx *Op
		var transformed []*Op
		for i, o := range op2.Ops {

			switch i {
			case 0:
				tx = op1
			default:
				// we must transform tx against the previous operation
				previous := op2.Ops[i-1]
				tx = previous.Transform(tx, !op1priority)
			}

			ox := tx.Transform(o, op1priority)

			if ox != nil {
				transformed = append(transformed, ox)
			}
		}
		return Compound(transformed...)
	}
	if op1.Type == Op_Compound {
		opx := proto.Clone(op2).(*Op)
		for _, tx := range op1.Ops {
			opx = tx.Transform(opx, op1priority)
			if opx == nil {
				return nil
			}
		}
		return opx
	}
	found, oneofLocation := SplitCommonOneofAncestor(op1.Location, op2.Location, true)
	if found {
		// t and op have a common oneof ancestor, and are acting on separate oneof root values. Any operation on the
		// descendant of a oneof value will delete the entire tree under all the other oneof values.
		valid := func(o *Op) bool {
			// Since any operation on a descendant of a oneof deletes all the other oneof root values, in most
			// situations we must delete the entire oneof tree in order to converge. The exception is when an operation
			// sets the whole oneof root value:
			return (o.Type == Op_Delete && len(o.Location) == len(oneofLocation)) ||
				(o.Type == Op_Set && len(o.Location) == len(oneofLocation)+1)
		}
		switch {
		case valid(op1) && valid(op2):
			// if both operations are valid, then use priority to determine if op2 should be removed
			if op1priority {
				// op1 has priority, so remove op2
				return nil
			} else {
				// op2 has priority, so continue
				return proto.Clone(op2).(*Op)
			}
		case valid(op1):
			// if only op1 is valid, remove op2
			return nil
		case valid(op2):
			// if only op2 is valid, continue
			return proto.Clone(op2).(*Op)
		default:
			// if neither operation is valid, in order to converge, we must delete the whole oneof group
			return &Op{
				Type:     Op_Delete,
				Location: oneofLocation,
			}
		}
	}
	return op1.transform(op2, op1priority)
}

func tIndependent(op1, op2 *Op) (op2x *Op) {

	// op1 and op2 are not acting on the same value, or the values don't conflict.
	op1behaviour := GetBehaviour(op1)
	op2behaviour := GetBehaviour(op2)

	if op1behaviour.ItemIsDeleted && TreeRelationship(op1.Location, op2.Location) == TREE_ANCESTOR {
		// Op2 is acting on a value that is a descendent of a value that op1 deleted. We should delete op2.
		return nil
	}

	if op1behaviour.ValueIsLocation && op1behaviour.ValueIsDeleted && TreeRelationship(op1.To(), op2.Location) == TREE_ANCESTOR {
		// Op2 is acting on a value that is a descendent of a value that op1 deleted. We should delete op2.
		return nil
	}

	if op1behaviour.IndexShifter != nil && TreeRelationship(op1.Parent(), op2.Location) == TREE_ANCESTOR {
		// Op2 is acting on a value that is a descendent of a value that may have had it's list index shifted by op1.
		// We should update the list index of the locator using the index shifter function.
		shifter := op1behaviour.IndexShifter(op1, DISABLED, NORMAL, VALUE)
		index := len(op1.Location) - 1
		value := op2.GetIndexAt(index)
		out := proto.Clone(op2).(*Op)
		shifted, _ := shifter(value)
		out.SetIndexAt(index, shifted)
		if op2behaviour.ValueIsLocation && TreeRelationship(op1.Parent(), op2.Parent()) == TREE_EQUAL {
			// If op1 and op2 both act on values within the same list (have the same parent), AND op2 has a location at
			// it's value, then we update the location using the location shifter. Example is two moves which are
			// acting on different values within a list.
			locationShifter := op1behaviour.IndexShifter(op1, DISABLED, NORMAL, LOCATION)
			shifted, _ = locationShifter(op2.ToIndex())
			out.SetToIndex(shifted)
		}
		return out
	}

	if op1.Type == Op_Rename {
		switch TreeRelationship(op1.Location, op2.Location) {
		case TREE_EQUAL, TREE_ANCESTOR:
			// Op2 is acting on a value that is a descendent of a value that was renamed by op1. We should update the
			// map key of the locator.
			keyIndex := len(op1.Location) - 1
			keyValue := op1.Value.(*Op_Key).Key
			out := proto.Clone(op2).(*Op)
			out.SetKeyAt(keyIndex, keyValue)
			// We don't need to worry about updating the value because all possible instances where the value key would
			// need updating are handled by special cases. e.g. conflicting map moves.
			return out
		}
	}

	return proto.Clone(op2).(*Op)
}

func tEdit(op1, op2 *Op, priority bool) (op2x *Op) {
	// Used by:
	// tEditFieldEditField
	// tEditIndexEditIndex
	// tEditKeyEditKey

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return tIndependent(op1, op2)
	}
	// Two delta edits operating on the same value - use Quill library to transform the operation.
	tQuill := op1.Value.(*Op_Delta).Delta.V.(*Delta_Quill).Quill.Quill()
	opQuill := op2.Value.(*Op_Delta).Delta.V.(*Delta_Quill).Quill.Quill()
	out := proto.Clone(op2).(*Op)
	out.Value = &Op_Delta{Delta: &Delta{V: &Delta_Quill{Quill: DeltaFromQuill(tQuill.Transform(*opQuill, priority))}}}
	return out
}
func tEditFieldEditField(op1, op2 *Op, priority bool) (op2x *Op) { return tEdit(op1, op2, priority) }
func tEditIndexEditIndex(op1, op2 *Op, priority bool) (op2x *Op) { return tEdit(op1, op2, priority) }
func tEditKeyEditKey(op1, op2 *Op, priority bool) (op2x *Op)     { return tEdit(op1, op2, priority) }

func tEditOverwrite(op1, op2 *Op) (op2x *Op) {
	// Used by:
	// tEditFieldSetField
	// tEditIndexSetIndex
	// tEditKeySetKey
	// tEditFieldDeleteField
	// tEditIndexDeleteIndex
	// tEditKeyDeleteKey
	// tSetIndexDeleteIndex

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return tIndependent(op1, op2)
	}
	// Op2 is trying to overwrite the value that op1 has modified. In order to converge, op2 will have priority.
	return proto.Clone(op2).(*Op)
}
func tOverwriteEdit(op1, op2 *Op) (op2x *Op) {
	// Used by:
	// tSetFieldEditField
	// tSetIndexEditIndex
	// tSetKeyEditKey
	// tDeleteFieldEditField
	// tDeleteIndexEditIndex
	// tDeleteKeyEditKey
	// tDeleteIndexSetIndex

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return tIndependent(op1, op2)
	}
	// op2 is trying to edit a value that op1 has already overwritten. In order to converge, op1 must take priority.
	return nil
}
func tEditFieldSetField(op1, op2 *Op, priority bool) (op2x *Op)    { return tEditOverwrite(op1, op2) }
func tEditFieldDeleteField(op1, op2 *Op, priority bool) (op2x *Op) { return tEditOverwrite(op1, op2) }
func tEditIndexSetIndex(op1, op2 *Op, priority bool) (op2x *Op)    { return tEditOverwrite(op1, op2) }
func tEditIndexDeleteIndex(op1, op2 *Op, priority bool) (op2x *Op) { return tEditOverwrite(op1, op2) }
func tEditKeySetKey(op1, op2 *Op, priority bool) (op2x *Op)        { return tEditOverwrite(op1, op2) }
func tEditKeyDeleteKey(op1, op2 *Op, priority bool) (op2x *Op)     { return tEditOverwrite(op1, op2) }
func tSetIndexDeleteIndex(op1, op2 *Op, priority bool) (op2x *Op)  { return tEditOverwrite(op1, op2) }
func tSetFieldEditField(op1, op2 *Op, priority bool) (op2x *Op)    { return tOverwriteEdit(op1, op2) }
func tDeleteFieldEditField(op1, op2 *Op, priority bool) (op2x *Op) { return tOverwriteEdit(op1, op2) }
func tSetIndexEditIndex(op1, op2 *Op, priority bool) (op2x *Op)    { return tOverwriteEdit(op1, op2) }
func tDeleteIndexEditIndex(op1, op2 *Op, priority bool) (op2x *Op) { return tOverwriteEdit(op1, op2) }
func tSetKeyEditKey(op1, op2 *Op, priority bool) (op2x *Op)        { return tOverwriteEdit(op1, op2) }
func tDeleteKeyEditKey(op1, op2 *Op, priority bool) (op2x *Op)     { return tOverwriteEdit(op1, op2) }
func tDeleteIndexSetIndex(op1, op2 *Op, priority bool) (op2x *Op)  { return tOverwriteEdit(op1, op2) }

func tEditIndexInsertIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	// Op2 is trying to insert a value into a list after op1 modified a value. Even when op1 and op2 act on the same
	// location, they are independent.
	return tIndependent(op1, op2)
}
func tInsertIndexEditIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	// Op2 is editing at the same index that op1 has inserted. op2 will edit at the shifted index and operations will be
	// independent. This is handled by tIndependent.
	return tIndependent(op1, op2)
}

func tMoveModify(op1, op2 *Op) (op2x *Op) {
	// Shared by:
	// tMoveIndexEditIndex
	// tMoveIndexSetIndex

	// op2 is trying to modify a value after op1 has moved values. Even when op1 and op2 act on the same location, they are
	// independent.
	return tIndependent(op1, op2)
}
func tModifyMove(op1, op2 *Op) (op2x *Op) {
	// Shared by:
	// tEditIndexMoveIndex
	// tSetIndexMoveIndex

	// Op2 is trying to move a value in a list after op modified a value. Even when op1 and op2 act on the same
	// location, they are independent.
	return tIndependent(op1, op2)
}
func tMoveIndexEditIndex(op1, op2 *Op, priority bool) (op2x *Op) { return tMoveModify(op1, op2) }
func tMoveIndexSetIndex(op1, op2 *Op, priority bool) (op2x *Op)  { return tMoveModify(op1, op2) }
func tEditIndexMoveIndex(op1, op2 *Op, priority bool) (op2x *Op) { return tModifyMove(op1, op2) }
func tSetIndexMoveIndex(op1, op2 *Op, priority bool) (op2x *Op)  { return tModifyMove(op1, op2) }

func tMoveIndexDeleteIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	// op2 is trying to delete a value after op1 has moved values. Even when op1 and op2 act on the same location,
	// they are independent.
	return tIndependent(op1, op2)
}
func tDeleteIndexMoveIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.Location, op2.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is trying to move the value that op1 has already deleted. In order to converge, op1 must take priority.
		return nil
	case to == TREE_EQUAL:
		// op2 is trying to move to the index of the value that op1 already deleted. Operations are independent.
		return tIndependent(op1, op2)
	default:
		panic("")
	}
}

func tEditKeyRenameKey(op1, op2 *Op, priority bool) (op2x *Op) {
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.Location, op2.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is moving the value that op1 already modified. Continue with op2.
		return proto.Clone(op2).(*Op)
	case to == TREE_EQUAL:
		// op2 is overwriting the value that op1 already modified. In order to converge, op2 must take priority.
		return proto.Clone(op2).(*Op)
	default:
		panic("")
	}
}
func tRenameKeyEditKey(op1, op2 *Op, priority bool) (op2x *Op) {
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.To(), op2.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is trying to modify the value that op1 moved. Op2 can continue with shifted key, which is correctly handled
		// by tIndependent.
		return tIndependent(op1, op2)
	case to == TREE_EQUAL:
		// op2 is trying to modify the value that op1 has already overwritten. In order to converge, the move must take
		// priority.
		return nil
	default:
		panic("")
	}
}

func tOverwrite(op1, op2 *Op, priority bool) (op2x *Op) {
	// Used by:
	// tSetFieldSetField
	// tSetIndexSetIndex
	// tSetKeySetKey
	// tSetFieldDeleteField
	// tSetKeyDeleteKey
	// tDeleteFieldSetField
	// tDeleteKeySetKey

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return tIndependent(op1, op2)
	}
	// Op2 and op1 are both overwriting the same value. Use priority to determine the outcome.
	if priority {
		// When op1 has priority, remove op2.
		return nil
	}
	return proto.Clone(op2).(*Op)
}
func tSetFieldSetField(op1, op2 *Op, priority bool) (op2x *Op) { return tOverwrite(op1, op2, priority) }
func tSetIndexSetIndex(op1, op2 *Op, priority bool) (op2x *Op) { return tOverwrite(op1, op2, priority) }
func tSetKeySetKey(op1, op2 *Op, priority bool) (op2x *Op)     { return tOverwrite(op1, op2, priority) }
func tSetFieldDeleteField(op1, op2 *Op, priority bool) (op2x *Op) {
	return tOverwrite(op1, op2, priority)
}
func tSetKeyDeleteKey(op1, op2 *Op, priority bool) (op2x *Op) { return tOverwrite(op1, op2, priority) }
func tDeleteFieldSetField(op1, op2 *Op, priority bool) (op2x *Op) {
	return tOverwrite(op1, op2, priority)
}
func tDeleteKeySetKey(op1, op2 *Op, priority bool) (op2x *Op) { return tOverwrite(op1, op2, priority) }

func tSetIndexInsertIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return tIndependent(op1, op2)
	}
	// op2 is inserting at the same list index that op1 has already replaced. This inserts a new value, so is independent.
	return proto.Clone(op2).(*Op)
}
func tInsertIndexSetIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	// op2 is replacing at the same index that op1 has inserted. op2 will replace at the shifted index and will be
	// independent. This is handled by tIndependent.
	return tIndependent(op1, op2)
}

func tSetKeyRenameKey(op2, op1 *Op, priority bool) (op2x *Op) {
	from := TreeRelationship(op2.Location, op1.Location)
	to := TreeRelationship(op2.Location, op1.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op2, op1)
	case from == TREE_EQUAL:
		// op2 is attempting to move the value that op1 already overwrote. We can continue with op2.
		return proto.Clone(op1).(*Op)
	case to == TREE_EQUAL:
		// op2 is attempting to overwrite the same value that op1 already overwrote. We can use priority to determine
		// which operation wins. However, if we remove op2 (the move operation), we must replace it with one that
		// deletes the "from" value (thus simulating the move operation running before the replace).
		if priority {
			return &Op{
				Type:     Op_Delete,
				Location: proto.Clone(op1).(*Op).Location,
			}
		}
		return proto.Clone(op1).(*Op)
	default:
		panic("")
	}
}
func tRenameKeySetKey(op1, op2 *Op, priority bool) (op2x *Op) {
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.To(), op2.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is trying to replace the value that op1 moved. Op2 can continue with shifted key, which is correctly
		// handled by tIndependent.
		return tIndependent(op1, op2)
	case to == TREE_EQUAL:
		// op2 is trying to replace the value that op1 has overwritten. We can use priority to determine the winner.
		if priority {
			// if op1 has priority, we can just remove op2
			return nil
		}
		// if op2 has priority, it can continue with a shifted key, which is correctly handled by tIndependent.
		return tIndependent(op1, op2)
	default:
		panic("")
	}
}

func tInsertIndexInsertIndex(op1, op2 *Op, priorityWinner bool) (op2x *Op) {
	var priority PriorityType
	if priorityWinner {
		priority = WINNER
	} else {
		priority = LOSER
	}
	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return tIndependent(op1, op2)
	}
	// Both operations are inserting at the same index. We should use priority to determine which is shifted.
	shifter := insertShifter(op1.ItemIndex(), priority, NORMAL, LOCATION)
	out := proto.Clone(op2).(*Op)
	shifted, _ := shifter(op2.ItemIndex())
	out.SetItemIndex(shifted)
	return out
}

func tInsertIndexMoveIndex(op1, op2 *Op, priorityWinner bool) (op2x *Op) {
	var priority PriorityType
	if priorityWinner {
		priority = WINNER
	} else {
		priority = LOSER
	}
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.Location, op2.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is trying to move the value that was at the same index as op1 inserted at. We can just apply the shifter
		// function to both from and to locations and the operations are independent. This is handled correctly by
		// tIndependent.
		return tIndependent(op1, op2)
	case to == TREE_EQUAL:
		// op2 is trying to move a value to the same index that op1 inserted at. We can use priority to determine
		// which is shifted, but the destination index should be shifted without taking account of priority.
		locationShifter := insertShifter(op1.ItemIndex(), priority, NORMAL, LOCATION)
		valueShifter := insertShifter(op1.ItemIndex(), DISABLED, NORMAL, VALUE)
		out := proto.Clone(op2).(*Op)
		shifted1, _ := valueShifter(op2.ItemIndex())
		out.SetItemIndex(shifted1)
		shifted2, _ := locationShifter(op2.ToIndex())
		out.SetToIndex(shifted2)
		return out
	default:
		panic("")
	}
}
func tMoveIndexInsertIndex(op1, op2 *Op, priorityWinner bool) (op2x *Op) {
	var priority PriorityType
	if priorityWinner {
		priority = WINNER
	} else {
		priority = LOSER
	}
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.To(), op2.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is inserting a new value at the same location that op1 moved from. Operations are independent, but we
		// don't want to use tIndependent because that would make the insert move with the moved value (it uses the
		// moveValueShifter shifter variant). We manually use moveLocationShifter to shift the location:

		// Note: priority doesn't matter here because it is only used when (i == to) || (from < to && i == to+1)
		// Since we know i == from, it cannot be used. Set to DISABLED to demonstrate this:
		shifter := moveShifter(op1.ItemIndex(), op1.ToIndex(), DISABLED, NORMAL, LOCATION)
		out := proto.Clone(op2).(*Op)
		shifted, _ := shifter(op2.ItemIndex())
		out.SetItemIndex(shifted)
		return out
	case to == TREE_EQUAL:
		// op2 is inserting a new value at the same location that op1 moved to. We can priority to determine which
		// operation is shifted.
		shifter := moveShifter(op1.ItemIndex(), op1.ToIndex(), priority, NORMAL, LOCATION)
		out := proto.Clone(op2).(*Op)
		shifted, _ := shifter(op2.ItemIndex())
		out.SetItemIndex(shifted)
		return out
	default:
		panic("")
	}
}

func tInsertIndexDeleteIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	// op2 is deleting at the same index that op1 has inserted. op2 will delete at the shifted index and will be
	// independent. This is handled by tIndependent.
	return tIndependent(op1, op2)
}
func tDeleteIndexInsertIndex(op1, op2 *Op, priority bool) (op2x *Op) {
	// op2 is trying to insert at the same index as op1 deleted from. Operations are independent.
	return tIndependent(op1, op2)
}

func tMoveIndexMoveIndex(op1, op2 *Op, priorityWinner bool) (op2x *Op) {
	var priority PriorityType
	if priorityWinner {
		priority = WINNER
	} else {
		priority = LOSER
	}
	fromFrom := TreeRelationship(op1.Location, op2.Location)
	fromTo := TreeRelationship(op1.Location, op2.To())
	toFrom := TreeRelationship(op1.To(), op2.Location)
	toTo := TreeRelationship(op1.To(), op2.To())
	switch {
	case fromFrom == TREE_EQUAL && toTo == TREE_EQUAL:
		// Op2 is trying to move the value that op1 already moved, and the "to" locations are the same. Operations are
		// identical so we can simply delete op2.
		return nil
	case fromFrom == TREE_EQUAL:
		// Op2 is trying to move the value that op1 already moved, and the "to" locations are different. So we can use
		// priority to determine which operation should win. If op1 has priority, we can just remove op2. If not, we
		// use the index shifter to update the from and to location so that op2 moves the correct value to the intended
		// location.
		if priority == WINNER {
			return nil
		}

		// Here all we need to do is modify the from location of op2 so that is uses the value at the to location of
		// op1. We don't need to use the shifter.
		locationShifter := moveShifter(op1.ItemIndex(), op1.ToIndex(), priority, NORMAL, LOCATION)
		out := proto.Clone(op2).(*Op)
		// must use location locationShifter here because that was used to shift op1.To
		shifted1, _ := locationShifter(op1.ToIndex())
		out.SetItemIndex(shifted1)
		shifted2, _ := locationShifter(op2.ToIndex())
		out.SetToIndex(shifted2)
		return out
	case toTo == TREE_EQUAL:
		// Op2 is trying to move another value to the same index that op1 just moved a value to. We can use priority to
		// determine which value is shifted.
		locationShifter := moveShifter(op1.ItemIndex(), op1.ToIndex(), priority, NORMAL, LOCATION)
		valueShifter := moveShifter(op1.ItemIndex(), op1.ToIndex(), DISABLED, NORMAL, VALUE)
		out := proto.Clone(op2).(*Op)
		shifted1, _ := valueShifter(op2.ItemIndex())
		out.SetItemIndex(shifted1)
		shifted2, _ := locationShifter(op2.ToIndex())
		out.SetToIndex(shifted2)
		return out
	case fromTo == TREE_EQUAL && toFrom == TREE_EQUAL:
		// Op2 is trying to move the value at the to index of the move that op1 has just done, and move to the from
		// index. Since both moves are non destructive and shift the other values around these operations are
		// independent and can be handled by tIndependent.
		return tIndependent(op1, op2)
	case fromTo == TREE_EQUAL:
		// Op2 is trying to move to the index that op1 just moved from. Operations are independent and can be handled
		// by tIndependent.
		return tIndependent(op1, op2)
	case toFrom == TREE_EQUAL:
		// Op2 is trying to move from the index that op1 just moved to. Operations are independent and can be handled
		// by tIndependent.
		return tIndependent(op1, op2)
	default:
		// Operations are independent.
		return tIndependent(op1, op2)
	}
}

func tRenameKeyRenameKey(op1, op2 *Op, priority bool) (op2x *Op) {
	// op1 has moved the value from op1.Location and overwritten op1.To().
	// op2 wants to move from op2.Location and overwrite op2.To()
	toFrom := TreeRelationship(op1.To(), op2.Location)
	toTo := TreeRelationship(op1.To(), op2.To())
	fromFrom := TreeRelationship(op1.Location, op2.Location)
	fromTo := TreeRelationship(op1.Location, op2.To())
	switch {
	case fromFrom == TREE_EQUAL && toTo == TREE_EQUAL:
		// Op2 is trying to move the value that op1 already moved, and the "to" locations are the same. We can simply
		// remove op.
		return nil
	case fromFrom == TREE_EQUAL:
		// Op2 is trying to move the value that op1 already moved, and the "to" locations are different. We can use
		// priority to determine which to location is used. If op1 has priority, delete the op2. If not, we change the
		// From location to move the correct value. If we remove op2, we must replace with an operation that deletes
		// the "to" location.
		if priority {
			return &Op{
				Type:     Op_Delete,
				Location: proto.Clone(op2).(*Op).To(),
			}
		}
		out := proto.Clone(op2).(*Op)
		out.Location = proto.Clone(op1).(*Op).To()
		return out
	case toTo == TREE_EQUAL:
		// Op2 is trying to move a value and overwrite the value that op1 already overwrote. We can use priority to
		// determine which value is used. If the transformer has priority, remove op2. If not, continue with op2. If
		// we remove op2, we must replace with an operation that deletes the "from" location.
		if priority {
			return &Op{
				Type:     Op_Delete,
				Location: proto.Clone(op2).(*Op).Location,
			}
		}
		return proto.Clone(op2).(*Op)
	case fromTo == TREE_EQUAL && toFrom == TREE_EQUAL:
		// Op2 is trying to move the value that op1 has already overwritten, and the "to" location is the value that
		// op1 moved. In order to converge, we must delete both values, so we replace op with a delete that removes at
		// the From location.
		return &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op2).(*Op).Location,
		}
	case fromTo == TREE_EQUAL:
		// Op2 is trying to overwrite the value that op1 already moved. We can simply run op2 with an updated "to"
		// location.
		out := proto.Clone(op2).(*Op)
		out.Value.(*Op_Key).Key = proto.Clone(op1).(*Op).Value.(*Op_Key).Key
		return out
	case toFrom == TREE_EQUAL:
		// Op2 is trying to move the value that op1 already overwrote. We can continue with op2.
		return proto.Clone(op2).(*Op)
	default:
		// independent operations
		return tIndependent(op1, op2)
	}
}

func tRenameKeyDeleteKey(op1, op2 *Op, priority bool) (op2x *Op) {
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.To(), op2.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is trying to delete the value that op1 moved. Op2 can continue with shifted key, which is correctly
		// handled by tIndependent.
		return tIndependent(op1, op2)
	case to == TREE_EQUAL:
		// op2 is trying to delete the value that op1 has already overwritten. We can simply remove op2.
		return nil
	default:
		panic("")
	}
}
func tDeleteKeyRenameKey(op1, op2 *Op, priority bool) (op2x *Op) {
	from := TreeRelationship(op1.Location, op2.Location)
	to := TreeRelationship(op1.Location, op2.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(op1, op2)
	case from == TREE_EQUAL:
		// op2 is trying to move the value that op1 already deleted. In order to converge we must remove op2 and replace
		// with an operation that deletes the "to" value.
		return &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op2).(*Op).To(),
		}
	case to == TREE_EQUAL:
		// op2 is trying to overwrite the value that op1 already deleted. continue with op2.
		return proto.Clone(op2).(*Op)
	default:
		panic("")
	}
}

func tDelete(op1, op2 *Op) (op2x *Op) {
	// Used by:
	// tDeleteFieldDeleteField
	// tDeleteIndexDeleteIndex
	// tDeleteKeyDeleteKey

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return tIndependent(op1, op2)
	}
	// op2 and op1 are both deleting the same value. We can remove op2.
	return nil
}
func tDeleteFieldDeleteField(op1, op2 *Op, priority bool) (op2x *Op) { return tDelete(op1, op2) }
func tDeleteIndexDeleteIndex(op1, op2 *Op, priority bool) (op2x *Op) { return tDelete(op1, op2) }
func tDeleteKeyDeleteKey(op1, op2 *Op, priority bool) (op2x *Op)     { return tDelete(op1, op2) }
func tDeleteOneofDeleteOneof(op1, op2 *Op, priority bool) (op2x *Op) { return tDelete(op1, op2) }
