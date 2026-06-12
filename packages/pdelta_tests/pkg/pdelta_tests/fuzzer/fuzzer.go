package fuzzer

import (
	"fmt"
	"math/rand"
	"os"
	"strconv"
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
				break
			}
		}
	}
	return out
}

// Adjacent returns two operations that are adjacent in the gather order. Adjacent operations frequently act on
// the same value or the same collection, so this produces many more conflicting pairs than two independent
// random picks.
func Adjacent(message proto.Message) []*pdelta.Op {
	ops := gatherValidOperationsMessage(nil, 0, message.ProtoReflect().Descriptor(), message.ProtoReflect(), SpecMessage{message: message.ProtoReflect()}, true)
	if len(ops) == 0 {
		panic("")
	}
	if len(ops) == 1 {
		return []*pdelta.Op{ops[0].op, ops[0].op}
	}
	i := rand.Intn(len(ops) - 1)
	return []*pdelta.Op{ops[i].op, ops[i+1].op}
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
//
//	func randomFragmentValue(location []*pdelta.Locator, set int, field protoreflect.FieldDescriptor, spec Spec) *pdelta.Fragment {
//		val := randomOpValueIgnoreCollection(location, set, field, spec)
//		switch val := val.(type) {
//		case *pdelta.Op_Message:
//			return &pdelta.Object{V: &pdelta.Object_Message{Message: val.Message}}
//		case *pdelta.Op_Scalar:
//			return &pdelta.Object{V: &pdelta.Object_Scalar{Scalar: val.Scalar}}
//		case *pdelta.Op_Object:
//			// Shouldn't get here because proto collections never contain collections, and randomFragmentValue is
//			// only used for the values of map / list collections.
//			return val.Object
//		}
//		panic(fmt.Sprintf("%T", val))
//	}
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
	//		key := rand.Intn(2) == 0
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
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Bool{Bool: rand.Intn(2) == 0}}}
	case protoreflect.Int32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Int32{Int32: randomInt32()}}}
	case protoreflect.Sint32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sint32{Sint32: randomInt32()}}}
	case protoreflect.Uint32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Uint32{Uint32: randomUint32()}}}
	case protoreflect.Int64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Int64{Int64: randomInt64()}}}
	case protoreflect.Sint64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sint64{Sint64: randomInt64()}}}
	case protoreflect.Uint64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Uint64{Uint64: randomUint64()}}}
	case protoreflect.Sfixed32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sfixed32{Sfixed32: randomInt32()}}}
	case protoreflect.Fixed32Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Fixed32{Fixed32: randomUint32()}}}
	case protoreflect.FloatKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Float{Float: randomFloat32()}}}
	case protoreflect.Sfixed64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Sfixed64{Sfixed64: randomInt64()}}}
	case protoreflect.Fixed64Kind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Fixed64{Fixed64: randomUint64()}}}
	case protoreflect.DoubleKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Double{Double: randomFloat64()}}}
	case protoreflect.StringKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_String_{String_: randomString()}}}
	case protoreflect.BytesKind:
		return &pdelta.Op_Scalar{Scalar: &pdelta.Scalar{V: &pdelta.Scalar_Bytes{Bytes: randomBytes()}}}
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
		return protoreflect.ValueOfBool(rand.Intn(2) == 0)
	case protoreflect.Int32Kind:
		return protoreflect.ValueOfInt32(randomInt32())
	case protoreflect.Sint32Kind:
		return protoreflect.ValueOfInt32(randomInt32())
	case protoreflect.Uint32Kind:
		return protoreflect.ValueOfUint32(randomUint32())
	case protoreflect.Int64Kind:
		return protoreflect.ValueOfInt64(randomInt64())
	case protoreflect.Sint64Kind:
		return protoreflect.ValueOfInt64(randomInt64())
	case protoreflect.Uint64Kind:
		return protoreflect.ValueOfUint64(randomUint64())
	case protoreflect.Sfixed32Kind:
		return protoreflect.ValueOfInt32(randomInt32())
	case protoreflect.Fixed32Kind:
		return protoreflect.ValueOfUint32(randomUint32())
	case protoreflect.FloatKind:
		return protoreflect.ValueOfFloat32(randomFloat32())
	case protoreflect.Sfixed64Kind:
		return protoreflect.ValueOfInt64(randomInt64())
	case protoreflect.Fixed64Kind:
		return protoreflect.ValueOfUint64(randomUint64())
	case protoreflect.DoubleKind:
		return protoreflect.ValueOfFloat64(randomFloat64())
	case protoreflect.StringKind:
		return protoreflect.ValueOfString(randomString())
	case protoreflect.BytesKind:
		return protoreflect.ValueOfBytes(randomBytes())
	case protoreflect.GroupKind:
		// what is this?
		panic("")
	}
	panic("")
}
func getRandomKey(field protoreflect.FieldDescriptor) interface{} {
	switch field.Kind() {
	case protoreflect.BoolKind:
		return rand.Intn(2) == 0
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

// edgeStrings are returned occasionally instead of a plain random string: empty strings, long strings, and
// multi-byte unicode (string indexes differ between UTF-8 runes, UTF-16 code units and bytes, so unicode is
// where cross language divergence would hide). Astral-plane characters (emoji) are included deliberately:
// quill deltas count positions in UTF-16 code units (the quill.js convention, which Dart follows natively and
// the Go side implements via utf16Expand / utf16Collapse), and emoji are where rune counting would diverge.
var edgeStrings = []string{
	"",
	"a",
	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",
	"héllo wörld",
	"日本語テキスト",
	"🚀🎉",
	"a🚀b",
	"e\u0301clair", // combining acute accent
}

func randomString() string {
	if rand.Intn(20) == 0 {
		return edgeStrings[rand.Intn(len(edgeStrings))]
	}
	b := make([]byte, 5)
	if _, err := rand.Read(b); err != nil {
		panic(err)
	}
	for i, byt := range b {
		b[i] = alphanum[int(byt)%len(alphanum)]
	}
	return string(b)
}

// randomBytes is never empty: the protobuf-dart runtime (still in 2.1) drops the oneof case when decoding an
// empty bytes value from JSON, so a scalar op with empty bytes arrives in Dart with no variant set.
func randomBytes() []byte {
	b := []byte(randomString())
	if len(b) == 0 {
		b = []byte{0}
	}
	return b
}

func randomInt32() int32 {
	if rand.Intn(20) == 0 {
		return []int32{0, 1, -1, 2147483647, -2147483648}[rand.Intn(5)]
	}
	return int32(rand.Intn(2048) - 1024)
}

func randomInt64() int64 {
	if rand.Intn(20) == 0 {
		return []int64{0, 1, -1, 9223372036854775807, -9223372036854775808}[rand.Intn(5)]
	}
	return int64(rand.Intn(2048) - 1024)
}

func randomUint32() uint32 {
	if rand.Intn(20) == 0 {
		return []uint32{0, 1, 2147483647, 4294967295}[rand.Intn(4)]
	}
	return uint32(rand.Intn(1024))
}

func randomUint64() uint64 {
	if rand.Intn(20) == 0 {
		return []uint64{0, 1, 18446744073709551615}[rand.Intn(3)]
	}
	return uint64(rand.Intn(1024))
}

func randomFloat32() float32 {
	if rand.Intn(4) == 0 {
		// Fractional values restricted to multiples of 1/4. The Go runtime truncates float fields to float32
		// and protojson prints the shortest decimal that round trips as float32, but the Dart runtime (still
		// in protobuf 2.1) stores the parsed double unrounded - so any value whose shortest float32 decimal
		// is not its exact expansion diverges between the binary (Any packed) and JSON paths in Dart.
		// Quarters print exactly.
		return float32(rand.Intn(2048*4))/4 - 1024
	}
	return float32(rand.Intn(2048) - 1024)
}

func randomFloat64() float64 {
	if rand.Intn(4) == 0 {
		return rand.Float64()*2048 - 1024
	}
	return float64(rand.Intn(2048) - 1024)
}

func init() {
	var seed int64
	if env := os.Getenv("FUZZ_SEED"); env != "" {
		var err error
		seed, err = strconv.ParseInt(env, 10, 64)
		if err != nil {
			panic("invalid FUZZ_SEED: " + env)
		}
	} else {
		seed = time.Now().UnixNano()
	}
	fmt.Printf("fuzzer seed: %d (set FUZZ_SEED=%d to reproduce)\n", seed, seed)
	rand.Seed(seed)
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

// GetRelated creates a random op that is valid to apply to message, biased heavily towards ops that conflict
// with prev: ops acting on the same value, the same collection, prev's destination, or on paths through them.
// Two independently random ops rarely collide in a large tree, so the conflicting branches of transform and
// reduce are starved of coverage without this.
func GetRelated(message proto.Message, prev *pdelta.Op) *pdelta.Op {
	if prev == nil || pdelta.IsNull(prev) || prev.Type == pdelta.Op_Compound {
		return Get(message)
	}
	all := gatherValidOperationsMessage(nil, 0, message.ProtoReflect().Descriptor(), message.ProtoReflect(), SpecMessage{message: message.ProtoReflect()}, true)
	if len(all) == 0 {
		panic("")
	}

	var related []opData
	var deep []opData
	for _, od := range all {
		if !isRelated(od.op, prev) {
			continue
		}
		related = append(related, od)
		// ops whose location passes through an element of prev's collection exercise the index shifting of
		// nested locations, and are very rare because deep locations are heavily pruned during gather - so they
		// are collected separately and picked with a boosted probability below
		if len(prev.Location) > 0 && len(od.op.Location) > len(prev.Location) &&
			pdelta.TreeRelationship(prev.Parent(), od.op.Location) == pdelta.TREE_ANCESTOR {
			deep = append(deep, od)
		}
	}
	if len(deep) > 0 && rand.Intn(4) == 0 {
		return deep[rand.Intn(len(deep))].op
	}

	// Synthesize exact collision variants: candidates in the same collection as prev, with their indexes or keys
	// overridden to prev's item / destination (and neighbouring indexes). These are the pairings that exercise
	// the conflicting branches, and they almost never occur with independent random indexes.
	var synthesized []*pdelta.Op
	for attempts := 0; attempts < 8 && len(related) > 0; attempts++ {
		candidate := related[rand.Intn(len(related))].op
		synth := synthesizeCollision(message, candidate, prev)
		if synth == nil {
			continue
		}
		// validate by applying to a throwaway clone
		if err := pdelta.Apply(synth, proto.Clone(message)); err != nil {
			continue
		}
		synthesized = append(synthesized, synth)
	}

	// weighted pick: synthesized collisions are the most valuable
	total := float64(len(synthesized))*4 + float64(len(related))
	if total == 0 {
		return Get(message)
	}
	target := rand.Float64() * total
	if target < float64(len(synthesized))*4 {
		return synthesized[int(target/4)]
	}
	return related[int(target-float64(len(synthesized))*4)].op
}

func isRelated(op, prev *pdelta.Op) bool {
	rel := func(a, b []*pdelta.Locator) bool {
		switch pdelta.TreeRelationship(a, b) {
		case pdelta.TREE_EQUAL, pdelta.TREE_ANCESTOR, pdelta.TREE_DESCENDENT:
			return true
		}
		return false
	}
	if rel(op.Location, prev.Location) {
		return true
	}
	opB := pdelta.GetBehaviour(op)
	prevB := pdelta.GetBehaviour(prev)
	if prevB.ValueIsLocation && rel(op.Location, prev.To()) {
		return true
	}
	if opB.ValueIsLocation && rel(op.To(), prev.Location) {
		return true
	}
	if opB.ValueIsLocation && prevB.ValueIsLocation && rel(op.To(), prev.To()) {
		return true
	}
	if len(op.Location) > 0 && len(prev.Location) > 0 &&
		pdelta.TreeRelationship(op.Parent(), prev.Parent()) == pdelta.TREE_EQUAL {
		return true
	}
	return false
}

// synthesizeCollision clones candidate and overrides its item index / key (and for moves and renames,
// sometimes its destination) to collide with prev's item or destination. Returns nil if the candidate or prev
// don't have compatible locator types in the same collection, or if the resulting index would be out of range
// (apply does not validate list bounds, so out of range indexes produce malformed operations).
func synthesizeCollision(message proto.Message, candidate, prev *pdelta.Op) *pdelta.Op {
	if len(candidate.Location) == 0 || len(prev.Location) == 0 {
		return nil
	}
	if pdelta.TreeRelationship(candidate.Parent(), prev.Parent()) != pdelta.TREE_EQUAL {
		return nil
	}
	candidateItem := candidate.Item()
	prevItem := prev.Item()
	out := proto.Clone(candidate).(*pdelta.Op)

	if _, ok := candidateItem.V.(*pdelta.Locator_Index); ok {
		if _, ok := prevItem.V.(*pdelta.Locator_Index); !ok {
			return nil
		}
		listLen, ok := listLenAt(message, candidate.Parent())
		if !ok {
			return nil
		}
		choices := []int64{prev.ItemIndex(), prev.ItemIndex() + 1, prev.ItemIndex() - 1}
		if pdelta.GetBehaviour(prev).ValueIsLocation {
			choices = append(choices, prev.ToIndex(), prev.ToIndex()+1, prev.ToIndex()-1)
		}
		index := choices[rand.Intn(len(choices))]
		toGap := false
		if rand.Intn(2) == 1 && pdelta.GetBehaviour(candidate).ValueIsLocation {
			toGap = true
		}
		// gap indexes (insert location, move destination) may equal the list length; item indexes must be
		// strictly inside the list
		max := int64(listLen) - 1
		if toGap || candidate.Type == pdelta.Op_Insert {
			max = int64(listLen)
		}
		if index < 0 || index > max {
			return nil
		}
		if toGap {
			out.SetToIndex(index)
		} else {
			out.SetItemIndex(index)
		}
		return out
	}

	if _, ok := candidateItem.V.(*pdelta.Locator_Key); ok {
		if _, ok := prevItem.V.(*pdelta.Locator_Key); !ok {
			return nil
		}
		choices := []*pdelta.Key{prevItem.GetKey()}
		if prev.Type == pdelta.Op_Rename {
			choices = append(choices, prev.Value.(*pdelta.Op_Key).Key)
		}
		key := proto.Clone(choices[rand.Intn(len(choices))]).(*pdelta.Key)
		if rand.Intn(2) == 0 || candidate.Type != pdelta.Op_Rename {
			out.Location[len(out.Location)-1] = &pdelta.Locator{V: &pdelta.Locator_Key{Key: key}}
		} else {
			out.Value = &pdelta.Op_Key{Key: key}
		}
		return out
	}

	return nil
}

// Related reports whether two ops act on related locations (same value, same collection, either one's
// destination, or paths through them). Used by the corpus writers to preferentially keep conflicting pairs.
func Related(op1, op2 *pdelta.Op) bool {
	if op1 == nil || op2 == nil || pdelta.IsNull(op1) || pdelta.IsNull(op2) {
		return false
	}
	if op1.Type == pdelta.Op_Compound || op2.Type == pdelta.Op_Compound {
		return false
	}
	return isRelated(op2, op1)
}

// listLenAt resolves the list at the given location in message and returns its length. Returns false if the
// location doesn't resolve to a list.
func listLenAt(m proto.Message, location []*pdelta.Locator) (int, bool) {
	var cur interface{} = m.ProtoReflect()
	for _, loc := range location {
		switch v := loc.V.(type) {
		case *pdelta.Locator_Oneof:
			// oneof locators are markers: the following field locator does the navigation
			continue
		case *pdelta.Locator_Field:
			msg, ok := cur.(protoreflect.Message)
			if !ok {
				return 0, false
			}
			fd := msg.Descriptor().Fields().ByNumber(protoreflect.FieldNumber(v.Field.Number))
			if fd == nil {
				return 0, false
			}
			val := msg.Get(fd)
			switch {
			case fd.IsList():
				cur = val.List()
			case fd.IsMap():
				cur = val.Map()
			case fd.Kind() == protoreflect.MessageKind:
				cur = val.Message()
			default:
				return 0, false
			}
		case *pdelta.Locator_Index:
			list, ok := cur.(protoreflect.List)
			if !ok || int(v.Index) >= list.Len() {
				return 0, false
			}
			msg, ok := list.Get(int(v.Index)).Interface().(protoreflect.Message)
			if !ok {
				return 0, false
			}
			cur = msg
		case *pdelta.Locator_Key:
			mp, ok := cur.(protoreflect.Map)
			if !ok {
				return 0, false
			}
			val := mp.Get(protoMapKey(keyInterface(v.Key)))
			if !val.IsValid() {
				return 0, false
			}
			msg, ok := val.Interface().(protoreflect.Message)
			if !ok {
				return 0, false
			}
			cur = msg
		}
	}
	list, ok := cur.(protoreflect.List)
	if !ok {
		return 0, false
	}
	return list.Len(), true
}

func keyInterface(key *pdelta.Key) interface{} {
	switch v := key.V.(type) {
	case *pdelta.Key_Bool:
		return v.Bool
	case *pdelta.Key_Int32:
		return v.Int32
	case *pdelta.Key_Int64:
		return v.Int64
	case *pdelta.Key_Uint32:
		return v.Uint32
	case *pdelta.Key_Uint64:
		return v.Uint64
	case *pdelta.Key_String_:
		return v.String_
	}
	panic("")
}
