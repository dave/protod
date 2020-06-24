package delta

import (
	"github.com/golang/protobuf/proto"
)

func (t *Op) Transform(op *Op, priority bool) *Op {
	if op == nil {
		return nil
	}
	if t == nil {
		return proto.Clone(op).(*Op)
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
			return Compound(transformed...)
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
	found, oneofLocation := SplitCommonOneofAncestor(t.Location, op.Location)
	if found {
		// t and op have a common oneof ancestor, and are acting on separate values. Any operation on the descendant of
		// a oneof value will delete the entire tree under all the other oneof values.

		var priorityOp, notOp *Op
		if priority {
			priorityOp = t
			notOp = op
		} else {
			priorityOp = op
			notOp = t
		}

		valid := map[Op_Type]bool{
			Op_Set:    true,
			Op_Edit:   false,
			Op_Insert: true,
			Op_Move:   false,
			Op_Rename: false,
			Op_Delete: false,
		}

		if !valid[priorityOp.Type] && valid[notOp.Type] {
			// if notOp is valid and priorityOp is not, we can swap them round so a set/insert always takes priority
			// over an edit/move/rename/delete.
			priorityOp, notOp = notOp, priorityOp
		}

		if valid[priorityOp.Type] {
			// nuke everything, and re-run the priority operation (if it's a set / insert).
			return Compound(
				&Op{
					Type:     Op_Delete,
					Location: oneofLocation,
				},
				proto.Clone(priorityOp).(*Op),
			)
		} else {
			// nuke everything.
			return &Op{
				Type:     Op_Delete,
				Location: oneofLocation,
			}
		}
	}
	return t.transform(op, priority)
}

func tIndependent(t, op *Op) *Op {

	// op1 and op2 are not acting on the same value, or the values don't conflict.
	behaviour := GetBehaviour(t)
	opBehaviour := GetBehaviour(op)

	if behaviour.ItemIsDeleted && TreeRelationship(t.Location, op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that t deleted. We should delete op.
		return nil
	}

	if behaviour.ValueIsLocation && behaviour.ValueIsDeleted && TreeRelationship(t.To(), op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that t deleted. We should delete op.
		return nil
	}

	if behaviour.IndexValueShifter != nil && TreeRelationship(t.Parent(), op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that may have had it's list index shifted by t.
		// We should update the list index of the locator using the index shifter function.
		valueShifter := behaviour.IndexValueShifter(t, op)
		out := proto.Clone(op).(*Op)
		out.SetItemIndex(valueShifter(op.ItemIndex()))
		if opBehaviour.ValueIsLocation && TreeRelationship(t.Parent(), op.Parent()) == TREE_EQUAL {
			// If t and op both act on values within the same list (have the same parent), AND op has a location at
			// it's value, then we update the location using the location shifter. Example is two moves which are
			// acting on different values within a list.
			locationShifter := behaviour.IndexLocationShifter(t, op)
			out.SetToIndex(locationShifter(op.ToIndex()))
		}
		return out
	}

	if behaviour.KeyShifter != nil && TreeRelationship(t.Parent(), op.Location) == TREE_ANCESTOR {
		// Op is acting on a value that is a descendent of a value that may have had it's map key shifted by t. We
		// should update the map key of the locator using the index shifter function.
		shifter := behaviour.KeyShifter(t, op)
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

func tEdit(t, op *Op, priority bool) *Op {
	// Used by:
	// tEditFieldEditField
	// tEditIndexEditIndex
	// tEditKeyEditKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return tIndependent(t, op)
	}
	// Two delta edits operating on the same value - use Quill library to transform the operation.
	tQuill := t.Value.(*Op_Delta).Delta.Quill()
	opQuill := op.Value.(*Op_Delta).Delta.Quill()
	out := proto.Clone(op).(*Op)
	out.Value = &Op_Delta{Delta: DeltaFromQuill(tQuill.Transform(*opQuill, priority))}
	return out
}
func tEditFieldEditField(t, op *Op, priority bool) *Op { return tEdit(t, op, priority) }
func tEditIndexEditIndex(t, op *Op, priority bool) *Op { return tEdit(t, op, priority) }
func tEditKeyEditKey(t, op *Op, priority bool) *Op     { return tEdit(t, op, priority) }

func tEditOverwrite(t, op *Op) *Op {
	// Used by:
	// tEditFieldSetField
	// tEditIndexSetIndex
	// tEditKeySetKey
	// tEditFieldDeleteField
	// tEditIndexDeleteIndex
	// tEditKeyDeleteKey
	// tSetIndexDeleteIndex

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return tIndependent(t, op)
	}
	// Op is trying to overwrite the value that t has modified. In order to converge, op will have priority.
	return proto.Clone(op).(*Op)
}
func tOverwriteEdit(t, op *Op) *Op {
	// Used by:
	// tSetFieldEditField
	// tSetIndexEditIndex
	// tSetKeyEditKey
	// tDeleteFieldEditField
	// tDeleteIndexEditIndex
	// tDeleteKeyEditKey
	// tDeleteIndexSetIndex

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return tIndependent(t, op)
	}
	// op is trying to edit a value that t has already overwritten. In order to converge, t must take priority.
	return nil
}
func tEditFieldSetField(t, op *Op, priority bool) *Op    { return tEditOverwrite(t, op) }
func tEditFieldDeleteField(t, op *Op, priority bool) *Op { return tEditOverwrite(t, op) }
func tEditIndexSetIndex(t, op *Op, priority bool) *Op    { return tEditOverwrite(t, op) }
func tEditIndexDeleteIndex(t, op *Op, priority bool) *Op { return tEditOverwrite(t, op) }
func tEditKeySetKey(t, op *Op, priority bool) *Op        { return tEditOverwrite(t, op) }
func tEditKeyDeleteKey(t, op *Op, priority bool) *Op     { return tEditOverwrite(t, op) }
func tSetIndexDeleteIndex(t, op *Op, priority bool) *Op  { return tEditOverwrite(t, op) }
func tSetFieldEditField(t, op *Op, priority bool) *Op    { return tOverwriteEdit(t, op) }
func tDeleteFieldEditField(t, op *Op, priority bool) *Op { return tOverwriteEdit(t, op) }
func tSetIndexEditIndex(t, op *Op, priority bool) *Op    { return tOverwriteEdit(t, op) }
func tDeleteIndexEditIndex(t, op *Op, priority bool) *Op { return tOverwriteEdit(t, op) }
func tSetKeyEditKey(t, op *Op, priority bool) *Op        { return tOverwriteEdit(t, op) }
func tDeleteKeyEditKey(t, op *Op, priority bool) *Op     { return tOverwriteEdit(t, op) }
func tDeleteIndexSetIndex(t, op *Op, priority bool) *Op  { return tOverwriteEdit(t, op) }

