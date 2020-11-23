package fuzzer

import (
	"math/rand"
	"time"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
)

// Get creates a random op that is valid to apply to message, for testing and benchmarking.
func Get(message proto.Message) *pdelta.Op {
	ops := gatherValidOperationsMessage(nil, 0, message.ProtoReflect().Descriptor(), message.ProtoReflect(), SpecMessage{message: message.ProtoReflect()}, true)
	if len(ops) == 0 {
		panic("")
	}
	var total float64
	for _, op := range ops {
		total += op.weight()
	}
	target := rand.Float64() * total
	var count float64
	for _, op := range ops {
		count += op.weight()
		if count >= target {
			return op.op
		}
	}
	panic("")
}

func List(message proto.Message, length int) []*pdelta.Op {
	ops := gatherValidOperationsMessage(nil, 0, message.ProtoReflect().Descriptor(), message.ProtoReflect(), SpecMessage{message: message.ProtoReflect()}, true)
	if len(ops) == 0 {
		panic("")
	}
	var total float64
	for _, op := range ops {
		total += op.weight()
	}
	var out []*pdelta.Op
	for i := 0; i < length; i++ {
		target := rand.Float64() * total
		var count float64
		for _, op := range ops {
			count += op.weight()
			if count >= target {
				out = append(out, op.op)
			}
		}
	}
	return out
}

func All(message proto.Message) []*pdelta.Op {
	ops := gatherValidOperationsMessage(nil, 0, message.ProtoReflect().Descriptor(), message.ProtoReflect(), SpecMessage{message: message.ProtoReflect()}, true)
	out := make([]*pdelta.Op, len(ops))
	for i, op := range ops {
		out[i] = op.op
	}
	return out

}

