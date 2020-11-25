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
	if len(ops) == 1 {
		return ops[0]
	}
	if len(ops) == 2 {
		return Compound(reduce(ops[0], ops[1])...)
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
	panic("not implemented")
}

func reduce(op1, op2 *Op) []*Op {

	op1IsNull, op2IsNull := IsNull(op1), IsNull(op2)
	switch {
	case op1IsNull && op2IsNull:
		return []*Op{}
	case op1IsNull:
		return []*Op{proto.Clone(op2).(*Op)}
	case op2IsNull:
		return []*Op{proto.Clone(op1).(*Op)}
	}

	return op1.reduce(op2)
}

func rIndependent(op1, op2 *Op) []*Op {

	// op1 and op2 are not acting on the same value, or the values don't conflict.
	//op1Behaviour := GetBehaviour(op1)
	op2Behaviour := GetBehaviour(op2)

	if op1.Type == Op_Set && TreeRelationship(op1.Location, op2.Location) == TREE_ANCESTOR {
		// op1 is a set operation, and op2 is acting on a descendent. We can just apply op2 to the value and use that
		// in the set:

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
			return []*Op{out}

		case *Op_Message:
			msg := MustUnmarshalAny(value.Message)
			op2new := proto.Clone(op2).(*Op)
			op2new.Location = op2new.Location[len(op1.Location):]
			if err := Apply(op2new, msg); err != nil {
				panic(err)
			}
			out := proto.Clone(op1).(*Op)
			out.Value = &Op_Message{Message: MustMarshalAny(msg)}
			return []*Op{out}
		}
	}

	if op2Behaviour.ItemIsDeleted && TreeRelationship(op1.Location, op2.Location) == TREE_DESCENDENT {
		// Op1 is acting on a value that is a descendent of a value that op2 deleted. We can remove op1.
		return []*Op{proto.Clone(op2).(*Op)}
	}

	if op2Behaviour.ValueIsLocation && op2Behaviour.ValueIsDeleted && TreeRelationship(op1.Location, op2.To()) == TREE_DESCENDENT {
		// Op1 is acting on a value that is a descendent of a value that op2 deleted. We can remove op1.
		return []*Op{proto.Clone(op2).(*Op)}
	}

	// TODO more logic here?

	return []*Op{proto.Clone(op1).(*Op), proto.Clone(op2).(*Op)}
}

func rEditEdit(op1, op2 *Op) []*Op {
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
	return []*Op{out}
}
func rEditFieldEditField(op1, op2 *Op) []*Op { return rEditEdit(op1, op2) }
func rEditIndexEditIndex(op1, op2 *Op) []*Op { return rEditEdit(op1, op2) }
func rEditKeyEditKey(op1, op2 *Op) []*Op     { return rEditEdit(op1, op2) }

func rMoveIndexMoveIndex(op1, op2 *Op) []*Op {

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

	op1FromIndex := op1.ItemIndex()
	op1ToIndex := op1.ToIndex()
	op2FromIndex := op2.ItemIndex()
	op2ToIndex := op2.ToIndex()
	op1ToIndexInOp2Context := op1ToIndex
	if op1FromIndex < op1ToIndex {
		// Remember the index that the to index points to in the resultant list is toIndex-1 because it's shifted
		// backwards by the removal of the value from earlier in the list. So we decrement toIndex.
		op1ToIndexInOp2Context = op1ToIndex - 1
	}

	if op1ToIndexInOp2Context != op2FromIndex {
		return []*Op{proto.Clone(op1).(*Op), proto.Clone(op2).(*Op)}
	}

	op2ToIndexInResultingList := op2ToIndex
	if op2FromIndex < op2ToIndex {
		op2ToIndexInResultingList = op2ToIndex - 1
	}

	op2ToIndexInOp1Context := op2ToIndexInResultingList
	if op1FromIndex < op2ToIndexInResultingList {
		op2ToIndexInOp1Context = op2ToIndexInResultingList + 1
	}

	if op2ToIndexInOp1Context == op1FromIndex {
		// e.g. MOVE A to B, MOVE B to A => null
		return []*Op{}
	}

	// e.g. MOVE A to B, MOVE B to C => MOVE A to C
	out := proto.Clone(op1).(*Op)
	out.SetToIndex(op2ToIndexInOp1Context)
	return []*Op{out}

}

