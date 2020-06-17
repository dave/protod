package delta

import (
	"fmt"
	"reflect"
	"strings"
	"time"

	quill "github.com/fmpwizard/go-quilljs-delta/delta"
	"github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
	"github.com/sergi/go-diff/diffmatchpatch"
	proto2 "google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
	"google.golang.org/protobuf/types/known/anypb"
)

//quill "github.com/fmpwizard/go-quilljs-delta/delta"

func Transform(op1, op2 *Op, op1priority bool) (op1x *Op, op2x *Op, err error) {
	if op1 == nil && op2 == nil {
		return nil, nil, nil
	}
	if op1 == nil {
		return nil, proto.Clone(op2).(*Op), nil
	}
	if op2 == nil {
		return proto.Clone(op1).(*Op), nil, nil
	}

	op2x = op1.Transform(op2, op1priority)
	op1x = op2.Transform(op1, !op1priority)

	return op1x, op2x, nil
}

func Apply(op *Op, input *proto2.Message) error {
	if op == nil {
		return nil
	}
	switch op.Type {
	case Op_Compound:
		for _, o := range op.Ops {
			if err := Apply(o, input); err != nil {
				return err
			}
		}
		return nil
	case Op_Edit:
		return ApplySet(op, input)
	case Op_Set:
		return ApplySet(op, input)
	case Op_Insert:
		return ApplyInsert(op, *input)
	case Op_Move:
		return ApplyMove(op, *input)
	case Op_Rename:
		return ApplyRename(op, *input)
	case Op_Delete:
		return ApplyDelete(op, input)
	}
	return fmt.Errorf("unknown op type %v", op.Type)
}

func ApplySet(op *Op, inputAddr *proto2.Message) error {
	if op.Location == nil {
		// root
		v := getValue(protoreflect.ValueOfMessage((*inputAddr).ProtoReflect()), op.Value)
		*inputAddr = v.Message().Interface()
		return nil
	}
	input := *inputAddr
	parentLocator, itemLocator := pop(op.Location)
	parent, _ := getLocation(input.ProtoReflect(), parentLocator)
	switch locator := itemLocator.V.(type) {
	case *Locator_Field:
		parent, ok := parent.(protoreflect.Message)
		if !ok {
			return fmt.Errorf("can't apply field locator to %T", parent)
		}
		field := getField(locator, parent)
		value := getValueField(parent, field, parent.Get(field), op.Value)
		parent.Set(field, value)
	case *Locator_Index:
		parent, ok := parent.(protoreflect.List)
		if !ok {
			return fmt.Errorf("can't apply list locator to %T", parent)
		}
		index := int(locator.Index)
		value := getValue(parent.Get(index), op.Value)
		parent.Set(index, value)
	case *Locator_Key:
		parent, ok := parent.(protoreflect.Map)
		if !ok {
			return fmt.Errorf("can't apply map locator to %T", parent)
		}
		key := getMapKey(locator.Key)
		value := getValue(parent.Get(key), op.Value)
		parent.Set(key, value)
	}
	return nil
}

func (o *Op) ItemIndex() int64 {
	return o.Item().V.(*Locator_Index).Index
}

func (o *Op) SetItemIndex(i int64) {
	o.Item().V.(*Locator_Index).Index = i
}

func (o *Op) ToIndex() int64 {
	return o.Value.(*Op_Index).Index
}

func (o *Op) SetToIndex(i int64) {
	o.Value.(*Op_Index).Index = i
}

func ApplyInsert(op *Op, input proto2.Message) error {
	parentLocator, itemLocator := pop(op.Location)
	parent, setter := getLocation(input.ProtoReflect(), parentLocator)
	switch locator := itemLocator.V.(type) {
	case *Locator_Field:
		return fmt.Errorf("can't insert with a field locator")
	case *Locator_Index:
		parent, ok := parent.(protoreflect.List)
		if !ok {
			return fmt.Errorf("can't insert with list locator in %T", parent)
		}
		value := getValue(protoreflect.Value{}, op.Value)
		index := int(locator.Index)
		length := parent.Len()
		if index == length {
			parent.Append(value)
			setter(protoreflect.ValueOfList(parent)) // must use parent setter in case of mutating operation
			return nil
		}
		parent.Append(parent.Get(length - 1))
		for i := length - 1; i > index; i-- {
			parent.Set(i, parent.Get(i-1))
		}
		parent.Set(index, value)
		setter(protoreflect.ValueOfList(parent)) // must use parent setter in case of mutating operation
	case *Locator_Key:
		return fmt.Errorf("can't insert with a key locator")
	}
	return nil
}

