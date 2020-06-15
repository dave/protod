package delta

import (
	"github.com/golang/protobuf/proto"
)

func (t *Op) Transform(op *Op, priority bool) *Op {
	if t == nil || op == nil {
		return nil
	}
	if op.Type == Op_Compound {
		var transformed []*Op
		for _, o := range op.Ops {
			ox := t.Transform(o, priority)
			if ox != nil {
				transformed = append(transformed, ox)
			}
		}
		switch {
		case len(transformed) == 0:
			return nil
		case len(transformed) == 1:
			return transformed[0]
		default:
			return &Op{
				Type: Op_Compound,
				Ops:  transformed,
			}
		}
	}
	if t.Type == Op_Compound {
		out := proto.Clone(op).(*Op)
		for _, t := range t.Ops {
			out = t.Transform(out, priority)
			if out == nil {
				return nil
			}
		}
		return out
	}
	return t.transform(op, priority)
}

func transformIndependent(t, op *Op) *Op {

	// op1 and op2 are not acting on the same value, or the values don't conflict.

	behaviour := GetBehaviour(t)
	opBehaviour := GetBehaviour(op)

	if behaviour.ItemIsDeleted && TreeRelationship(t.Location, op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that t deleted. We should delete op.
		return nil
	}

	if behaviour.ValueIsDeleted && TreeRelationship(t.To(), op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that t deleted. We should delete op.
		return nil
	}

	if behaviour.IndexShifter != nil && TreeRelationship(t.Parent(), op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that may have had it's list index shifted by t.
		// We should update the list index of the locator using the index shifter function.
		shifter := behaviour.IndexShifter(t, op, false)
		index := len(t.Location) - 1
		value := op.Location[index].V.(*Locator_Index).Index
		out := proto.Clone(op).(*Op)
		out.Location[index].V.(*Locator_Index).Index = shifter(value)
		if opBehaviour.ValueIsLocation && TreeRelationship(t.Parent(), op.Parent()) == TREE_EQUAL {
			// If t and op both act on values within the same list (have the same parent), AND op has a location at
			// it's value, then we update the location using the shifter. Example is two moves which are acting on
			// different values within a list.
			value := op.Value.(*Op_Index).Index
			out.Value.(*Op_Index).Index = shifter(value)
		}
		return out
	}

	if behaviour.KeyShifter != nil && TreeRelationship(t.Parent(), op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that may have had it's map key shifted by t. We
		// should update the map key of the locator using the index shifter function.
		shifter := behaviour.KeyShifter(t, op, false)
		index := len(t.Location) - 1
		value := op.Location[index].V.(*Locator_Key).Key
		out := proto.Clone(op).(*Op)
		out.Location[index] = &Locator{V: &Locator_Key{Key: shifter(value)}}
		// We don't need to worry about updating the value because all possible instances where the value key would
		// need updating are handled by special cases. e.g. conflicting map moves.
		return out
	}

	return proto.Clone(op).(*Op)
}

func transformEditEdit(t, op *Op, priority bool) *Op {
	// Used by:
	// transformEditFieldEditField
	// transformEditIndexEditIndex
	// transformEditKeyEditKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// Two delta edits operating on the same value - use Quill library to transform the operation.
	tQuill := t.Value.(*Op_Delta).Delta.Quill()
	opQuill := op.Value.(*Op_Delta).Delta.Quill()
	out := proto.Clone(op).(*Op)
	out.Value = &Op_Delta{Delta: DeltaFromQuill(tQuill.Transform(*opQuill, priority))}
	return out
}

func transformEditOverwrite(t, op *Op) *Op {
	// Used by:
	// transformEditFieldSetField
	// transformEditFieldDeleteField
	// transformEditIndexSetIndex
	// transformEditIndexDeleteIndex
	// transformEditKeySetKey
	// transformEditKeyDeleteKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// Op is trying to overwrite the value that t has modified. In order to converge, op will have priority.
	return proto.Clone(op).(*Op)
}

func transformEditFieldEditField(t, op *Op, priority bool) *Op {
	return transformEditEdit(t, op, priority)
}
func transformEditFieldSetField(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}
func transformEditFieldDeleteField(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}

