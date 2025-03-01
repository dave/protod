package pdelta

// reduce reduces two consecutive non-compound operations. If the operations are independent, the result will return
// both inputs. If the operations can be reduced, the result will be a single operation. If the operations cancel each
// other out, the result will be an empty slice.
func (op1 *Op) reduce(op2 *Op) (outcome ReduceOutcome, op1x, op2x *Op) {
	switch op1.Type {
	case Op_Edit:
		_, tItem := op1.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rEditFieldEditField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rEditFieldSetField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rEditFieldDeleteField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rEditIndexEditIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rEditIndexSetIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rEditIndexDeleteIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rEditKeyEditKey(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rEditKeySetKey(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rEditKeyDeleteKey(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rEditKeyRenameKey(op1, op2)
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
		_, tItem := op1.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rSetFieldEditField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rSetFieldSetField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rSetFieldDeleteField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rSetIndexEditIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rSetIndexSetIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rSetIndexDeleteIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rSetKeyEditKey(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rSetKeySetKey(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rSetKeyDeleteKey(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rSetKeyRenameKey(op1, op2)
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
		_, tItem := op1.Pop()
		switch tItem.V.(type) {
		case *Locator_Index:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rInsertIndexSetIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rInsertIndexMoveIndex(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rInsertIndexDeleteIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
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
		_, tItem := op1.Pop()
		switch tItem.V.(type) {
		case *Locator_Index:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rMoveIndexMoveIndex(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rMoveIndexDeleteIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
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
		_, tItem := op1.Pop()
		switch tItem.V.(type) {
		case *Locator_Field:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rDeleteFieldEditField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rDeleteFieldSetField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rDeleteFieldDeleteField(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rDeleteIndexEditIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rDeleteIndexSetIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rDeleteIndexInsertIndex(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rDeleteIndexMoveIndex(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rDeleteIndexDeleteIndex(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rDeleteKeyEditKey(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rDeleteKeySetKey(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rDeleteKeyDeleteKey(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rDeleteKeyRenameKey(op1, op2)
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Oneof:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				case *Locator_Oneof:
					return rDeleteOneofDeleteOneof(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rIndependent(op1, op2)
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
		_, tItem := op1.Pop()
		switch tItem.V.(type) {
		case *Locator_Key:
			switch op2.Type {
			case Op_Edit:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Set:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rRenameKeySetKey(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Insert:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Index:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return rIndependent(op1, op2)
				case *Locator_Index:
					return rIndependent(op1, op2)
				case *Locator_Key:
					return rRenameKeyDeleteKey(op1, op2)
				case *Locator_Oneof:
					return rIndependent(op1, op2)
				default:
					panic("invalid op")
				}
			case Op_Rename:
				_, opItem := op2.Pop()
				switch opItem.V.(type) {
				case *Locator_Key:
					return rRenameKeyRenameKey(op1, op2)
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