func ApplyMove(op *Op, input proto2.Message) error {
	parentLocator, itemLocator := pop(op.Location)
	parent, _ := getLocation(input.ProtoReflect(), parentLocator)
	switch locator := itemLocator.V.(type) {
	case *Locator_Field:
		return fmt.Errorf("can't move with a field locator")
	case *Locator_Index:
		parent, ok := parent.(protoreflect.List)
		if !ok {
			return fmt.Errorf("can't move with list locator in %T", parent)
		}
		value, ok := op.Value.(*Op_Index)
		if !ok {
			return fmt.Errorf("can't move in list with %T value", op.Value)
		}

		from := int(locator.Index)
		to := int(value.Index)
		if to > from {
			// the index in the "to" location is in the frame of reference of the original list. If moving forward,
			// that location is shifted backwards by the removal of the value that we're moving, so we decrement "to".
			to--
		}
		if from == to {
			return nil
		}
		item := parent.Get(from)
		if from > to {
			for i := from; i > to; i-- {
				parent.Set(i, parent.Get(i-1))
			}
		} else {
			for i := from; i < to; i++ {
				parent.Set(i, parent.Get(i+1))
			}
		}
		parent.Set(to, item)
	case *Locator_Key:
		return fmt.Errorf("can't move with a key locator")
	}
	return nil
}

func ApplyRename(op *Op, input proto2.Message) error {
	parentLocator, itemLocator := pop(op.Location)
	parent, _ := getLocation(input.ProtoReflect(), parentLocator)
	switch locator := itemLocator.V.(type) {
	case *Locator_Field:
		return fmt.Errorf("can't move with a field locator")
	case *Locator_Index:
		return fmt.Errorf("can't rename with an index locator")
	case *Locator_Key:
		parent, ok := parent.(protoreflect.Map)
		if !ok {
			return fmt.Errorf("can't delete map locator from %T", parent)
		}
		value, ok := op.Value.(*Op_Key)
		if !ok {
			return fmt.Errorf("can't move in list with %T value", op.Value)
		}
		if proto.Equal(locator.Key, value.Key) {
			return nil
		}
		from := getMapKey(locator.Key)
		to := getMapKey(value.Key)

		v := parent.Get(from)

		parent.Set(to, v)
		parent.Clear(from)

	}
	return nil
}

func ApplyDelete(op *Op, inputAddr *proto2.Message) error {
	if op.Location == nil {
		// root
		*inputAddr = nil
		return nil
	}
	input := *inputAddr
	parentLocator, itemLocator := pop(op.Location)
	parent, setter := getLocation(input.ProtoReflect(), parentLocator)
	switch locator := itemLocator.V.(type) {
	case *Locator_Field:
		parent, ok := parent.(protoreflect.Message)
		if !ok {
			return fmt.Errorf("can't delete field locator from %T", parent)
		}
		field := getField(locator, parent)
		parent.Clear(field)
	case *Locator_Index:
		parent, ok := parent.(protoreflect.List)
		if !ok {
			return fmt.Errorf("can't delete list locator from %T", parent)
		}
		index := int(locator.Index)
		length := parent.Len()
		for i := index; i < length-1; i++ {
			parent.Set(i, parent.Get(i+1))
		}
		parent.Truncate(length - 1)
		setter(protoreflect.ValueOfList(parent)) // must use parent setter in case of mutating operation
	case *Locator_Key:
		parent, ok := parent.(protoreflect.Map)
		if !ok {
			return fmt.Errorf("can't delete map locator from %T", parent)
		}
		key := getMapKey(locator.Key)
		parent.Clear(key)
	}
	return nil
}

func reflectValueOfEnum(enum int32) protoreflect.Value {
	return protoreflect.ValueOfEnum(protoreflect.EnumNumber(enum))
}

