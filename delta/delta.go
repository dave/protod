package delta

import (
	"fmt"
	"time"

	"github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
	"github.com/sergi/go-diff/diffmatchpatch"
	proto2 "google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
	"google.golang.org/protobuf/types/known/anypb"
)

func Apply(delta *Delta, input proto2.Message) error {
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
		newValue, err := getValue(val.Get(field), delta.Value)
		if err != nil {
			return fmt.Errorf("getting value: %w", err)
		}
		val.Set(field, newValue)
	case protoreflect.List:
		idx := int(locLast.V.(*Locator_Index).Index)
		newVaue, err := getValue(val.Get(idx), delta.Value)
		if err != nil {
			return fmt.Errorf("getting value: %w", err)
		}
		val.Set(idx, newVaue)
	case protoreflect.Map:
		key := getMapKey(locLast.V.(*Locator_Key).Key)
		newValue, err := getValue(val.Get(key), delta.Value)
		if err != nil {
			return fmt.Errorf("getting value: %w", err)
		}
		val.Set(key, newValue)
	default:
		panic(fmt.Sprintf("unknown val type %T", val))
	}
	return nil
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

func getLoc(location LocatorInterface) []*Locator {
	var loc []*Locator
	for _, indexer := range location.Location_get() {
		switch indexer := indexer.(type) {
		case FieldIndexerStruct:
			loc = append(loc, &Locator{V: &Locator_Field{Field: &Field{Name: indexer.Name, Number: int32(indexer.Number)}}})
		case IndexIndexer:
			loc = append(loc, &Locator{V: &Locator_Index{Index: int64(indexer)}})
		case BoolKeyIndexer:
			loc = append(loc, &Locator{V: &Locator_Key{Key: &Key{V: &Key_Bool{Bool: bool(indexer)}}}})
		case Int32KeyIndexer:
			loc = append(loc, &Locator{V: &Locator_Key{Key: &Key{V: &Key_Int32{Int32: int32(indexer)}}}})
		case Int64KeyIndexer:
			loc = append(loc, &Locator{V: &Locator_Key{Key: &Key{V: &Key_Int64{Int64: int64(indexer)}}}})
		case Uint32KeyIndexer:
			loc = append(loc, &Locator{V: &Locator_Key{Key: &Key{V: &Key_Uint32{Uint32: uint32(indexer)}}}})
		case Uint64KeyIndexer:
			loc = append(loc, &Locator{V: &Locator_Key{Key: &Key{V: &Key_Uint64{Uint64: uint64(indexer)}}}})
		case StringKeyIndexer:
			loc = append(loc, &Locator{V: &Locator_Key{Key: &Key{V: &Key_String_{String_: string(indexer)}}}})
		}
	}
	return loc
}

func EditDiff(from, to string, location LocatorInterface) *Delta {
	return &Delta{
		Type:     Delta_Edit,
		Location: getLoc(location),
		Value:    NewAnyDiff(from, to),
	}
}

func EditValue(value interface{}, location LocatorInterface) *Delta {
	return &Delta{
		Type:     Delta_Edit,
		Location: getLoc(location),
		Value:    NewAny(value),
	}
}

func NewAnyDiff(from, to string) *anypb.Any {
	dmp := diffmatchpatch.New()
	dmp.DiffTimeout = time.Millisecond * 100
	dlt := dmp.DiffToDelta(dmp.DiffCleanupSemantic(dmp.DiffMain(from, to, false)))
	return mustAny(&Scalar{V: &Scalar_Delta{Delta: dlt}})
}

