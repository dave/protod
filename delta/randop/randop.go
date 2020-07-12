package randop

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/dave/protod/delta"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
)

// Get creates a random op that is valid to apply to message, for testing and benchmarking.
func Get(message proto.Message) *delta.Op {
	factory := func() protoreflect.Value {
		return protoreflect.ValueOfMessage(message.ProtoReflect().New())
	}
	ops := gatherValidOperationsMessage(nil, 0, message.ProtoReflect().Descriptor(), message.ProtoReflect(), factory, true)
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

func List(message proto.Message, length int) []*delta.Op {
	factory := func() protoreflect.Value {
		return protoreflect.ValueOfMessage(message.ProtoReflect().New())
	}
	ops := gatherValidOperationsMessage(nil, 0, message.ProtoReflect().Descriptor(), message.ProtoReflect(), factory, true)
	if len(ops) == 0 {
		panic("")
	}
	var total float64
	for _, op := range ops {
		total += op.weight()
	}
	var out []*delta.Op
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

func gatherValidOperations(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, value protoreflect.Value, factory func() protoreflect.Value, exists bool) []opData {
	if !shouldIterate(location, set) {
		return []opData{}
	}
	switch {
	case field.IsList():
		if value.IsValid() {
			return gatherValidOperationsList(location, set, field, value.List(), factory, exists)
		}
		return gatherValidOperationsList(location, set, field, nil, factory, exists)
	case field.IsMap():
		if value.IsValid() {
			return gatherValidOperationsMap(location, set, field, value.Map(), factory, exists)
		}
		return gatherValidOperationsMap(location, set, field, nil, factory, exists)
	}
	return gatherValidOperationsIgnoreCollections(location, set, field, value, factory, exists)
}
func gatherValidOperationsIgnoreCollections(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, value protoreflect.Value, factory func() protoreflect.Value, exists bool) []opData {
	switch field.Kind() {
	case protoreflect.EnumKind:
		return gatherValidOperationsEnum(location, set, field, exists)
	case protoreflect.MessageKind:
		if value.IsValid() {
			return gatherValidOperationsMessage(location, set, field.Message(), value.Message(), factory, exists)
		}
		return gatherValidOperationsMessage(location, set, field.Message(), nil, factory, exists)
	case protoreflect.GroupKind:
		// what is this?
		panic("")
	default:
		return gatherValidOperationsScalar(location, set, field, value.Interface(), exists)
	}
}
func gatherValidOperationsEnum(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, exists bool) []opData {
	// set
	// delete
	var ops []opData
	if exists {
		ops = append(ops, opData{exists: exists, op: &delta.Op{Type: delta.Op_Delete, Location: location}})
	}
	ops = append(ops, opData{exists: exists, op: &delta.Op{Type: delta.Op_Set, Location: location, Value: &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Enum{Enum: int32(randomEnum(field))}}}}})
	return ops
}
func gatherValidOperationsScalar(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, value interface{}, exists bool) []opData {
	// set
	// delete
	var ops []opData
	if exists {
		ops = append(ops, opData{exists: exists, op: &delta.Op{Type: delta.Op_Delete, Location: location}})
	}
	ops = append(ops, opData{exists: exists, op: &delta.Op{Type: delta.Op_Set, Location: location, Value: randomOpValueIgnoreCollection(location, set, field, nil).(*delta.Op_Scalar)}})
	if field.Kind() == protoreflect.StringKind {
		var val string
		if exists {
			val = value.(string)
		}
		ops = append(ops, opData{exists: exists, op: delta.Edit(location, val, randomString())})
	}
	return ops
}
func gatherValidOperationsList(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, list protoreflect.List, factory func() protoreflect.Value, exists bool) []opData {
	var ops []opData

	// DONE delete
	if exists {
		ops = append(ops, opData{exists: exists, op: &delta.Op{
			Type:     delta.Op_Delete,
			Location: location,
		}})
	}

	// DONE set
	ops = append(ops, opData{exists: exists, op: &delta.Op{
		Type:     delta.Op_Set,
		Location: location,
		Value:    &delta.Op_Object{Object: randomDeltaList(location, set, field, factory)},
	}})

	// DONE move
	if list != nil && list.Len() > 0 {
		for i := 0; i < list.Len(); i++ { // repeat this n times where n=list length
			randomSourceIndex := rand.Intn(list.Len())
			randomDestinationIndex := rand.Intn(list.Len() + 1)
			ops = append(ops, opData{exists: exists, op: &delta.Op{
				Type:     delta.Op_Move,
				Location: delta.CopyAndAppendIndex(location, int64(randomSourceIndex)),
				Value:    &delta.Op_Index{Index: int64(randomDestinationIndex)},
			}})
		}
	}

	childFactory := func() protoreflect.Value { return factory().List().NewElement() }

	// DONE insert
	var randomDestinationIndex int
	if list != nil {
		randomDestinationIndex = rand.Intn(list.Len() + 1)
	}
	insertLocation := delta.CopyAndAppendIndex(location, int64(randomDestinationIndex))
	insertValue := randomOpValueIgnoreCollection(insertLocation, set, field, childFactory) // don't increment set because this value does not exist
	ops = append(ops, opData{exists: exists, op: &delta.Op{
		Type:     delta.Op_Insert,
		Location: insertLocation,
		Value:    delta.ToOpValue(insertValue),
	}})

	// DONE gather ops for children ->
	if list != nil {
		for i := 0; i < list.Len(); i++ {
			ops = append(ops, gatherValidOperationsIgnoreCollections(delta.CopyAndAppendIndex(location, int64(i)), set+1, field, list.Get(i), childFactory, true)...)
		}
	}

	return ops
}
func gatherValidOperationsMap(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, m protoreflect.Map, factory func() protoreflect.Value, exists bool) []opData {
	var ops []opData
	// DONE delete
	if exists {
		ops = append(ops, opData{exists: exists, op: &delta.Op{
			Type:     delta.Op_Delete,
			Location: location,
		}})
	}

	// DONE set
	ops = append(ops, opData{exists: exists, op: &delta.Op{
		Type:     delta.Op_Set,
		Location: location,
		Value:    &delta.Op_Object{Object: randomDeltaMap(location, set, field.MapKey(), field.MapValue(), factory)},
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
			ops = append(ops, opData{exists: exists, op: &delta.Op{
				Type:     delta.Op_Rename,
				Location: delta.CopyAndAppend(location, newLocatorKey(existingKey1)),
				Value:    &delta.Op_Key{Key: existingKey2},
			}})
		}

		// rename to new key
		existingKey := deltaMapKey(keys[rand.Intn(len(keys))].Interface())
		newKey := deltaMapKey(getRandomKey(field.MapKey()))
		ops = append(ops, opData{exists: exists, op: &delta.Op{
			Type:     delta.Op_Rename,
			Location: delta.CopyAndAppend(location, newLocatorKey(existingKey)),
			Value:    &delta.Op_Key{Key: newKey},
		}})
	}

	// gather ops for existing children ->
	for _, key := range keys {
		ops = append(ops, gatherValidOperationsIgnoreCollections(delta.CopyAndAppend(location, newLocatorKey(deltaMapKey(key.Interface()))), set+1, field.MapValue(), m.Get(key), m.NewValue, true)...)
	}

	// DONE gather ops for new child ->
	newKey := deltaMapKey(getRandomKey(field.MapKey()))
	ops = append(ops, gatherValidOperationsIgnoreCollections(delta.CopyAndAppend(location, newLocatorKey(newKey)), set, field.MapValue(), protoreflect.Value{}, factory().Map().NewValue, false)...)

	return ops
}
func newLocatorKey(key *delta.Key) *delta.Locator {
	return &delta.Locator{V: &delta.Locator_Key{Key: key}}
}
func gatherValidOperationsMessage(location []*delta.Locator, set int, descriptor protoreflect.MessageDescriptor, message protoreflect.Message, factory func() protoreflect.Value, exists bool) []opData {
	var ops []opData
	if exists {
		ops = append(ops, opData{exists: exists, op: &delta.Op{
			Type:     delta.Op_Delete,
			Location: location,
		}})
	}
	ops = append(ops, opData{exists: exists, op: &delta.Op{
		Type:     delta.Op_Set,
		Location: location,
		Value:    &delta.Op_Message{Message: delta.MustMarshalAny(randomMessage(location, set, factory).Interface())},
	}})
	for i := 0; i < descriptor.Fields().Len(); i++ {
		childField := descriptor.Fields().Get(i)
		childLocation := delta.CopyAndAppendField(location, string(childField.Name()), int32(childField.Number()))
		childFactory := func() protoreflect.Value { return factory().Message().NewField(childField) }
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
		ops = append(ops, gatherValidOperations(childLocation, childSet, childField, childValue, childFactory, childExists)...)
	}
	return ops
}
func randomProtoValue(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, factory func() protoreflect.Value) protoreflect.Value {
	switch {
	case field.IsList():
		return protoreflect.ValueOfList(randomProtoList(location, set, field, factory))
	case field.IsMap():
		return protoreflect.ValueOfMap(randomProtoMap(location, set, field.MapKey(), field.MapValue(), factory))
	}
	return randomProtoValueIgnoreCollection(location, set, field, factory)
}
func randomOpValue(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, factory func() protoreflect.Value) interface{} {
	switch {
	case field.IsList():
		return &delta.Op_Object{Object: randomDeltaList(location, set, field, factory)}
	case field.IsMap():
		return &delta.Op_Object{Object: randomDeltaMap(location, set, field.MapKey(), field.MapValue(), factory)}
	}
	return randomOpValueIgnoreCollection(location, set, field, factory)
}
func randomObjectValue(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, factory func() protoreflect.Value) *delta.Object {
	val := randomOpValueIgnoreCollection(location, set, field, factory)
	switch val := val.(type) {
	case *delta.Op_Message:
		return &delta.Object{V: &delta.Object_Message{Message: val.Message}}
	case *delta.Op_Scalar:
		return &delta.Object{V: &delta.Object_Scalar{Scalar: val.Scalar}}
	case *delta.Op_Object:
		// Shouldn't get here because proto collections never contain collections, and randomObjectValue is
		// only used for the values of map / list collections.
		return val.Object
	}
	panic(fmt.Sprintf("%T", val))
}
func randomProtoList(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, factory func() protoreflect.Value) protoreflect.List {
	list := factory().List()
	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
		list.Append(randomProtoValueIgnoreCollection(delta.CopyAndAppendIndex(location, int64(i)), set, field, list.NewElement))
	}
	return list
}

