package tests

/*
// Random creates a random op that is valid to apply to message, for testing and benchmarking.
func Random(message proto.Message) *delta.Op {
	ops := gatherValidOperationsMessage(nil, message.ProtoReflect())
}

func gatherValidOperations(location []*delta.Locator, field protoreflect.FieldDescriptor, value protoreflect.Value) []*delta.Op {
	if field == nil {
		return gatherValidOperationsMessage(location, value.Message())
	}
	switch {
	case field.IsList():
		return gatherValidOperationsList(location, field, value.List())
	case field.IsMap():
		return gatherValidOperationsMap(location, field, value.Map())
	}
}
func gatherValidOperationsList(location []*delta.Locator, field protoreflect.FieldDescriptor, list protoreflect.List) []*delta.Op {
	// move
	// delete list
	// delete index
	// insert
	// gather ops for children ->
	return nil
}
func gatherValidOperationsMap(location []*delta.Locator, field protoreflect.FieldDescriptor, m protoreflect.Map) []*delta.Op {
	// rename to new key
	// rename to existing key
	// delete map
	// delete key
	// gather ops for existing children ->
	// gather ops for new children ->
	return nil
}
func gatherValidOperationsMessage(location []*delta.Locator, message protoreflect.Message) []*delta.Op {
	var ops []*delta.Op
	for i := 0; i < message.Descriptor().Fields().Len(); i++ {
		field := message.Descriptor().Fields().Get(i)
		// set operation is always valid
		if shouldSet(location, message.Has(field)) {
			ops = append(ops, &delta.Op{
				Type:     delta.Op_Set,
				Location: delta.CopyAndAppendField(location, string(field.Name()), int32(field.Number())),
				Value:    delta.ToOpValue(randomValue(field, func() protoreflect.Value { return message.NewField(field) })),
			})
		}
		if message.Has(field) {
			// delete operation is valid if field exists
			if shouldDelete(location) {
				ops = append(ops, &delta.Op{
					Type:     delta.Op_Delete,
					Location: delta.CopyAndAppendField(location, string(field.Name()), int32(field.Number())),
				})
			}
		}
	}
	return ops
}

func randomValue(field protoreflect.FieldDescriptor, valueFactory func() protoreflect.Value) (interface{}, protoreflect.Value) {
	switch {
	case field.IsList():
		return &delta.Op_Object{Object: randomList(field, valueFactory)}
	case field.IsMap():
		return &delta.Op_Object{Object: randomMap(field.MapKey(), field.MapValue(), valueFactory)}
	}
	return randomValueIgnoreCollection(field, valueFactory)
}
func randomObjectValue(field protoreflect.FieldDescriptor, valueFactory func() protoreflect.Value) *delta.Object {
	val := randomValueIgnoreCollection(field, valueFactory)
	switch val := val.(type) {
	case *delta.Op_Message:
		return &delta.Object{V: &delta.Object_Message{Message: val.Message}}
	case *delta.Op_Scalar:
		return &delta.Object{V: &delta.Object_Scalar{Scalar: val.Scalar}}
	}
	panic("")
}

func randomList(valueField protoreflect.FieldDescriptor, valueFactory func() protoreflect.Value) *delta.Object {
	var obs []*delta.Object
	for i := 0; i < rand.Intn(5); i++ {
		obs = append(obs, randomObjectValue(valueField, valueFactory))
	}
	return &delta.Object{V: &delta.Object_List{List: &delta.List{List: obs}}}
}
func randomMap(keyField, valueField protoreflect.FieldDescriptor, valueFactory func() protoreflect.Value) *delta.Object {
	switch keyField.Kind() {
	case protoreflect.BoolKind:
		m := map[bool]*delta.Object{}
		for i := 0; i < rand.Intn(5); i++ {
			key := rand.Intn(1) == 0
			value := randomObjectValue(valueField, valueFactory)
			m[key] = value
		}
		val := valueFactory().Map()
		for i := 0; i < rand.Intn(5); i++ {
			key := rand.Intn(1) == 0
			value := randomObjectValue(valueField, valueFactory)
			val.Set()
		}
		return &delta.Object{V: &delta.Object_MapBool{MapBool: &delta.MapBool{Map: m}}}
	case protoreflect.Int32Kind:
		m := map[int32]*delta.Object{}
		for i := 0; i < rand.Intn(5); i++ {
			key := int32(rand.Intn(2048) - 1024)
			value := randomObjectValue(valueField, valueFactory)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapInt32{MapInt32: &delta.MapInt32{Map: m}}}
	case protoreflect.Int64Kind:
		m := map[int64]*delta.Object{}
		for i := 0; i < rand.Intn(5); i++ {
			key := int64(rand.Intn(2048) - 1024)
			value := randomObjectValue(valueField, valueFactory)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapInt64{MapInt64: &delta.MapInt64{Map: m}}}
	case protoreflect.Uint32Kind:
		m := map[uint32]*delta.Object{}
		for i := 0; i < rand.Intn(5); i++ {
			key := uint32(rand.Intn(1024))
			value := randomObjectValue(valueField, valueFactory)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapUint32{MapUint32: &delta.MapUint32{Map: m}}}
	case protoreflect.Uint64Kind:
		m := map[uint64]*delta.Object{}
		for i := 0; i < rand.Intn(5); i++ {
			key := uint64(rand.Intn(1024))
			value := randomObjectValue(valueField, valueFactory)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapUint64{MapUint64: &delta.MapUint64{Map: m}}}
	case protoreflect.StringKind:
		m := map[string]*delta.Object{}
		for i := 0; i < rand.Intn(5); i++ {
			key := randomString()
			value := randomObjectValue(valueField, valueFactory)
			m[key] = value
		}
		return &delta.Object{V: &delta.Object_MapString{MapString: &delta.MapString{Map: m}}}
	}
	panic("")
}
func randomValueIgnoreCollection(field protoreflect.FieldDescriptor, valueFactory func() protoreflect.Value) (interface{}, protoreflect.Value) {
	switch field.Kind() {
	case protoreflect.EnumKind:
		val := field.Enum().Values().Get(rand.Intn(field.Enum().Values().Len()))
		return &delta.Op_Enum{Enum: int32(val.Number())}, protoreflect.ValueOfEnum(val.Number())
	case protoreflect.MessageKind:
		// add random values to message?
		message := valueFactory().Message()
		for i := 0; i < message.Descriptor().Fields().Len(); i++ {
			if shouldSetFieldInNewMessage() {
				field := message.Descriptor().Fields().Get(i)
				factory := func() protoreflect.Value { return message.NewField(field) }
				_, val := randomValue(field, factory)
				message.Set(field, val)
			}
		}
		return &delta.Op_Message{Message: delta.MustMarshalAny(message.Interface())}, protoreflect.ValueOfMessage(message)
	case protoreflect.BoolKind:
		val := rand.Intn(1) == 0
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Bool{Bool: val}}}, protoreflect.ValueOfBool(val)
	case protoreflect.Int32Kind:
		val := int32(rand.Intn(2048) - 1024)
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Int32{Int32: val}}}, protoreflect.ValueOfInt32(val)
	case protoreflect.Sint32Kind:
		val := int32(rand.Intn(2048) - 1024)
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sint32{Sint32: val}}}, protoreflect.ValueOfInt32(val)
	case protoreflect.Uint32Kind:
		val := uint32(rand.Intn(1024))
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Uint32{Uint32: val}}}, protoreflect.ValueOfUint32(val)
	case protoreflect.Int64Kind:
		val := int64(rand.Intn(2048) - 1024)
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Int64{Int64: val}}}, protoreflect.ValueOfInt64(val)
	case protoreflect.Sint64Kind:
		val := int64(rand.Intn(2048) - 1024)
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sint64{Sint64: val}}}, protoreflect.ValueOfInt64(val)
	case protoreflect.Uint64Kind:
		val := uint64(rand.Intn(1024))
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Uint64{Uint64: val}}}, protoreflect.ValueOfUint64(val)
	case protoreflect.Sfixed32Kind:
		val := int32(rand.Intn(2048) - 1024)
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sfixed32{Sfixed32: val}}}, protoreflect.ValueOfInt32(val)
	case protoreflect.Fixed32Kind:
		val := uint32(rand.Intn(1024))
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Fixed32{Fixed32: val}}}, protoreflect.ValueOfUint32(val)
	case protoreflect.FloatKind:
		val := rand.Float32()*2048 - 1024
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Float{Float: val}}}, protoreflect.ValueOfFloat32(val)
	case protoreflect.Sfixed64Kind:
		val := int64(rand.Intn(2048) - 1024)
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Sfixed64{Sfixed64: val}}}, protoreflect.ValueOfInt64(val)
	case protoreflect.Fixed64Kind:
		val := uint64(rand.Intn(1024))
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Fixed64{Fixed64: val}}}, protoreflect.ValueOfUint64(val)
	case protoreflect.DoubleKind:
		val := rand.Float64()*2048 - 1024
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Double{Double: val}}}, protoreflect.ValueOfFloat64(val)
	case protoreflect.StringKind:
		val := randomString()
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_String_{String_: val}}}, protoreflect.ValueOfString(val)
	case protoreflect.BytesKind:
		val := []byte(randomString())
		return &delta.Op_Scalar{Scalar: &delta.Scalar{V: &delta.Scalar_Bytes{Bytes: val}}}, protoreflect.ValueOfBytes(val)
	case protoreflect.GroupKind:
		// what is this?
		panic("")
	}
	panic("")
}
func getRandomMapKey(field protoreflect.FieldDescriptor) protoreflect.MapKey {
	var mapKey protoreflect.MapKey
	switch field.Kind() {
	case protoreflect.BoolKind:
		val := rand.Intn(1) == 0
		mapKey = protoreflect.ValueOfBool(val).MapKey()
	case protoreflect.Int32Kind:
		val := int32(rand.Intn(2048) - 1024)
		mapKey = protoreflect.ValueOfInt32(val).MapKey()
	case protoreflect.Int64Kind:
		val := int64(rand.Intn(2048) - 1024)
		mapKey = protoreflect.ValueOfInt64(val).MapKey()
	case protoreflect.Uint32Kind:
		val := uint32(rand.Intn(1024))
		mapKey = protoreflect.ValueOfUint32(val).MapKey()
	case protoreflect.Uint64Kind:
		val := uint64(rand.Intn(1024))
		mapKey = protoreflect.ValueOfUint64(val).MapKey()
	case protoreflect.StringKind:
		mapKey = protoreflect.ValueOfString(val).MapKey()
	}
	return mapKey
}

const alphanum = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

func randomString() string {
	b := make([]byte, 20)
	if _, err := rand.Read(b); err != nil {
		panic(err)
	}
	for i, byt := range b {
		b[i] = alphanum[int(byt)%len(alphanum)]
	}
	return string(b)
}

func shouldSetFieldInNewMessage() bool {
	return rand.Float64() < 0.2
}

func shouldDelete(location []*delta.Locator) bool {
	// TODO: deeply nested deletes should be higher probability, so we don't delete the root nodes too often
	return rand.Float64() < 0.1
}

func shouldSet(location []*delta.Locator, isSet bool) bool {
	// TODO: deeply nested sets should be higher probability, so we don't reset the root nodes too often
	if isSet {
		return rand.Float64() < 0.02 // only 2% overwrite
	}
	return rand.Float64() < 0.1 // 10% set new value
}

func init() {
	rand.Seed(time.Now().Unix())
}
*/
