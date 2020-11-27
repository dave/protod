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

func TestRandomApplyCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../assets/cases_apply_random.json")
	if err != nil {
		t.Fatal(err)
	}
	cases := strings.Split(string(casesBytes), "\n")
	for _, caseJson := range cases {
		caseJson = strings.TrimPrefix(caseJson, "[")
		caseJson = strings.TrimSuffix(caseJson, "]")
		caseJson = strings.TrimSuffix(caseJson, ",")
		testCase := &ApplyTestCase{}
		err := protojson.Unmarshal([]byte(caseJson), testCase)
		if err != nil {
			t.Fatalf("unmarshaling %q: %+v", caseJson, err)
		}
		runApplyTest(t, testCase)
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
		before := proto.Clone(p).(*Person)
		op := fuzzer.Get(p)
		if err := pdelta.Apply(op, p); err != nil {
			t.Fatal(err)
		}
		if i%1000 == 0 {
			s := mustJson(p)
			fmt.Println(len(s), s)
		}
		item := &ApplyTestCase{
			Name:     petname.Generate(3, "-"),
			Op:       op,
			Data:     pdelta.MustMarshalAny(before),
			Expected: pdelta.MustMarshalAny(proto.Clone(p).(*Person)),
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
		if err := ioutil.WriteFile("../../assets/cases_apply_random.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}
