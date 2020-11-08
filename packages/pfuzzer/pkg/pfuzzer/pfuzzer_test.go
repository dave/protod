package pfuzzer

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"reflect"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestSingle(t *testing.T) {
	p := mustPerson(`{"name":"a","cases":{"Cr2XdBjb3UcylPTJ6EU5":{"name":"MGAlPoo2h5yGPSG06GJB"}},"company":{"flags":{"-872":"gYacSXXsUH2gs3nijFSA"},"ceo":{"cases":{"gPVX7vGHN8gM50w3Nd8C":{"name":"jIGLrc4toMyDFeNbH49C","items":[{"title":"BGVvSkLSHYkwqcOg9FOM"},{"title":"viEAyVWRxrVRbEBlmAHW"}],"flags":{"-57":"RnvYVzuWx9TwFBYiwqN6"}}},"company":{"ceo":{"name":"ahmyWZL0rvz9Xb4AkE1n"}}}}}`)
	op := mustOp(`{"type":"Insert","location":[{"field":{"name":"company","number":5}},{"field":{"name":"ceo","number":14}},{"field":{"name":"typeList","number":8}},{"index":"0"}],"scalar":{"enum":1}}`)
	if err := pdelta.Apply(op, p); err != nil {
		t.Fatal(err)
	}
}

func TestRandomApplyCases(t *testing.T) {
	cases := strings.Split(RANDOM_CASES, "\n")
	p := &pdelta_tests.Person{Name: "a"}
	for _, caseJson := range cases {
		item := &pdelta_tests.RandomTestItem{}
		before := proto.Clone(p).(*pdelta_tests.Person)
		err := protojson.Unmarshal([]byte(caseJson), item)
		if err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		if err := pdelta.Apply(item.Op, p); err != nil {
			t.Fatal(err)
		}
		if !compareProto(item.Expected, p) {
			input, err := protojson.Marshal(before)
			if err != nil {
				t.Fatal(err)
			}
			t.Fatalf("input: %s\nop: %s\nexpected: %s\nresult:%s", string(input), item.Op.Debug(), mustJson(item.Expected), mustJson(p))
		}
		//fmt.Printf("input: %s\nop: %s\nexpected: %s\nresult:%s\n\n", string(input), item.Op.Debug(), string(expcted), string(result))
	}
}

func TestRandomReduceCases(t *testing.T) {
	cases := strings.Split(RANDOM_REDUCE_CASES, "\n")
	//cases := []string{`{"data":{"age":667, "embedded":{}}, "op1":{"type":"Set", "location":[{"field":{"name":"company", "number":5}}], "message":{"@type":"type.googleapis.com/pdelta_tests.Company", "name":"HLBKf"}}, "op2":{"type":"Set", "location":[{"field":{"name":"company", "number":5}}, {"field":{"name":"flags", "number":13}}, {"key":{"int64":"-816"}}], "scalar":{"string":"og4Zf"}}, "reduced":{"type":"Compound", "ops":[{"type":"Set", "location":[{"field":{"name":"company", "number":5}}], "message":{"@type":"type.googleapis.com/pdelta_tests.Company", "name":"HLBKf"}}, {"type":"Set", "location":[{"field":{"name":"company", "number":5}}, {"field":{"name":"flags", "number":13}}, {"key":{"int64":"-816"}}], "scalar":{"string":"og4Zf"}}]}}`}
	for _, caseJson := range cases {
		item := &pdelta_tests.ReduceTestItem{}
		if err := protojson.Unmarshal([]byte(caseJson), item); err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		data1 := proto.Clone(item.Data).(*pdelta_tests.Person)
		data2 := proto.Clone(item.Data).(*pdelta_tests.Person)
		opMerged := pdelta.Reduce(pdelta.Compound(item.Op1, item.Op2))
		if !compareProto(item.Reduced, opMerged) {
			t.Fatalf("\nexpected: %v (%v)\nfound: %v (%v)\n", item.Reduced.Debug(), mustJson(item.Reduced), opMerged.Debug(), mustJson(opMerged))
		}
		if err := pdelta.Apply(item.Op1, data1); err != nil {
			t.Fatal(err)
		}
		if err := pdelta.Apply(item.Op2, data1); err != nil {
			t.Fatal(err)
		}
		if err := pdelta.Apply(opMerged, data2); err != nil {
			t.Fatal(err)
		}
		if !compareProto(data1, data2) {
			t.Fatalf("op1: %v\nop2: %v\nreduced: %v\ndata: %v\nexpected: %v\nfound: %v\n", item.Op1.Debug(), item.Op2.Debug(), opMerged.Debug(), mustJson(item.Data), mustJson(data1), mustJson(data2))
		}
	}
}

