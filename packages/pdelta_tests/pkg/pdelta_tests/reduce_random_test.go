package pdelta_tests

import (
	"fmt"
	"io/ioutil"
	"math/rand"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/fuzzer"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/petname"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestRandomReduceCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../assets/cases_reduce_random.json")
	if err != nil {
		t.Fatal(err)
	}
	cases := strings.Split(string(casesBytes), "\n")
	//cases := []string{`...`}
	for _, caseJson := range cases {
		caseJson = strings.TrimPrefix(caseJson, "[")
		caseJson = strings.TrimSuffix(caseJson, "]")
		caseJson = strings.TrimSuffix(caseJson, ",")
		item := &ReduceTestCase{}
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

		item := &ReduceTestCase{
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
		if err := ioutil.WriteFile("../../assets/cases_reduce_random.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}
