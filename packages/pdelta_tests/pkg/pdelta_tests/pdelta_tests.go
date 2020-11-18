package pdelta_tests

import (
	"encoding/json"
	"fmt"
	reflect "reflect"
	"sort"
	"strings"
	"testing"

	proto1 "github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
	any "github.com/golang/protobuf/ptypes/any"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

const OUTPUT_CASES = false

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

func compareResults(t *testing.T, result, expected string) {
	expected = strings.TrimSpace(expected)
	expected = strings.ReplaceAll(expected, "\t", "")
	result = strings.TrimSpace(result)
	result = strings.ReplaceAll(result, "\t", "")
	if expected != result {
		//fmt.Println(result)
		//t.Fatalf("")
		t.Fatalf("Unexpected result. Expected:\n%s\n\nResult:\n%s\n", expected, result)
	}
}

func compareJson(s1, s2 string) bool {
	var i1, i2 interface{}
	if err := json.Unmarshal([]byte(s1), &i1); err != nil {
		return false
	}
	if err := json.Unmarshal([]byte(s2), &i2); err != nil {
		return false
	}
	return reflect.DeepEqual(i1, i2)
}

func printAlias(m proto.Message) string {
	p := m.(*Person)
	return strings.Join(p.Alias, " ")
}

func printFlags(m proto.Message) string {
	c := m.(*Company)
	var keys []int64
	for key := range c.Flags {
		keys = append(keys, key)
	}
	sort.Slice(keys, func(i, j int) bool { return keys[i] < keys[j] })
	var out string
	for i, key := range keys {
		if i != 0 {
			out += " "
		}
		out += fmt.Sprintf("%d:%s", key, c.Flags[key])
	}
	return out
}

func mustJson(message proto.Message) string {
	if message == nil {
		return "[nil]"
	}
	if !message.ProtoReflect().IsValid() {
		return "[invalid]"
	}
	b, err := protojson.MarshalOptions{Indent: "\t"}.Marshal(message)
	if err != nil {
		panic(err)
	}
	return string(b)
}
