package tests

import (
	"testing"

	"github.com/dave/protod/delta"
	proto1 "github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
	any "github.com/golang/protobuf/ptypes/any"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

const OUTPUT_CASES = true

func TestDiffs(t *testing.T) {
	cases := []struct {
		op   *delta.Op
		diff string
	}{
		{
			op:   Op().Person().Name().Edit("Lorem ipsum dolor.", "Lorem dolor sit amet."),
			diff: `{"ops":[{"retain":"6"},{"delete":"11"},{"insert":"dolor sit amet"},{"retain":"1"}]}`,
		},
		{
			op:   Op().Person().Name().Edit("the quick brown fox jumped over the lazy dog.", "the quick orange fox jumped over me."),
			diff: `{"ops":[{"retain":"10"},{"delete":"5"},{"insert":"orange"},{"retain":"17"},{"delete":"12"},{"insert":"me"},{"retain":"1"}]}`,
		},
	}

	for _, tc := range cases {
		diff, err := protojson.Marshal(tc.op.Value.(*delta.Op_Delta).Delta.V.(*delta.Delta_Quill).Quill)
		if err != nil {
			t.Fatal(err)
		}
		if !compareJson(string(diff), tc.diff) {
			t.Fatalf("\ndiff result:   %s\ndiff expected: %s", string(diff), tc.diff)
		}
	}
}

func mustUnmarshalAny(a *any.Any) proto.Message {
	if a == nil {
		return nil
	}
	var da ptypes.DynamicAny
	if err := ptypes.UnmarshalAny(a, &da); err != nil {
		panic(err)
	}
	return proto1.MessageV2(da.Message)
}