func reflectValueOfScalar(scalar *Scalar) protoreflect.Value {
	switch value := scalar.V.(type) {
	case *Scalar_Float:
		return protoreflect.ValueOfFloat32(value.Float)
	case *Scalar_Double:
		return protoreflect.ValueOfFloat64(value.Double)
	case *Scalar_Int32:
		return protoreflect.ValueOfInt32(value.Int32)
	case *Scalar_Int64:
		return protoreflect.ValueOfInt64(value.Int64)
	case *Scalar_Uint32:
		return protoreflect.ValueOfUint32(value.Uint32)
	case *Scalar_Uint64:
		return protoreflect.ValueOfUint64(value.Uint64)
	case *Scalar_Bool:
		return protoreflect.ValueOfBool(value.Bool)
	case *Scalar_String_:
		return protoreflect.ValueOfString(value.String_)
	case *Scalar_Bytes:
		return protoreflect.ValueOfBytes(value.Bytes)
	default:
		//case *Scalar_Sint32, *Scalar_Sint64:
		//case *Scalar_Fixed32, *Scalar_Fixed64:
		//case *Scalar_Sfixed32, *Scalar_Sfixed64:
		panic(fmt.Sprintf("unsupported scalar %T in reflectValueOfScalar", value))
	}
}

func valueOfScalar(scalar *Scalar) interface{} {
	switch value := scalar.V.(type) {
	case *Scalar_Float:
		return value.Float
	case *Scalar_Double:
		return value.Double
	case *Scalar_Int32:
		return value.Int32
	case *Scalar_Int64:
		return value.Int64
	case *Scalar_Uint32:
		return value.Uint32
	case *Scalar_Uint64:
		return value.Uint64
	case *Scalar_Bool:
		return value.Bool
	case *Scalar_String_:
		return value.String_
	case *Scalar_Bytes:
		return value.Bytes
	default:
		panic(fmt.Sprintf("unsupported scalar %T in valueOfScalar", value))
	}
}

func getValue(current protoreflect.Value, value isOp_Value) protoreflect.Value {
	return getValueField(nil, nil, current, value)
}

func getValueField(parent protoreflect.Message, field protoreflect.FieldDescriptor, current protoreflect.Value, value isOp_Value) protoreflect.Value {
	switch value := value.(type) {
	case *Op_Enum:
		return reflectValueOfEnum(value.Enum)
	case *Op_Scalar:
		return reflectValueOfScalar(value.Scalar)
	case *Op_Delta:
		prevString := current.String()
		dlt := value.Delta.Quill()

		// TODO: Is there a better way of applying the delta to prevString?
		out := quill.New(nil).Insert(prevString, nil).Compose(*dlt)
		var sb strings.Builder
		for _, o := range out.Ops {
			if len(o.Insert) == 0 {
				panic("non insert operation found after applying delta")
			}
			sb.WriteString(string(o.Insert))
		}
		return protoreflect.ValueOfString(sb.String())
	case *Op_Message:
		dynamicAny := MustUnmarshalAny(value.Message)
		reflectMessage := proto.MessageReflect(dynamicAny.Message)
		return protoreflect.ValueOfMessage(reflectMessage)
	case *Op_Object:
		return fromObject(parent, field, value.Object)
	default:
		//	*Op_Index
		//	*Op_Key
		// TODO: add these?
		panic(fmt.Sprintf("can't get value of %T", value))
	}
}

func fromObject(parent protoreflect.Message, field protoreflect.FieldDescriptor, object *Object) protoreflect.Value {
	switch value := object.V.(type) {
	case *Object_Scalar:
		return reflectValueOfScalar(value.Scalar)
	case *Object_Message:
		dynamicAny := MustUnmarshalAny(value.Message)
		reflectMessage := proto.MessageReflect(dynamicAny.Message)
		return protoreflect.ValueOfMessage(reflectMessage)
	case *Object_List:
		list := parent.NewField(field).List()
		for _, o := range value.List.List {
			list.Append(fromObject(nil, nil, o))
		}
		return protoreflect.ValueOfList(list)
	case *Object_MapBool:
		m := parent.NewField(field).Map()
		for k, o := range value.MapBool.Map {
			m.Set(protoreflect.ValueOfBool(k).MapKey(), fromObject(nil, nil, o))
		}
		return protoreflect.ValueOfMap(m)
	case *Object_MapInt32:
		m := parent.NewField(field).Map()
		for k, o := range value.MapInt32.Map {
			m.Set(protoreflect.ValueOfInt32(k).MapKey(), fromObject(nil, nil, o))
		}
		return protoreflect.ValueOfMap(m)
	case *Object_MapInt64:
		m := parent.NewField(field).Map()
		for k, o := range value.MapInt64.Map {
			m.Set(protoreflect.ValueOfInt64(k).MapKey(), fromObject(nil, nil, o))
		}
		return protoreflect.ValueOfMap(m)
	case *Object_MapUint32:
		m := parent.NewField(field).Map()
		for k, o := range value.MapUint32.Map {
			m.Set(protoreflect.ValueOfUint32(k).MapKey(), fromObject(nil, nil, o))
		}
		return protoreflect.ValueOfMap(m)
	case *Object_MapUint64:
		m := parent.NewField(field).Map()
		for k, o := range value.MapUint64.Map {
			m.Set(protoreflect.ValueOfUint64(k).MapKey(), fromObject(nil, nil, o))
		}
		return protoreflect.ValueOfMap(m)
	case *Object_MapString:
		m := parent.NewField(field).Map()
		for k, o := range value.MapString.Map {
			m.Set(protoreflect.ValueOfString(k).MapKey(), fromObject(nil, nil, o))
		}
		return protoreflect.ValueOfMap(m)
	default:
		panic(fmt.Sprintf("invalid type in fromObject %T", value))
	}
}

