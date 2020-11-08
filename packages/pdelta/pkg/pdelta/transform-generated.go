package pdelta

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
					return tEditFieldEditField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tEditFieldSetField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tEditFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tEditIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tEditIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tEditIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tEditIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tEditIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tEditKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tEditKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tEditKeyDeleteKey(t, op, priority)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tEditKeyRenameKey(t, op, priority)
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
					return tSetFieldEditField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tSetFieldSetField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tSetFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tSetIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tSetIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tSetIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tSetIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tSetIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tSetKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tSetKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tSetKeyDeleteKey(t, op, priority)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tSetKeyRenameKey(t, op, priority)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tInsertIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tInsertIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tInsertIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tInsertIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tInsertIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tMoveIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tMoveIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tMoveIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tMoveIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tMoveIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tDeleteFieldEditField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tDeleteFieldSetField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tDeleteFieldDeleteField(t, op, priority)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tDeleteIndexEditIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tDeleteIndexSetIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tDeleteIndexInsertIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tDeleteIndexMoveIndex(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tDeleteIndexDeleteIndex(t, op, priority)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tDeleteKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tDeleteKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tDeleteKeyDeleteKey(t, op, priority)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tDeleteKeyRenameKey(t, op, priority)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Oneof:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tIndependent(t, op)
				case *Locator_Oneof:
					return tDeleteOneofDeleteOneof(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tIndependent(t, op)
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
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tRenameKeyEditKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tRenameKeySetKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return tIndependent(t, op)
				case *Locator_Index:
					return tIndependent(t, op)
				case *Locator_Key:
					return tRenameKeyDeleteKey(t, op, priority)
				case *Locator_Oneof:
					return tIndependent(t, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return tRenameKeyRenameKey(t, op, priority)
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
