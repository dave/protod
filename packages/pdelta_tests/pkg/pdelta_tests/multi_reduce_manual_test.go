package pdelta_tests

import (
	"io/ioutil"
	"strings"
	"testing"

	"google.golang.org/protobuf/encoding/protojson"
)

func TestMultiReduceCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../assets/cases_multi_reduce_manual.json")
	if err != nil {
		t.Fatal(err)
	}
	caseStrings := strings.Split(string(casesBytes), "\n")
	for _, caseString := range caseStrings {
		caseString = strings.TrimPrefix(caseString, "[")
		caseString = strings.TrimSuffix(caseString, "]")
		caseString = strings.TrimSuffix(caseString, ",")
		var tc ReduceTestCase
		if err := protojson.Unmarshal([]byte(caseString), &tc); err != nil {
			t.Fatal(err)
		}
		runReduceCase(t, &tc)
	}
}

func TestMultiReduce(t *testing.T) {

	const write = false

	items := []*ReduceTestCase{
		{
			Name: "SET_EDIT_CHILD_OBJECT",
			//Op:     Op().Person().Cases().Set(map[string]*Case{"a": {}}),
			//Op2:     Op().Person().Cases().Key("a").Name().Set("b"),
			Reduced: Op().Person().Cases().Set(map[string]*Case{"a": {Name: "b"}}),
		},
	}
	var solo bool
	for _, item := range items {
		if item.Solo {
			solo = true
			break
		}
	}
	var sbj strings.Builder
	sbj.WriteString("[")
	for i, item := range items {
		if solo && !item.Solo {
			continue
		}

		b, err := protojson.Marshal(item)
		if err != nil {
			t.Fatal(err)
		}
		if i > 0 {
			sbj.WriteString(",\n")
		}
		sbj.Write(b)

		runReduceCase(t, item)

	}
	if solo {
		t.Fatal("solo")
	}
	sbj.WriteString("]")
	if write {
		if err := ioutil.WriteFile("../../assets/cases_multi_reduce_manual.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}
