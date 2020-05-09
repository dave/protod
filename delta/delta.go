package delta

import (
	"fmt"

	"github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
	proto2 "google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
	"google.golang.org/protobuf/types/known/anypb"
)

func Apply(delta *Delta, input proto2.Message) {
	var locPath []*Locator
	if len(delta.Location) > 1 {
		locPath = delta.Location[0 : len(delta.Location)-1]
	}
	locLast := delta.Location[len(delta.Location)-1]
	val := getLocation(input.ProtoReflect(), locPath)
	switch val := val.(type) {
	case protoreflect.Message:
		field := val.Descriptor().Fields().ByNumber(protoreflect.FieldNumber(locLast.V.(*Locator_Field).Field.Number))
		if string(field.Name()) != locLast.V.(*Locator_Field).Field.Name {
			panic("field name / number mismatch")
		}
		val.Set(field, getValue(delta.Value))
	case protoreflect.List:
		val.Set(int(locLast.V.(*Locator_Index).Index), getValue(delta.Value))
	default:
		panic(fmt.Sprintf("unknown val type %T", val))
	}
}

func EditValue(value interface{}, location LocatorInterface) *Delta {
	var loc []*Locator
	for _, indexer := range location.Location_get() {
		switch indexer := indexer.(type) {
		case FieldIndexerStruct:
			loc = append(loc, &Locator{V: &Locator_Field{Field: &Field{Name: indexer.Name, Number: int32(indexer.Number)}}})
		case IndexIndexer:
			loc = append(loc, &Locator{V: &Locator_Index{Index: int64(indexer)}})
		case KeyIndexer:
			loc = append(loc, &Locator{V: &Locator_Key{Key: string(indexer)}})
		}
	}
	return &Delta{
		Type:     Delta_EditValue,
		Location: loc,
		Value:    NewAny(value),
	}
}

func NewAny(value interface{}) *anypb.Any {
	// TODO: create separate functions for sint32, sint64, fixed32, fixed64, sfixed32, sfixed64 if needed
	switch value := value.(type) {
	case string:
		return mustAny(&Scalar{V: &Scalar_Str{Str: value}})
	case float64:
		return mustAny(&Scalar{V: &Scalar_Double{Double: value}})
	case float32:
		return mustAny(&Scalar{V: &Scalar_Float{Float: value}})
	case int64:
		return mustAny(&Scalar{V: &Scalar_Int64{Int64: value}})
	case int32:
		return mustAny(&Scalar{V: &Scalar_Int32{Int32: value}})
	case uint64:
		return mustAny(&Scalar{V: &Scalar_Uint64{Uint64: value}})
	case uint32:
		return mustAny(&Scalar{V: &Scalar_Uint32{Uint32: value}})
	case bool:
		return mustAny(&Scalar{V: &Scalar_Bool{Bool: value}})
	case []byte:
		return mustAny(&Scalar{V: &Scalar_Bytes{Bytes: value}})
	case proto.Message:
		return mustAny(value)
	default:
		panic("unknown type in changeValue")
	}
}

func Location(m proto2.Message, name string) int32 {
	return int32(m.ProtoReflect().Descriptor().Fields().ByName(protoreflect.Name(name)).Number())
}

func getLocation(m protoreflect.Message, loc []*Locator) interface{} {
	var current interface{} = m
	for _, sel := range loc {
		switch c := current.(type) {
		case protoreflect.Message:
			fieldDescriptor := c.Descriptor().Fields().ByNumber(protoreflect.FieldNumber(sel.V.(*Locator_Field).Field.Number))
			if string(fieldDescriptor.Name()) != sel.V.(*Locator_Field).Field.Name {
				panic("field name / number mismatch")
			}
			fieldValue := c.Get(fieldDescriptor)
			switch fieldValueInterface := fieldValue.Interface().(type) {
			case proto2.Message:
				current = fieldValueInterface.ProtoReflect()
			case protoreflect.Message:
				current = fieldValueInterface
			case protoreflect.List:
				current = fieldValueInterface
			default:
				current = fieldValue
			}
		case protoreflect.List:
			indexValue := c.Get(int(sel.V.(*Locator_Index).Index))
			switch indexValueInterface := indexValue.Interface().(type) {
			case proto2.Message:
				current = indexValueInterface.ProtoReflect()
			case protoreflect.Message:
				current = indexValueInterface
			case protoreflect.List:
				current = indexValueInterface
			default:
				current = indexValue
			}
		}
	}
	return current
}

func getValue(a *anypb.Any) protoreflect.Value {
	da := &ptypes.DynamicAny{}
	err := ptypes.UnmarshalAny(a.ProtoReflect().Interface().(*anypb.Any), da)
	if err != nil {
		panic(err)
	}
	switch message := da.Message.(type) {
	case *Scalar:
		switch value := message.V.(type) {
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
		case *Scalar_Str:
			return protoreflect.ValueOfString(value.Str)
		case *Scalar_Bytes:
			return protoreflect.ValueOfBytes(value.Bytes)
		case *Scalar_Sint32, *Scalar_Sint64:
			panic("unsupported type in value")
		case *Scalar_Fixed32, *Scalar_Fixed64:
			panic("unsupported type in value")
		case *Scalar_Sfixed32, *Scalar_Sfixed64:
			panic("unsupported type in value")
		default:
			panic("unknown type")
		}
	default:
		value := protoreflect.ValueOfMessage(proto.MessageReflect(da.Message))
		return value
	}
}

func mustAny(m proto.Message) *anypb.Any {
	a, err := ptypes.MarshalAny(m)
	if err != nil {
		panic(err)
	}
	return a
}

type String_scalar struct {
	location []Indexer
}

func (b String_scalar) Location_get() []Indexer {
	return b.location
}

func NewString_scalar(l []Indexer) String_scalar {
	return String_scalar{location: l}
}

type Int64_scalar struct {
	location []Indexer
}

func (b Int64_scalar) Location_get() []Indexer {
	return b.location
}

func NewInt64_scalar(l []Indexer) Int64_scalar {
	return Int64_scalar{location: l}
}

type Int32_scalar struct {
	location []Indexer
}

func (b Int32_scalar) Location_get() []Indexer {
	return b.location
}

func NewInt32_scalar(l []Indexer) Int32_scalar {
	return Int32_scalar{location: l}
}

type LocatorInterface interface {
	Location_get() []Indexer
}

type Indexer interface {
	isIndexer()
}

func FieldIndexer(name string, number int) FieldIndexerStruct {
	return FieldIndexerStruct{name, number}
}

type FieldIndexerStruct struct {
	Name   string
	Number int
}

func (FieldIndexerStruct) isIndexer() {}

type IndexIndexer int

func (IndexIndexer) isIndexer() {}

type KeyIndexer string

func (KeyIndexer) isIndexer() {}

func CopyAndAppend(in []Indexer, v Indexer) []Indexer {
	out := make([]Indexer, len(in)+1)
	copy(out, in)
	out[len(out)-1] = v
	return out
}
