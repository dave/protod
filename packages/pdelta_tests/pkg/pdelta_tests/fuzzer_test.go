package pdelta_tests

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"math/rand"
	"reflect"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/fuzzer"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/petname"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestRandomApplyCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../cases_apply_random.json")
	if err != nil {
		t.Fatal(err)
	}
	cases := strings.Split(string(casesBytes), "\n")
	p := &Person{Name: "a"}
	for _, caseJson := range cases {
		caseJson = strings.TrimPrefix(caseJson, "[")
		caseJson = strings.TrimSuffix(caseJson, "]")
		caseJson = strings.TrimSuffix(caseJson, ",")
		item := &ApplyTestItem{}
		before := proto.Clone(p).(*Person)
		err := protojson.Unmarshal([]byte(caseJson), item)
		if err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		if err := pdelta.Apply(item.Op, p); err != nil {
			t.Fatalf("apply case %v: %v", item.Name, err)
		}
		if !compareProto(item.Expected, p) {
			input, err := protojson.Marshal(before)
			if err != nil {
				t.Fatal(err)
			}
			t.Fatalf("apply case %v: input: %s\nop: %s\nexpected: %s\nresult:%s", item.Name, string(input), item.Op.Debug(), mustJsonPretty(item.Expected), mustJsonPretty(p))
		}
	}
}

func TestRandomReduceCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../cases_reduce_random.json")
	if err != nil {
		t.Fatal(err)
	}
	cases := strings.Split(string(casesBytes), "\n")
	//cases := []string{`...`}
	for _, caseJson := range cases {
		caseJson = strings.TrimPrefix(caseJson, "[")
		caseJson = strings.TrimSuffix(caseJson, "]")
		caseJson = strings.TrimSuffix(caseJson, ",")
		item := &ReduceTestItem{}
		if err := protojson.Unmarshal([]byte(caseJson), item); err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		data1 := proto.Clone(item.Data).(*Person)
		data2 := proto.Clone(item.Data).(*Person)
		opMerged := pdelta.Reduce(pdelta.Compound(item.Op1, item.Op2))
		if !compareProto(item.Reduced, opMerged) {
			t.Fatalf("reduce case %v: expected: %v (%v)\nfound: %v (%v)\n", item.Name, item.Reduced.Debug(), mustJsonPretty(item.Reduced), opMerged.Debug(), mustJsonPretty(opMerged))
		}
		if err := pdelta.Apply(item.Op1, data1); err != nil {
			t.Fatalf("reduce case %v: %v", item.Name, err)
		}
		if err := pdelta.Apply(item.Op2, data1); err != nil {
			t.Fatalf("reduce case %v: %v", item.Name, err)
		}
		if err := pdelta.Apply(opMerged, data2); err != nil {
			t.Fatalf("reduce case %v: %v", item.Name, err)
		}
		if !compareProto(data1, data2) {
			t.Fatalf("reduce case %v: op1: %v\nop2: %v\nreduced: %v\ndata: %v\nexpected: %v\nfound: %v\n", item.Name, item.Op1.Debug(), item.Op2.Debug(), opMerged.Debug(), mustJsonPretty(item.Data), mustJsonPretty(data1), mustJsonPretty(data2))
		}
	}
}

func TestRandomReduce(t *testing.T) {

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
	two := 0
	one := 0
	zero := 0
	var numWrite int
	for i := 0; i < 100000; i++ {

		pBefore := proto.Clone(p).(*Person)
		pAfterMerged := proto.Clone(p).(*Person)

		op1 := fuzzer.Get(p)
		if err := pdelta.Apply(op1, p); err != nil {
			t.Fatal(err)
		}

		op2 := fuzzer.Get(p)
		if err := pdelta.Apply(op2, p); err != nil {
			t.Fatal(err)
		}
		pAfterTwo := proto.Clone(p).(*Person)

		opMerged := pdelta.Reduce(pdelta.Compound(op1, op2))
		if err := pdelta.Apply(opMerged, pAfterMerged); err != nil {
			t.Fatal(err)
		}

		var writeThisItem bool
		if !pdelta.IsNull(op1) && !pdelta.IsNull(op2) {
			if pdelta.IsNull(opMerged) {
				writeThisItem = true
				zero++
			} else if len(opMerged.Flatten()) == 1 {
				writeThisItem = true
				one++
			} else if len(opMerged.Flatten()) == 2 {
				if rand.Float64() > 0.9 {
					// only emit 10% of the instances where the operations weren't merged because there's 10x as many
					writeThisItem = true
				}
				two++
			} else {
				panic("shouldn't get here")
			}
		}

		item := &ReduceTestItem{
			Name:    petname.Generate(3, "-"),
			Data:    pBefore,
			Op1:     op1,
			Op2:     op2,
			Reduced: opMerged,
		}
		b, err := protojson.Marshal(item)
		if err != nil {
			t.Fatal(err)
		}

		if !proto.Equal(pAfterTwo, pAfterMerged) {
			fmt.Println(string(b))
			t.Fatalf("op1: %v\nop2: %v\nmerged: %v\nbefore: %v\nwant: %v\ngot: %v\n", op1.Debug(), op2.Debug(), opMerged.Debug(), mustJsonPretty(pBefore), mustJsonPretty(pAfterTwo), mustJsonPretty(pAfterMerged))
		}

		if i%1000 == 0 {
			fmt.Printf("2: %d, 1: %d, 0: %d (write: %d)\n", two, one, zero, numWrite)
		}

		if writeThisItem {
			if numWrite > 0 {
				sbj.WriteString(",\n")
			}
			sbj.Write(b)
			numWrite++
		}
	}
	sbj.WriteString("]")
	if write {
		fmt.Println("numWrite: ", numWrite)
		if err := ioutil.WriteFile("../../cases_reduce_random.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}

func TestRandomApply(t *testing.T) {

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
	for i := 0; i < 15000; i++ {
		op := fuzzer.Get(p)
		if err := pdelta.Apply(op, p); err != nil {
			t.Fatal(err)
		}
		if i%1000 == 0 {
			s := mustJson(p)
			fmt.Println(len(s), s)
		}
		item := &ApplyTestItem{
			Name:     petname.Generate(3, "-"),
			Op:       op,
			Expected: proto.Clone(p).(*Person),
		}
		b, err := protojson.Marshal(item)
		if err != nil {
			t.Fatal(err)
		}
		if i > 0 {
			sbj.WriteString(",\n")
		}
		sbj.Write(b)
	}
	sbj.WriteString("]")
	if write {
		if err := ioutil.WriteFile("../../cases_apply_random.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}

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

func mustPerson(s string) *Person {
	value := &Person{}
	err := protojson.Unmarshal([]byte(s), value)
	if err != nil {
		panic(err)
	}
	return value
}
func mustOp(s string) *pdelta.Op {
	value := &pdelta.Op{}
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