func gatherValidOperations(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, value protoreflect.Value, spec Spec, exists bool) []opData {
	if !shouldIterate(location, set) {
		return []opData{}
	}
	switch {
	case field.IsList():
		if value.IsValid() {
			return gatherValidOperationsList(location, set, field, value.List(), spec, exists)
		}
		return gatherValidOperationsList(location, set, field, nil, spec, exists)
	case field.IsMap():
		if value.IsValid() {
			return gatherValidOperationsMap(location, set, field, value.Map(), spec, exists)
		}
		return gatherValidOperationsMap(location, set, field, nil, spec, exists)
	}
	return gatherValidOperationsIgnoreCollections(location, set, field, value, spec, exists)
}
func gatherValidOperationsIgnoreCollections(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, value protoreflect.Value, spec Spec, exists bool) []opData {
	switch field.Kind() {
	case protoreflect.EnumKind:
		return gatherValidOperationsEnum(location, set, field, exists)
	case protoreflect.MessageKind:
		if value.IsValid() {
			return gatherValidOperationsMessage(location, set, field.Message(), value.Message(), spec, exists)
		}
		return gatherValidOperationsMessage(location, set, field.Message(), nil, spec, exists)
	case protoreflect.GroupKind:
		// what is this?
		panic("")
	default:
		return gatherValidOperationsScalar(location, set, field, value.Interface(), exists)
	}
}
func gatherValidOperationsEnum(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, exists bool) []opData {
	// set
	// delete
	var ops []opData
	if exists {
		ops = append(ops, opData{exists: exists, op: &pdelta.Op{Type: pdelta.Op_Delete, Location: location}})
	}
	ops = append(ops, opData{exists: exists, op: &pdelta.Op{Type: pdelta.Op_Set, Location: location, Value: &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Enum{Enum: int32(randomEnum(field))}}}}})
	return ops
}
func gatherValidOperationsScalar(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, value interface{}, exists bool) []opData {
	// set
	// delete
	var ops []opData
	if exists {
		ops = append(ops, opData{exists: exists, op: &pdelta.Op{Type: pdelta.Op_Delete, Location: location}})
	}
	ops = append(ops, opData{exists: exists, op: &pdelta.Op{Type: pdelta.Op_Set, Location: location, Value: randomOpValueIgnoreCollection(location, set, field, nil).(*pdelta.Op_Scalar)}})
	if field.Kind() == protoreflect.StringKind {
		var val string
		if exists {
			val = value.(string)
		}
		ops = append(ops, opData{exists: exists, op: pdelta.Edit(location, val, randomString())})
	}
	return ops
}
func gatherValidOperationsList(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, list protoreflect.List, spec Spec, exists bool) []opData {
	var ops []opData

	// DONE delete
	if exists {
		ops = append(ops, opData{exists: exists, op: &pdelta.Op{
			Type:     pdelta.Op_Delete,
			Location: location,
		}})
	}

	// DONE set
	ops = append(ops, opData{exists: exists, op: &pdelta.Op{
		Type:     pdelta.Op_Set,
		Location: location,
		Value:    &pdelta.Op_Fragment{Fragment: randomDeltaList(location, set, field, spec)},
	}})

	// DONE move
	if list != nil && list.Len() > 0 {
		for i := 0; i < list.Len(); i++ { // repeat this n times where n=list length
			randomSourceIndex := rand.Intn(list.Len())
			randomDestinationIndex := rand.Intn(list.Len() + 1)
			ops = append(ops, opData{exists: exists, op: &pdelta.Op{
				Type:     pdelta.Op_Move,
				Location: pdelta.CopyAndAppendIndex(location, int64(randomSourceIndex)),
				Value:    &pdelta.Op_Index{Index: int64(randomDestinationIndex)},
			}})
		}
	}

	childSpec := SpecList{value: spec.New().List()}

	// DONE insert
	var randomDestinationIndex int
	if list != nil {
		randomDestinationIndex = rand.Intn(list.Len() + 1)
	}
	insertLocation := pdelta.CopyAndAppendIndex(location, int64(randomDestinationIndex))
	insertValue := randomOpValueIgnoreCollection(insertLocation, set, field, childSpec) // don't increment set because this value does not exist
	ops = append(ops, opData{exists: exists, op: &pdelta.Op{
		Type:     pdelta.Op_Insert,
		Location: insertLocation,
		Value:    pdelta.ToOpValue(insertValue),
	}})

	// DONE gather ops for children ->
	if list != nil {
		for i := 0; i < list.Len(); i++ {
			ops = append(ops, gatherValidOperationsIgnoreCollections(pdelta.CopyAndAppendIndex(location, int64(i)), set+1, field, list.Get(i), childSpec, true)...)
		}
	}

	return ops
}
func gatherValidOperationsMap(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, m protoreflect.Map, spec Spec, exists bool) []opData {
	var ops []opData
	// DONE delete
	if exists {
		ops = append(ops, opData{exists: exists, op: &pdelta.Op{
			Type:     pdelta.Op_Delete,
			Location: location,
		}})
	}

	// DONE set
	ops = append(ops, opData{exists: exists, op: &pdelta.Op{
		Type:     pdelta.Op_Set,
		Location: location,
		Value:    &pdelta.Op_Fragment{Fragment: randomDeltaMap(location, set, field.MapKey(), field.MapValue(), spec)},
	}})

	var keys []protoreflect.MapKey
	if m != nil {
		m.Range(func(key protoreflect.MapKey, value protoreflect.Value) bool {
			keys = append(keys, key)
			return true
		})
	}

	if len(keys) > 0 {
		for i := 0; i < len(keys); i++ { // repeat this n times where n=map length
			existingKey1 := deltaMapKey(keys[rand.Intn(len(keys))].Interface())
			existingKey2 := deltaMapKey(keys[rand.Intn(len(keys))].Interface())
			// DONE rename to existing key
			ops = append(ops, opData{exists: exists, op: &pdelta.Op{
				Type:     pdelta.Op_Rename,
				Location: pdelta.CopyAndAppend(location, newLocatorKey(existingKey1)),
				Value:    &pdelta.Op_Key{Key: existingKey2},
			}})
		}

		// rename to new key
		existingKey := deltaMapKey(keys[rand.Intn(len(keys))].Interface())
		newKey := deltaMapKey(getRandomKey(field.MapKey()))
		ops = append(ops, opData{exists: exists, op: &pdelta.Op{
			Type:     pdelta.Op_Rename,
			Location: pdelta.CopyAndAppend(location, newLocatorKey(existingKey)),
			Value:    &pdelta.Op_Key{Key: newKey},
		}})
	}

	childSpec := SpecMap{value: spec.New().Map()}

	// gather ops for existing children ->
	if m != nil {
		for _, key := range keys {
			ops = append(ops, gatherValidOperationsIgnoreCollections(pdelta.CopyAndAppend(location, newLocatorKey(deltaMapKey(key.Interface()))), set+1, field.MapValue(), m.Get(key), childSpec, true)...)
		}
	}

	// DONE gather ops for new child ->
	newKey := deltaMapKey(getRandomKey(field.MapKey()))
	ops = append(ops, gatherValidOperationsIgnoreCollections(pdelta.CopyAndAppend(location, newLocatorKey(newKey)), set, field.MapValue(), protoreflect.Value{}, childSpec, false)...)

	return ops
}
func newLocatorKey(key *pdelta.Key) *pdelta.Locator {
	return &pdelta.Locator{V: &pdelta.Locator_Key{Key: key}}
}
func gatherValidOperationsMessage(location []*pdelta.Locator, set int, descriptor protoreflect.MessageDescriptor, message protoreflect.Message, spec Spec, exists bool) []opData {
	var ops []opData
	if exists {
		ops = append(ops, opData{exists: exists, op: &pdelta.Op{
			Type:     pdelta.Op_Delete,
			Location: location,
		}})
	}
	ops = append(ops, opData{exists: exists, op: &pdelta.Op{
		Type:     pdelta.Op_Set,
		Location: location,
		Value:    &pdelta.Op_Message{Message: pdelta.MustMarshalAny(randomMessage(location, set, spec).Interface())},
	}})
	oneOfFields := map[protoreflect.FieldDescriptor]*pdelta.Oneof{}
	for oneOfIndex := 0; oneOfIndex < descriptor.Oneofs().Len(); oneOfIndex++ {
		oneOfDescriptor := descriptor.Oneofs().Get(oneOfIndex)
		oneOf := &pdelta.Oneof{Name: string(oneOfDescriptor.Name())}
		for fieldIndex := 0; fieldIndex < oneOfDescriptor.Fields().Len(); fieldIndex++ {
			fieldDescriptor := oneOfDescriptor.Fields().Get(fieldIndex)
			oneOfFields[fieldDescriptor] = oneOf
			oneOf.Fields = append(oneOf.Fields, &pdelta.Field{Name: string(fieldDescriptor.Name()), Number: int32(fieldDescriptor.Number()), MessageFullName: string(descriptor.FullName())})
		}
		ops = append(ops, opData{exists: exists, op: &pdelta.Op{
			Type:     pdelta.Op_Delete,
			Location: pdelta.CopyAndAppendOneof(location, oneOf.Name, oneOf.Fields...),
		}})
	}
	for i := 0; i < descriptor.Fields().Len(); i++ {
		childField := descriptor.Fields().Get(i)
		parent := location
		if oneOf, found := oneOfFields[childField]; found {
			parent = pdelta.CopyAndAppendOneof(location, oneOf.Name, oneOf.Fields...)
		}
		childLocation := pdelta.CopyAndAppendField(parent, string(descriptor.FullName()), string(childField.Name()), int32(childField.Number()))
		childSpec := SpecField{parent: spec.New().Message(), field: childField}
		var childExists bool
		var childValue protoreflect.Value
		if message != nil {
			childExists = message.Has(childField)
			childValue = message.Get(childField)
		}
		childSet := set
		if childExists {
			childSet++
		}
		ops = append(ops, gatherValidOperations(childLocation, childSet, childField, childValue, childSpec, childExists)...)
	}
	return ops
}
func randomProtoValue(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) protoreflect.Value {
	switch {
	case field.IsList():
		return protoreflect.ValueOfList(randomProtoList(location, set, field, spec))
	case field.IsMap():
		return protoreflect.ValueOfMap(randomProtoMap(location, set, field.MapKey(), field.MapValue(), spec))
	}
	return randomProtoValueIgnoreCollection(location, set, field, spec)
}

