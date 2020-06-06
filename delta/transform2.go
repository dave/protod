package delta

import "github.com/golang/protobuf/proto"

func (transformer *Op) Transform2(op *Op, priority bool) *Op {
	if transformer == nil || op == nil {
		return nil
	}
	if op.Type == Op_Compound {
		var transformed []*Op
		for _, o := range op.Ops {
			ox := transformer.Transform(o, priority)
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
	if transformer.Type == Op_Compound {
		out := proto.Clone(op).(*Op)
		for _, t := range transformer.Ops {
			out = t.Transform(out, priority)
			if out == nil {
				return nil
			}
		}
		return out
	}
	switch transformer.Type {
	case Op_Edit:
		transformerPath, transformerItem := transformer.Pop()
		transformerDelta, transformerIsDelta := transformer.Value.(*Op_Delta)
		if transformerIsDelta {
			switch transformerValue := transformerItem.V.(type) {
			case *Locator_Field:
				switch op.Type {
				case Op_Edit:
					opPath, opItem := op.Pop()
					opDelta, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformEditFieldEditField()
						case *Locator_Index:
							return transformEditFieldEditIndex()
						case *Locator_Key:
							return transformEditFieldEditKey()
						default:
							panic("invalid op")
						}
					} else {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformEditFieldReplaceField()
						case *Locator_Index:
							return transformEditFieldReplaceIndex()
						case *Locator_Key:
							return transformEditFieldReplaceKey()
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					opPath, opItem := op.Pop()
					switch opItemValue := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditFieldInsertIndex()
					case *Locator_Key:
						return transformEditFieldInsertKey()
					default:
						panic("invalid op")
					}
				case Op_Move:
					opPath, opItem := op.Pop()
					switch opFrom := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						opTo := op.Value.(*Op_Index)
						return transformEditFieldMoveIndex()
					case *Locator_Key:
						opTo := op.Value.(*Op_Key)
						return transformEditFieldMoveKey()
					default:
						panic("invalid op")
					}
				case Op_Delete:
					opPath, opItem := op.Pop()
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformEditFieldDeleteField()
					case *Locator_Index:
						return transformEditFieldDeleteIndex()
					case *Locator_Key:
						return transformEditFieldDeleteKey()
					default:
						panic("invalid op")
					}
				default:
					panic("invalid op")
				}
			case *Locator_Index:
				switch op.Type {
				case Op_Edit:
					opPath, opItem := op.Pop()
					opDelta, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformEditIndexEditField()
						case *Locator_Index:
							return transformEditIndexEditIndex()
						case *Locator_Key:
							return transformEditIndexEditKey()
						default:
							panic("invalid op")
						}
					} else {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformEditIndexReplaceField()
						case *Locator_Index:
							return transformEditIndexReplaceIndex()
						case *Locator_Key:
							return transformEditIndexReplaceKey()
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					opPath, opItem := op.Pop()
					switch opItemValue := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditIndexInsertIndex()
					case *Locator_Key:
						return transformEditIndexInsertKey()
					default:
						panic("invalid op")
					}
				case Op_Move:
					opPath, opItem := op.Pop()
					switch opFrom := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						opTo := op.Value.(*Op_Index)
						return transformEditIndexMoveIndex()
					case *Locator_Key:
						opTo := op.Value.(*Op_Key)
						return transformEditIndexMoveKey()
					default:
						panic("invalid op")
					}
				case Op_Delete:
					opPath, opItem := op.Pop()
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformEditIndexDeleteField()
					case *Locator_Index:
						return transformEditIndexDeleteIndex()
					case *Locator_Key:
						return transformEditIndexDeleteKey()
					default:
						panic("invalid op")
					}
				default:
					panic("invalid op")
				}
			case *Locator_Key:
				switch op.Type {
				case Op_Edit:
					opPath, opItem := op.Pop()
					opDelta, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformEditKeyEditField()
						case *Locator_Index:
							return transformEditKeyEditIndex()
						case *Locator_Key:
							return transformEditKeyEditKey()
						default:
							panic("invalid op")
						}
					} else {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformEditKeyReplaceField()
						case *Locator_Index:
							return transformEditKeyReplaceIndex()
						case *Locator_Key:
							return transformEditKeyReplaceKey()
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					opPath, opItem := op.Pop()
					switch opItemValue := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformEditKeyInsertIndex()
					case *Locator_Key:
						return transformEditKeyInsertKey()
					default:
						panic("invalid op")
					}
				case Op_Move:
					opPath, opItem := op.Pop()
					switch opFrom := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						opTo := op.Value.(*Op_Index)
						return transformEditKeyMoveIndex()
					case *Locator_Key:
						opTo := op.Value.(*Op_Key)
						return transformEditKeyMoveKey()
					default:
						panic("invalid op")
					}
				case Op_Delete:
					opPath, opItem := op.Pop()
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformEditKeyDeleteField()
					case *Locator_Index:
						return transformEditKeyDeleteIndex()
					case *Locator_Key:
						return transformEditKeyDeleteKey()
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

			switch transformerValue := transformerItem.V.(type) {
			case *Locator_Field:
				switch op.Type {
				case Op_Edit:
					opPath, opItem := op.Pop()
					opDelta, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceFieldEditField()
						case *Locator_Index:
							return transformReplaceFieldEditIndex()
						case *Locator_Key:
							return transformReplaceFieldEditKey()
						default:
							panic("invalid op")
						}
					} else {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceFieldReplaceField()
						case *Locator_Index:
							return transformReplaceFieldReplaceIndex()
						case *Locator_Key:
							return transformReplaceFieldReplaceKey()
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					opPath, opItem := op.Pop()
					switch opItemValue := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceFieldInsertIndex()
					case *Locator_Key:
						return transformReplaceFieldInsertKey()
					default:
						panic("invalid op")
					}
				case Op_Move:
					opPath, opItem := op.Pop()
					switch opFrom := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						opTo := op.Value.(*Op_Index)
						return transformReplaceFieldMoveIndex()
					case *Locator_Key:
						opTo := op.Value.(*Op_Key)
						return transformReplaceFieldMoveKey()
					default:
						panic("invalid op")
					}
				case Op_Delete:
					opPath, opItem := op.Pop()
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformReplaceFieldDeleteField()
					case *Locator_Index:
						return transformReplaceFieldDeleteIndex()
					case *Locator_Key:
						return transformReplaceFieldDeleteKey()
					default:
						panic("invalid op")
					}
				default:
					panic("invalid op")
				}
			case *Locator_Index:
				switch op.Type {
				case Op_Edit:
					opPath, opItem := op.Pop()
					opDelta, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceIndexEditField()
						case *Locator_Index:
							return transformReplaceIndexEditIndex()
						case *Locator_Key:
							return transformReplaceIndexEditKey()
						default:
							panic("invalid op")
						}
					} else {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceIndexReplaceField()
						case *Locator_Index:
							return transformReplaceIndexReplaceIndex()
						case *Locator_Key:
							return transformReplaceIndexReplaceKey()
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					opPath, opItem := op.Pop()
					switch opItemValue := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceIndexInsertIndex()
					case *Locator_Key:
						return transformReplaceIndexInsertKey()
					default:
						panic("invalid op")
					}
				case Op_Move:
					opPath, opItem := op.Pop()
					switch opFrom := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						opTo := op.Value.(*Op_Index)
						return transformReplaceIndexMoveIndex()
					case *Locator_Key:
						opTo := op.Value.(*Op_Key)
						return transformReplaceIndexMoveKey()
					default:
						panic("invalid op")
					}
				case Op_Delete:
					opPath, opItem := op.Pop()
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformReplaceIndexDeleteField()
					case *Locator_Index:
						return transformReplaceIndexDeleteIndex()
					case *Locator_Key:
						return transformReplaceIndexDeleteKey()
					default:
						panic("invalid op")
					}
				default:
					panic("invalid op")
				}
			case *Locator_Key:
				switch op.Type {
				case Op_Edit:
					opPath, opItem := op.Pop()
					opDelta, opIsDelta := op.Value.(*Op_Delta)
					if opIsDelta {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceKeyEditField()
						case *Locator_Index:
							return transformReplaceKeyEditIndex()
						case *Locator_Key:
							return transformReplaceKeyEditKey()
						default:
							panic("invalid op")
						}
					} else {
						switch opValue := opItem.V.(type) {
						case *Locator_Field:
							return transformReplaceKeyReplaceField()
						case *Locator_Index:
							return transformReplaceKeyReplaceIndex()
						case *Locator_Key:
							return transformReplaceKeyReplaceKey()
						default:
							panic("invalid op")
						}
					}
				case Op_Insert:
					opPath, opItem := op.Pop()
					switch opItemValue := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						return transformReplaceKeyInsertIndex()
					case *Locator_Key:
						return transformReplaceKeyInsertKey()
					default:
						panic("invalid op")
					}
				case Op_Move:
					opPath, opItem := op.Pop()
					switch opFrom := opItem.V.(type) {
					case *Locator_Field:
						panic("invalid op")
					case *Locator_Index:
						opTo := op.Value.(*Op_Index)
						return transformReplaceKeyMoveIndex()
					case *Locator_Key:
						opTo := op.Value.(*Op_Key)
						return transformReplaceKeyMoveKey()
					default:
						panic("invalid op")
					}
				case Op_Delete:
					opPath, opItem := op.Pop()
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformReplaceKeyDeleteField()
					case *Locator_Index:
						return transformReplaceKeyDeleteIndex()
					case *Locator_Key:
						return transformReplaceKeyDeleteKey()
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
		transformerPath, transformerItem := transformer.Pop()
		switch transformerValue := transformerItem.V.(type) {
		case *Locator_Field:
			panic("invalid op")
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				opPath, opItem := op.Pop()
				opDelta, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformInsertIndexEditField()
					case *Locator_Index:
						return transformInsertIndexEditIndex()
					case *Locator_Key:
						return transformInsertIndexEditKey()
					default:
						panic("invalid op")
					}
				} else {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformInsertIndexReplaceField()
					case *Locator_Index:
						return transformInsertIndexReplaceIndex()
					case *Locator_Key:
						return transformInsertIndexReplaceKey()
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				opPath, opItem := op.Pop()
				switch opItemValue := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformInsertIndexInsertIndex()
				case *Locator_Key:
					return transformInsertIndexInsertKey()
				default:
					panic("invalid op")
				}
			case Op_Move:
				opPath, opItem := op.Pop()
				switch opFrom := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					opTo := op.Value.(*Op_Index)
					return transformInsertIndexMoveIndex()
				case *Locator_Key:
					opTo := op.Value.(*Op_Key)
					return transformInsertIndexMoveKey()
				default:
					panic("invalid op")
				}
			case Op_Delete:
				opPath, opItem := op.Pop()
				switch opValue := opItem.V.(type) {
				case *Locator_Field:
					return transformInsertIndexDeleteField()
				case *Locator_Index:
					return transformInsertIndexDeleteIndex()
				case *Locator_Key:
					return transformInsertIndexDeleteKey()
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}

		case *Locator_Key:

			switch op.Type {
			case Op_Edit:
				opPath, opItem := op.Pop()
				opDelta, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformInsertKeyEditField()
					case *Locator_Index:
						return transformInsertKeyEditIndex()
					case *Locator_Key:
						return transformInsertKeyEditKey()
					default:
						panic("invalid op")
					}
				} else {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformInsertKeyReplaceField()
					case *Locator_Index:
						return transformInsertKeyReplaceIndex()
					case *Locator_Key:
						return transformInsertKeyReplaceKey()
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				opPath, opItem := op.Pop()
				switch opItemValue := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformInsertKeyInsertIndex()
				case *Locator_Key:
					return transformInsertKeyInsertKey()
				default:
					panic("invalid op")
				}
			case Op_Move:
				opPath, opItem := op.Pop()
				switch opFrom := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					opTo := op.Value.(*Op_Index)
					return transformInsertKeyMoveIndex()
				case *Locator_Key:
					opTo := op.Value.(*Op_Key)
					return transformInsertKeyMoveKey()
				default:
					panic("invalid op")
				}
			case Op_Delete:
				opPath, opItem := op.Pop()
				switch opValue := opItem.V.(type) {
				case *Locator_Field:
					return transformInsertKeyDeleteField()
				case *Locator_Index:
					return transformInsertKeyDeleteIndex()
				case *Locator_Key:
					return transformInsertKeyDeleteKey()
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
		transformerPath, transformerItem := transformer.Pop()
		switch transformerFrom := transformerItem.V.(type) {
		case *Locator_Field:
			panic("invalid op")
		case *Locator_Index:
			transformerTo := transformer.Value.(*Op_Index)

			switch op.Type {
			case Op_Edit:
				opPath, opItem := op.Pop()
				opDelta, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformMoveIndexEditField()
					case *Locator_Index:
						return transformMoveIndexEditIndex()
					case *Locator_Key:
						return transformMoveIndexEditKey()
					default:
						panic("invalid op")
					}
				} else {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformMoveIndexReplaceField()
					case *Locator_Index:
						return transformMoveIndexReplaceIndex()
					case *Locator_Key:
						return transformMoveIndexReplaceKey()
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				opPath, opItem := op.Pop()
				switch opItemValue := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformMoveIndexInsertIndex()
				case *Locator_Key:
					return transformMoveIndexInsertKey()
				default:
					panic("invalid op")
				}
			case Op_Move:
				opPath, opItem := op.Pop()
				switch opFrom := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					opTo := op.Value.(*Op_Index)
					return transformMoveIndexMoveIndex()
				case *Locator_Key:
					opTo := op.Value.(*Op_Key)
					return transformMoveIndexMoveKey()
				default:
					panic("invalid op")
				}
			case Op_Delete:
				opPath, opItem := op.Pop()
				switch opValue := opItem.V.(type) {
				case *Locator_Field:
					return transformMoveIndexDeleteField()
				case *Locator_Index:
					return transformMoveIndexDeleteIndex()
				case *Locator_Key:
					return transformMoveIndexDeleteKey()
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}

		case *Locator_Key:
			transformerTo := transformer.Value.(*Op_Key)
			switch op.Type {
			case Op_Edit:
				opPath, opItem := op.Pop()
				opDelta, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformMoveKeyEditField()
					case *Locator_Index:
						return transformMoveKeyEditIndex()
					case *Locator_Key:
						return transformMoveKeyEditKey()
					default:
						panic("invalid op")
					}
				} else {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformMoveKeyReplaceField()
					case *Locator_Index:
						return transformMoveKeyReplaceIndex()
					case *Locator_Key:
						return transformMoveKeyReplaceKey()
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				opPath, opItem := op.Pop()
				switch opItemValue := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformMoveKeyInsertIndex()
				case *Locator_Key:
					return transformMoveKeyInsertKey()
				default:
					panic("invalid op")
				}
			case Op_Move:
				opPath, opItem := op.Pop()
				switch opFrom := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					opTo := op.Value.(*Op_Index)
					return transformMoveKeyMoveIndex()
				case *Locator_Key:
					opTo := op.Value.(*Op_Key)
					return transformMoveKeyMoveKey()
				default:
					panic("invalid op")
				}
			case Op_Delete:
				opPath, opItem := op.Pop()
				switch opValue := opItem.V.(type) {
				case *Locator_Field:
					return transformMoveKeyDeleteField()
				case *Locator_Index:
					return transformMoveKeyDeleteIndex()
				case *Locator_Key:
					return transformMoveKeyDeleteKey()
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
		transformerPath, transformerItem := transformer.Pop()
		switch transformerValue := transformerItem.V.(type) {
		case *Locator_Field:
			switch op.Type {
			case Op_Edit:
				opPath, opItem := op.Pop()
				opDelta, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteFieldEditField()
					case *Locator_Index:
						return transformDeleteFieldEditIndex()
					case *Locator_Key:
						return transformDeleteFieldEditKey()
					default:
						panic("invalid op")
					}
				} else {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteFieldReplaceField()
					case *Locator_Index:
						return transformDeleteFieldReplaceIndex()
					case *Locator_Key:
						return transformDeleteFieldReplaceKey()
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				opPath, opItem := op.Pop()
				switch opItemValue := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteFieldInsertIndex()
				case *Locator_Key:
					return transformDeleteFieldInsertKey()
				default:
					panic("invalid op")
				}
			case Op_Move:
				opPath, opItem := op.Pop()
				switch opFrom := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					opTo := op.Value.(*Op_Index)
					return transformDeleteFieldMoveIndex()
				case *Locator_Key:
					opTo := op.Value.(*Op_Key)
					return transformDeleteFieldMoveKey()
				default:
					panic("invalid op")
				}
			case Op_Delete:
				opPath, opItem := op.Pop()
				switch opValue := opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteFieldDeleteField()
				case *Locator_Index:
					return transformDeleteFieldDeleteIndex()
				case *Locator_Key:
					return transformDeleteFieldDeleteKey()
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Index:
			switch op.Type {
			case Op_Edit:
				opPath, opItem := op.Pop()
				opDelta, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteIndexEditField()
					case *Locator_Index:
						return transformDeleteIndexEditIndex()
					case *Locator_Key:
						return transformDeleteIndexEditKey()
					default:
						panic("invalid op")
					}
				} else {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteIndexReplaceField()
					case *Locator_Index:
						return transformDeleteIndexReplaceIndex()
					case *Locator_Key:
						return transformDeleteIndexReplaceKey()
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				opPath, opItem := op.Pop()
				switch opItemValue := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteIndexInsertIndex()
				case *Locator_Key:
					return transformDeleteIndexInsertKey()
				default:
					panic("invalid op")
				}
			case Op_Move:
				opPath, opItem := op.Pop()
				switch opFrom := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					opTo := op.Value.(*Op_Index)
					return transformDeleteIndexMoveIndex()
				case *Locator_Key:
					opTo := op.Value.(*Op_Key)
					return transformDeleteIndexMoveKey()
				default:
					panic("invalid op")
				}
			case Op_Delete:
				opPath, opItem := op.Pop()
				switch opValue := opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteIndexDeleteField()
				case *Locator_Index:
					return transformDeleteIndexDeleteIndex()
				case *Locator_Key:
					return transformDeleteIndexDeleteKey()
				default:
					panic("invalid op")
				}
			default:
				panic("invalid op")
			}
		case *Locator_Key:
			switch op.Type {
			case Op_Edit:
				opPath, opItem := op.Pop()
				opDelta, opIsDelta := op.Value.(*Op_Delta)
				if opIsDelta {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteKeyEditField()
					case *Locator_Index:
						return transformDeleteKeyEditIndex()
					case *Locator_Key:
						return transformDeleteKeyEditKey()
					default:
						panic("invalid op")
					}
				} else {
					switch opValue := opItem.V.(type) {
					case *Locator_Field:
						return transformDeleteKeyReplaceField()
					case *Locator_Index:
						return transformDeleteKeyReplaceIndex()
					case *Locator_Key:
						return transformDeleteKeyReplaceKey()
					default:
						panic("invalid op")
					}
				}
			case Op_Insert:
				opPath, opItem := op.Pop()
				switch opItemValue := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					return transformDeleteKeyInsertIndex()
				case *Locator_Key:
					return transformDeleteKeyInsertKey()
				default:
					panic("invalid op")
				}
			case Op_Move:
				opPath, opItem := op.Pop()
				switch opFrom := opItem.V.(type) {
				case *Locator_Field:
					panic("invalid op")
				case *Locator_Index:
					opTo := op.Value.(*Op_Index)
					return transformDeleteKeyMoveIndex()
				case *Locator_Key:
					opTo := op.Value.(*Op_Key)
					return transformDeleteKeyMoveKey()
				default:
					panic("invalid op")
				}
			case Op_Delete:
				opPath, opItem := op.Pop()
				switch opValue := opItem.V.(type) {
				case *Locator_Field:
					return transformDeleteKeyDeleteField()
				case *Locator_Index:
					return transformDeleteKeyDeleteIndex()
				case *Locator_Key:
					return transformDeleteKeyDeleteKey()
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

func transformEditFieldEditField() *Op    { panic("TODO") }
func transformEditFieldEditIndex() *Op    { panic("TODO") }
func transformEditFieldEditKey() *Op      { panic("TODO") }
func transformEditFieldReplaceField() *Op { panic("TODO") }
func transformEditFieldReplaceIndex() *Op { panic("TODO") }
func transformEditFieldReplaceKey() *Op   { panic("TODO") }
func transformEditFieldInsertIndex() *Op  { panic("TODO") }
func transformEditFieldInsertKey() *Op    { panic("TODO") }
func transformEditFieldMoveIndex() *Op    { panic("TODO") }
func transformEditFieldMoveKey() *Op      { panic("TODO") }
func transformEditFieldDeleteField() *Op  { panic("TODO") }
func transformEditFieldDeleteIndex() *Op  { panic("TODO") }
func transformEditFieldDeleteKey() *Op    { panic("TODO") }

func transformEditIndexEditField() *Op    { panic("TODO") }
func transformEditIndexEditIndex() *Op    { panic("TODO") }
func transformEditIndexEditKey() *Op      { panic("TODO") }
func transformEditIndexReplaceField() *Op { panic("TODO") }
func transformEditIndexReplaceIndex() *Op { panic("TODO") }
func transformEditIndexReplaceKey() *Op   { panic("TODO") }
func transformEditIndexInsertIndex() *Op  { panic("TODO") }
func transformEditIndexInsertKey() *Op    { panic("TODO") }
func transformEditIndexMoveIndex() *Op    { panic("TODO") }
func transformEditIndexMoveKey() *Op      { panic("TODO") }
func transformEditIndexDeleteField() *Op  { panic("TODO") }
func transformEditIndexDeleteIndex() *Op  { panic("TODO") }
func transformEditIndexDeleteKey() *Op    { panic("TODO") }

func transformEditKeyEditField() *Op    { panic("TODO") }
func transformEditKeyEditIndex() *Op    { panic("TODO") }
func transformEditKeyEditKey() *Op      { panic("TODO") }
func transformEditKeyReplaceField() *Op { panic("TODO") }
func transformEditKeyReplaceIndex() *Op { panic("TODO") }
func transformEditKeyReplaceKey() *Op   { panic("TODO") }
func transformEditKeyInsertIndex() *Op  { panic("TODO") }
func transformEditKeyInsertKey() *Op    { panic("TODO") }
func transformEditKeyMoveIndex() *Op    { panic("TODO") }
func transformEditKeyMoveKey() *Op      { panic("TODO") }
func transformEditKeyDeleteField() *Op  { panic("TODO") }
func transformEditKeyDeleteIndex() *Op  { panic("TODO") }
func transformEditKeyDeleteKey() *Op    { panic("TODO") }

func transformReplaceFieldEditField() *Op    { panic("TODO") }
func transformReplaceFieldEditIndex() *Op    { panic("TODO") }
func transformReplaceFieldEditKey() *Op      { panic("TODO") }
func transformReplaceFieldReplaceField() *Op { panic("TODO") }
func transformReplaceFieldReplaceIndex() *Op { panic("TODO") }
func transformReplaceFieldReplaceKey() *Op   { panic("TODO") }
func transformReplaceFieldInsertIndex() *Op  { panic("TODO") }
func transformReplaceFieldInsertKey() *Op    { panic("TODO") }
func transformReplaceFieldMoveIndex() *Op    { panic("TODO") }
func transformReplaceFieldMoveKey() *Op      { panic("TODO") }
func transformReplaceFieldDeleteField() *Op  { panic("TODO") }
func transformReplaceFieldDeleteIndex() *Op  { panic("TODO") }
func transformReplaceFieldDeleteKey() *Op    { panic("TODO") }

func transformReplaceIndexEditField() *Op    { panic("TODO") }
func transformReplaceIndexEditIndex() *Op    { panic("TODO") }
func transformReplaceIndexEditKey() *Op      { panic("TODO") }
func transformReplaceIndexReplaceField() *Op { panic("TODO") }
func transformReplaceIndexReplaceIndex() *Op { panic("TODO") }
func transformReplaceIndexReplaceKey() *Op   { panic("TODO") }
func transformReplaceIndexInsertIndex() *Op  { panic("TODO") }
func transformReplaceIndexInsertKey() *Op    { panic("TODO") }
func transformReplaceIndexMoveIndex() *Op    { panic("TODO") }
func transformReplaceIndexMoveKey() *Op      { panic("TODO") }
func transformReplaceIndexDeleteField() *Op  { panic("TODO") }
func transformReplaceIndexDeleteIndex() *Op  { panic("TODO") }
func transformReplaceIndexDeleteKey() *Op    { panic("TODO") }

func transformReplaceKeyEditField() *Op    { panic("TODO") }
func transformReplaceKeyEditIndex() *Op    { panic("TODO") }
func transformReplaceKeyEditKey() *Op      { panic("TODO") }
func transformReplaceKeyReplaceField() *Op { panic("TODO") }
func transformReplaceKeyReplaceIndex() *Op { panic("TODO") }
func transformReplaceKeyReplaceKey() *Op   { panic("TODO") }
func transformReplaceKeyInsertIndex() *Op  { panic("TODO") }
func transformReplaceKeyInsertKey() *Op    { panic("TODO") }
func transformReplaceKeyMoveIndex() *Op    { panic("TODO") }
func transformReplaceKeyMoveKey() *Op      { panic("TODO") }
func transformReplaceKeyDeleteField() *Op  { panic("TODO") }
func transformReplaceKeyDeleteIndex() *Op  { panic("TODO") }
func transformReplaceKeyDeleteKey() *Op    { panic("TODO") }

func transformInsertIndexEditField() *Op    { panic("TODO") }
func transformInsertIndexEditIndex() *Op    { panic("TODO") }
func transformInsertIndexEditKey() *Op      { panic("TODO") }
func transformInsertIndexReplaceField() *Op { panic("TODO") }
func transformInsertIndexReplaceIndex() *Op { panic("TODO") }
func transformInsertIndexReplaceKey() *Op   { panic("TODO") }
func transformInsertIndexInsertIndex() *Op  { panic("TODO") }
func transformInsertIndexInsertKey() *Op    { panic("TODO") }
func transformInsertIndexMoveIndex() *Op    { panic("TODO") }
func transformInsertIndexMoveKey() *Op      { panic("TODO") }
func transformInsertIndexDeleteField() *Op  { panic("TODO") }
func transformInsertIndexDeleteIndex() *Op  { panic("TODO") }
func transformInsertIndexDeleteKey() *Op    { panic("TODO") }

func transformInsertKeyEditField() *Op    { panic("TODO") }
func transformInsertKeyEditIndex() *Op    { panic("TODO") }
func transformInsertKeyEditKey() *Op      { panic("TODO") }
func transformInsertKeyReplaceField() *Op { panic("TODO") }
func transformInsertKeyReplaceIndex() *Op { panic("TODO") }
func transformInsertKeyReplaceKey() *Op   { panic("TODO") }
func transformInsertKeyInsertIndex() *Op  { panic("TODO") }
func transformInsertKeyInsertKey() *Op    { panic("TODO") }
func transformInsertKeyMoveIndex() *Op    { panic("TODO") }
func transformInsertKeyMoveKey() *Op      { panic("TODO") }
func transformInsertKeyDeleteField() *Op  { panic("TODO") }
func transformInsertKeyDeleteIndex() *Op  { panic("TODO") }
func transformInsertKeyDeleteKey() *Op    { panic("TODO") }

func transformMoveIndexEditField() *Op    { panic("TODO") }
func transformMoveIndexEditIndex() *Op    { panic("TODO") }
func transformMoveIndexEditKey() *Op      { panic("TODO") }
func transformMoveIndexReplaceField() *Op { panic("TODO") }
func transformMoveIndexReplaceIndex() *Op { panic("TODO") }
func transformMoveIndexReplaceKey() *Op   { panic("TODO") }
func transformMoveIndexInsertIndex() *Op  { panic("TODO") }
func transformMoveIndexInsertKey() *Op    { panic("TODO") }
func transformMoveIndexMoveIndex() *Op    { panic("TODO") }
func transformMoveIndexMoveKey() *Op      { panic("TODO") }
func transformMoveIndexDeleteField() *Op  { panic("TODO") }
func transformMoveIndexDeleteIndex() *Op  { panic("TODO") }
func transformMoveIndexDeleteKey() *Op    { panic("TODO") }

func transformMoveKeyEditField() *Op    { panic("TODO") }
func transformMoveKeyEditIndex() *Op    { panic("TODO") }
func transformMoveKeyEditKey() *Op      { panic("TODO") }
func transformMoveKeyReplaceField() *Op { panic("TODO") }
func transformMoveKeyReplaceIndex() *Op { panic("TODO") }
func transformMoveKeyReplaceKey() *Op   { panic("TODO") }
func transformMoveKeyInsertIndex() *Op  { panic("TODO") }
func transformMoveKeyInsertKey() *Op    { panic("TODO") }
func transformMoveKeyMoveIndex() *Op    { panic("TODO") }
func transformMoveKeyMoveKey() *Op      { panic("TODO") }
func transformMoveKeyDeleteField() *Op  { panic("TODO") }
func transformMoveKeyDeleteIndex() *Op  { panic("TODO") }
func transformMoveKeyDeleteKey() *Op    { panic("TODO") }

func transformDeleteFieldEditField() *Op    { panic("TODO") }
func transformDeleteFieldEditIndex() *Op    { panic("TODO") }
func transformDeleteFieldEditKey() *Op      { panic("TODO") }
func transformDeleteFieldReplaceField() *Op { panic("TODO") }
func transformDeleteFieldReplaceIndex() *Op { panic("TODO") }
func transformDeleteFieldReplaceKey() *Op   { panic("TODO") }
func transformDeleteFieldInsertIndex() *Op  { panic("TODO") }
func transformDeleteFieldInsertKey() *Op    { panic("TODO") }
func transformDeleteFieldMoveIndex() *Op    { panic("TODO") }
func transformDeleteFieldMoveKey() *Op      { panic("TODO") }
func transformDeleteFieldDeleteField() *Op  { panic("TODO") }
func transformDeleteFieldDeleteIndex() *Op  { panic("TODO") }
func transformDeleteFieldDeleteKey() *Op    { panic("TODO") }

func transformDeleteIndexEditField() *Op    { panic("TODO") }
func transformDeleteIndexEditIndex() *Op    { panic("TODO") }
func transformDeleteIndexEditKey() *Op      { panic("TODO") }
func transformDeleteIndexReplaceField() *Op { panic("TODO") }
func transformDeleteIndexReplaceIndex() *Op { panic("TODO") }
func transformDeleteIndexReplaceKey() *Op   { panic("TODO") }
func transformDeleteIndexInsertIndex() *Op  { panic("TODO") }
func transformDeleteIndexInsertKey() *Op    { panic("TODO") }
func transformDeleteIndexMoveIndex() *Op    { panic("TODO") }
func transformDeleteIndexMoveKey() *Op      { panic("TODO") }
func transformDeleteIndexDeleteField() *Op  { panic("TODO") }
func transformDeleteIndexDeleteIndex() *Op  { panic("TODO") }
func transformDeleteIndexDeleteKey() *Op    { panic("TODO") }

func transformDeleteKeyEditField() *Op    { panic("TODO") }
func transformDeleteKeyEditIndex() *Op    { panic("TODO") }
func transformDeleteKeyEditKey() *Op      { panic("TODO") }
func transformDeleteKeyReplaceField() *Op { panic("TODO") }
func transformDeleteKeyReplaceIndex() *Op { panic("TODO") }
func transformDeleteKeyReplaceKey() *Op   { panic("TODO") }
func transformDeleteKeyInsertIndex() *Op  { panic("TODO") }
func transformDeleteKeyInsertKey() *Op    { panic("TODO") }
func transformDeleteKeyMoveIndex() *Op    { panic("TODO") }
func transformDeleteKeyMoveKey() *Op      { panic("TODO") }
func transformDeleteKeyDeleteField() *Op  { panic("TODO") }
func transformDeleteKeyDeleteIndex() *Op  { panic("TODO") }
func transformDeleteKeyDeleteKey() *Op    { panic("TODO") }
