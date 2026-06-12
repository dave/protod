package pdelta_tests

import (
	"encoding/json"
	"io/ioutil"
	"reflect"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"google.golang.org/protobuf/encoding/protojson"
)

// TestReduceOutputs pins the exact structural output of Reduce for every case in the reduce corpora. The same
// asset files are checked by the Dart test reduce_outputs_test.dart, which guarantees the Go and Dart
// implementations produce identical operations, not just equivalent ones. Set write to true to regenerate the
// assets after intentionally changing reduce behaviour.
func TestReduceOutputs(t *testing.T) {

	const write = false

	for _, name := range []string{"cases_reduce_manual", "cases_reduce_random", "cases_multi_reduce_manual"} {
		casesBytes, err := ioutil.ReadFile("../../assets/" + name + ".json")
		if err != nil {
			t.Fatal(err)
		}
		var expected []string
		if !write {
			expectedBytes, err := ioutil.ReadFile("../../assets/" + name + "_outputs.json")
			if err != nil {
				t.Fatal(err)
			}
			expected = strings.Split(strings.TrimSuffix(string(expectedBytes), "\n"), "\n")
		}
		var sb strings.Builder
		for i, caseString := range strings.Split(string(casesBytes), "\n") {
			caseString = strings.TrimPrefix(caseString, "[")
			caseString = strings.TrimSuffix(caseString, "]")
			caseString = strings.TrimSuffix(caseString, ",")
			var tc ReduceTestCase
			if err := protojson.Unmarshal([]byte(caseString), &tc); err != nil {
				t.Fatal(err)
			}
			reduced := pdelta.Reduce(tc.Op)
			if write {
				if pdelta.IsNull(reduced) {
					sb.WriteString("null\n")
				} else {
					b, err := protojson.Marshal(reduced)
					if err != nil {
						t.Fatal(err)
					}
					sb.WriteString(string(b) + "\n")
				}
				continue
			}
			if i >= len(expected) {
				t.Fatalf("%s: more cases than expected outputs", name)
			}
			if expected[i] == "null" {
				if !pdelta.IsNull(reduced) {
					t.Fatalf("%s case %s: expected null, got: %v", name, tc.Name, reduced.Debug())
				}
				continue
			}
			// Compare as parsed protojson rather than proto.Equal: ops can contain Any-packed messages, and the
			// wire bytes inside an Any are not deterministic for messages with maps. The protojson form expands
			// the Any into JSON, and JSON objects compare unordered.
			reducedJson, err := protojson.Marshal(reduced)
			if err != nil {
				t.Fatal(err)
			}
			var expectedParsed, reducedParsed interface{}
			if err := json.Unmarshal([]byte(expected[i]), &expectedParsed); err != nil {
				t.Fatal(err)
			}
			if err := json.Unmarshal(reducedJson, &reducedParsed); err != nil {
				t.Fatal(err)
			}
			if !reflect.DeepEqual(reducedParsed, expectedParsed) {
				t.Fatalf("%s case %s:\nexpected: %s\nfound: %s", name, tc.Name, expected[i], reducedJson)
			}
		}
		if write {
			if err := ioutil.WriteFile("../../assets/"+name+"_outputs.json", []byte(sb.String()), 0666); err != nil {
				t.Fatal(err)
			}
		}
	}
}