func transformEditIndexEditIndex(t, op *Op, priority bool) *Op {
	return transformEditEdit(t, op, priority)
}
func transformEditIndexSetIndex(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}
func transformEditIndexInsertIndex(t, op *Op, priority bool) *Op {
	// Op is trying to insert a value into a list after t modified a value. Even when t and op act on the same
	// location, they are independent.
	return transformIndependent(t, op)
}
func transformEditIndexMoveIndex(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	// Op is trying to move a value in a list after op modified a value. Even when t and op act on the same
	// location, they are independent.
	return transformIndependent(t, op)
}
func transformEditIndexDeleteIndex(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}

func transformEditKeyEditKey(t, op *Op, priority bool) *Op {
	return transformEditEdit(t, op, priority)
}
func transformEditKeySetKey(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}
func transformEditKeyRenameKey(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is moving the value that t already modified. Continue with op.
		return proto.Clone(op).(*Op)
	case to == TREE_EQUAL:
		// op is overwriting the value that t already modified. In order to converge, op must take priority.
		return proto.Clone(op).(*Op)
	default:
		panic("")
	}
}
func transformEditKeyDeleteKey(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}

func transformOverwriteEdit(t, op *Op) *Op {
	// Used by:
	// transformSetFieldEditField
	// transformSetKeyEditKey
	// transformSetIndexEditIndex

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op is trying to edit a value that t has already overwritten. In order to converge, t must take priority.
	return nil
}

func transformSetFieldEditField(t, op *Op, priority bool) *Op {
	return transformOverwriteEdit(t, op)
}

func transformOverwriteOverwrite(t, op *Op, priority bool) *Op {
	// Used by:
	// transformSetFieldSetField
	// transformSetFieldDeleteField
	// transformSetIndexSetIndex
	// transformSetIndexDeleteIndex
	// transformSetKeySetKey
	// transformSetKeyDeleteKey
	// transformDeleteFieldSetField
	// transformDeleteIndexSetIndex
	// transformDeleteKeySetKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// Op and t are both overwriting the same value. Use priority to determine the outcome.
	if priority {
		// When t has priority, remove op.
		return nil
	}
	return proto.Clone(op).(*Op)
}