func randomDeltaList(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, factory func() protoreflect.Value) *delta.Object {
	var obs []*delta.Object
	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
		obs = append(obs, randomObjectValue(delta.CopyAndAppendIndex(location, int64(i)), set, field, factory().List().NewElement))
	}
	return &delta.Object{V: &delta.Object_List{List: &delta.List{List: obs}}}
}
func randomProtoMap(location []*delta.Locator, set int, keyField, valueField protoreflect.FieldDescriptor, factory func() protoreflect.Value) protoreflect.Map {
	m := factory().Map()
	for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
		k := getRandomKey(keyField)
		protoKey := protoMapKey(k)
		deltaKey := deltaMapKey(k)
		val := randomProtoValueIgnoreCollection(delta.CopyAndAppend(location, delta.NewLocatorKey(deltaKey)), set, valueField, m.NewValue)
		m.Set(protoKey, val)
	}
	return m
}
func randomDeltaMap(location []*delta.Locator, set int, keyField, valueField protoreflect.FieldDescriptor, factory func() protoreflect.Value) *delta.Object {
	switch keyField.Kind() {
	case protoreflect.BoolKind:
		m := map[bool]*delta.Object{}
		for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
			key := rand.Intn(1) == 0
			value := randomObjectValue(delta.CopyAndAppendKeyBool(location, key), set, valueField, factory().Map().NewValue)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapBool{MapBool: &delta.MapBool{Map: m}}}
	case protoreflect.Int32Kind:
		m := map[int32]*delta.Object{}
		for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
			key := int32(rand.Intn(2048) - 1024)
			value := randomObjectValue(delta.CopyAndAppendKeyInt32(location, key), set, valueField, factory().Map().NewValue)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapInt32{MapInt32: &delta.MapInt32{Map: m}}}
	case protoreflect.Int64Kind:
		m := map[int64]*delta.Object{}
		for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
			key := int64(rand.Intn(2048) - 1024)
			value := randomObjectValue(delta.CopyAndAppendKeyInt64(location, key), set, valueField, factory().Map().NewValue)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapInt64{MapInt64: &delta.MapInt64{Map: m}}}
	case protoreflect.Uint32Kind:
		m := map[uint32]*delta.Object{}
		for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
			key := uint32(rand.Intn(1024))
			value := randomObjectValue(delta.CopyAndAppendKeyUint32(location, key), set, valueField, factory().Map().NewValue)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapUint32{MapUint32: &delta.MapUint32{Map: m}}}
	case protoreflect.Uint64Kind:
		m := map[uint64]*delta.Object{}
		for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
			key := uint64(rand.Intn(1024))
			value := randomObjectValue(delta.CopyAndAppendKeyUint64(location, key), set, valueField, factory().Map().NewValue)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapUint64{MapUint64: &delta.MapUint64{Map: m}}}
	case protoreflect.StringKind:
		m := map[string]*delta.Object{}
		for i := 0; i < rand.Intn(RANDOM_COLLECTION_MAX_ITEMS); i++ {
			key := randomString()
			value := randomObjectValue(delta.CopyAndAppendKeyString(location, key), set, valueField, factory().Map().NewValue)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapString{MapString: &delta.MapString{Map: m}}}
	}
	panic("")
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
func randomMessage(location []*delta.Locator, set int, factory func() protoreflect.Value) protoreflect.Message {
	message := factory().Message()
	for i := 0; i < message.Descriptor().Fields().Len(); i++ {
		field := message.Descriptor().Fields().Get(i)
		fieldLocation := delta.CopyAndAppendField(location, string(field.Name()), int32(field.Number()))
		if shouldIterate(fieldLocation, set) {
			factory := func() protoreflect.Value { return message.NewField(field) }
			val := randomProtoValue(fieldLocation, set, field, factory)
			message.Set(field, val)
		}
	}
	return message
}
func randomOpValueIgnoreCollection(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, factory func() protoreflect.Value) interface{} {
	switch field.Kind() {
	case protoreflect.EnumKind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Enum{Enum: int32(randomEnum(field))}}}
	case protoreflect.MessageKind:
		return &delta.Op_Message{Message: delta.MustMarshalAny(randomMessage(location, set, factory).Interface())}
	case protoreflect.BoolKind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Bool{Bool: rand.Intn(1) == 0}}}
	case protoreflect.Int32Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Int32{Int32: int32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Sint32Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sint32{Sint32: int32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Uint32Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Uint32{Uint32: uint32(rand.Intn(1024))}}}
	case protoreflect.Int64Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Int64{Int64: int64(rand.Intn(2048) - 1024)}}}
	case protoreflect.Sint64Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sint64{Sint64: int64(rand.Intn(2048) - 1024)}}}
	case protoreflect.Uint64Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Uint64{Uint64: uint64(rand.Intn(1024))}}}
	case protoreflect.Sfixed32Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sfixed32{Sfixed32: int32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Fixed32Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Fixed32{Fixed32: uint32(rand.Intn(1024))}}}
	case protoreflect.FloatKind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Float{Float: float32(rand.Intn(2048) - 1024)}}}
	case protoreflect.Sfixed64Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sfixed64{Sfixed64: int64(rand.Intn(2048) - 1024)}}}
	case protoreflect.Fixed64Kind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Fixed64{Fixed64: uint64(rand.Intn(1024))}}}
	case protoreflect.DoubleKind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Double{Double: float64(rand.Intn(2048) - 1024)}}}
	case protoreflect.StringKind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_String_{String_: randomString()}}}
	case protoreflect.BytesKind:
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Bytes{Bytes: []byte(randomString())}}}
	case protoreflect.GroupKind:
		// what is this?
		panic("")
	}
	panic("")
}
func randomProtoValueIgnoreCollection(location []*delta.Locator, set int, field protoreflect.FieldDescriptor, factory func() protoreflect.Value) protoreflect.Value {
	switch field.Kind() {
	case protoreflect.EnumKind:
		return protoreflect.ValueOfEnum(randomEnum(field))
	case protoreflect.MessageKind:
		return protoreflect.ValueOfMessage(randomMessage(location, set, factory))
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
func deltaMapKey(val interface{}) *delta.Key {
	switch val := val.(type) {
	case bool:
		return &delta.Key{V: &delta.Key_Bool{Bool: val}}
	case int32:
		return &delta.Key{V: &delta.Key_Int32{Int32: val}}
	case int64:
		return &delta.Key{V: &delta.Key_Int64{Int64: val}}
	case uint32:
		return &delta.Key{V: &delta.Key_Uint32{Uint32: val}}
	case uint64:
		return &delta.Key{V: &delta.Key_Uint64{Uint64: val}}
	case string:
		return &delta.Key{V: &delta.Key_String_{String_: val}}
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

func shouldIterate(location []*delta.Locator, set int) bool {
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
	op     *delta.Op
	exists bool // does this field / index / key already exist in the object?
}

func (o opData) weight() float64 {
	var weight float64
	switch o.op.Type {
	case delta.Op_Set:
		if o.exists {
			weight = 1
		} else {
			weight = 5
		}
	case delta.Op_Edit:
		weight = 5
	case delta.Op_Insert:
		weight = 5
	case delta.Op_Move:
		weight = 10
	case delta.Op_Rename:
		weight = 10
	case delta.Op_Delete:
		weight = 1
	}
	return weight
}
