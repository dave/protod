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
	//cases := []string{`{"name":"rapidly-great-pika","data":{"company":{"ceo":{"cases":{"JK45F":{"name":"Dy5na"}},"typeMap":{"1AbDD":"Bravo"}}},"typeList":["Bravo","Alpha"],"typeMap":{"daxNh":"Alpha"},"embedded":{"name":"6DC7G"},"dbl":724,"house":{"name":"nXCdC","number":849},"double":{"name":"4n3ZG","bar":"O6pYe"}},"op":{"type":"Compound","ops":[{"type":"Delete"},{"type":"Set","location":[{"field":{"name":"typeMap","number":9,"messageFullName":"pdelta_tests.Person"}},{"key":{"string":"TrYkn"}}],"scalar":{"enum":3}}]},"reduced":{"type":"Compound","ops":[{"type":"Set","location":[{"field":{"name":"typeMap","number":9,"messageFullName":"pdelta_tests.Person"}},{"key":{"string":"TrYkn"}}],"scalar":{"enum":3}},{"type":"Delete"}]}}`}
	for _, caseJson := range cases {
		caseJson = strings.TrimPrefix(caseJson, "[")
		caseJson = strings.TrimSuffix(caseJson, "]")
		caseJson = strings.TrimSuffix(caseJson, ",")
		item := &ReduceTestCase{}
		if err := protojson.Unmarshal([]byte(caseJson), item); err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		runReduceCase(t, item)
	}
}

func TestRandomSingleCase(t *testing.T) {
	cases := []string{
		`{"name":"wildly-bursting-deer","data":{"cases":{"DCOnm":{"name":"5Q1gQ"},"eCrFK":{"name":"4l8xr","flags":{"244":"BaWEt"}}},"company":{"revenue":-448,"flags":{"-267":"18b1A"}},"alias":["MDbR4","Lrt6l","DC8Kt","91Kyg"],"typeList":["Alpha","Alpha"],"typeMap":{"dxCxu":"Charlie"},"embedded":{},"house":{},"shirt":{"designer":"t1BIC"},"pants":{"waist":197},"double":{"name":"qzFvT"}},"op":{"type":"Compound","ops":[{"type":"Insert","location":[{"field":{"name":"alias","number":6,"messageFullName":"pdelta_tests.Person"}},{"index":"0"}],"scalar":{"string":"JWm9u"}},{"type":"Move","location":[{"field":{"name":"alias","number":6,"messageFullName":"pdelta_tests.Person"}},{"index":"1"}],"index":"5"}]},"reduced":{"type":"Compound","ops":[{"type":"Move","location":[{"field":{"name":"alias","number":6,"messageFullName":"pdelta_tests.Person"}},{"index":"0"}],"index":"4"},{"type":"Insert","location":[{"field":{"name":"alias","number":6,"messageFullName":"pdelta_tests.Person"}},{"index":"0"}],"scalar":{"string":"JWm9u"}}]}}`,
		//`{"name":"sadly-moral-alien","data":{"name":"pJRxj","alias":["rQPFV","hyGCx","3vTMn"],"embedded":{},"cas":{},"pants":{"waist":859}},"op":{"type":"Compound","ops":[{"type":"Move","location":[{"field":{"name":"alias","number":6,"messageFullName":"pdelta_tests.Person"}},{"index":"0"}],"index":"3"},{"type":"Move","location":[{"field":{"name":"alias","number":6,"messageFullName":"pdelta_tests.Person"}},{"index":"1"}],"index":"3"}]},"reduced":{"type":"Move","location":[{"field":{"name":"alias","number":6,"messageFullName":"pdelta_tests.Person"}},{"index":"0"}],"index":"3"}}`,
	}
	for _, caseJson := range cases {
		caseJson = strings.TrimPrefix(caseJson, "[")
		caseJson = strings.TrimSuffix(caseJson, "]")
		caseJson = strings.TrimSuffix(caseJson, ",")
		item := &ReduceTestCase{}
		if err := protojson.Unmarshal([]byte(caseJson), item); err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		runReduceCase(t, item)
	}
}

func TestRandomMultiReduce(t *testing.T) {
	p := &Person{Name: "a"}
	for i := 0; i < 20000; i++ {
		pBefore := proto.Clone(p).(*Person)
		pAfterMerged := proto.Clone(p).(*Person)
		numOps := 3 + i%4
		var ops []*pdelta.Op
		for j := 0; j < numOps; j++ {
			op := fuzzer.Get(p)
			if err := pdelta.Apply(op, p); err != nil {
				t.Fatal(err)
			}
			ops = append(ops, op)
		}
		compound := pdelta.Compound(ops...)
		opMerged := pdelta.Reduce(compound)
		if err := pdelta.Apply(opMerged, pAfterMerged); err != nil {
			t.Fatalf("error applying merged operation: %v\n\nop: %v\nmerged: %v\ndata: %v", err, compound.Debug(), opMerged.Debug(), mustJson(pBefore))
		}
		if !compareProto(p, pAfterMerged) {
			t.Fatalf("applying merged operation does not converge:\nop: %v\nmerged: %v\ndata: %v\nexpected: %v\nfound: %v", compound.Debug(), opMerged.Debug(), mustJson(pBefore), mustJson(p), mustJson(pAfterMerged))
		}
	}
}

func TestRandomReduce(t *testing.T) {

	const run = true
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

		opMerged := pdelta.Reduce(pdelta.Compound(op1, op2))
		if err := pdelta.Apply(opMerged, pAfterMerged); err != nil {
			t.Fatal(fmt.Sprintf("error applying merged operation: %v\n\nop1: %v\nop2: %v,\nmerged: %v\ndata: %v", err, op1.Debug(), op2.Debug(), opMerged.Debug(), mustJson(pAfterMerged)))
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
			Op:      pdelta.Compound(op1, op2),
			Reduced: opMerged,
		}

		runReduceCase(t, item)

		b, err := protojson.Marshal(item)
		if err != nil {
			t.Fatal(err)
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