func getField(locator *Locator_Field, message protoreflect.Message) protoreflect.FieldDescriptor {
	field := message.Descriptor().Fields().ByNumber(protoreflect.FieldNumber(locator.Field.Number))
	if string(field.Name()) != locator.Field.Name {
		panic("field name / number mismatch")
	}
	return field
}

func (o *Op) Item() *Locator {
	if o.Type == Op_Compound {
		panic("Pop called on Op_Compound")
	}
	_, item := pop(o.Location)
	return item
}

func (o *Op) Parent() []*Locator {
	if o.Type == Op_Compound {
		panic("Pop called on Op_Compound")
	}
	parent, _ := pop(o.Location)
	return parent
}

func (o *Op) Pop() (path []*Locator, value *Locator) {
	if o.Type == Op_Compound {
		panic("Pop called on Op_Compound")
	}
	return pop(o.Location)
}

func pop(in []*Locator) (path []*Locator, value *Locator) {
	if len(in) == 0 {
		// TODO: work out if this breaks anything. In order for operations that act on the root node to be transformed
		// TODO: correctly, we need to consider them as Field locations. We must be able to do a type switch on item.V
		return nil, &Locator{V: &Locator_Field{}}
	}
	if len(in) == 1 {
		return nil, in[0]
	}
	return in[0 : len(in)-1], in[len(in)-1]
}

func getMapKey(key *Key) protoreflect.MapKey {
	var mapKey protoreflect.MapKey
	switch key := key.V.(type) {
	case *Key_Bool:
		mapKey = protoreflect.ValueOfBool(key.Bool).MapKey()
	case *Key_Int32:
		mapKey = protoreflect.ValueOfInt32(key.Int32).MapKey()
	case *Key_Int64:
		mapKey = protoreflect.ValueOfInt64(key.Int64).MapKey()
	case *Key_Uint32:
		mapKey = protoreflect.ValueOfUint32(key.Uint32).MapKey()
	case *Key_Uint64:
		mapKey = protoreflect.ValueOfUint64(key.Uint64).MapKey()
	case *Key_String_:
		mapKey = protoreflect.ValueOfString(key.String_).MapKey()
	}
	return mapKey
}

func Edit(location []*Locator, from, to string) *Op {
	dmp := diffmatchpatch.New()
	dmp.DiffTimeout = time.Millisecond * 100
	diffs := dmp.DiffCleanupSemantic(dmp.DiffMain(from, to, false))
	d := &Delta{}
	for _, diff := range diffs {
		switch diff.Type {
		case diffmatchpatch.DiffDelete:
			d.Ops = append(d.Ops, &Quill{V: &Quill_Delete{Delete: int64(len([]rune(diff.Text)))}})
		case diffmatchpatch.DiffEqual:
			d.Ops = append(d.Ops, &Quill{V: &Quill_Retain{Retain: int64(len([]rune(diff.Text)))}})
		case diffmatchpatch.DiffInsert:
			d.Ops = append(d.Ops, &Quill{V: &Quill_Insert{Insert: diff.Text}})
		}
	}
	return &Op{
		Type:     Op_Edit,
		Location: location,
		Value:    &Op_Delta{Delta: d},
	}
}

func Delete(location []*Locator) *Op {
	return &Op{
		Type:     Op_Delete,
		Location: location,
	}
}

