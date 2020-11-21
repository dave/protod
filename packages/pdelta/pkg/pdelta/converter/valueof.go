package converter

import (
	"reflect"

	"google.golang.org/protobuf/reflect/protoreflect"
)

func ValueOf(value reflect.Value, message protoreflect.Message, field protoreflect.FieldDescriptor) protoreflect.Value {
	if field.IsList() {
		return NewList(value, message, field)
	} else if field.IsMap() {
		return NewMap(value, message, field)
	}
	return protoreflect.ValueOf(value)
}

func NewList(value reflect.Value, message protoreflect.Message, field protoreflect.FieldDescriptor) protoreflect.Value {
	if !field.IsList() {
		panic("field must be list")
	}
	if value.Kind() != reflect.Slice && value.Kind() != reflect.Array {
		panic("value must be slice or array")
	}
	conv := NewConverter(value.Type().Elem(), field)
	protoList := message.NewField(field).List()
	for i := 0; i < value.Len(); i++ {
		reflectValue := value.Index(i)
		protoValue := conv.PBValueOf(reflectValue)
		protoList.Append(protoValue)
	}
	return protoreflect.ValueOfList(protoList)
}

func NewMap(value reflect.Value, message protoreflect.Message, field protoreflect.FieldDescriptor) protoreflect.Value {
	if !field.IsMap() {
		panic("field must be map")
	}
	if value.Kind() != reflect.Map {
		panic("value must be map")
	}
	keyConv := NewConverter(value.Type().Key(), field.MapKey())
	valueConv := NewConverter(value.Type().Elem(), field.MapValue())
	protoMap := message.NewField(field).Map()
	iter := value.MapRange()
	for iter.Next() {
		reflectKey := iter.Key()
		reflectValue := iter.Value()
		protoKey := keyConv.PBValueOf(reflectKey).MapKey()
		protoValue := valueConv.PBValueOf(reflectValue)
		protoMap.Set(protoKey, protoValue)
	}
	return protoreflect.ValueOfMap(protoMap)
}