//func randomOpValue(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) interface{} {
//	switch {
//	case field.IsList():
//		return &pdelta.Op_Fragment{Fragment: randomDeltaList(location, set, field, spec)}
//	case field.IsMap():
//		return &pdelta.Op_Fragment{Fragment: randomDeltaMap(location, set, field.MapKey(), field.MapValue(), spec)}
//	}
//	return randomOpValueIgnoreCollection(location, set, field, spec)
//}

// TODO
//func randomFragmentValue(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) *pdelta.Fragment {
//	val := randomOpValueIgnoreCollection(location, set, field, spec)
//	switch val := val.(type) {
//	case *pdelta.Op_Message:
//		return &pdelta.Object{V: &pdelta.Object_Message{Message: val.Message}}
//	case *pdelta.Op_Scalar:
//		return &pdelta.Object{V: &pdelta.Object_Scalar{Scalar: val.Scalar}}
//	case *pdelta.Op_Object:
//		// Shouldn't get here because proto collections never contain collections, and randomFragmentValue is
//		// only used for the values of map / list collections.
//		return val.Object
//	}
//	panic(fmt.Sprintf("%T", val))
//}
func randomProtoList(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) protoreflect.List {
	list := spec.New().List()
	childSpec := SpecList{value: list}
	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
		list.Append(randomProtoValueIgnoreCollection(pdelta.CopyAndAppendIndex(location, int64(i)), set, field, childSpec))
	}
	return list
}

