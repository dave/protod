package delta

//
//type Transformer interface {
//	Transform(*Op) *Op
//}
//
//type MultiTransformer []Transformer
//
//func (t MultiTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	out := proto.Clone(op).(*Op)
//	for _, transformer := range t {
//		out = transformer.Transform(out)
//	}
//	return out
//}
//
//type ReplaceTransformer struct {
//	loc      []*Locator
//	priority bool
//}
//
//func transformCompound(t Transformer, ops []*Op) *Op {
//	var transformed []*Op
//	for _, o := range ops {
//		ox := t.Transform(o)
//		if ox != nil {
//			transformed = append(transformed, ox)
//		}
//	}
//	switch {
//	case len(transformed) == 0:
//		return nil
//	case len(transformed) == 1:
//		return transformed[0]
//	default:
//		return &Op{
//			Type: Op_Compound,
//			Ops:  transformed,
//		}
//	}
//}
//
//func (t *ReplaceTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	if op.Type == Op_Compound {
//		return transformCompound(t, op.Ops)
//	}
//	out := proto.Clone(op).(*Op)
//
//	if IsEqual(t.loc, out.Location) {
//		switch out.Type {
//		case Op_Move:
//			// TODO: work out if there's a more elegant way to handle this.
//			// Move operations that move the value to be deleted shouldn't be affected because
//			// they move the holder that the value sits in, and that value may be deleted, replaced
//			// or edited independent of the move.
//			return out
//
//		case Op_Insert:
//			_, v := out.Pop()
//			switch v.V.(type) {
//			case *Locator_Index:
//				// list insert creates a new value
//				return out
//			case *Locator_Key:
//				// map insert overwrites the value
//				if t.priority {
//					return nil
//				}
//				return out
//			default: // *Locator_Field
//				// invalid
//				panic("Locator_Field in Op_Insert in ReplaceTransformer.Transform")
//			}
//		default: // Op_Edit, Op_Delete
//			if t.priority {
//				// only operations with priority delete at the actual location
//				return nil
//			}
//			return out
//		}
//	} else if IsAncestor(t.loc, out.Location) {
//		return nil
//	}
//
//	return out
//}
//
//type DeleteTransformer struct {
//	loc      []*Locator
//	priority bool
//}
//
//func (t *DeleteTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	if op.Type == Op_Compound {
//		return transformCompound(t, op.Ops)
//	}
//	out := proto.Clone(op).(*Op)
//
//	if out.Type == Op_Move {
//		_, v := out.Pop()
//		switch v.V.(type) {
//		case *Locator_Key:
//			fmt.Println("--")
//			fmt.Println("t.loc", t.loc)
//			fmt.Println("out.To()", out.To())
//			fmt.Println("--")
//			if IsEqual(t.loc, out.To()) {
//				// map move overwrites the value at the to location
//				if t.priority {
//					return nil
//				}
//				return out
//			}
//		}
//	}
//
//	if IsEqual(t.loc, out.Location) {
//		switch out.Type {
//		case Op_Insert:
//			_, v := out.Pop()
//			switch v.V.(type) {
//			case *Locator_Index:
//				// list insert creates a new value
//				return out
//			case *Locator_Key:
//				// map insert overwrites the value
//				if t.priority {
//					return nil
//				}
//				return out
//			default: // *Locator_Field
//				// invalid
//				panic("Locator_Field in Op_Insert in DeleteTransformer.Transform")
//			}
//		case Op_Move:
//			//switch to := out.Value.(type) {
//			//case *Op_Key:
//			//	// TODO this is dumb... special case for chained_move_3
//			//
//			//	path, _ := out.Pop()
//			//
//			//	toLocation := append(
//			//		append([]*Locator(nil), path...),
//			//		&Locator{V: &Locator_Key{Key: to.Key}},
//			//	)
//			//
//			//	// replace with delete at to pos
//			//	return &Op{
//			//		Type:     Op_Delete,
//			//		Location: toLocation,
//			//	}
//			//}
//			return nil
//		default: // Op_Edit, Op_Delete
//			return nil
//		}
//	} else if IsAncestor(t.loc, out.Location) {
//		return nil
//	}
//
//	return out
//}
//
//
//type DeltaTransformer struct {
//	loc      []*Locator
//	delta    *Delta
//	priority bool
//}
//
//func (t *DeltaTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	if op.Type == Op_Compound {
//		return transformCompound(t, op.Ops)
//	}
//	out := proto.Clone(op).(*Op)
//
//	if IsEqual(t.loc, out.Location) && op.Type == Op_Edit {
//		delta, ok := op.Value.(*Op_Delta)
//		if !ok {
//			return out
//		}
//		transformerQuill := t.delta.Quill()
//		opQuill := delta.Delta.Quill()
//		transformedQuill := transformerQuill.Transform(*opQuill, t.priority)
//		out.Value = &Op_Delta{Delta: DeltaFromQuill(transformedQuill)}
//	}
//
//	return out
//}
//
//type NullTransformer struct{}
//
//func (t *NullTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	return proto.Clone(op).(*Op)
//}
//
//type CompoundTransformer struct {
//	ts []Transformer
//}
//
//func (t *CompoundTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	out := proto.Clone(op).(*Op)
//	for _, transformer := range t.ts {
//		out = transformer.Transform(out)
//	}
//	return out
//}
//
//type IndexTransformer struct {
//	tp []*Locator
//	tf func(int64) int64
//}
//
//func (t *IndexTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	if op.Type == Op_Compound {
//		return transformCompound(t, op.Ops)
//	}
//	out := proto.Clone(op).(*Op)
//
//	if !IsAncestor(t.tp, out.Affected()) {
//		return out
//	}
//
//	valueIndex := len(t.tp)
//
//	idx, ok := out.Location[valueIndex].V.(*Locator_Index)
//	if !ok {
//		panic(fmt.Sprintf("invalid transformation point %T in IndexTransformer.Transform", out.Location[valueIndex].V))
//	}
//	idx.Index = t.tf(idx.Index)
//
//	// apply transformer to move to index only if needs to
//	if out.Type == Op_Move && valueIndex == len(out.Location)-1 {
//		value, ok := out.Value.(*Op_Index)
//		if !ok {
//			panic(fmt.Sprintf("invalid value %T in IndexTransformer.Transform", out.Value))
//		}
//		value.Index = t.tf(value.Index)
//	}
//	return out
//
//}
//
//type KeyTransformer struct {
//	tp []*Locator
//	tf func(*Key) *Key
//}
//
//func (t *KeyTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	if op.Type == Op_Compound {
//		return transformCompound(t, op.Ops)
//	}
//	out := proto.Clone(op).(*Op)
//
//	if !IsAncestor(t.tp, out.Affected()) {
//		return out
//	}
//
//	keyIndex := len(t.tp)
//
//	key, ok := out.Location[keyIndex].V.(*Locator_Key)
//	if !ok {
//		panic(fmt.Sprintf("invalid transformation point %T in KeyTransformer.Transform", out.Location[keyIndex].V))
//	}
//	key.Key = t.tf(key.Key)
//
//	// apply transformer to move to index only if needs to
//	if out.Type == Op_Move && keyIndex == len(out.Location)-1 {
//		value, ok := out.Value.(*Op_Key)
//		if !ok {
//			panic(fmt.Sprintf("invalid value %T in KeyTransformer.Transform", out.Value))
//		}
//		value.Key = t.tf(value.Key)
//	}
//
//	return out
//}
//
//type MessageTransformer struct {
//}
//
//func (t *MessageTransformer) Transform(op *Op) *Op {
//	if op == nil {
//		return nil
//	}
//	return proto.Clone(op).(*Op)
//}
//
//func Independent(in1, in2 *Op) bool {
//	return !IsAncestor(in1.Affected(), in2.Affected()) &&
//		!IsAncestor(in2.Affected(), in1.Affected())
//}
//
//func (o *Op) Transformer(priority bool) Transformer {
//	switch o.Type {
//	case Op_Compound:
//		var ts []Transformer
//		for _, op := range o.Ops {
//			ts = append(ts, op.Transformer(priority))
//		}
//		return &CompoundTransformer{ts: ts}
//	case Op_Insert:
//		path, popped := o.Pop()
//		switch v := popped.V.(type) {
//		case *Locator_Field:
//			panic("Transformer called with Locator_Field as value of Op_Insert")
//		case *Locator_Index:
//			f := func(i int64) int64 {
//				switch {
//				case i > v.Index:
//					return i + 1
//				case i == v.Index:
//					if priority {
//						return i + 1
//					} else {
//						return i
//					}
//				default: // i < insert.Index:
//					return i
//				}
//			}
//			return &IndexTransformer{tp: path, tf: f}
//		case *Locator_Key:
//			return &ReplaceTransformer{loc: o.Location, priority: priority}
//		default:
//			panic(fmt.Sprintf("invalid type in Transformer Op_Insert"))
//		}
//	case Op_Move:
//		path, popped := o.Pop()
//		switch from := popped.V.(type) {
//		case *Locator_Index:
//			to, ok := o.Value.(*Op_Index)
//			if !ok {
//				panic(fmt.Sprintf("Transformer called with Locator_Index and %T to location", o.Value))
//			}
//			f := func(i int64) int64 {
//				if from.Index > to.Index {
//					// items in between to and from shift forward one
//					switch {
//					case i > from.Index:
//						return i
//					case i == from.Index:
//						return to.Index
//					case i < from.Index && i > to.Index:
//						return i + 1
//					case i == to.Index:
//						if priority {
//							return i + 1
//						} else {
//							return i
//						}
//					default: // i < to.Index:
//						return i
//					}
//				} else if from.Index < to.Index {
//					// items in between to and from shift back one
//					switch {
//					case i > to.Index:
//						return i
//					case i == to.Index:
//						if priority {
//							return i - 1
//						} else {
//							return i
//						}
//					case i < to.Index && i > from.Index:
//						return i - 1
//					case i == from.Index:
//						return to.Index
//					default: // i < from.Index:
//						return i
//					}
//				} else {
//					// from.Index == to.Index
//					return i
//				}
//			}
//			return &IndexTransformer{tp: path, tf: f}
//		case *Locator_Key:
//			to, ok := o.Value.(*Op_Key)
//			if !ok {
//				panic(fmt.Sprintf("Transformer called with Locator_Key and %T to location", o.Value))
//			}
//			f := func(in *Key) *Key {
//				if proto.Equal(in, from.Key) {
//					return proto.Clone(to.Key).(*Key)
//				}
//				return proto.Clone(in).(*Key)
//			}
//			fmt.Println("**", o.To())
//			return MultiTransformer{
//				&KeyTransformer{tp: path, tf: f},
//				&DeleteTransformer{loc: o.To(), priority: priority},
//			}
//		default: // *Locator_Field:
//			panic("Transformer called with Locator_Field as value of Op_Move")
//		}
//	case Op_Edit:
//		switch value := o.Value.(type) {
//		case *Op_Scalar, *Op_Message, *Op_Object:
//			return &ReplaceTransformer{loc: o.Location, priority: priority}
//		case *Op_Delta:
//			return &DeltaTransformer{
//				loc:      o.Location,
//				delta:    value.Delta,
//				priority: priority,
//			}
//		default:
//			//	*Op_Index, *Op_Key
//			panic(fmt.Sprintf("Transformer called with Op_Edit and %T", o.Value))
//		}
//		return &NullTransformer{}
//	case Op_Delete:
//		path, popped := o.Pop()
//		switch popped.V.(type) {
//		case *Locator_Index:
//			del, ok := popped.V.(*Locator_Index)
//			if !ok {
//				panic(fmt.Sprintf("TransformerIndex called with %T delete location", popped.V))
//			}
//			f := func(i int64) int64 {
//				switch {
//				case i > del.Index:
//					return i - 1
//				case i == del.Index:
//					return i
//				default: // i < del.Index:
//					return i
//				}
//			}
//			return MultiTransformer{
//				&DeleteTransformer{loc: o.Location, priority: priority},
//				&IndexTransformer{tp: path, tf: f},
//			}
//		default: // *Locator_Key, *Locator_Field:
//			return &DeleteTransformer{loc: o.Location, priority: priority}
//		}
//	default:
//		panic(fmt.Sprintf("Invalid type %T in TransformerIndex", o.Type))
//	}
//
//}
//
//func (o *Op) Affected() []*Locator {
//
//	// In order for an operation to be potentially affected by o, it must be at a descendent of this
//	// location.
//	// For move, list insert, and list delete operations, the last part of o.Location specifies the
//	// index of the target object, and other siblings are affected, so this returns the parent location.
//
//	switch o.Type {
//	case Op_Compound:
//		// The affected location of a compound operation is the common ancestor of all the operations
//		var affected [][]*Locator
//		var minLength int
//		for _, op := range o.Ops {
//			a := op.Affected()
//			affected = append(affected, a)
//			if len(a) < minLength || minLength == 0 {
//				minLength = len(a)
//			}
//		}
//		var out []*Locator
//		for i := 0; i < minLength; i++ {
//			for j := range affected {
//				if proto.Equal(affected[j][i], affected[0][i]) {
//					if j == len(affected)-1 {
//						out = append(out, affected[0][i])
//					}
//				} else {
//					return out
//				}
//			}
//		}
//		return out
//	case Op_Delete, Op_Insert:
//		path, value := pop(o.Location)
//		if _, ok := value.V.(*Locator_Index); ok {
//			// Op_Delete:
//			// list delete operations affect the parent location, but map / key delete operations
//			// only affect the item at the insertion point
//
//			// Op_Insert:
//			// list insert operations affect the parent location, but map / key insert operations
//			// only affect the location at the insertion point
//			return path
//		}
//		return o.Location
//	case Op_Move:
//		// move operations affect other siblings at the parent location.
//		// note: map move operations may affect siblings IF the "to" location overwrites another node.
//		path, _ := pop(o.Location)
//		return path
//	default: // Op_Edit
//		return o.Location
//	}
//}
