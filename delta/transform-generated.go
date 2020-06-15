package delta

func (t *Op) transform(op *Op, priority bool) *Op {
	switch t.Type {
	case Op_Edit:
		_, tItem := t.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditFieldEditField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditFieldSetField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformEditIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformEditIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformEditIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformEditIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformEditIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformEditKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformEditKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformEditKeyDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformEditKeyRenameKey(t, op, priority)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		default:
			panic("invalid op")
		}
	case Op_Set:
		_, tItem := t.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetFieldEditField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetFieldSetField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformSetIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformSetIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformSetIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformSetIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformSetIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformSetKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformSetKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformSetKeyDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformSetKeyRenameKey(t, op, priority)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		default:
			panic("invalid op")
		}
	case Op_Insert:
		_, tItem := t.Pop()
		switch tItem.V.(type) {
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformInsertIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformInsertIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformInsertIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformInsertIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformInsertIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		default:
			panic("invalid op")
		}
	case Op_Move:
		_, tItem := t.Pop()
		switch tItem.V.(type) {
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformMoveIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformMoveIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformMoveIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformMoveIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformMoveIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		default:
			panic("invalid op")
		}
	case Op_Delete:
		_, tItem := t.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteFieldEditField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteFieldSetField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformDeleteIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformDeleteIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformDeleteIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformDeleteIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformDeleteIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformDeleteKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformDeleteKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformDeleteKeyDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformDeleteKeyRenameKey(t, op, priority)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		default:
			panic("invalid op")
		}
	case Op_Rename:
		_, tItem := t.Pop()
		switch tItem.V.(type) {
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformRenameKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformRenameKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformIndependent(t, op)
				case *Locator_Index:
					return transformIndependent(t, op)
				case *Locator_Key:
					return transformRenameKeyDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformRenameKeyRenameKey(t, op, priority)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		default:
			panic("invalid op")
		}
	default:
		panic("invalid op")
	}
}