// TODO
func randomDeltaList(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) *pdelta.Fragment {
	value := randomProtoList(location, set, field, spec)
	fieldSpec := spec.(SpecField)
	message := fieldSpec.parent.New()
	message.Set(fieldSpec.field, protoreflect.ValueOfList(value))
	return &pdelta.Fragment{
		Field:   &pdelta.Field{Name: string(fieldSpec.field.Name()), Number: int32(fieldSpec.field.Number()), MessageFullName: string(message.Descriptor().FullName())},
		Message: pdelta.MustMarshalAny(message.Interface().(proto.Message)),
	}

	//var obs []*pdelta.Object
	//childSpec := SpecList{value: spec.New().List()}
	//for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
	//	obs = append(obs, randomObjectValue(pdelta.CopyAndAppendIndex(location, int64(i)), set, field, childSpec))
	//}
	//return &pdelta.Object{V: &pdelta.Object_List{List: &pdelta.List{List: obs}}}
}
func randomProtoMap(location []*pdelta.Locator, set int, keyField, valueField protoreflect.FieldDescriptor, spec Spec) protoreflect.Map {
	value := spec.New().Map()
	childSpec := SpecMap{value: value}
	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
		k := getRandomKey(keyField)
		protoKey := protoMapKey(k)
		deltaKey := deltaMapKey(k)
		val := randomProtoValueIgnoreCollection(pdelta.CopyAndAppend(location, pdelta.NewLocatorKey(deltaKey)), set, valueField, childSpec)
		value.Set(protoKey, val)
	}
	return value
}