func tEditIndexInsertIndex(t, op *Op, priority bool) *Op {
	// Op is trying to insert a value into a list after t modified a value. Even when t and op act on the same
	// location, they are independent.
	return tIndependent(t, op)
}
func tInsertIndexEditIndex(t, op *Op, priority bool) *Op {
	// Op is editing at the same index that t has inserted. op will edit at the shifted index and operations will be
	// independent. This is handled by tIndependent.
	return tIndependent(t, op)
}

func tMoveModify(t, op *Op) *Op {
	// Shared by:
	// tMoveIndexEditIndex
	// tMoveIndexSetIndex

	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}

	// op is trying to modify a value after t has moved values. Even when t and op act on the same location, they are
	// independent.
	return tIndependent(t, op)
}
func tModifyMove(t, op *Op) *Op {
	// Shared by:
	// tEditIndexMoveIndex
	// tSetIndexMoveIndex

	if op.IsNullMove() {
		return nil
	}
	// Op is trying to move a value in a list after op modified a value. Even when t and op act on the same
	// location, they are independent.
	return tIndependent(t, op)
}
func tMoveIndexEditIndex(t, op *Op, priority bool) *Op { return tMoveModify(t, op) }
func tMoveIndexSetIndex(t, op *Op, priority bool) *Op  { return tMoveModify(t, op) }
func tEditIndexMoveIndex(t, op *Op, priority bool) *Op { return tModifyMove(t, op) }
func tSetIndexMoveIndex(t, op *Op, priority bool) *Op  { return tModifyMove(t, op) }

func tMoveIndexDeleteIndex(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	// op is trying to delete a value after t has moved values. Even when t and op act on the same location,
	// they are independent.
	return tIndependent(t, op)
}
func tDeleteIndexMoveIndex(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to move the value that op has already deleted. In order to converge, t must take priority.
		return nil
	case to == TREE_EQUAL:
		// op is trying to move to the index of the value that op already deleted. Operations are independent.
		return tIndependent(t, op)
	default:
		panic("")
	}
}

func tEditKeyRenameKey(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
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
func tRenameKeyEditKey(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to modify the value that t moved. Op can continue with shifted key, which is correctly handled
		// by tIndependent.
		return tIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to modify the value that t has already overwritten. In order to converge, the move must take
		// priority.
		return nil
	default:
		panic("")
	}
}