func transformSetFieldSetField(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformSetFieldDeleteField(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformSetIndexEditIndex(t, op *Op, priority bool) *Op {
	return transformOverwriteEdit(t, op)
}
func transformSetIndexSetIndex(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformSetIndexInsertIndex(t, op *Op, priority bool) *Op {
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op is inserting at the same list index that t has already replaced. This inserts a new value, so is independent.
	return proto.Clone(op).(*Op)
}
func transformSetIndexMoveIndex(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is attempting to move the value that t already replaced. We can continue with op.
		return proto.Clone(op).(*Op)
	case to == TREE_EQUAL:
		// op is attempting to move a value and place it at the same index that t overwrote. The move operation inserts
		// the moved value and shifts the overwritten value, so the operations are independent.
		return proto.Clone(op).(*Op)
	default:
		panic("")
	}
}
func transformSetIndexDeleteIndex(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformSetKeyEditKey(t, op *Op, priority bool) *Op {
	return transformOverwriteEdit(t, op)
}
func transformSetKeySetKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformSetKeyRenameKey(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is attempting to move the value that t already overwrote. We can continue with op.
		return proto.Clone(op).(*Op)
	case to == TREE_EQUAL:
		// op is attempting to overwrite the same value that t already overwrote. We can use priority to determine
		// which operation wins. However, if we remove op (the move operation), we must replace it with one that
		// deletes the "from" value (thus simulating the move operation running before the replace).
		if priority {
			return &Op{
				Type:     Op_Delete,
				Location: proto.Clone(op).(*Op).Location,
			}
		}
		return proto.Clone(op).(*Op)
	default:
		panic("")
	}
}
func transformSetKeyDeleteKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformInsertIndexEditIndex(t, op *Op, priority bool) *Op {

	// Note: not needed because all paths lead to transformIndependent
	// if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
	//	return transformIndependent(t, op)
	// }

	// op is editing at the same index that t has inserted. op will edit at the shifted index and operations will be
	// independent. This is handled by transformIndependent.
	return transformIndependent(t, op)
}
func transformInsertIndexSetIndex(t, op *Op, priority bool) *Op {

	// Note: not needed because all paths lead to transformIndependent
	// if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
	//	return transformIndependent(t, op)
	// }

	// op is replacing at the same index that t has inserted. op will replace at the shifted index and will be
	// independent. This is handled by transformIndependent.
	return transformIndependent(t, op)
}
func transformInsertIndexInsertIndex(t, op *Op, priority bool) *Op {
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// Both operations are inserting at the same index. We should use priority to determine which is shifted.
	shifter := insertShifter(t.Item().V.(*Locator_Index).Index, priority, true)
	index := len(op.Location) - 1
	value := op.Location[index].V.(*Locator_Index).Index
	out := proto.Clone(op).(*Op)
	out.Location[index].V.(*Locator_Index).Index = shifter(value)
	return out
}
func transformInsertIndexMoveIndex(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to move the value that was at the same index as t inserted at. We can just apply the shifter
		// function to both from and to locations and the operations are independent. This is handled correctly by
		// transformIndependent.
		return transformIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to move a value to the same index that t inserted at. We can use priority to determine
		// which is shifted.
		shifter := insertShifter(t.Item().V.(*Locator_Index).Index, priority, true)
		index := len(op.Location) - 1
		moveFrom := op.Location[index].V.(*Locator_Index).Index
		moveTo := op.Value.(*Op_Index).Index
		out := proto.Clone(op).(*Op)
		out.Location[index].V.(*Locator_Index).Index = shifter(moveFrom)
		out.Value.(*Op_Index).Index = shifter(moveTo)
		return out
	default:
		panic("")
	}
}
func transformInsertIndexDeleteIndex(t, op *Op, priority bool) *Op {

	// Note: not needed because all paths lead to transformIndependent
	// if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
	//	return transformIndependent(t, op)
	// }

	// op is deleting at the same index that t has inserted. op will delete at the shifted index and will be
	// independent. This is handled by transformIndependent.
	return transformIndependent(t, op)
}

func transformMoveIndexModifyIndex(t, op *Op, priority bool) *Op {
	// Shared by:
	// transformMoveIndexEditIndex
	// transformMoveIndexSetIndex
	// transformMoveIndexDeleteIndex

	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to modify the value at the index that t has moved to. We can continue with op with shifted
		// location.
		return transformIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to modify the value at the index that t has moved to. The operations are independent and we can
		// continue with op after shifting it's location
		return transformIndependent(t, op)
	default:
		panic("")
	}
}