// TODO
func randomDeltaMap(location []*pdelta.Locator, set int, keyField, valueField protoreflect.FieldDescriptor, spec Spec) *pdelta.Fragment {
	value := randomProtoMap(location, set, keyField, valueField, spec)
	fieldSpec := spec.(SpecField)
	message := fieldSpec.parent.New()
	message.Set(fieldSpec.field, protoreflect.ValueOfMap(value))
	return &pdelta.Fragment{
		Field:   &pdelta.Field{Name: string(fieldSpec.field.Name()), Number: int32(fieldSpec.field.Number()), MessageFullName: string(message.Descriptor().FullName())},
		Message: pdelta.MustMarshalAny(message.Interface().(proto.Message)),
	}

	//childSpec := SpecMap{value: spec.New().Map()}
	//switch keyField.Kind() {
	//case protoreflect.BoolKind:
	//	m := map[bool]*pdelta.Object{}
	//	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
	//		key := rand.Intn(1) == 0
	//		value := randomObjectValue(pdelta.CopyAndAppendKeyBool(location, key), set, valueField, childSpec)
	//		m[key] = value
	//	}
	//	return &pdelta.Object{V: &pdelta.Object_MapBool{MapBool: &pdelta.MapBool{Map: m}}}
	//case protoreflect.Int32Kind:
	//	m := map[int32]*pdelta.Object{}
	//	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
	//		key := int32(rand.Intn(2048) - 1024)
	//		value := randomObjectValue(pdelta.CopyAndAppendKeyInt32(location, key), set, valueField, childSpec)
	//		m[key] = value
	//	}
	//	return &pdelta.Object{V: &pdelta.Object_MapInt32{MapInt32: &pdelta.MapInt32{Map: m}}}
	//case protoreflect.Int64Kind:
	//	m := map[int64]*pdelta.Object{}
	//	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
	//		key := int64(rand.Intn(2048) - 1024)
	//		value := randomObjectValue(pdelta.CopyAndAppendKeyInt64(location, key), set, valueField, childSpec)
	//		m[key] = value
	//	}
	//	return &pdelta.Object{V: &pdelta.Object_MapInt64{MapInt64: &pdelta.MapInt64{Map: m}}}
	//case protoreflect.Uint32Kind:
	//	m := map[uint32]*pdelta.Object{}
	//	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
	//		key := uint32(rand.Intn(1024))
	//		value := randomObjectValue(pdelta.CopyAndAppendKeyUint32(location, key), set, valueField, childSpec)
	//		m[key] = value
	//	}
	//	return &pdelta.Object{V: &pdelta.Object_MapUint32{MapUint32: &pdelta.MapUint32{Map: m}}}
	//case protoreflect.Uint64Kind:
	//	m := map[uint64]*pdelta.Object{}
	//	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
	//		key := uint64(rand.Intn(1024))
	//		value := randomObjectValue(pdelta.CopyAndAppendKeyUint64(location, key), set, valueField, childSpec)
	//		m[key] = value
	//	}
	//	return &pdelta.Object{V: &pdelta.Object_MapUint64{MapUint64: &pdelta.MapUint64{Map: m}}}
	//case protoreflect.StringKind:
	//	m := map[string]*pdelta.Object{}
	//	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
	//		key := randomString()
	//		value := randomObjectValue(pdelta.CopyAndAppendKeyString(location, key), set, valueField, childSpec)
	//		m[key] = value
	//	}
	//	return &pdelta.Object{V: &pdelta.Object_MapString{MapString: &pdelta.MapString{Map: m}}}
	//}
	//panic("")
}
func randomEnum(field protoreflect.FieldDescriptor) protoreflect.EnumNumber {
	var values []protoreflect.EnumNumber
	for i := 0; i < field.Enum().Values().Len(); i++ {
		v := field.Enum().Values().Get(i)
		if v.Number() == 0 {
			continue
		}
		values = append(values, v.Number())
	}
	if len(values) == 0 {
		return 0
	}
	return values[rand.Intn(len(values))]
	//return field.Enum().Values().Get(rand.Intn(field.Enum().Values().Len())).Number()
}
func randomMessage(location []*pdelta.Locator, set int, spec Spec) protoreflect.Message {
	message := spec.New().Message()
	for i := 0; i < message.Descriptor().Fields().Len(); i++ {
		field := message.Descriptor().Fields().Get(i)
		fieldLocation := pdelta.CopyAndAppendField(location, string(message.Descriptor().FullName()), string(field.Name()), int32(field.Number()))
		if shouldIterate(fieldLocation, set) {
			fieldSpec := SpecField{parent: message, field: field}
			val := randomProtoValue(fieldLocation, set, field, fieldSpec)
			message.Set(field, val)
		}
	}
	return message
}
func randomOpValueIgnoreCollection(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) interface{} {
	switch field.Kind() {
	case protoreflect.EnumKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Enum{Enum: int32(randomEnum(field))}}}
	case protoreflect.MessageKind:
		return &pdelta.Op_Message{Message: pdelta.MustMarshalAny(randomMessage(location, set, spec).Interface())}
	case protoreflect.BoolKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Bool{Bool: rand.Intn(1) == 0}}}
	case protoreflect.Int32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Int32{Int32: int32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Sint32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sint32{Sint32: int32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Uint32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Uint32{Uint32: uint32(rand.Intn(1024))}}}
	case protoreflect.Int64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Int64{Int64: int64(rand.Intn(2048) - 1024)}}}
	case protoreflect.Sint64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sint64{Sint64: int64(rand.Intn(2048) - 1024)}}}
	case protoreflect.Uint64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Uint64{Uint64: uint64(rand.Intn(1024))}}}
	case protoreflect.Sfixed32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sfixed32{Sfixed32: int32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Fixed32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Fixed32{Fixed32: uint32(rand.Intn(1024))}}}
	case protoreflect.FloatKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Float{Float: float32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Sfixed64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sfixed64{Sfixed64: int64(rand.Intn(2048) - 1024)}}}
	case protoreflect.Fixed64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Fixed64{Fixed64: uint64(rand.Intn(1024))}}}
	case protoreflect.DoubleKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Double{Double: float64(rand.Intn(2048) - 1024)}}}
	case protoreflect.StringKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_String_{String_: randomString()}}}
	case protoreflect.BytesKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Bytes{Bytes: []byte(randomString())}}}
	case protoreflect.GroupKind:
		// what is this?
		panic("")
	}
	panic("")
}
func randomProtoValueIgnoreCollection(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) protoreflect.Value {
	switch field.Kind() {
	case protoreflect.EnumKind:
		return protoreflect.ValueOfEnum(randomEnum(field))
	case protoreflect.MessageKind:
		return protoreflect.ValueOfMessage(randomMessage(location, set, spec))
	case protoreflect.BoolKind:
		return protoreflect.ValueOfBool(rand.Intn(1) == 0)
	case protoreflect.Int32Kind:
		return protoreflect.ValueOfInt32(int32(rand.Intn(2048) - 1024))
	case protoreflect.Sint32Kind:
		return protoreflect.ValueOfInt32(int32(rand.Intn(2048) - 1024))
	case protoreflect.Uint32Kind:
		return protoreflect.ValueOfUint32(uint32(rand.Intn(1024)))
	case protoreflect.Int64Kind:
		return protoreflect.ValueOfInt64(int64(rand.Intn(2048) - 1024))
	case protoreflect.Sint64Kind:
		return protoreflect.ValueOfInt64(int64(rand.Intn(2048) - 1024))
	case protoreflect.Uint64Kind:
		return protoreflect.ValueOfUint64(uint64(rand.Intn(1024)))
	case protoreflect.Sfixed32Kind:
		return protoreflect.ValueOfInt32(int32(rand.Intn(2048) - 1024))
	case protoreflect.Fixed32Kind:
		return protoreflect.ValueOfUint32(uint32(rand.Intn(1024)))
	case protoreflect.FloatKind:
		return protoreflect.ValueOfFloat32(float32(rand.Intn(2048) - 1024))
	case protoreflect.Sfixed64Kind:
		return protoreflect.ValueOfInt64(int64(rand.Intn(2048) - 1024))
	case protoreflect.Fixed64Kind:
		return protoreflect.ValueOfUint64(uint64(rand.Intn(1024)))
	case protoreflect.DoubleKind:
		return protoreflect.ValueOfFloat64(float64(rand.Intn(2048) - 1024))
	case protoreflect.StringKind:
		return protoreflect.ValueOfString(randomString())
	case protoreflect.BytesKind:
		return protoreflect.ValueOfBytes([]byte(randomString()))
	case protoreflect.GroupKind:
		// what is this?
		panic("")
	}
	panic("")
}
func getRandomKey(field protoreflect.FieldDescriptor) interface{} {
	switch field.Kind() {
	case protoreflect.BoolKind:
		return rand.Intn(1) == 0
	case protoreflect.Int32Kind:
		return int32(rand.Intn(2048) - 1024)
	case protoreflect.Int64Kind:
		return int64(rand.Intn(2048) - 1024)
	case protoreflect.Uint32Kind:
		return uint32(rand.Intn(1024))
	case protoreflect.Uint64Kind:
		return uint64(rand.Intn(1024))
	case protoreflect.StringKind:
		return randomString()
	}
	panic("")
}
func protoMapKey(val interface{}) protoreflect.MapKey {
	switch val := val.(type) {
	case bool:
		return protoreflect.ValueOfBool(val).MapKey()
	case int32:
		return protoreflect.ValueOfInt32(val).MapKey()
	case int64:
		return protoreflect.ValueOfInt64(val).MapKey()
	case uint32:
		return protoreflect.ValueOfUint32(val).MapKey()
	case uint64:
		return protoreflect.ValueOfUint64(val).MapKey()
	case string:
		return protoreflect.ValueOfString(val).MapKey()
	}
	panic("")
}
func deltaMapKey(val interface{}) *pdelta.Key {
	switch val := val.(type) {
	case bool:
		return &pdelta.Key{V: &pdelta.Key_Bool{Bool: val}}
	case int32:
		return &pdelta.Key{V: &pdelta.Key_Int32{Int32: val}}
	case int64:
		return &pdelta.Key{V: &pdelta.Key_Int64{Int64: val}}
	case uint32:
		return &pdelta.Key{V: &pdelta.Key_Uint32{Uint32: val}}
	case uint64:
		return &pdelta.Key{V: &pdelta.Key_Uint64{Uint64: val}}
	case string:
		return &pdelta.Key{V: &pdelta.Key_String_{String_: val}}
	}
	panic("")
}

