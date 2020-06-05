package delta

import (
	"fmt"

	"github.com/golang/protobuf/proto"
)

func (transformer *Op) Transform(op *Op, priority bool) *Op {
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
	switch transformer.Type {
	case Op_Edit:
		// transformer has replaced (or modified if isDelta) the value at transformer.Location
		transformerDelta, isTransformerDelta := transformer.Value.(*Op_Delta)
		switch op.Type {
		case Op_Edit:
			if isTransformerDelta {
				switch TreeRelationship(transformer.Location, op.Location) {
				case TREE_EQUAL:
					opDelta, isOpDelta := op.Value.(*Op_Delta)
					if isOpDelta {
						// Two delta edits operating on the same value - use Quill library to transform
						// the operation.
						transformerQuill := transformerDelta.Delta.Quill()
						opQuill := opDelta.Delta.Quill()
						transformedQuill := transformerQuill.Transform(*opQuill, priority)
						out := proto.Clone(op).(*Op)
						out.Value = &Op_Delta{Delta: DeltaFromQuill(transformedQuill)}
						return out
					}
					return proto.Clone(op).(*Op)
				case TREE_ANCESTOR:
					panic("Invalid op")
				default:
					return proto.Clone(op).(*Op)
				}
			}
			switch TreeRelationship(transformer.Location, op.Location) {
			case TREE_EQUAL:
				if priority {
					// Both operations are trying to replace the same value. When the transformer
					// has priority, the transform should delete the operation.
					return nil
				}
				return proto.Clone(op).(*Op)
			case TREE_ANCESTOR:
				// The transformer has replaced a value which is an ancestor of the value being
				// replaced. The transform should delete the operation.
				return nil
			default:
				return proto.Clone(op).(*Op)
			}
		case Op_Insert:
			_, opItem := op.Pop()
			switch opItem.V.(type) {
			case *Locator_Field:
				// impossible
				panic("invalid operation Op_Insert with Locator_Field")
			case *Locator_Index:
				// insert at index creates a new value
				return proto.Clone(op).(*Op)
			case *Locator_Key:
				// insert at key overwrites a value at op.Location
				switch TreeRelationship(transformer.Location, op.Location) {
				case TREE_EQUAL:
					if isTransformerDelta {
						// The operation is trying to modify the value that the transformer has already
						// overwritten. Delete the op.
						return nil
					}
					if priority {
						// Both operations are trying to replace the same value. When the transformer
						// has priority, the transform should delete the operation.
						return nil
					}
					return proto.Clone(op).(*Op)
				case TREE_ANCESTOR:
					// The transformer has replaced a value which is an ancestor of the value being
					// replaced. The transform should delete the operation.
					return nil
				default:
					return proto.Clone(op).(*Op)
				}
			}
		case Op_Move:
			opParent, opItem := op.Pop()
			switch opItem.V.(type) {
			case *Locator_Field:
				// impossible
				panic("invalid operation Op_Move with Locator_Field")
			case *Locator_Index:
				// move with index creates a new value
				switch TreeRelationship(transformer.Location, opParent) {
				case TREE_ANCESTOR, TREE_EQUAL:
					// The operation is trying to move a value which is a descendent of the value that has been
					// replaced. We should delete the operation.
					return nil
				default:
					// operations are independent
					return proto.Clone(op).(*Op)
				}
			case *Locator_Key:
				// move with key overwrites a value at op.To()
				switch TreeRelationship(transformer.Location, op.To()) {
				case TREE_EQUAL:
					if isTransformerDelta {
						// The operation is trying to overwrite the value that the transformer has edited.
						return proto.Clone(op).(*Op)

						// TODO ???
						// Delete the op, and replace with an operation that deletes the
						// "from" location.
						//out := proto.Clone(op).(*Op)
						//return &Op{
						//	Type:     Op_Delete,
						//	Location: out.Location,
						//}
					}
					if priority {
						// Both operations are trying to replace the same value. When the transformer
						// has priority, the transform should delete the move operation, and replace
						// with an operation that deletes the "from" location.
						out := proto.Clone(op).(*Op)
						return &Op{
							Type:     Op_Delete,
							Location: out.Location,
						}
					}
					return proto.Clone(op).(*Op)
				case TREE_ANCESTOR:
					// The transformer has replaced a value which is an ancestor of the value being
					// replaced. The transform should delete the operation.
					return nil
				default:
					// operations are independent
					return proto.Clone(op).(*Op)
				}
			default:
				// impossible
				panic("invalid operation type")
			}
		case Op_Delete:
			switch TreeRelationship(transformer.Location, op.Location) {
			case TREE_EQUAL:
				if isTransformerDelta {
					// The operation is trying to modify the value that the transformer has already
					// overwritten. We should delete the op.
					return nil
				}
				if priority {
					// Both operations are trying to replace the same value. When the transformer
					// has priority, the transform should delete the operation.
					return nil
				}
				return proto.Clone(op).(*Op)
			case TREE_ANCESTOR:
				// The transformer has replaced a value which is an ancestor of the value being
				// replaced. The transform should delete the operation.
				return nil
			default:
				// operations are independent
				return proto.Clone(op).(*Op)
			}
		default:
			// impossible
			panic("invalid operation type")
		}
	case Op_Insert:
		transformerPath, transformerItem := transformer.Pop()
		switch transformerItemValue := transformerItem.V.(type) {
		case *Locator_Field:
			// impossible
			panic("Op_Insert with Locator_Field item")
		case *Locator_Index:
			// transformer is inserting a new value, shifting some indexes at transformerPath
			opPath, _ := op.Pop()
			relationship := TreeRelationship(transformerPath, opPath)
			switch relationship {
			case TREE_ANCESTOR, TREE_EQUAL:
				// index transformation function
				f := func(i int64) int64 {
					switch {
					case i > transformerItemValue.Index:
						return i + 1
					case i == transformerItemValue.Index:
						if priority {
							return i + 1
						} else {
							return i
						}
					default: // i < transformerItemValue.Index:
						return i
					}
				}
				// update the location in op
				locationIndex := len(transformer.Location) - 1
				oldValue := op.Location[locationIndex].V.(*Locator_Index).Index
				out := proto.Clone(op).(*Op)
				out.Location[locationIndex].V.(*Locator_Index).Index = f(oldValue)

				// for list move operations: update "to" location in op
				if op.Type == Op_Move && relationship == TREE_EQUAL {
					oldValue := op.Value.(*Op_Index).Index
					out.Value.(*Op_Index).Index = f(oldValue)
				}
				return out
			default:
				// operations are independent
				return proto.Clone(op).(*Op)
			}
		case *Locator_Key:
			// transformer overwrites the value at o.Location
			switch op.Type {
			case Op_Edit:
				switch TreeRelationship(transformer.Location, op.Location) {
				case TREE_EQUAL:
					// Op is trying to edit the value that the transformer has overwritten. When
					// the transformer has priority, the transform should delete the edit operation.
					if priority {
						return nil
					}
					return proto.Clone(op).(*Op)
				case TREE_ANCESTOR:
					// Op is trying to edit a descendent of the value that the transformer has
					// overwritten. We should delete the op.
					return nil
				default:
					// operations are independent
					return proto.Clone(op).(*Op)
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					// impossible
					panic("Op_Insert with Locator_Field value")
				case *Locator_Index:
					// operation creates a new value
					return proto.Clone(op).(*Op)
				case *Locator_Key:
					// operation overwrites value at op.Location
					switch TreeRelationship(transformer.Location, op.Location) {
					case TREE_EQUAL:
						// Op is trying to replace the value that the transformer has overwritten. When
						// the transformer has priority, the transform should delete the operation.
						if priority {
							return nil
						}
						return proto.Clone(op).(*Op)
					case TREE_ANCESTOR:
						// Op is trying to replace a descendent of the value that the transformer has
						// overwritten. We should delete the op.
						return nil
					default:
						// operations are independent
						return proto.Clone(op).(*Op)
					}
				default:
					// impossible
					panic("invalid loactor type")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					// impossible
					panic("Op_Move with Locator_Field")
				case *Locator_Index:
					switch TreeRelationship(transformer.Location, op.Location) {
					case TREE_ANCESTOR:
						// Op is trying to modify a descendent of the value that the transformer has
						// overwritten. We should delete the op.
						return nil
					default:
						// operations are independent
						return proto.Clone(op).(*Op)
					}
				case *Locator_Key:
					fromRelationship := TreeRelationship(transformer.Location, op.Location)
					toRelationship := TreeRelationship(transformer.Location, op.To())
					switch {
					case fromRelationship == TREE_EQUAL:
						// Op is trying to move the value that transformer has already overwritten. We
						// should delete the op.
						return nil
					case toRelationship == TREE_EQUAL:
						// Op is trying to overwrite the value that transformer has already overwritten.
						// We should delete the op if transformer has priority.
						if priority {
							// When the transformer has priority, the transform should delete the move
							// operation, and replace with an operation that deletes the "from" location.
							out := proto.Clone(op).(*Op)
							return &Op{
								Type:     Op_Delete,
								Location: out.Location,
							}
						}
						return proto.Clone(op).(*Op)
					case fromRelationship == TREE_ANCESTOR || toRelationship == TREE_ANCESTOR:
						// Op is modifying a descendent of the value that transformer has overwritten.
						// We should delete the op.
						return nil
					default:
						// operations are independent
						return proto.Clone(op).(*Op)
					}
				default:
					// impossible
					panic("invalid loactor type")
				}
			case Op_Delete:
				switch TreeRelationship(transformer.Location, op.Location) {
				case TREE_EQUAL:
					// Op is trying to delete the value that transformer has already overwritten.
					// We should delete the op if transformer has priority.
					if priority {
						return nil
					}
					return proto.Clone(op).(*Op)
				case TREE_ANCESTOR:
					// Op is deleting a descendent of the value that transformer has overwritten.
					// We should delete the op.
					return nil
				default:
					// operations are independent
					return proto.Clone(op).(*Op)
				}
			default:
				// impossible
				panic("invalid operation type")
			}
		default:
			// impossible
			panic("invalid locator type")
		}
	case Op_Move:
		transformerPath, transformerItem := transformer.Pop()
		switch transformerItemValue := transformerItem.V.(type) {
		case *Locator_Field:
			// impossible
			panic("Op_Move with Locator_Field item")
		case *Locator_Index:
			// transformer is inserting a new value, shifting some indexes at transformerPath
			from := transformerItemValue
			to := transformer.Value.(*Op_Index)
			opPath, _ := op.Pop()
			relationship := TreeRelationship(transformerPath, opPath)
			switch relationship {
			case TREE_ANCESTOR, TREE_EQUAL:
				// index transformation function
				f := func(i int64) int64 {
					if from.Index > to.Index {
						// items in between to and from shift forward one
						switch {
						case i > from.Index:
							return i
						case i == from.Index:
							return to.Index
						case i < from.Index && i > to.Index:
							return i + 1
						case i == to.Index:
							if priority {
								return i + 1
							} else {
								return i
							}
						default: // i < to.Index:
							return i
						}
					} else if from.Index < to.Index {
						// items in between to and from shift back one
						switch {
						case i > to.Index:
							return i
						case i == to.Index:
							if priority {
								return i - 1
							} else {
								return i
							}
						case i < to.Index && i > from.Index:
							return i - 1
						case i == from.Index:
							return to.Index
						default: // i < from.Index:
							return i
						}
					} else {
						// from.Index == to.Index
						return i
					}
				}
				// update the location in op
				locationIndex := len(transformer.Location) - 1
				oldValue := op.Location[locationIndex].V.(*Locator_Index).Index
				out := proto.Clone(op).(*Op)
				out.Location[locationIndex].V.(*Locator_Index).Index = f(oldValue)

				// for list move operations: update "to" location in op
				if op.Type == Op_Move && relationship == TREE_EQUAL {
					oldValue := op.Value.(*Op_Index).Index
					out.Value.(*Op_Index).Index = f(oldValue)
				}
				return out
			default:
				// operations are independent
				return proto.Clone(op).(*Op)
			}
		case *Locator_Key:
			// transformer has moved the value from transformer.Location and overwritten transformer.To()
			switch op.Type {
			case Op_Edit:
				toRelationship := TreeRelationship(transformer.To(), op.Location)
				fromRelationship := TreeRelationship(transformer.Location, op.Location)
				switch {
				case toRelationship == TREE_EQUAL:
					switch op.Value.(type) {
					case *Op_Scalar, *Op_Message, *Op_Object:
						if priority {
							// Op is trying to replace the value that the transformer has overwritten. If
							// the transformer has priority we should delete the op.
							return nil
						}
						return proto.Clone(op).(*Op)
					case *Op_Delta:
						// The operation is trying to modify the value that the transformer has already
						// overwritten. Delete the op.
						return nil
					default: // *Op_Index, *Op_Key
						panic(fmt.Sprintf("Transformer called with Op_Edit and %T", transformer.Value))
					}
				case fromRelationship == TREE_EQUAL:
					// Op is trying to edit the value that the transformer has moved. We should update
					// the location on the edit op.
					transformerCopy := proto.Clone(transformer).(*Op)
					out := proto.Clone(op).(*Op)
					out.Location = transformerCopy.To()
					return out
				case toRelationship == TREE_ANCESTOR:
					// Op is trying to edit a descendent of the value that the transformer has
					// overwritten. We should delete the op.
					return nil
				case fromRelationship == TREE_ANCESTOR:
					// Op is trying to edit a descendent of the value that the transformer has moved.
					// We should update the location in the edit op.
					indexToUpdate := len(transformer.Location) - 1
					transformerCopy := proto.Clone(transformer).(*Op)
					out := proto.Clone(op).(*Op)
					out.Location[indexToUpdate] = &Locator{V: &Locator_Key{transformerCopy.Value.(*Op_Key).Key}}
					return out
				default:
					// independent operations
					return proto.Clone(op).(*Op)
				}
			case Op_Insert:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					// impossible
					panic("invalid op")
				case *Locator_Index:
					toRelationship := TreeRelationship(transformer.To(), op.Location)
					fromRelationship := TreeRelationship(transformer.Location, op.Location)
					switch {
					case toRelationship == TREE_EQUAL || fromRelationship == TREE_EQUAL:
						// impossible
						panic("invalid ops combination")
					case toRelationship == TREE_ANCESTOR:
						// the operation is trying to edit a descendent of the value that the transformer
						// has overwritted. Delete the op.
						return nil
					case fromRelationship == TREE_ANCESTOR:
						// Op is trying to edit a descendent of the value that the transformer has
						// moved. We should update the location on the edit op.
						indexToUpdate := len(transformer.Location) - 1
						transformerCopy := proto.Clone(transformer).(*Op)
						out := proto.Clone(op).(*Op)
						out.Location[indexToUpdate] = &Locator{V: &Locator_Key{transformerCopy.Value.(*Op_Key).Key}}
						return out
					default:
						// independent operations
						return proto.Clone(op).(*Op)
					}
				case *Locator_Key:
					// operation is overwriting op.Location with a new value
					toRelationship := TreeRelationship(transformer.To(), op.Location)
					fromRelationship := TreeRelationship(transformer.Location, op.Location)
					switch {
					case toRelationship == TREE_EQUAL:
						// Op is trying to replace the value that the transformer has overwritten. If
						// the transformer has priority we should delete the op.
						if priority {
							return nil
						}
						return proto.Clone(op).(*Op)
					case fromRelationship == TREE_EQUAL:
						// Op is trying to overwrite the value that the transformer has moved. We should
						// update the location of op.
						transformerCopy := proto.Clone(transformer).(*Op)
						out := proto.Clone(op).(*Op)
						out.Location = transformerCopy.To()
						return out
					case toRelationship == TREE_ANCESTOR:
						// the operation is trying to overwrite a descendent of the value that the
						// transformer has overwritted. Delete the op.
						return nil
					case fromRelationship == TREE_ANCESTOR:
						// Op is trying to overwrite a descendent of the value that the transformer has
						// moved. We should update the location on the edit op.
						indexToUpdate := len(transformer.Location) - 1
						transformerCopy := proto.Clone(transformer).(*Op)
						out := proto.Clone(op).(*Op)
						out.Location[indexToUpdate] = &Locator{V: &Locator_Key{transformerCopy.Value.(*Op_Key).Key}}
						return out
					default:
						// independent operations
						return proto.Clone(op).(*Op)
					}
				default:
					// impossible
					panic("invalid op")
				}
			case Op_Move:
				_, opItem := op.Pop()
				switch opItem.V.(type) {
				case *Locator_Field:
					// impossible
					panic("invalid op")
				case *Locator_Index:
					toRelationship := TreeRelationship(transformer.To(), op.Location)
					fromRelationship := TreeRelationship(transformer.Location, op.Location)
					switch {
					case toRelationship == TREE_EQUAL || fromRelationship == TREE_EQUAL:
						// impossible
						panic("invalid ops combination")
					case toRelationship == TREE_ANCESTOR:
						// the operation is trying to move a descendent of the value that the transformer
						// has overwritted. Delete the op.
						return nil
					case fromRelationship == TREE_ANCESTOR:
						// Op is trying to move a descendent of the value that the transformer has
						// moved. We should update the location on the edit op.
						indexToUpdate := len(transformer.Location) - 1
						transformerCopy := proto.Clone(transformer).(*Op)
						out := proto.Clone(op).(*Op)
						out.Location[indexToUpdate] = &Locator{V: &Locator_Key{transformerCopy.Value.(*Op_Key).Key}}
						return out
					default:
						// independent operations
						return proto.Clone(op).(*Op)
					}
				case *Locator_Key:
					// transformer has moved the value from transformer.Location and overwritten transformer.To()
					// operation wants to move from op.Location and overwrite op.To()
					toFrom := TreeRelationship(transformer.To(), op.Location)
					toTo := TreeRelationship(transformer.To(), op.To())
					fromFrom := TreeRelationship(transformer.Location, op.Location)
					fromTo := TreeRelationship(transformer.Location, op.To())
					switch {
					case fromFrom == TREE_EQUAL && toTo == TREE_EQUAL:
						// Operation is trying to move the value that transformer already moved, and the "to" locations
						// are the same. Delete the op.
						return nil
					case fromFrom == TREE_EQUAL:
						// Operation is trying to move the value that transformer already moved, and the "to" locations
						// are different. If the transformer has priority, delete the op. If not, we change the From
						// location to move the correct value.
						if priority {
							return nil
						}
						transformerCopy := proto.Clone(transformer).(*Op)
						out := proto.Clone(op).(*Op)
						out.Location = transformerCopy.To()
						return out
					case toTo == TREE_EQUAL:
						// Operation is trying to overwrite a value that the transformer already overwrote. If the
						// transformer has priority, delete the op.
						if priority {
							return nil
						}
						return proto.Clone(op).(*Op)
					case fromTo == TREE_EQUAL && toFrom == TREE_EQUAL:
						// Operation is trying to move the value that transformer has already overwritten, and the "to"
						// location is the value that transformer moved. In order for the transformation to converge,
						// we must delete both values, so we replace op with a delete that removes at the From
						// location.
						out := proto.Clone(op).(*Op)
						return &Op{
							Type:     Op_Delete,
							Location: out.Location,
						}
						return out
					case fromTo == TREE_EQUAL:
						// Operation is trying to overwrite the value that from moved.
						// In order to converge, we must run operation as before but delete the transformer from
						// location.
						return &Op{
							Type: Op_Compound,
							Ops: []*Op{
								{
									Type:     Op_Delete,
									Location: transformer.To(),
								},
								proto.Clone(op).(*Op),
							},
						}
					case toFrom == TREE_EQUAL:
						// Operation is trying to move the value that transformer already overwrote. We delete the op.
						// In order to converge we must delete the operation "To" location.
						return &Op{
							Type:     Op_Delete,
							Location: op.To(),
						}
					default:
						// independent operations
						return proto.Clone(op).(*Op)
					}
				default:
					// impossible
					panic("invalid op")
				}
			case Op_Delete:
				toRelationship := TreeRelationship(transformer.To(), op.Location)
				fromRelationship := TreeRelationship(transformer.Location, op.Location)
				switch {
				case toRelationship == TREE_EQUAL:
					if priority {
						// Op is trying to delete the value that the transformer has overwritten. If the transformer
						// has priority we should delete the op.
						return nil
					}
					return proto.Clone(op).(*Op)
				case fromRelationship == TREE_EQUAL:
					// Op is trying to delete the value that the transformer has moved. We should update the location
					// on the delete op.
					transformerCopy := proto.Clone(transformer).(*Op)
					out := proto.Clone(op).(*Op)
					out.Location = transformerCopy.To()
					return out
				case toRelationship == TREE_ANCESTOR:
					// Op is trying to delete a descendent of the value that the transformer has overwritten. We should
					// delete the op.
					return nil
				case fromRelationship == TREE_ANCESTOR:
					// Op is trying to delete a descendent of the value that the transformer has moved. We should
					// update the location in the delete op.
					indexToUpdate := len(transformer.Location) - 1
					transformerCopy := proto.Clone(transformer).(*Op)
					out := proto.Clone(op).(*Op)
					out.Location[indexToUpdate] = &Locator{V: &Locator_Key{transformerCopy.Value.(*Op_Key).Key}}
					return out
				default:
					// independent operations
					return proto.Clone(op).(*Op)
				}
			}
		default:
			// impossible
			panic("invalid locator type")
		}
	case Op_Delete:

		transformerPath, transformerItem := transformer.Pop()

		deleteIndex, isIndex := transformerItem.V.(*Locator_Index)
		transformAncestorsIfNeeded := func(op *Op) *Op {
			// shifts indexes in op.Location if op is a descendent of one of the values shifted by the delete
			// transformer
			out := proto.Clone(op).(*Op)
			if !isIndex {
				// only need to shift indexes if the transformer is deleting from an index.
				return out
			}
			opPath, _ := out.Pop()
			relationship := TreeRelationship(transformerPath, opPath)

			if relationship != TREE_ANCESTOR && relationship != TREE_EQUAL {
				return out
			}

			shift := func(i int64) int64 {
				switch {
				case i > deleteIndex.Index:
					return i - 1
				case i == deleteIndex.Index:
					return i
				default: // i < del.Index:
					return i
				}
			}

			// update the location in op
			locationIndex := len(transformer.Location) - 1
			oldValue := out.Location[locationIndex].V.(*Locator_Index).Index
			out.Location[locationIndex].V.(*Locator_Index).Index = shift(oldValue)

			// for list move operations: update "to" location in op
			if out.Type == Op_Move && relationship == TREE_EQUAL {
				oldValue := out.Value.(*Op_Index).Index
				out.Value.(*Op_Index).Index = shift(oldValue)
			}
			return out
		}

		// transformer has deleted the value at transformer.Location
		switch op.Type {
		case Op_Edit:
			_, isDelta := op.Value.(*Op_Delta)
			switch TreeRelationship(transformer.Location, op.Location) {
			case TREE_EQUAL:
				if isDelta {
					// Op is trying to modify the value that transformer has already deleted. Delete the op.
					return nil
				}
				if priority {
					// Both operations are trying to replace the same value. When the transformer has priority,
					// the transform should delete the operation.
					return nil
				}
				return transformAncestorsIfNeeded(op)
			case TREE_ANCESTOR:
				// Op is trying to replace a descendent of the value that transformer deleted. Delete the op.
				return nil
			default:
				// independent operations
				return transformAncestorsIfNeeded(op)
			}
		case Op_Insert:
			_, opItem := op.Pop()
			switch opItem.V.(type) {
			case *Locator_Field:
				// impossible
				panic("invalid op")
			case *Locator_Index:
				// operation is inserting a new value at op.Location
				switch TreeRelationship(transformer.Location, op.Location) {
				case TREE_EQUAL:
					// Op is inserting at the same location that transformer just deleted. Continue as normal.
					return transformAncestorsIfNeeded(op)
				case TREE_ANCESTOR:
					// Op is trying to insert into a descendent of the value that transformer deleted. Delete the op.
					return nil
				default:
					// independent operations
					return transformAncestorsIfNeeded(op)
				}
			case *Locator_Key:
				// insert at key overwrites a value at op.Location
				switch TreeRelationship(transformer.Location, op.Location) {
				case TREE_EQUAL:
					if priority {
						// Both operations are trying to replace the same value. When the transformer has priority,
						// we should delete the operation.
						return nil
					}
					return transformAncestorsIfNeeded(op)
				case TREE_ANCESTOR:
					// The operation is trying to overwrite a descendent of the value that the transformed has
					// already deleted. We should delete the operation.
					return nil
				default:
					return transformAncestorsIfNeeded(op)
				}
			}
		case Op_Move:
			_, opItem := op.Pop()
			switch opItem.V.(type) {
			case *Locator_Field:
				// impossible
				panic("invalid operation Op_Move with Locator_Field")
			case *Locator_Index:
				// move with index creates a new value
				switch TreeRelationship(transformer.Location, op.Location) {
				case TREE_EQUAL:
					// Op is trying to move the value that transformer has already deleted. Delete the op.
					return nil
				case TREE_ANCESTOR:
					// The operation is trying to move a value which is a descendent of the value that has been
					// deleted. We should delete the operation.
					return nil
				}
				// operations are independent
				return transformAncestorsIfNeeded(op)
			case *Locator_Key:
				// move with key overwrites a value at op.To()
				switch TreeRelationship(transformer.Location, op.To()) {
				case TREE_EQUAL:
					if priority {
						// Both operations are trying to replace the same value. When the transformer
						// has priority, the transform should delete the move operation, and replace
						// with an operation that deletes the "from" location.
						out := proto.Clone(op).(*Op)
						return &Op{
							Type:     Op_Delete,
							Location: out.Location,
						}
					}
					return transformAncestorsIfNeeded(op)
				case TREE_ANCESTOR:
					// The transformer has replaced a value which is an ancestor of the value being
					// replaced. The transform should delete the operation.
					return nil
				default:
					// operations are independent
					return transformAncestorsIfNeeded(op)
				}
			default:
				// impossible
				panic("invalid operation type")
			}
		case Op_Delete:
			switch TreeRelationship(transformer.Location, op.Location) {
			case TREE_EQUAL:
				// Both operations are trying to replace the same value. We should delete the operation.
				return nil
			case TREE_ANCESTOR:
				// The transformer has replaced a value which is an ancestor of the value being
				// replaced. The transform should delete the operation.
				return nil
			default:
				// operations are independent
				return transformAncestorsIfNeeded(op)
			}
		default:
			// impossible
			panic("invalid operation type")
		}
	case Op_Compound:
		out := proto.Clone(op).(*Op)
		for _, t := range transformer.Ops {
			out = t.Transform(out, priority)
			if out == nil {
				return nil
			}
		}
		return out
	}
	return nil
}