func Move(location []*Locator, to int64) *Op {
	_, item := pop(location)
	//switch v := item.V.(type) {
	switch item.V.(type) {
	case *Locator_Index:
		//if to > v.Index {
		//	// When we move an item in a list, the "to" location is in the frame of reference of the result. When
		//	// moving forward (to > from), the "to" index is shifted back, so the index in the original list is one
		//	// more than the given index. For example:
		//	// data: [a, b, c] -> op: move from 0 to 1 -> result: [b, a, c]
		//	// the value was moved to index 1 in the resultant list, but the new position position is index 2 in the
		//	// original list.
		//	// For the purposes of correctly transforming the move operation, it's important we always work in the
		//	// frame of reference of the original list. So we tweak the to address here and tweak it back in the apply
		//	// function.
		//	to++
		//}
		return &Op{
			Type:     Op_Move,
			Location: location,
			Value:    opIndex(to),
		}
	default:
		panic(fmt.Sprintf("can't create move operation with %T item", item.V))
	}
}

func Rename(location []*Locator, to interface{}) *Op {
	_, item := pop(location)
	switch item.V.(type) {
	case *Locator_Key:
		return &Op{
			Type:     Op_Rename,
			Location: location,
			Value:    opKey(to),
		}
	default:
		panic(fmt.Sprintf("can't create rename operation with %T item", item.V))
	}
}

func Insert(location []*Locator, value interface{}) *Op {
	return &Op{
		Type:     Op_Insert,
		Location: location,
		Value:    opValue(value),
	}
}

func Set(location []*Locator, value interface{}) *Op {
	return &Op{
		Type:     Op_Set,
		Location: location,
		Value:    opValue(value),
	}
}

func opIndex(value interface{}) isOp_Value {
	switch value := value.(type) {
	case int:
		return &Op_Index{Index: int64(value)}
	case int64:
		return &Op_Index{Index: value}
	default:
		panic(fmt.Sprintf("can't make list index from %T", value))
	}
}

func getKey(value interface{}) *Key {
	switch value := value.(type) {
	case int:
		// default for int -> Key_Int64
		return &Key{V: &Key_Int64{Int64: int64(value)}}
	case bool:
		return &Key{V: &Key_Bool{Bool: value}}
	case int32:
		return &Key{V: &Key_Int32{Int32: value}}
	case int64:
		return &Key{V: &Key_Int64{Int64: value}}
	case uint32:
		return &Key{V: &Key_Uint32{Uint32: value}}
	case uint64:
		return &Key{V: &Key_Uint64{Uint64: value}}
	case string:
		return &Key{V: &Key_String_{String_: value}}
	default:
		panic(fmt.Sprintf("can't make map key from %T", value))
	}
}

func opKey(value interface{}) isOp_Value {
	return &Op_Key{Key: getKey(value)}
}

func locKey(value interface{}) isLocator_V {
	return &Locator_Key{Key: getKey(value)}
}

type ProtoEnum interface {
	Descriptor() protoreflect.EnumDescriptor
	Number() protoreflect.EnumNumber
}

func opValue(value interface{}) isOp_Value {
	switch value := value.(type) {
	case int, string, float64, float32, int64, int32, uint64, uint32, bool, []byte:
		return &Op_Scalar{Scalar: getScalar(value)}
	case proto.Message:
		return &Op_Message{Message: MustMarshalAny(value)}
	case ProtoEnum:
		return &Op_Enum{Enum: int32(value.Number())}
	default:
		return &Op_Object{Object: NewObject(value)}
	}
}

func NewObject(value interface{}) *Object {
	return newObject(reflect.ValueOf(value))
}