func tOverwrite(t, op *Op, priority bool) *Op {
	// Used by:
	// tSetFieldSetField
	// tSetIndexSetIndex
	// tSetKeySetKey
	// tSetFieldDeleteField
	// tSetKeyDeleteKey
	// tDeleteFieldSetField
	// tDeleteKeySetKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return tIndependent(t, op)
	}
	// Op and t are both overwriting the same value. Use priority to determine the outcome.
	if priority {
		// When t has priority, remove op.
		return nil
	}
	return proto.Clone(op).(*Op)
}
func tSetFieldSetField(t, op *Op, priority bool) *Op    { return tOverwrite(t, op, priority) }
func tSetIndexSetIndex(t, op *Op, priority bool) *Op    { return tOverwrite(t, op, priority) }
func tSetKeySetKey(t, op *Op, priority bool) *Op        { return tOverwrite(t, op, priority) }
func tSetFieldDeleteField(t, op *Op, priority bool) *Op { return tOverwrite(t, op, priority) }
func tSetKeyDeleteKey(t, op *Op, priority bool) *Op     { return tOverwrite(t, op, priority) }
func tDeleteFieldSetField(t, op *Op, priority bool) *Op { return tOverwrite(t, op, priority) }
func tDeleteKeySetKey(t, op *Op, priority bool) *Op     { return tOverwrite(t, op, priority) }

func tSetIndexInsertIndex(t, op *Op, priority bool) *Op {
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return tIndependent(t, op)
	}
	// op is inserting at the same list index that t has already replaced. This inserts a new value, so is independent.
	return proto.Clone(op).(*Op)
}
func tInsertIndexSetIndex(t, op *Op, priority bool) *Op {
	// op is replacing at the same index that t has inserted. op will replace at the shifted index and will be
	// independent. This is handled by tIndependent.
	return tIndependent(t, op)
}

func tSetKeyRenameKey(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
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
func tRenameKeySetKey(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to replace the value that t moved. Op can continue with shifted key, which is correctly handled
		// by tIndependent.
		return tIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to replace the value that t has overwritten. We can use priority to determine the winner.
		if priority {
			// if t has priority, we can just remove op
			return nil
		}
		// if op has priority, it can continue with a shifted key, which is correctly handled by tIndependent.
		return tIndependent(t, op)
	default:
		panic("")
	}
}

func tInsertIndexInsertIndex(t, op *Op, priority bool) *Op {
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return tIndependent(t, op)
	}
	// Both operations are inserting at the same index. We should use priority to determine which is shifted.
	shifter := insertLocationShifter(t.ItemIndex(), priority, true)
	out := proto.Clone(op).(*Op)
	out.SetItemIndex(shifter(op.ItemIndex()))
	return out
}

func tInsertIndexMoveIndex(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to move the value that was at the same index as t inserted at. We can just apply the shifter
		// function to both from and to locations and the operations are independent. This is handled correctly by
		// tIndependent.
		return tIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to move a value to the same index that t inserted at. We can use priority to determine
		// which is shifted, but the destination index should be shifted without taking account of priority.
		locationShifter := insertLocationShifter(t.ItemIndex(), priority, true)
		valueShifter := insertValueShifter(t.ItemIndex())
		out := proto.Clone(op).(*Op)
		out.SetItemIndex(valueShifter(op.ItemIndex()))
		out.SetToIndex(locationShifter(op.ToIndex()))
		return out
	default:
		panic("")
	}
}
func tMoveIndexInsertIndex(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
	case from == TREE_EQUAL:
		// op is inserting a new value at the same location that t moved from. Operations are independent, but we don't
		// want to use tIndependent because that would make the insert move with the moved value (it uses the
		// moveValueShifter shifter variant). We manually use moveLocationShifter to shift the location:

		// Note: priority doesn't matter here because it is only used when (i == to) || (from < to && i == to+1)
		// Since we know i == from, it cannot be used. Set to false to demonstrate this:
		shifter := moveLocationShifter(t.ItemIndex(), t.ToIndex(), false, false)
		out := proto.Clone(op).(*Op)
		out.SetItemIndex(shifter(op.ItemIndex()))
		return out
	case to == TREE_EQUAL:
		// op is inserting a new value at the same location that t moved to. We can priority to determine which
		// operation is shifted.
		shifter := moveLocationShifter(t.ItemIndex(), t.ToIndex(), priority, true)
		out := proto.Clone(op).(*Op)
		out.SetItemIndex(shifter(op.ItemIndex()))
		return out
	default:
		panic("")
	}
}