func rEditSet(op1, op2 *Op) []*Op {
	// Used by:
	// rEditFieldSetField
	// rEditIndexSetIndex
	// rEditKeySetKey

	// e.g. EDIT A, SET A => SET A

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return []*Op{proto.Clone(op2).(*Op)}
}
func rEditFieldSetField(op1, op2 *Op) []*Op { return rEditSet(op1, op2) }
func rEditIndexSetIndex(op1, op2 *Op) []*Op { return rEditSet(op1, op2) }
func rEditKeySetKey(op1, op2 *Op) []*Op     { return rEditSet(op1, op2) }

func rEditDelete(op1, op2 *Op) []*Op {
	// Used by:
	// rEditFieldDeleteField
	// rEditIndexDeleteIndex
	// rEditKeyDeleteKey

	// e.g. EDIT A, DELETE A => DELETE A

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return []*Op{proto.Clone(op2).(*Op)}
}
func rEditFieldDeleteField(op1, op2 *Op) []*Op { return rEditDelete(op1, op2) }
func rEditIndexDeleteIndex(op1, op2 *Op) []*Op { return rEditDelete(op1, op2) }
func rEditKeyDeleteKey(op1, op2 *Op) []*Op     { return rEditDelete(op1, op2) }

func rEditKeyRenameKey(op1, op2 *Op) []*Op {

	// e.g. EDIT A, RENAME B to A => RENAME B to A

	if TreeRelationship(op1.Location, op2.To()) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return []*Op{proto.Clone(op2).(*Op)}
}

func rSetEdit(op1, op2 *Op) []*Op {
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
	return []*Op{out}
}
func rSetFieldEditField(op1, op2 *Op) []*Op { return rSetEdit(op1, op2) }
func rSetIndexEditIndex(op1, op2 *Op) []*Op { return rSetEdit(op1, op2) }
func rSetKeyEditKey(op1, op2 *Op) []*Op     { return rSetEdit(op1, op2) }

func rSetSet(op1, op2 *Op) []*Op {
	// Used by:
	// rSetFieldSetField
	// rSetIndexSetIndex
	// rSetKeySetKey

	// e.g. SET A v1, SET A v2 => SET A v2

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return []*Op{proto.Clone(op2).(*Op)}
}
func rSetFieldSetField(op1, op2 *Op) []*Op { return rSetSet(op1, op2) }
func rSetIndexSetIndex(op1, op2 *Op) []*Op { return rSetSet(op1, op2) }
func rSetKeySetKey(op1, op2 *Op) []*Op     { return rSetSet(op1, op2) }

func rSetDelete(op1, op2 *Op) []*Op {
	// Used by:
	// rSetFieldDeleteField
	// rSetIndexDeleteIndex
	// rSetKeyDeleteKey

	// e.g. SET A, DELETE A => DELETE A

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return []*Op{proto.Clone(op2).(*Op)}
}
func rSetFieldDeleteField(op1, op2 *Op) []*Op { return rSetDelete(op1, op2) }
func rSetIndexDeleteIndex(op1, op2 *Op) []*Op { return rSetDelete(op1, op2) }
func rSetKeyDeleteKey(op1, op2 *Op) []*Op     { return rSetDelete(op1, op2) }

func rSetKeyRenameKey(op1, op2 *Op) []*Op {
	// e.g. SET A, RENAME B to A => RENAME B to A

	if TreeRelationship(op1.Location, op2.To()) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	return []*Op{proto.Clone(op2).(*Op)}
}
func rInsertIndexSetIndex(op1, op2 *Op) []*Op {
	// e.g. INSERT A v1, SET A v2 => INSERT A v2

	if TreeRelationship(op1.Location, op2.Location) != TREE_EQUAL {
		return rIndependent(op1, op2)
	}

	out := proto.Clone(op1).(*Op)
	out.Value = proto.Clone(op2).(*Op).Value
	return []*Op{out}
}
func rInsertIndexMoveIndex(op1, op2 *Op) []*Op {
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
	return []*Op{out}
}
func rInsertIndexDeleteIndex(op1, op2 *Op) []*Op {
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
	return []*Op{proto.Clone(op1).(*Op), proto.Clone(op2).(*Op)}

	// Naive logic would return nothing:
	// return []*Op{}
}
func rMoveIndexDeleteIndex(op1, op2 *Op) []*Op {
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

	if moveToIndexInOp2Context == op2.ItemIndex() {
		out := proto.Clone(op2).(*Op)
		out.SetItemIndex(moveFromIndex)
		return []*Op{out}
	}

	return []*Op{proto.Clone(op1).(*Op), proto.Clone(op2).(*Op)}
}