func newObject(value reflect.Value) *Object {
	switch value.Kind() {
	case reflect.Bool,
		reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64,
		reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64,
		reflect.Float32, reflect.Float64,
		reflect.String:
		return &Object{V: &Object_Scalar{Scalar: getScalar(value.Interface())}}

	case reflect.Array, reflect.Slice:
		if value.Kind() == reflect.Slice && value.Type().Elem().Kind() == reflect.Uint8 {
			// special case for []byte
			return &Object{V: &Object_Scalar{Scalar: getScalar(value.Interface())}}
		}
		list := make([]*Object, value.Len())
		for i := 0; i < value.Len(); i++ {
			list[i] = newObject(value.Index(i))
		}
		return &Object{V: &Object_List{List: &List{List: list}}}
	case reflect.Map:
		switch value.Type().Key().Kind() {
		case reflect.Bool:
			m := make(map[bool]*Object, value.Len())
			for _, v := range value.MapKeys() {
				m[v.Bool()] = newObject(value.MapIndex(v))
			}
			return &Object{V: &Object_MapBool{MapBool: &MapBool{Map: m}}}
		case reflect.Int8, reflect.Int16, reflect.Int32:
			m := make(map[int32]*Object, value.Len())
			for _, v := range value.MapKeys() {
				m[int32(v.Int())] = newObject(value.MapIndex(v))
			}
			return &Object{V: &Object_MapInt32{MapInt32: &MapInt32{Map: m}}}
		case reflect.Int, reflect.Int64:
			m := make(map[int64]*Object, value.Len())
			for _, v := range value.MapKeys() {
				m[v.Int()] = newObject(value.MapIndex(v))
			}
			return &Object{V: &Object_MapInt64{MapInt64: &MapInt64{Map: m}}}
		case reflect.Uint8, reflect.Uint16, reflect.Uint32:
			m := make(map[uint32]*Object, value.Len())
			for _, v := range value.MapKeys() {
				m[uint32(v.Uint())] = newObject(value.MapIndex(v))
			}
			return &Object{V: &Object_MapUint32{MapUint32: &MapUint32{Map: m}}}
		case reflect.Uint, reflect.Uint64:
			m := make(map[uint64]*Object, value.Len())
			for _, v := range value.MapKeys() {
				m[v.Uint()] = newObject(value.MapIndex(v))
			}
			return &Object{V: &Object_MapUint64{MapUint64: &MapUint64{Map: m}}}
		case reflect.String:
			m := make(map[string]*Object, value.Len())
			for _, v := range value.MapKeys() {
				m[v.String()] = newObject(value.MapIndex(v))
			}
			return &Object{V: &Object_MapString{MapString: &MapString{Map: m}}}

		default:
			panic(fmt.Sprintf("invalid map key type %s", value.Type().Key().String()))
		}

	case reflect.Struct:
		if m, ok := value.Interface().(proto.Message); ok {
			return &Object{V: &Object_Message{Message: MustMarshalAny(m)}}
		}
		if m, ok := value.Addr().Interface().(proto.Message); ok {
			return &Object{V: &Object_Message{Message: MustMarshalAny(m)}}
		}
		panic(fmt.Sprintf("invalid type %T", value))

	case reflect.Interface, reflect.Ptr:
		if m, ok := value.Interface().(proto.Message); ok {
			return &Object{V: &Object_Message{Message: MustMarshalAny(m)}}
		}
		return newObject(value.Elem())

	default:
		// reflect.Uintptr, reflect.Complex64, reflect.Complex128, reflect.Chan, reflect.Func, reflect.UnsafePointer
		panic(fmt.Sprintf("invalid type %T", value))
	}
}

func getScalar(value interface{}) *Scalar {
	switch value := value.(type) {
	case bool:
		return &Scalar{V: &Scalar_Bool{Bool: value}}

	case int:
		return &Scalar{V: &Scalar_Int64{Int64: int64(value)}}
	case int8:
		return &Scalar{V: &Scalar_Int32{Int32: int32(value)}}
	case int16:
		return &Scalar{V: &Scalar_Int32{Int32: int32(value)}}
	case int32:
		return &Scalar{V: &Scalar_Int32{Int32: value}}
	case int64:
		return &Scalar{V: &Scalar_Int64{Int64: value}}

	case uint:
		return &Scalar{V: &Scalar_Uint64{Uint64: uint64(value)}}
	case uint8:
		return &Scalar{V: &Scalar_Uint32{Uint32: uint32(value)}}
	case uint16:
		return &Scalar{V: &Scalar_Uint32{Uint32: uint32(value)}}
	case uint32:
		return &Scalar{V: &Scalar_Uint32{Uint32: value}}
	case uint64:
		return &Scalar{V: &Scalar_Uint64{Uint64: value}}

	case float32:
		return &Scalar{V: &Scalar_Float{Float: value}}
	case float64:
		return &Scalar{V: &Scalar_Double{Double: value}}

	case string:
		return &Scalar{V: &Scalar_String_{String_: value}}

	case []byte:
		return &Scalar{V: &Scalar_Bytes{Bytes: value}}

	default:
		panic(fmt.Sprintf("invalid type %T for scalar", value))
	}
}

