package pdelta_tests

import (
	"fmt"
	"io/ioutil"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/fuzzer"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/petname"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestTransformRandomCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../assets/cases_transform_random.json")
	if err != nil {
		t.Fatal(err)
	}
	cases := strings.Split(string(casesBytes), "\n")
	for _, caseJson := range cases {
		caseJson = strings.TrimPrefix(caseJson, "[")
		caseJson = strings.TrimSuffix(caseJson, "]")
		caseJson = strings.TrimSuffix(caseJson, ",")
		item := &TransformTestCase{}
		if err := protojson.Unmarshal([]byte(caseJson), item); err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		CheckTransformConverges(t, item)
	}
}

func TestTransformRandom(t *testing.T) {

	const run = false
	const write = false

	if run {
		// continue
	} else {
		return
	}

	p := &Person{Name: "a"}
	var sbj strings.Builder
	sbj.WriteString("[")
	for i := 0; i < 10000; i++ {

		ops := fuzzer.List(p, 2)

		testCase := &TransformTestCase{
			Name: petname.Generate(3, "-"),
			Data: pdelta.MustMarshalAny(proto.Clone(p).(*Person)),
			Op1:  ops[0],
			Op2:  ops[1],
		}
		CheckTransformConverges(t, testCase)

		b, err := protojson.Marshal(testCase)
		if err != nil {
			t.Fatal(err)
		}
		if i > 0 {
			sbj.WriteString(",\n")
		}
		sbj.Write(b)

		// apply
		_, op1x, err := pdelta.Transform(ops[0], ops[1], true)
		if err != nil {
			t.Fatal(err)
		}
		if err := pdelta.Apply(ops[0], p); err != nil {
			t.Fatal(err)
		}
		if err := pdelta.Apply(op1x, p); err != nil {
			t.Fatal(err)
		}
	}
	sbj.WriteString("]")
	if write {
		if err := ioutil.WriteFile("../../assets/cases_transform_random.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}

func CheckTransformConverges(t *testing.T, testCase *TransformTestCase) {

	data := pdelta.MustUnmarshalAny(testCase.Data).(*Person)
	opA := testCase.Op1
	opB := testCase.Op2

	dump := func() {
		fmt.Printf("\nData: %s\nopA: %s\nopB: %s\n", data, opA, opB)
	}

	// opA has priority
	opAxpA, opBxpA, err := pdelta.Transform(opA, opB, true)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	// opB has priority
	opAxpB, opBxpB, err := pdelta.Transform(opA, opB, false)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	dataApA := proto.Clone(data) // one should apply to data
	if err := pdelta.Apply(opA, dataApA); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := pdelta.Apply(opBxpA, dataApA); err != nil {
		dump()
		t.Fatal(err)
	}

	dataBpA := proto.Clone(data)
	if err := pdelta.Apply(opB, dataBpA); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := pdelta.Apply(opAxpA, dataBpA); err != nil {
		dump()
		t.Fatal(err)
	}

	dataApB := proto.Clone(data)
	if err := pdelta.Apply(opA, dataApB); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := pdelta.Apply(opBxpB, dataApB); err != nil {
		dump()
		t.Fatal(err)
	}

	dataBpB := proto.Clone(data)
	if err := pdelta.Apply(opB, dataBpB); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := pdelta.Apply(opAxpB, dataBpB); err != nil {
		dump()
		t.Fatal(err)
	}

	resultApA, err := protojson.Marshal(dataApA)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	resultApB, err := protojson.Marshal(dataApB)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	resultBpA, err := protojson.Marshal(dataBpA)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	resultBpB, err := protojson.Marshal(dataBpB)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	if !compareJson(string(resultApA), string(resultBpA)) {
		t.Fatalf("\nData: %s\nopA: %s\nopB: %s\npriority: A\nresult-A-Bx: %s\nresult-B-Ax: %s\n", data, opA, opB, resultApA, resultBpA)
	}

	if !compareJson(string(resultApB), string(resultBpB)) {
		t.Fatalf("\nData: %s\nopA: %s\nopB: %s\npriority: B\nresult-A-Bx: %s\nresult-B-Ax: %s\n", data, opA, opB, resultApB, resultBpB)
	}

}