const alphanum = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

func randomString() string {
	b := make([]byte, 5)
	if _, err := rand.Read(b); err != nil {
		panic(err)
	}
	for i, byt := range b {
		b[i] = alphanum[int(byt)%len(alphanum)]
	}
	return string(b)
}

func init() {
	rand.Seed(time.Now().Unix())
}

func shouldIterate(location []*pdelta.Locator, set int) bool {
	unset := len(location) - set

	switch {
	case unset >= 4:
		return false
	case unset == 3:
		return rand.Float64() < 0.1
	case unset == 2:
		return rand.Float64() < 0.2
	case unset == 1:
		return rand.Float64() < 0.4
	case unset == 0:
		return rand.Float64() < 0.6
	}
	panic("")
}

const RANDOM_COLLECTION_MAX_ITEMS = 5

type opData struct {
	op     *pdelta.Op
	exists bool // does this field / index / key already exist in the object?
}

func (o opData) weight() float64 {
	var weight float64
	switch o.op.Type {
	case pdelta.Op_Set:
		if o.exists {
			weight = 1
		} else {
			weight = 5
		}
	case pdelta.Op_Edit:
		weight = 5
	case pdelta.Op_Insert:
		weight = 5
	case pdelta.Op_Move:
		weight = 10
	case pdelta.Op_Rename:
		weight = 10
	case pdelta.Op_Delete:
		weight = 1
	}
	return weight
}

type Spec interface {
	New() protoreflect.Value
}

type SpecField struct {
	parent protoreflect.Message
	field  protoreflect.FieldDescriptor
}

func (s SpecField) New() protoreflect.Value {
	return s.parent.NewField(s.field)
}

type SpecMessage struct {
	message protoreflect.Message
}

func (s SpecMessage) New() protoreflect.Value {
	return protoreflect.ValueOf(s.message.New())
}

type SpecList struct {
	value protoreflect.List
}

func (s SpecList) New() protoreflect.Value {
	return s.value.NewElement()
}

type SpecMap struct {
	value protoreflect.Map
}

func (s SpecMap) New() protoreflect.Value {
	return s.value.NewValue()
}