func tInsertIndexDeleteIndex(t, op *Op, priority bool) *Op {
	// op is deleting at the same index that t has inserted. op will delete at the shifted index and will be
	// independent. This is handled by tIndependent.
	return tIndependent(t, op)
}
func tDeleteIndexInsertIndex(t, op *Op, priority bool) *Op {
	// op is trying to insert at the same index as t deleted from. Operations are independent.
	return tIndependent(t, op)
}

func tMoveIndexMoveIndex(t, op *Op, priority bool) *Op {
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

		// Here all we need to do is modify the from location of op so that is uses the value at the to location of t.
		// We don't need to use the shifter.
		locationShifter := moveLocationShifter(t.ItemIndex(), t.ToIndex(), priority, true)
		out := proto.Clone(op).(*Op)
		// must use location locationShifter here because that was used to shift t.To
		out.SetItemIndex(locationShifter(t.ToIndex()))
		out.SetToIndex(locationShifter(op.ToIndex()))
		return out
	case toTo == TREE_EQUAL:
		// Op is trying to move another value to the same index that t just moved a value to. We can use priority to
		// determine which value is shifted.
		locationShifter := moveLocationShifter(t.ItemIndex(), t.ToIndex(), priority, true)
		valueShifter := moveValueShifter(t.ItemIndex(), t.ToIndex())
		out := proto.Clone(op).(*Op)
		out.SetItemIndex(valueShifter(op.ItemIndex()))
		out.SetToIndex(locationShifter(op.ToIndex()))
		return out
	case fromTo == TREE_EQUAL && toFrom == TREE_EQUAL:
		// Op is trying to move the value at the to index of the move that t has just done, and move to the from index.
		// Since both moves are non destructive and shift the other values around these operations are independent and
		// can be handled by tIndependent.
		return tIndependent(t, op)
	case fromTo == TREE_EQUAL:
		// Op is trying to move to the index that t just moved from. Operations are independent and can be handled by
		// tIndependent.
		return tIndependent(t, op)
	case toFrom == TREE_EQUAL:
		// Op is trying to move from the index that t just moved to. Operations are independent and can be handled by
		// tIndependent.
		return tIndependent(t, op)
	default:
		// Operations are independent.
		return tIndependent(t, op)
	}
}

func tRenameKeyRenameKey(t, op *Op, priority bool) *Op {
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
		// From location to move the correct value. If we remove op, we must replace with an operation that deletes
		// the "to" location.
		if priority {
			return &Op{
				Type:     Op_Delete,
				Location: proto.Clone(op).(*Op).To(),
			}
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

func tRenameKeyDeleteKey(t, op *Op, priority bool) *Op {
	if t.IsNullMove() {
		return proto.Clone(op).(*Op)
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.To(), op.Location)
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to delete the value that t moved. Op can continue with shifted key, which is correctly handled
		// by tIndependent.
		return tIndependent(t, op)
	case to == TREE_EQUAL:
		// op is trying to delete the value that t has already overwritten. We can simply remove op.
		return nil
	default:
		panic("")
	}
}
func tDeleteKeyRenameKey(t, op *Op, priority bool) *Op {
	if op.IsNullMove() {
		return nil
	}
	from := TreeRelationship(t.Location, op.Location)
	to := TreeRelationship(t.Location, op.To())
	switch {
	case from != TREE_EQUAL && to != TREE_EQUAL:
		return tIndependent(t, op)
	case from == TREE_EQUAL:
		// op is trying to move the value that op already deleted. In order to converge we must remove op and replace
		// with an operation that deletes the "to" value.
		return &Op{
			Type:     Op_Delete,
			Location: proto.Clone(op).(*Op).To(),
		}
	case to == TREE_EQUAL:
		// op is trying to overwrite the value that op already deleted. continue with op.
		return proto.Clone(op).(*Op)
	default:
		panic("")
	}
}

func tDelete(t, op *Op) *Op {
	// Used by:
	// tDeleteFieldDeleteField
	// tDeleteIndexDeleteIndex
	// tDeleteKeyDeleteKey

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return tIndependent(t, op)
	}
	// op and t are both deleting the same value. We can remove op.
	return nil
}
func tDeleteFieldDeleteField(t, op *Op, priority bool) *Op { return tDelete(t, op) }
func tDeleteIndexDeleteIndex(t, op *Op, priority bool) *Op { return tDelete(t, op) }
func tDeleteKeyDeleteKey(t, op *Op, priority bool) *Op     { return tDelete(t, op) }
