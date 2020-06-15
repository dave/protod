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
	switch t.Type {
	case Op_Edit:
		_, transformerItem := t.Pop()
		_, transformerIsDelta := t.Value.(*Op_Delta)
		if transformerIsDelta {
			switch transformerItem.V.(type) {
			case *Locator_Field:
				switch op.Type {
				case Op_Edit:
					_, opItem := op.Pop()
					_, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
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
					} else {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformEditFieldReplaceField(t, op, priority)
						case *Locator_Index:
							return transformEditFieldReplaceIndex(t, op, priority)
						case *Locator_Key:
							return transformEditFieldReplaceKey(t, op, priority)
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditFieldInsertIndex(t, op, priority)
					case *Locator_Key:
						return transformEditFieldInsertKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Move:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditFieldMoveIndex(t, op, priority)
					case *Locator_Key:
						return transformEditFieldMoveKey(t, op, priority)
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
				default:
					panic("invalid op")
				}
			case *Locator_Index:
				switch op.Type {
				case Op_Edit:
					_, opItem := op.Pop()
					_, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
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
					} else {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformEditIndexReplaceField(t, op, priority)
						case *Locator_Index:
							return transformEditIndexReplaceIndex(t, op, priority)
						case *Locator_Key:
							return transformEditIndexReplaceKey(t, op, priority)
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditIndexInsertIndex(t, op, priority)
					case *Locator_Key:
						return transformEditIndexInsertKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Move:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditIndexMoveIndex(t, op, priority)
					case *Locator_Key:
						return transformEditIndexMoveKey(t, op, priority)
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
				default:
					panic("invalid op")
				}
			case *Locator_Key:
				switch op.Type {
				case Op_Edit:
					_, opItem := op.Pop()
					_, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
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
					} else {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformEditKeyReplaceField(t, op, priority)
						case *Locator_Index:
							return transformEditKeyReplaceIndex(t, op, priority)
						case *Locator_Key:
							return transformEditKeyReplaceKey(t, op, priority)
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditKeyInsertIndex(t, op, priority)
					case *Locator_Key:
						return transformEditKeyInsertKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Move:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditKeyMoveIndex(t, op, priority)
					case *Locator_Key:
						return transformEditKeyMoveKey(t, op, priority)
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
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		} else {
			switch transformerItem.V.(type) {
			case *Locator_Field:
				switch op.Type {
				case Op_Edit:
					_, opItem := op.Pop()
					_, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceFieldEditField(t, op, priority)
						case *Locator_Index:
							return transformReplaceFieldEditIndex(t, op, priority)
						case *Locator_Key:
							return transformReplaceFieldEditKey(t, op, priority)
						default:
							panic("invalid op")
						}
					} else {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceFieldReplaceField(t, op, priority)
						case *Locator_Index:
							return transformReplaceFieldReplaceIndex(t, op, priority)
						case *Locator_Key:
							return transformReplaceFieldReplaceKey(t, op, priority)
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceFieldInsertIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceFieldInsertKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Move:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceFieldMoveIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceFieldMoveKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Delete:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformReplaceFieldDeleteField(t, op, priority)
					case *Locator_Index:
						return transformReplaceFieldDeleteIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceFieldDeleteKey(t, op, priority)
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
					_, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceIndexEditField(t, op, priority)
						case *Locator_Index:
							return transformReplaceIndexEditIndex(t, op, priority)
						case *Locator_Key:
							return transformReplaceIndexEditKey(t, op, priority)
						default:
							panic("invalid op")
						}
					} else {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceIndexReplaceField(t, op, priority)
						case *Locator_Index:
							return transformReplaceIndexReplaceIndex(t, op, priority)
						case *Locator_Key:
							return transformReplaceIndexReplaceKey(t, op, priority)
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceIndexInsertIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceIndexInsertKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Move:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceIndexMoveIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceIndexMoveKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Delete:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformReplaceIndexDeleteField(t, op, priority)
					case *Locator_Index:
						return transformReplaceIndexDeleteIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceIndexDeleteKey(t, op, priority)
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
					_, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceKeyEditField(t, op, priority)
						case *Locator_Index:
							return transformReplaceKeyEditIndex(t, op, priority)
						case *Locator_Key:
							return transformReplaceKeyEditKey(t, op, priority)
						default:
							panic("invalid op")
						}
					} else {
						switch opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceKeyReplaceField(t, op, priority)
						case *Locator_Index:
							return transformReplaceKeyReplaceIndex(t, op, priority)
						case *Locator_Key:
							return transformReplaceKeyReplaceKey(t, op, priority)
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceKeyInsertIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceKeyInsertKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Move:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceKeyMoveIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceKeyMoveKey(t, op, priority)
					default:
						panic("invalid op")
					}
				case Op_Delete:
					_, opItem := op.Pop()
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformReplaceKeyDeleteField(t, op, priority)
					case *Locator_Index:
						return transformReplaceKeyDeleteIndex(t, op, priority)
					case *Locator_Key:
						return transformReplaceKeyDeleteKey(t, op, priority)
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
	case Op_Insert:
		_, transformerItem := t.Pop()
		switch transformerItem.V.(type) {
		case *Locator_Field:
			panic("invalid op")
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				_, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
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
				} else {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformInsertIndexReplaceField(t, op, priority)
					case *Locator_Index:
						return transformInsertIndexReplaceIndex(t, op, priority)
					case *Locator_Key:
						return transformInsertIndexReplaceKey(t, op, priority)
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformInsertIndexInsertIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertIndexInsertKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformInsertIndexMoveIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertIndexMoveKey(t, op, priority)
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
			default:
				panic("invalid op")
			}

		case *Locator_Key:

			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				_, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformInsertKeyEditField(t, op, priority)
					case *Locator_Index:
						return transformInsertKeyEditIndex(t, op, priority)
					case *Locator_Key:
						return transformInsertKeyEditKey(t, op, priority)
					default:
						panic("invalid op")
					}
				} else {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformInsertKeyReplaceField(t, op, priority)
					case *Locator_Index:
						return transformInsertKeyReplaceIndex(t, op, priority)
					case *Locator_Key:
						return transformInsertKeyReplaceKey(t, op, priority)
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformInsertKeyInsertIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertKeyInsertKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformInsertKeyMoveIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertKeyMoveKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformInsertKeyDeleteField(t, op, priority)
				case *Locator_Index:
					return transformInsertKeyDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformInsertKeyDeleteKey(t, op, priority)
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
		_, transformerItem := t.Pop()
		switch transformerItem.V.(type) {
		case *Locator_Field:
			panic("invalid op")
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				_, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
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
				} else {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformMoveIndexReplaceField(t, op, priority)
					case *Locator_Index:
						return transformMoveIndexReplaceIndex(t, op, priority)
					case *Locator_Key:
						return transformMoveIndexReplaceKey(t, op, priority)
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformMoveIndexInsertIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveIndexInsertKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformMoveIndexMoveIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveIndexMoveKey(t, op, priority)
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
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				_, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformMoveKeyEditField(t, op, priority)
					case *Locator_Index:
						return transformMoveKeyEditIndex(t, op, priority)
					case *Locator_Key:
						return transformMoveKeyEditKey(t, op, priority)
					default:
						panic("invalid op")
					}
				} else {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformMoveKeyReplaceField(t, op, priority)
					case *Locator_Index:
						return transformMoveKeyReplaceIndex(t, op, priority)
					case *Locator_Key:
						return transformMoveKeyReplaceKey(t, op, priority)
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformMoveKeyInsertIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveKeyInsertKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformMoveKeyMoveIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveKeyMoveKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Delete:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					return transformMoveKeyDeleteField(t, op, priority)
				case *Locator_Index:
					return transformMoveKeyDeleteIndex(t, op, priority)
				case *Locator_Key:
					return transformMoveKeyDeleteKey(t, op, priority)
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
		_, transformerItem := t.Pop()
		switch transformerItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				_, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
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
				} else {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteFieldReplaceField(t, op, priority)
					case *Locator_Index:
						return transformDeleteFieldReplaceIndex(t, op, priority)
					case *Locator_Key:
						return transformDeleteFieldReplaceKey(t, op, priority)
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteFieldInsertIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteFieldInsertKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteFieldMoveIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteFieldMoveKey(t, op, priority)
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
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				_, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
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
				} else {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteIndexReplaceField(t, op, priority)
					case *Locator_Index:
						return transformDeleteIndexReplaceIndex(t, op, priority)
					case *Locator_Key:
						return transformDeleteIndexReplaceKey(t, op, priority)
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteIndexInsertIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteIndexInsertKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteIndexMoveIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteIndexMoveKey(t, op, priority)
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
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				_, opItem := op.Pop()
				_, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
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
				} else {
					switch opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteKeyReplaceField(t, op, priority)
					case *Locator_Index:
						return transformDeleteKeyReplaceIndex(t, op, priority)
					case *Locator_Key:
						return transformDeleteKeyReplaceKey(t, op, priority)
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteKeyInsertIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteKeyInsertKey(t, op, priority)
				default:
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteKeyMoveIndex(t, op, priority)
				case *Locator_Key:
					return transformDeleteKeyMoveKey(t, op, priority)
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

func transformIndependent(t, op *Op) *Op {

	// op1 and op2 are not acting on the same value, or the values don't conflict.

	behaviour := getBehaviour(t)
	opBehaviour := getBehaviour(op)

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
	// transformEditFieldReplaceField
	// transformEditFieldDeleteField
	// transformEditIndexReplaceIndex
	// transformEditIndexDeleteIndex
	// transformEditKeyReplaceKey
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
func transformEditFieldReplaceField(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}
func transformEditFieldDeleteField(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}

func transformEditIndexEditIndex(t, op *Op, priority bool) *Op {
	return transformEditEdit(t, op, priority)
}
func transformEditIndexReplaceIndex(t, op *Op, priority bool) *Op {
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
func transformEditKeyReplaceKey(t, op *Op, priority bool) *Op {
	return transformEditOverwrite(t, op)
}
func transformEditKeyInsertKey(t, op *Op, priority bool) *Op {
	// we don't have a "transformEditInsert" function because key / index inserts are completely different.
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// Op is overwriting the value that t has modified. In order to converge, op has priority.
	return proto.Clone(op).(*Op)
}
func transformEditKeyMoveKey(t, op *Op, priority bool) *Op {
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
	// transformReplaceFieldEditField
	// transformReplaceKeyEditKey
	// transformReplaceIndexEditIndex

	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op is trying to edit a value that t has already overwritten. In order to converge, t must take priority.
	return nil
}

func transformReplaceFieldEditField(t, op *Op, priority bool) *Op {
	return transformOverwriteEdit(t, op)
}

func transformOverwriteOverwrite(t, op *Op, priority bool) *Op {
	// Used by:
	// transformReplaceFieldReplaceField
	// transformReplaceFieldDeleteField
	// transformReplaceIndexReplaceIndex
	// transformReplaceIndexDeleteIndex
	// transformReplaceKeyReplaceKey
	// transformReplaceKeyInsertKey
	// transformReplaceKeyDeleteKey
	// transformInsertKeyReplaceKey
	// transformInsertKeyInsertKey
	// transformInsertKeyDeleteKey
	// transformDeleteFieldReplaceField
	// transformDeleteIndexReplaceIndex
	// transformDeleteKeyReplaceKey
	// transformDeleteKeyInsertKey

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

func transformReplaceFieldReplaceField(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformReplaceFieldDeleteField(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformReplaceIndexEditIndex(t, op *Op, priority bool) *Op {
	return transformOverwriteEdit(t, op)
}
func transformReplaceIndexReplaceIndex(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformReplaceIndexInsertIndex(t, op *Op, priority bool) *Op {
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op is inserting at the same list index that t has already replaced. This inserts a new value, so is independent.
	return proto.Clone(op).(*Op)
}
func transformReplaceIndexMoveIndex(t, op *Op, priority bool) *Op {
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
func transformReplaceIndexDeleteIndex(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformReplaceKeyEditKey(t, op *Op, priority bool) *Op {
	return transformOverwriteEdit(t, op)
}
func transformReplaceKeyReplaceKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformReplaceKeyInsertKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformOverwriteKeyMoveKey(t, op *Op, priority bool) *Op {
	// Used by:
	// transformReplaceKeyMoveKey
	// transformInsertKeyMoveKey

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

func transformReplaceKeyMoveKey(t, op *Op, priority bool) *Op {
	return transformOverwriteKeyMoveKey(t, op, priority)
}
func transformReplaceKeyDeleteKey(t, op *Op, priority bool) *Op {
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
func transformInsertIndexReplaceIndex(t, op *Op, priority bool) *Op {

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

func transformInsertKeyEditKey(t, op *Op, priority bool) *Op {
	if TreeRelationship(t.Location, op.Location) != TREE_EQUAL {
		return transformIndependent(t, op)
	}
	// op is trying to modify the same value that op has overwritten. In order to converge, we must give t the priority
	// and remove op.
	return nil
}
func transformInsertKeyReplaceKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformInsertKeyInsertKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformInsertKeyMoveKey(t, op *Op, priority bool) *Op {
	return transformOverwriteKeyMoveKey(t, op, priority)
}
func transformInsertKeyDeleteKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}

func transformMoveIndexModifyIndex(t, op *Op, priority bool) *Op {
	// Shared by:
	// transformMoveIndexEditIndex
	// transformMoveIndexReplaceIndex
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
func transformMoveIndexReplaceIndex(t, op *Op, priority bool) *Op {
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

func transformMoveKeyEditKey(t, op *Op, priority bool) *Op {
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
func transformMoveKeyOverwriteKey(t, op *Op, priority bool) *Op {
	// Shared by:
	// transformMoveKeyReplaceKey
	// transformMoveKeyInsertKey

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
func transformMoveKeyReplaceKey(t, op *Op, priority bool) *Op {
	return transformMoveKeyOverwriteKey(t, op, priority)
}
func transformMoveKeyInsertKey(t, op *Op, priority bool) *Op {
	return transformMoveKeyOverwriteKey(t, op, priority)
}
func transformMoveKeyMoveKey(t, op *Op, priority bool) *Op {
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
func transformMoveKeyDeleteKey(t, op *Op, priority bool) *Op {
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
func transformDeleteFieldReplaceField(t, op *Op, priority bool) *Op {
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
func transformDeleteIndexReplaceIndex(t, op *Op, priority bool) *Op {
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
func transformDeleteKeyReplaceKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformDeleteKeyInsertKey(t, op *Op, priority bool) *Op {
	return transformOverwriteOverwrite(t, op, priority)
}
func transformDeleteKeyMoveKey(t, op *Op, priority bool) *Op {
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

func transformEditFieldEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditFieldDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformEditIndexEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditIndexEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditIndexReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditIndexReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditIndexInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditIndexMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditIndexDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditIndexDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformEditKeyEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditKeyEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditKeyReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditKeyReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditKeyInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditKeyMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditKeyDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformEditKeyDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformReplaceFieldEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceFieldDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformReplaceIndexEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceIndexEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceIndexReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceIndexReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceIndexInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceIndexMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceIndexDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceIndexDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformReplaceKeyEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceKeyEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceKeyReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceKeyReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceKeyInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceKeyMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceKeyDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformReplaceKeyDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformInsertIndexEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertIndexEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertIndexReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertIndexReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertIndexInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertIndexMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertIndexDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertIndexDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformInsertKeyEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertKeyEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertKeyReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertKeyReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertKeyInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertKeyMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertKeyDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformInsertKeyDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformMoveIndexEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveIndexEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveIndexReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveIndexReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveIndexInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveIndexMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveIndexDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveIndexDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformMoveKeyEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveKeyEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveKeyReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveKeyReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveKeyInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveKeyMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveKeyDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformMoveKeyDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformDeleteFieldEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteFieldDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformDeleteIndexEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteIndexEditKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteIndexReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteIndexReplaceKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteIndexInsertKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteIndexMoveKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteIndexDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteIndexDeleteKey(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}

func transformDeleteKeyEditField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteKeyEditIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteKeyReplaceField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteKeyReplaceIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteKeyInsertIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteKeyMoveIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteKeyDeleteField(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
func transformDeleteKeyDeleteIndex(t, op *Op, priority bool) *Op {
	return transformIndependent(t, op)
}
