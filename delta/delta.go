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

func Apply(delta *Op, input proto2.Message) error {

	getValue := func(previous protoreflect.Value, a *anypb.Any) (protoreflect.Value, error) {
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
			case *Scalar_Diff:
				prevString := previous.String()
				dmp := diffmatchpatch.New()
				diffs, err := dmp.DiffFromDelta(prevString, value.Diff)
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

func Diff(from, to string, location Location) *Op {
	return &Op{
		Type:     Op_Edit,
		Location: location.Location_get(),
		Value:    NewAnyDiff(from, to),
	}
}

func Edit(value interface{}, location Location) *Op {
	return &Op{
		Type:     Op_Edit,
		Location: location.Location_get(),
		Value:    NewAny(value),
	}
}

type Location interface {
	Location_get() []*Locator
}

func NewAnyDiff(from, to string) *anypb.Any {
	dmp := diffmatchpatch.New()
	dmp.DiffTimeout = time.Millisecond * 100
	dlt := dmp.DiffToDelta(dmp.DiffCleanupSemantic(dmp.DiffMain(from, to, false)))
	return MustMarshalAny(&Scalar{V: &Scalar_Diff{Diff: dlt}})
}

func NewAny(value interface{}) *anypb.Any {
	// TODO: create separate functions for sint32, sint64, fixed32, fixed64, sfixed32, sfixed64 if needed
	switch value := value.(type) {
	case string:
		return MustMarshalAny(&Scalar{V: &Scalar_String_{String_: value}})
	case float64:
		return MustMarshalAny(&Scalar{V: &Scalar_Double{Double: value}})
	case float32:
		return MustMarshalAny(&Scalar{V: &Scalar_Float{Float: value}})
	case int64:
		return MustMarshalAny(&Scalar{V: &Scalar_Int64{Int64: value}})
	case int32:
		return MustMarshalAny(&Scalar{V: &Scalar_Int32{Int32: value}})
	case uint64:
		return MustMarshalAny(&Scalar{V: &Scalar_Uint64{Uint64: value}})
	case uint32:
		return MustMarshalAny(&Scalar{V: &Scalar_Uint32{Uint32: value}})
	case bool:
		return MustMarshalAny(&Scalar{V: &Scalar_Bool{Bool: value}})
	case []byte:
		return MustMarshalAny(&Scalar{V: &Scalar_Bytes{Bytes: value}})
	case proto.Message:
		return MustMarshalAny(value)
	default:
		panic("unknown type in changeValue")
	}
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