func NewAny(value interface{}) *anypb.Any {
	// TODO: create separate functions for sint32, sint64, fixed32, fixed64, sfixed32, sfixed64 if needed
	switch value := value.(type) {
	case string:
		return mustAny(&Scalar{V: &Scalar_String_{String_: value}})
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
		var value protoreflect.Value
		switch c := current.(type) {
		case protoreflect.Message:
			fieldDescriptor := c.Descriptor().Fields().ByNumber(protoreflect.FieldNumber(sel.V.(*Locator_Field).Field.Number))
			if string(fieldDescriptor.Name()) != sel.V.(*Locator_Field).Field.Name {
				panic("field name / number mismatch")
			}
			value = c.Get(fieldDescriptor)
		case protoreflect.List:
			value = c.Get(int(sel.V.(*Locator_Index).Index))
		case protoreflect.Map:
			value = c.Get(getMapKey(sel.V.(*Locator_Key).Key))
		default:
			panic(fmt.Sprintf("unknown locator %T", current))
		}

		switch valueInterface := value.Interface().(type) {
		case proto2.Message:
			current = valueInterface.ProtoReflect()
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
	return current
}

func MustUnmarshalAny(any *anypb.Any) *ptypes.DynamicAny {
	da := &ptypes.DynamicAny{}
	err := ptypes.UnmarshalAny(any.ProtoReflect().Interface().(*anypb.Any), da)
	if err != nil {
		panic(err)
	}
	return da
}

func getValue(previous protoreflect.Value, a *anypb.Any) (protoreflect.Value, error) {
	da := MustUnmarshalAny(a)
	switch message := da.Message.(type) {
	case *Scalar:
		switch value := message.V.(type) {
		case *Scalar_Float:
			return protoreflect.ValueOfFloat32(value.Float), nil
		case *Scalar_Double:
			return protoreflect.ValueOfFloat64(value.Double), nil
		case *Scalar_Int32:
			return protoreflect.ValueOfInt32(value.Int32), nil
		case *Scalar_Int64:
			return protoreflect.ValueOfInt64(value.Int64), nil
		case *Scalar_Uint32:
			return protoreflect.ValueOfUint32(value.Uint32), nil
		case *Scalar_Uint64:
			return protoreflect.ValueOfUint64(value.Uint64), nil
		case *Scalar_Bool:
			return protoreflect.ValueOfBool(value.Bool), nil
		case *Scalar_String_:
			return protoreflect.ValueOfString(value.String_), nil
		case *Scalar_Bytes:
			return protoreflect.ValueOfBytes(value.Bytes), nil
		case *Scalar_Delta:
			prevString := previous.String()
			dmp := diffmatchpatch.New()
			diffs, err := dmp.DiffFromDelta(prevString, value.Delta)
			if err != nil {
				return protoreflect.Value{}, fmt.Errorf("error parsing delta: %w", err)
			}
			newString := dmp.DiffText2(diffs)
			return protoreflect.ValueOfString(newString), nil
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
		return value, nil
	}

}

func mustAny(m proto.Message) *anypb.Any {
	a, err := ptypes.MarshalAny(m)
	if err != nil {
		panic(err)
	}
	return a
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

func FieldLocator(name string, number int) Locator {
	return Locator{V: &Locator_Field{Field: &Field{Name: name, Number: int32(number)}}}
}

type FieldIndexerStruct struct {
	Name   string
	Number int
}

func (FieldIndexerStruct) isIndexer() {}

type IndexIndexer int

func (IndexIndexer) isIndexer() {}

func KeyIndexer(key interface{}) Indexer {
	switch key := key.(type) {
	case bool:
		return BoolKeyIndexer(key)
	case int32:
		return Int32KeyIndexer(key)
	case int64:
		return Int64KeyIndexer(key)
	case uint32:
		return Uint32KeyIndexer(key)
	case uint64:
		return Uint64KeyIndexer(key)
	case string:
		return StringKeyIndexer(key)
	}
	panic("unknown type")
}

type BoolKeyIndexer bool
type Int32KeyIndexer int32
type Int64KeyIndexer int64
type Uint32KeyIndexer uint32
type Uint64KeyIndexer uint64
type StringKeyIndexer string

func (BoolKeyIndexer) isIndexer()   {}
func (Int32KeyIndexer) isIndexer()  {}
func (Int64KeyIndexer) isIndexer()  {}
func (Uint32KeyIndexer) isIndexer() {}
func (Uint64KeyIndexer) isIndexer() {}
func (StringKeyIndexer) isIndexer() {}

func CopyAndAppend(in []Indexer, v Indexer) []Indexer {
	out := make([]Indexer, len(in)+1)
	copy(out, in)
	out[len(out)-1] = v
	return out
}

func CopyAndAppendLocator(in []Locator, v Locator) []Locator {
	out := make([]Locator, len(in)+1)
	copy(out, in)
	out[len(out)-1] = v
	return out
}
