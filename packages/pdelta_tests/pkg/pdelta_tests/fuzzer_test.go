package pdelta_tests

import (
	"encoding/json"
	"fmt"
	"reflect"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/fuzzer"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestRandomTransform(t *testing.T) {
	p := &Person{Name: "a"}
	for i := 0; i < 10000; i++ {

		//if i%1000 == 0 {
		//	fmt.Println(i)
		//}

		ops := fuzzer.List(p, 2)
		testTwoOpsConvergeFuzzer(t, ops[0], ops[1], p)

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
}

//func TestFuzzer(t *testing.T) {
//	message := &Person{}
//	ops := fuzzer.All(message)
//	for i, op := range ops {
//		fmt.Println(i, op.Debug())
//	}
//}
//
//func TestSingle(t *testing.T) {
//	p := mustPerson(`{"name":"a","cases":{"Cr2XdBjb3UcylPTJ6EU5":{"name":"MGAlPoo2h5yGPSG06GJB"}},"company":{"flags":{"-872":"gYacSXXsUH2gs3nijFSA"},"ceo":{"cases":{"gPVX7vGHN8gM50w3Nd8C":{"name":"jIGLrc4toMyDFeNbH49C","items":[{"title":"BGVvSkLSHYkwqcOg9FOM"},{"title":"viEAyVWRxrVRbEBlmAHW"}],"flags":{"-57":"RnvYVzuWx9TwFBYiwqN6"}}},"company":{"ceo":{"name":"ahmyWZL0rvz9Xb4AkE1n"}}}}}`)
//	op := mustOp(`{"type":"Insert","location":[{"field":{"name":"company","number":5}},{"field":{"name":"ceo","number":14}},{"field":{"name":"typeList","number":8}},{"index":"0"}],"scalar":{"enum":1}}`)
//	if err := pdelta.Apply(op, p); err != nil {
//		t.Fatal(err)
//	}
//}

func mustJson(message proto.Message) string {
	b, err := protojson.Marshal(message)
	if err != nil {
		panic(err)
	}
	return string(b)
}

func testTwoOpsConvergeFuzzer(t *testing.T, opA, opB *pdelta.Op, data proto.Message) {

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

func compareProto(m1, m2 proto.Message) bool {
	m1b, err := protojson.Marshal(m1)
	if err != nil {
		panic(err)
	}
	m2b, err := protojson.Marshal(m2)
	if err != nil {
		panic(err)
	}
	var i1, i2 interface{}
	if err := json.Unmarshal(m1b, &i1); err != nil {
		panic(err)
	}
	if err := json.Unmarshal(m2b, &i2); err != nil {
		panic(err)
	}
	return reflect.DeepEqual(i1, i2)
}