func getLocation(m protoreflect.Message, loc []*Locator) (interface{}, func(protoreflect.Value)) {
	var current interface{} = m
	var setter func(protoreflect.Value)
	for _, sel := range loc {
		var value protoreflect.Value
		switch c := current.(type) {
		case protoreflect.Message:
			field, ok := sel.V.(*Locator_Field)
			if !ok {
				panic(fmt.Sprintf("field locator expected to find message, got %T", sel.V))
			}
			fieldDescriptor := getField(field, c)
			value = c.Get(fieldDescriptor)

			if !c.Has(fieldDescriptor) {
				// avoid assignment to nil maps or pointers
				value = c.NewField(fieldDescriptor)
				c.Set(fieldDescriptor, value)
			}
			setter = func(value protoreflect.Value) {
				c.Set(fieldDescriptor, value)
			}

		case protoreflect.List:
			index, ok := sel.V.(*Locator_Index)
			if !ok {
				panic(fmt.Sprintf("index locator expected to find list, got %T", sel.V))
			}
			indexInt := int(index.Index)
			value = c.Get(indexInt)
			setter = func(value protoreflect.Value) {
				c.Set(indexInt, value)
			}
		case protoreflect.Map:
			key, ok := sel.V.(*Locator_Key)
			if !ok {
				panic(fmt.Sprintf("key locator expected to find map, got %T", sel.V))
			}
			mapKey := getMapKey(key.Key)
			value = c.Get(mapKey)
			setter = func(value protoreflect.Value) {
				c.Set(mapKey, value)
			}
		default:
			panic(fmt.Sprintf("unknown locator %T", current))
		}

		switch valueInterface := value.Interface().(type) {
		case protoreflect.Message:
			current = valueInterface
		case protoreflect.List:
			current = valueInterface
		case protoreflect.Map:
			current = valueInterface
		default:
			current = value
		}
	}
	return current, setter
}

func MustMarshalAny(m proto.Message) *anypb.Any {
	a, err := ptypes.MarshalAny(m)
	if err != nil {
		panic(err)
	}
	return a
}

func MustUnmarshalAny(any *anypb.Any) *ptypes.DynamicAny {
	da := &ptypes.DynamicAny{}
	err := ptypes.UnmarshalAny(any.ProtoReflect().Interface().(*anypb.Any), da)
	if err != nil {
		panic(err)
	}
	return da
}

func CopyAndAppend(in []*Locator, v *Locator) []*Locator {
	out := make([]*Locator, len(in)+1)
	copy(out, in)
	out[len(out)-1] = v
	return out
}

func CopyAndAppendField(in []*Locator, name string, number int32) []*Locator {
	return CopyAndAppend(in, NewLocatorField(name, number))
}
func CopyAndAppendIndex(in []*Locator, index int64) []*Locator {
	return CopyAndAppend(in, NewLocatorIndex(index))
}
func CopyAndAppendKeyString(in []*Locator, key string) []*Locator {
	return CopyAndAppend(in, NewLocatorKeyString(key))
}
func CopyAndAppendKeyBool(in []*Locator, key bool) []*Locator {
	return CopyAndAppend(in, NewLocatorKeyBool(key))
}
func CopyAndAppendKeyInt32(in []*Locator, key int32) []*Locator {
	return CopyAndAppend(in, NewLocatorKeyInt32(key))
}
func CopyAndAppendKeyInt64(in []*Locator, key int64) []*Locator {
	return CopyAndAppend(in, NewLocatorKeyInt64(key))
}
func CopyAndAppendKeyUint32(in []*Locator, key uint32) []*Locator {
	return CopyAndAppend(in, NewLocatorKeyUint32(key))
}
func CopyAndAppendKeyUint64(in []*Locator, key uint64) []*Locator {
	return CopyAndAppend(in, NewLocatorKeyUint64(key))
}