func transformMoveIndexEditIndex(t, op *Op, priority bool) *Op {
	return transformMoveIndexModifyIndex(t, op, priority)
}
func transformMoveIndexSetIndex(t, op *Op, priority bool) *Op {
	return transformMoveIndexModifyIndex(t, op, priority)
}
func transformMoveIndexInsertIndex(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is inserting a new value at the same location that t moved from. Operations are independent and we can
		// run op after shifting location
		return transformIndependent(t, op)
	case to == TREE_EQUAL:
		// op is inserting a new value at the same location that t moved to. We can use priority to determine which
		// operation is shifted.
		shifter := moveShifter(t.Item().V.(*Locator_Index).Index, t.Value.(*Op_Index).Index, priority)
		index := len(op.Location) - 1
		value := op.Location[index].V.(*Locator_Index).Index
		out := proto.Clone(op).(*Op)
		out.Location[index].V.(*Locator_Index).Index = shifter(value)
		return out
	default:
		panic("")
	}
}
func transformMoveIndexMoveIndex(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	fromFrom := TreeRelationship(t.Location, op.Location)
	fromTo := TreeRelationship(t.Location, op.To())
	toFrom := TreeRelationship(t.To(), op.Location)
	toTo := TreeRelationship(t.To(), op.To())
	switch {
	case fromFrom == TREE_EQUAL && toTo == TREE_EQUAL:
		// Op is trying to move the value that t already moved, and the "to" locations are the same. Operations are
		// identical so we can simply delete op.
		return nil
	case fromFrom == TREE_EQUAL:
		// Op is trying to move the value that t already moved, and the "to" locations are different. So we can use
		// priority ot determine which operation should win. If the transformer has priority, we can just remove op.
		// If not, we use the index shifter to update the from and to location so that op moves the correct value to
		// the intended location.
		if priority {
			return nil
		}
		// priority in shifter doesn't matter because it is only used when i == toIndex, and we know t.To() != op.To()
		shifter := moveShifter(t.Item().V.(*Locator_Index).Index, t.Value.(*Op_Index).Index, false)
		index := len(op.Location) - 1
		opFrom := op.Location[index].V.(*Locator_Index).Index
		opTo := op.Value.(*Op_Index).Index
		out := proto.Clone(op).(*Op)
		out.Location[index].V.(*Locator_Index).Index = shifter(opFrom)
		out.Value.(*Op_Index).Index = shifter(opTo)
		return out
	case toTo == TREE_EQUAL:
		// Op is trying to move another value to the same index that t just moved a value to. We can use priority to
		// determine which value is shifted.
		shifter := moveShifter(t.Item().V.(*Locator_Index).Index, t.Value.(*Op_Index).Index, priority)
		index := len(op.Location) - 1
		opFrom := op.Location[index].V.(*Locator_Index).Index
		opTo := op.Value.(*Op_Index).Index
		out := proto.Clone(op).(*Op)
		out.Location[index].V.(*Locator_Index).Index = shifter(opFrom)
		out.Value.(*Op_Index).Index = shifter(opTo)
		return out
	case fromTo == TREE_EQUAL && toFrom == TREE_EQUAL:
		// Op is trying to move the value at the to index of the move that t has just done, and move to the from index.
		// Since both moves are non destructive and shift the other values around these operations are independent and
		// can be handled by transformIndependent.
		return transformIndependent(t, op)
	case fromTo == TREE_EQUAL:
		// Op is trying to move to the index that t just moved from. Operations are independent and can be handled by
		// transformIndependent.
		return transformIndependent(t, op)
	case toFrom == TREE_EQUAL:
		// Op is trying to move from the index that t just moved to. Operations are independent and can be handled by
		// transformIndependent.
		return transformIndependent(t, op)
	default:
		// Operations are independent.
		return transformIndependent(t, op)
	}
}
func transformMoveIndexDeleteIndex(t, op *Op, priority bool) *Op {
	return transformMoveIndexModifyIndex(t, op, priority)
}

func transformRenameKeyEditKey(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to modify the value that t moved. Op can continue with shifted key, which is correctly handled
		// by transformIndependent.
		return transformIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to modify the value that t has already overwritten. In order to converge, the move must take
		// priority.
		return nil
	default:
		panic("")
	}
}
func transformRenameKeySetKey(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to replace the value that t moved. Op can continue with shifted key, which is correctly handled
		// by transformIndependent.
		return transformIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to replace the value that t has overwritten. We can use priority to determine the winner.
		if priority {
			// if t has priority, we can just remove op
			return nil
		}
		// if op has priority, it can continue with a shifted key, which is correctly handled by transformIndependent.
		return transformIndependent(t, op)
	default:
		panic("")
	}
}
func transformRenameKeyRenameKey(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	// t has moved the value from t.Location and overwritten t.To().
	// op wants to move from op.Location and overwrite op.To()
	toFrom := TreeRelationship(t.To(), op.Location)
	toTo := TreeRelationship(t.To(), op.To())
	fromFrom := TreeRelationship(t.Location, op.Location)
	fromTo := TreeRelationship(t.Location, op.To())
	switch {
	case fromFrom == TREE_EQUAL && toTo == TREE_EQUAL:
		// Op is trying to move the value that t already moved, and the "to" locations are the same. We can simply
		// remove op.
		return nil
	case fromFrom == TREE_EQUAL:
		// Op is trying to move the value that t already moved, and the "to" locations are different. We can use
		// priority to determine which to location is used. If t has priority, delete the op. If not, we change the
		// From location to move the correct value.
		if priority {
			return nil
		}
		out := proto.Clone(op).(*Op)
		out.Location = proto.Clone(t).(*Op).To()
		return out
	case toTo == TREE_EQUAL:
		// Op is trying to move a value and overwrite the value that t already overwrote. We can use priority to
		// determine which value is used. If the transformer has priority, remove op. If not, continue with op. If
		// we remove op, we must replace with an operation that deletes the "from" location.
		if priority {
			return &Op{
				Type:     Op_Delete,
				Location: proto.Clone(op).(*Op).Location,
			}
		}
		return proto.Clone(op).(*Op)
	case fromTo == TREE_EQUAL && toFrom == TREE_EQUAL:
		// Op is trying to move the value that t has already overwritten, and the "to" location is the value that
		// t moved. In order to converge, we must delete both values, so we replace op with a delete that removes at
		// the From location.
		return &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op).(*Op).Location,
		}
	case fromTo == TREE_EQUAL:
		// Op is trying to overwrite the value that t already moved. We can simply run op with an updated "to"
		// location.
		out := proto.Clone(op).(*Op)
		out.Value.(*Op_Key).Key = proto.Clone(t).(*Op).Value.(*Op_Key).Key
		return out
	case toFrom == TREE_EQUAL:
		// Op is trying to move the value that t already overwrote. We can continue with op.
		return proto.Clone(op).(*Op)
	default:
		// independent operations
		return proto.Clone(op).(*Op)
	}
}
func transformRenameKeyDeleteKey(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to delete the value that t moved. Op can continue with shifted key, which is correctly handled
		// by transformIndependent.
		return transformIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to delete the value that t has already overwritten. We can simply remove op.
		return nil
	default:
		panic("")
	}
}