//func TestRandomReduceSingle(t *testing.T) {
//
//	item := &pdelta_tests.ReduceTestItem{
//		Data: &pdelta_tests.Person{},
//		Op1:  pdelta_tests.Op().Person().Company().Ceo().Alias().Move(0, 2),
//		Op2:  pdelta_tests.Op().Person().Company().Ceo().Alias().Move(1, 0),
//	}
//
//	//item := &pdelta_tests.ReduceTestItem{}
//	//b := []byte(`{"data":{"name":"6TWQw","cases":{"3yhwR":{},"FAlaC":{"name":"fzYv5"},"Qsfke":{"flags":{"46":"qfCb5"}},"gD6EW":{"flags":{"-663":"dpsTI","0":"G9EXs"}},"kOj6n":{"name":"0ix48"}},"company":{"flags":{"-1018":"PU9F7"}},"alias":["AkTEc"],"type":"Bravo","typeList":["Alpha","Alpha"],"typeMap":{"xRPRd":"Charlie"},"embedded":{"name":"jriDW"},"dbl":-257},"op1":{"type":"Set","location":[{"oneof":{"name":"choice","fields":[{"name":"str","number":11},{"name":"dbl","number":12},{"name":"itm","number":13},{"name":"cas","number":14},{"name":"cho","number":15}]}},{"field":{"name":"cas","number":14}},{"field":{"name":"flags","number":23}}],"object":{"mapInt64":{"map":{"-587":{"scalar":{"string":"Zwn3Z"}},"415":{"scalar":{"string":"TlXIi"}}}}}},"op2":{"type":"Delete","location":[{"oneof":{"name":"choice","fields":[{"name":"str","number":11},{"name":"dbl","number":12},{"name":"itm","number":13},{"name":"cas","number":14},{"name":"cho","number":15}]}},{"field":{"name":"cas","number":14}}]}}`)
//	//if err := protojson.Unmarshal(b, item); err != nil {
//	//	t.Fatal(err)
//	//}
//
//	p := proto.Clone(item.Data).(*pdelta_tests.Person)
//	if err := pdelta.Apply(item.Op1, p); err != nil {
//		t.Fatal(err)
//	}
//	if err := pdelta.Apply(item.Op2, p); err != nil {
//		t.Fatal(err)
//	}
//	opMerged := pdelta.Reduce(pdelta.Compound(item.Op1, item.Op2))
//	p1 := proto.Clone(item.Data).(*pdelta_tests.Person)
//	if err := pdelta.Apply(opMerged, p1); err != nil {
//		t.Fatal(err)
//	}
//	if !proto.Equal(p, p1) {
//		t.Fatalf("op1: %v\nop2: %v\nmerged: %v\nbefore: %v\nwant: %v\ngot: %v\n", item.Op1.Debug(), item.Op2.Debug(), opMerged.Debug(), mustJson(item.Data), mustJson(p), mustJson(p1))
//	}
//}

