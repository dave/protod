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
		if err := ioutil.WriteFile("../../assets/cases_apply_random.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}
