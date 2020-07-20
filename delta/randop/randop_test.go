package randop

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"reflect"
	"strings"
	"testing"

	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/tests"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestSingle(t *testing.T) {
	p := mustPerson(`{"name":"a","cases":{"Cr2XdBjb3UcylPTJ6EU5":{"name":"MGAlPoo2h5yGPSG06GJB"}},"company":{"flags":{"-872":"gYacSXXsUH2gs3nijFSA"},"ceo":{"cases":{"gPVX7vGHN8gM50w3Nd8C":{"name":"jIGLrc4toMyDFeNbH49C","items":[{"title":"BGVvSkLSHYkwqcOg9FOM"},{"title":"viEAyVWRxrVRbEBlmAHW"}],"flags":{"-57":"RnvYVzuWx9TwFBYiwqN6"}}},"company":{"ceo":{"name":"ahmyWZL0rvz9Xb4AkE1n"}}}}}`)
	op := mustOp(`{"type":"Insert","location":[{"field":{"name":"company","number":5}},{"field":{"name":"ceo","number":14}},{"field":{"name":"typeList","number":8}},{"index":"0"}],"scalar":{"enum":1}}`)
	if err := delta.Apply(op, p); err != nil {
		t.Fatal(err)
	}
}

func TestRandomApplyCases(t *testing.T) {
	cases := strings.Split(RANDOM_CASES, "\n")
	p := &tests.Person{Name: "a"}
	for _, caseJson := range cases {
		item := &tests.RandomTestItem{}
		before := proto.Clone(p).(*tests.Person)
		err := protojson.Unmarshal([]byte(caseJson), item)
		if err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		if err := delta.Apply(item.Op, p); err != nil {
			t.Fatal(err)
		}
		expcted, err := protojson.Marshal(item.Expected)
		if err != nil {
			t.Fatal(err)
		}
		result, err := protojson.Marshal(p)
		if err != nil {
			t.Fatal(err)
		}
		if !compareJson(string(result), string(expcted)) {
			input, err := protojson.Marshal(before)
			if err != nil {
				t.Fatal(err)
			}
			t.Fatalf("input: %s\nop: %s\nexpected: %s\nresult:%s", string(input), item.Op.Debug(), string(expcted), string(result))
		}
		//fmt.Printf("input: %s\nop: %s\nexpected: %s\nresult:%s\n\n", string(input), item.Op.Debug(), string(expcted), string(result))
	}
}

func TestRandomApply(t *testing.T) {

	const disabled = true
	if disabled {
		return
	}

	p := &tests.Person{Name: "a"}
	var sbd, sbg strings.Builder
	sbd.WriteString("const RANDOM_CASES = '''")
	sbg.WriteString("package randop\n\nconst RANDOM_CASES = `")
	for i := 0; i < 10000; i++ {
		op := Get(p)
		if err := delta.Apply(op, p); err != nil {
			t.Fatal(err)
		}
		if i%1000 == 0 {
			s := mustJson(p)
			fmt.Println(len(s), s)
		}
		item := &tests.RandomTestItem{
			Op:       op,
			Expected: proto.Clone(p).(*tests.Person),
		}
		b, err := protojson.Marshal(item)
		if err != nil {
			t.Fatal(err)
		}
		if i > 0 {
			sbd.WriteString("\n")
			sbg.WriteString("\n")
		}
		sbd.Write(b)
		sbg.Write(b)
	}
	sbd.WriteString("''';")
	sbg.WriteString("`")
	if err := ioutil.WriteFile("../../test/random_cases.dart", []byte(sbd.String()), 0666); err != nil {
		t.Fatal(err)
	}
	if err := ioutil.WriteFile("./cases_test.go", []byte(sbg.String()), 0666); err != nil {
		t.Fatal(err)
	}
}

func TestRandomTransform(t *testing.T) {
	p := &tests.Person{Name: "a"}
	for i := 0; i < 10000; i++ {

		//if i%1000 == 0 {
		//	fmt.Println(i)
		//}

		ops := List(p, 2)
		testTwoOpsConverge(t, ops[0], ops[1], p)

		// apply
		_, op1x, err := delta.Transform(ops[0], ops[1], true)
		if err != nil {
			t.Fatal(err)
		}
		if err := delta.Apply(ops[0], p); err != nil {
			t.Fatal(err)
		}
		if err := delta.Apply(op1x, p); err != nil {
			t.Fatal(err)
		}
	}
}

func mustPerson(s string) *tests.Person {
	value := &tests.Person{}
	err := protojson.Unmarshal([]byte(s), value)
	if err != nil {
		panic(err)
	}
	return value
}
func mustOp(s string) *delta.Op {
	value := &delta.Op{}
	err := protojson.Unmarshal([]byte(s), value)
	if err != nil {
		panic(err)
	}
	return value
}

func mustJson(message proto.Message) string {
	b, err := protojson.Marshal(message)
	if err != nil {
		panic(err)
	}
	return string(b)
}

func testTwoOpsConverge(t *testing.T, opA, opB *delta.Op, data proto.Message) {

	dump := func() {
		fmt.Printf("\nData: %s\nopA: %s\nopB: %s\n", data, opA, opB)
	}

	// opA has priority
	opAxpA, opBxpA, err := delta.Transform(opA, opB, true)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	// opB has priority
	opAxpB, opBxpB, err := delta.Transform(opA, opB, false)
	if err != nil {
		dump()
		t.Fatal(err)
	}

	dataApA := proto.Clone(data) // one should apply to data
	if err := delta.Apply(opA, dataApA); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := delta.Apply(opBxpA, dataApA); err != nil {
		dump()
		t.Fatal(err)
	}

	dataBpA := proto.Clone(data)
	if err := delta.Apply(opB, dataBpA); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := delta.Apply(opAxpA, dataBpA); err != nil {
		dump()
		t.Fatal(err)
	}

	dataApB := proto.Clone(data)
	if err := delta.Apply(opA, dataApB); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := delta.Apply(opBxpB, dataApB); err != nil {
		dump()
		t.Fatal(err)
	}

	dataBpB := proto.Clone(data)
	if err := delta.Apply(opB, dataBpB); err != nil {
		dump()
		t.Fatal(err)
	}
	if err := delta.Apply(opAxpB, dataBpB); err != nil {
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
