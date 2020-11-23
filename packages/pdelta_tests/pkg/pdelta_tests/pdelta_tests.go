package pdelta_tests

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
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

const OUTPUT_CASES = true

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

func compareResults(t *testing.T, result, name string) {
	expectedBytes, err := ioutil.ReadFile(fmt.Sprintf("../../expected_%v.txt", name))
	if err != nil {
		t.Fatal(err)
	}
	expected := string(expectedBytes)
	expected = strings.ReplaceAll(expected, "\t", "")
	result = strings.TrimSpace(result)
	result = strings.ReplaceAll(result, "\t", "")
	if expected != result {
		t.Fatalf("Unexpected result in %v expected test. Expected:\n%s\n\nResult:\n%s\n", name, expected, result)
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

func mustJsonPretty(message proto.Message) string {
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
