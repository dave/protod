package pdelta

// reduce reduces two consecutive non-compound operations. If the operations are independent, the result will return
// both inputs. If the operations can be reduced, the result will be a single operation. If the operations cancel each
// other out, the result will be an empty slice.
func (r *Op) reduce(op *Op) []*Op {
	switch r.Type {
	case Op_Edit:
		_, tItem := r.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rEditFieldEditField(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rEditFieldSetField(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rEditFieldDeleteField(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
					return rIndependent(r, op)
				case *Locator_Index:
					return rEditIndexEditIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rEditIndexSetIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rEditIndexDeleteIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rEditKeyEditKey(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rEditKeySetKey(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rEditKeyDeleteKey(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rEditKeyRenameKey(r, op)
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
		_, tItem := r.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rSetFieldEditField(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rSetFieldSetField(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rSetFieldDeleteField(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
					return rIndependent(r, op)
				case *Locator_Index:
					return rSetIndexEditIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rSetIndexSetIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rSetIndexDeleteIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rSetKeyEditKey(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rSetKeySetKey(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rSetKeyDeleteKey(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rSetKeyRenameKey(r, op)
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
		_, tItem := r.Pop()
		switch tItem.V.(type) {
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rInsertIndexSetIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rInsertIndexMoveIndex(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rInsertIndexDeleteIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
		_, tItem := r.Pop()
		switch tItem.V.(type) {
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rMoveIndexMoveIndex(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rMoveIndexDeleteIndex(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
		_, tItem := r.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
		_, tItem := r.Pop()
		switch tItem.V.(type) {
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(r, op)
				case *Locator_Index:
					return rIndependent(r, op)
				case *Locator_Key:
					return rIndependent(r, op)
				case *Locator_Oneof:
					return rIndependent(r, op)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(r, op)
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