func TestRandomReduce(t *testing.T) {

	const disabled = true
	if disabled {
		return
	}

	const write = false

	p := &pdelta_tests.Person{Name: "a"}
	var sbd, sbg strings.Builder
	if write {
		sbd.WriteString("const RANDOM_REDUCE_CASES = '''")
		sbg.WriteString("package pfuzzer\n\nconst RANDOM_REDUCE_CASES = `")
	}
	two := 0
	one := 0
	zero := 0
	for i := 0; i < 5000; i++ {

		pBefore := proto.Clone(p).(*pdelta_tests.Person)
		pAfterMerged := proto.Clone(p).(*pdelta_tests.Person)

		op1 := Get(p)
		if err := pdelta.Apply(op1, p); err != nil {
			t.Fatal(err)
		}

		op2 := Get(p)
		if err := pdelta.Apply(op2, p); err != nil {
			t.Fatal(err)
		}
		pAfterTwo := proto.Clone(p).(*pdelta_tests.Person)

		opMerged := pdelta.Reduce(pdelta.Compound(op1, op2))
		if err := pdelta.Apply(opMerged, pAfterMerged); err != nil {
			t.Fatal(err)
		}

		if !pdelta.IsNull(op1) && !pdelta.IsNull(op2) {
			if pdelta.IsNull(opMerged) {
				//fmt.Printf("op1: %v\nop2: %v\nmerged: %v\n", op1.Debug(), op2.Debug(), opMerged.Debug())
				zero++
			} else if len(opMerged.Flatten()) == 1 {
				one++
			} else if len(opMerged.Flatten()) == 2 {
				two++
			}
		}

		item := &pdelta_tests.ReduceTestItem{
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
			t.Fatalf("op1: %v\nop2: %v\nmerged: %v\nbefore: %v\nwant: %v\ngot: %v\n", op1.Debug(), op2.Debug(), opMerged.Debug(), mustJson(pBefore), mustJson(pAfterTwo), mustJson(pAfterMerged))
		}

		if i%1000 == 0 {
			fmt.Printf("2: %d, 1: %d, 0: %d (%d)\n", two, one, zero, len(b))
			//s := mustJson(p)
			//fmt.Println(len(s), s)
		}

		if write {
			if i > 0 {
				sbd.WriteString("\n")
				sbg.WriteString("\n")
			}
			sbd.Write(b)
			sbg.Write(b)
		}
	}
	if write {
		sbd.WriteString("''';")
		sbg.WriteString("`")
		if err := ioutil.WriteFile("../../../pdelta_tests/test/random_reduce_cases.dart", []byte(sbd.String()), 0666); err != nil {
			t.Fatal(err)
		}
		if err := ioutil.WriteFile("./cases_reduce_test.go", []byte(sbg.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}

func TestRandomApply(t *testing.T) {

	const disabled = true
	if disabled {
		return
	}

	p := &pdelta_tests.Person{Name: "a"}
	var sbd, sbg strings.Builder
	sbd.WriteString("const RANDOM_CASES = '''")
	sbg.WriteString("package pfuzzer\n\nconst RANDOM_CASES = `")
	for i := 0; i < 10000; i++ {
		op := Get(p)
		if err := pdelta.Apply(op, p); err != nil {
			t.Fatal(err)
		}
		if i%1000 == 0 {
			s := mustJson(p)
			fmt.Println(len(s), s)
		}
		item := &pdelta_tests.RandomTestItem{
			Op:       op,
			Expected: proto.Clone(p).(*pdelta_tests.Person),
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
	if err := ioutil.WriteFile("../../../pdelta_tests/test/random_cases.dart", []byte(sbd.String()), 0666); err != nil {
		t.Fatal(err)
	}
	if err := ioutil.WriteFile("./cases_test.go", []byte(sbg.String()), 0666); err != nil {
		t.Fatal(err)
	}
}

func TestRandomTransform(t *testing.T) {
	p := &pdelta_tests.Person{Name: "a"}
	for i := 0; i < 10000; i++ {

		//if i%1000 == 0 {
		//	fmt.Println(i)
		//}

		ops := List(p, 2)
		testTwoOpsConverge(t, ops[0], ops[1], p)

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

func mustPerson(s string) *pdelta_tests.Person {
	value := &pdelta_tests.Person{}
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

func testTwoOpsConverge(t *testing.T, opA, opB *pdelta.Op, data proto.Message) {

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