func transformDeleteEdit(t, op *Op) *Op {
	// Used by:
	// transformDeleteFieldEditField
	// transformDeleteIndexEditIndex
	// transformDeleteKeyEditKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op is trying to modify the value that t already deleted. In order to converge, t must have priority.
	return nil
}

func transformDeleteFieldEditField(t, op *Op, priority bool) *Op {
	return transformDeleteEdit(t, op)
}
func transformDeleteFieldSetField(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformDeleteDelete(t, op *Op) *Op {
	// Used by:
	// transformDeleteFieldDeleteField
	// transformDeleteIndexDeleteIndex
	// transformDeleteKeyDeleteKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op and t are both deleting the same value. We can remove op.
	return nil
}
func transformDeleteFieldDeleteField(t, op *Op, priority bool) *Op {
	return transformDeleteDelete(t, op)
}

func transformDeleteIndexEditIndex(t, op *Op, priority bool) *Op {
	return transformDeleteEdit(t, op)
}
func transformDeleteIndexSetIndex(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformDeleteIndexInsertIndex(t, op *Op, priority bool) *Op {
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op is trying to insert at the same index as t deleted from. Operations are independent.
	return transformIndependent(t, op)
}
func transformDeleteIndexMoveIndex(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to move the value that op has already deleted. In order to converge, t must take priority.
		return nil
	case to == TREE_EQUAL:
		// op is trying to move to the index of the value that op already deleted. Operations are independent.
		return transformIndependent(t, op)
	default:
		panic("")
	}
}
func transformDeleteIndexDeleteIndex(t, op *Op, priority bool) *Op {
	return transformDeleteDelete(t, op)
}

func transformDeleteKeyEditKey(t, op *Op, priority bool) *Op {
	return transformDeleteEdit(t, op)
}
func transformDeleteKeySetKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformDeleteKeyRenameKey(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return transformIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to move the value that op already deleted. In order to converge we must remove op and replace
		// with an operation that deletes the "to" value.
		return &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op).(*Op).To(),
		}
	case to == TREE_EQUAL:
		// op is trying to overwrite the value that op already deleted. We can use priority to determine which outcome
		// to accept. If we delete op, we must replace with an operation that deleted the "from" value.
		if priority {
			return &Op{
				Type:     Op_Delete,
				Location: proto.Clone(op).(*Op).Location,
			}
		}
		return proto.Clone(op).(*Op)
	default:
		panic("")
	}
}
func transformDeleteKeyDeleteKey(t, op *Op, priority bool) *Op {
	return transformDeleteDelete(t, op)
}