func NewLocatorField(name string, number int32) *Locator {
	return &Locator{V: &Locator_Field{Field: &Field{Name: name, Number: number}}}
}
func NewLocatorIndex(index int64) *Locator {
	return &Locator{V: &Locator_Index{Index: index}}
}
func NewLocatorKeyString(key string) *Locator {
	return &Locator{V: &Locator_Key{Key: &Key{V: &Key_String_{String_: key}}}}
}
func NewLocatorKeyBool(key bool) *Locator {
	return &Locator{V: &Locator_Key{Key: &Key{V: &Key_Bool{Bool: key}}}}
}
func NewLocatorKeyInt32(key int32) *Locator {
	return &Locator{V: &Locator_Key{Key: &Key{V: &Key_Int32{Int32: key}}}}
}
func NewLocatorKeyInt64(key int64) *Locator {
	return &Locator{V: &Locator_Key{Key: &Key{V: &Key_Int64{Int64: key}}}}
}
func NewLocatorKeyUint32(key uint32) *Locator {
	return &Locator{V: &Locator_Key{Key: &Key{V: &Key_Uint32{Uint32: key}}}}
}
func NewLocatorKeyUint64(key uint64) *Locator {
	return &Locator{V: &Locator_Key{Key: &Key{V: &Key_Uint64{Uint64: key}}}}
}

type TreeRelationshipType int

const (
	TREE_NONE       TreeRelationshipType = 0
	TREE_EQUAL      TreeRelationshipType = 1
	TREE_ANCESTOR   TreeRelationshipType = 2
	TREE_DESCENDENT TreeRelationshipType = 3
)

func TreeRelationship(p1, p2 []*Locator) TreeRelationshipType {
	ancestor := isAncestor(p1, p2)
	descendent := isAncestor(p2, p1)
	switch {
	case ancestor && descendent:
		return TREE_EQUAL
	case ancestor:
		return TREE_ANCESTOR
	case descendent:
		return TREE_DESCENDENT
	default:
		return TREE_NONE
	}
}

func isAncestor(ancestor, descendent []*Locator) bool {
	if len(ancestor) > len(descendent) {
		return false
	}
	for i, al := range ancestor {
		dl := descendent[i]
		if !proto.Equal(al, dl) {
			return false
		}
	}
	return true
}

// IsNullMove returns true if o is an Op_Move and the from and to locations are the same.
func (o *Op) IsNullMove() bool {
	if o.Type != Op_Move && o.Type != Op_Rename {
		return false
	}
	from := o.Item()
	to := o.Value
	switch fromValue := from.V.(type) {
	case *Locator_Index:
		toValue := to.(*Op_Index)
		return fromValue.Index == toValue.Index || fromValue.Index == toValue.Index-1
	case *Locator_Key:
		toValue := to.(*Op_Key)
		return proto.Equal(fromValue.Key, toValue.Key)
	}
	panic("")
}

func (o *Op) To() []*Locator {
	if o.Type != Op_Move && o.Type != Op_Rename {
		return []*Locator{}
	}
	path, value := o.Pop()
	switch value.V.(type) {
	case *Locator_Index:
		return append(
			append([]*Locator(nil), path...),
			&Locator{V: &Locator_Index{Index: o.Value.(*Op_Index).Index}},
		)
	case *Locator_Key:
		return append(
			append([]*Locator(nil), path...),
			&Locator{V: &Locator_Key{Key: o.Value.(*Op_Key).Key}},
		)
	default:
		panic(fmt.Sprintf("invalid location %T in To()", value.V))
	}
}

func DeltaFromQuill(qd *quill.Delta) *Delta {
	delta := &Delta{}
	delta.Ops = make([]*Quill, len(qd.Ops))
	for i, op := range qd.Ops {
		switch {
		case len(op.Insert) > 0:
			delta.Ops[i] = &Quill{V: &Quill_Insert{Insert: string(op.Insert)}}
		case op.Delete != nil:
			delta.Ops[i] = &Quill{V: &Quill_Delete{Delete: int64(*op.Delete)}}
		case op.Retain != nil:
			delta.Ops[i] = &Quill{V: &Quill_Retain{Retain: int64(*op.Retain)}}
		default:
			panic("invalid op in DeltaFromQuill")
		}
	}
	return delta
}

func (d *Delta) Quill() *quill.Delta {
	ptr := func(i int) *int { return &i }
	ops := make([]quill.Op, len(d.Ops))

	for i, q := range d.Ops {
		switch op := q.V.(type) {
		case *Quill_Insert:
			ops[i] = quill.Op{Insert: []rune(op.Insert)}
		case *Quill_Retain:
			ops[i] = quill.Op{Retain: ptr(int(op.Retain))}
		case *Quill_Delete:
			ops[i] = quill.Op{Delete: ptr(int(op.Delete))}
		}
	}
	return quill.New(ops)
}
