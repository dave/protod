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
					return transformEditFieldEditIndex(t, op, priority)
				case *Locator_Key:
					return transformEditFieldEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditFieldSetField(t, op, priority)
				case *Locator_Index:
					return transformEditFieldSetIndex(t, op, priority)
				case *Locator_Key:
					return transformEditFieldSetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformEditFieldInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformEditFieldMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return transformEditFieldDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformEditFieldDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformEditFieldRenameKey(t, op, priority)
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
					return transformEditIndexEditField(t, op, priority)
				case *Locator_Index:
					return transformEditIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformEditIndexEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditIndexSetField(t, op, priority)
				case *Locator_Index:
					return transformEditIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformEditIndexSetKey(t, op, priority)
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
					return transformEditIndexDeleteField(t, op, priority)
				case *Locator_Index:
					return transformEditIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformEditIndexDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformEditIndexRenameKey(t, op, priority)
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
					return transformEditKeyEditField(t, op, priority)
				case *Locator_Index:
					return transformEditKeyEditIndex(t, op, priority)
				case *Locator_Key:
					return transformEditKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditKeySetField(t, op, priority)
				case *Locator_Index:
					return transformEditKeySetIndex(t, op, priority)
				case *Locator_Key:
					return transformEditKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformEditKeyInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformEditKeyMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformEditKeyDeleteField(t, op, priority)
				case *Locator_Index:
					return transformEditKeyDeleteIndex(t, op, priority)
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
					return transformSetFieldEditIndex(t, op, priority)
				case *Locator_Key:
					return transformSetFieldEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetFieldSetField(t, op, priority)
				case *Locator_Index:
					return transformSetFieldSetIndex(t, op, priority)
				case *Locator_Key:
					return transformSetFieldSetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformSetFieldInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformSetFieldMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return transformSetFieldDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformSetFieldDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformSetFieldRenameKey(t, op, priority)
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
					return transformSetIndexEditField(t, op, priority)
				case *Locator_Index:
					return transformSetIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformSetIndexEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetIndexSetField(t, op, priority)
				case *Locator_Index:
					return transformSetIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformSetIndexSetKey(t, op, priority)
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
					return transformSetIndexDeleteField(t, op, priority)
				case *Locator_Index:
					return transformSetIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformSetIndexDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformSetIndexRenameKey(t, op, priority)
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
					return transformSetKeyEditField(t, op, priority)
				case *Locator_Index:
					return transformSetKeyEditIndex(t, op, priority)
				case *Locator_Key:
					return transformSetKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetKeySetField(t, op, priority)
				case *Locator_Index:
					return transformSetKeySetIndex(t, op, priority)
				case *Locator_Key:
					return transformSetKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformSetKeyInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformSetKeyMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformSetKeyDeleteField(t, op, priority)
				case *Locator_Index:
					return transformSetKeyDeleteIndex(t, op, priority)
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
					return transformInsertIndexEditField(t, op, priority)
				case *Locator_Index:
					return transformInsertIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertIndexEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformInsertIndexSetField(t, op, priority)
				case *Locator_Index:
					return transformInsertIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertIndexSetKey(t, op, priority)
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
					return transformInsertIndexDeleteField(t, op, priority)
				case *Locator_Index:
					return transformInsertIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertIndexDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformInsertIndexRenameKey(t, op, priority)
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
					return transformMoveIndexEditField(t, op, priority)
				case *Locator_Index:
					return transformMoveIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveIndexEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformMoveIndexSetField(t, op, priority)
				case *Locator_Index:
					return transformMoveIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveIndexSetKey(t, op, priority)
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
					return transformMoveIndexDeleteField(t, op, priority)
				case *Locator_Index:
					return transformMoveIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveIndexDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformMoveIndexRenameKey(t, op, priority)
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
					return transformDeleteFieldEditIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteFieldEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteFieldSetField(t, op, priority)
				case *Locator_Index:
					return transformDeleteFieldSetIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteFieldSetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformDeleteFieldInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformDeleteFieldMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return transformDeleteFieldDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteFieldDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformDeleteFieldRenameKey(t, op, priority)
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
					return transformDeleteIndexEditField(t, op, priority)
				case *Locator_Index:
					return transformDeleteIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteIndexEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteIndexSetField(t, op, priority)
				case *Locator_Index:
					return transformDeleteIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteIndexSetKey(t, op, priority)
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
					return transformDeleteIndexDeleteField(t, op, priority)
				case *Locator_Index:
					return transformDeleteIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteIndexDeleteKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return transformDeleteIndexRenameKey(t, op, priority)
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
					return transformDeleteKeyEditField(t, op, priority)
				case *Locator_Index:
					return transformDeleteKeyEditIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteKeySetField(t, op, priority)
				case *Locator_Index:
					return transformDeleteKeySetIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformDeleteKeyInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformDeleteKeyMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteKeyDeleteField(t, op, priority)
				case *Locator_Index:
					return transformDeleteKeyDeleteIndex(t, op, priority)
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
					return transformRenameKeyEditField(t, op, priority)
				case *Locator_Index:
					return transformRenameKeyEditIndex(t, op, priority)
				case *Locator_Key:
					return transformRenameKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformRenameKeySetField(t, op, priority)
				case *Locator_Index:
					return transformRenameKeySetIndex(t, op, priority)
				case *Locator_Key:
					return transformRenameKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformRenameKeyInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return transformRenameKeyMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformRenameKeyDeleteField(t, op, priority)
				case *Locator_Index:
					return transformRenameKeyDeleteIndex(t, op, priority)
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
