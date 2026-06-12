package pdelta_tests

import (
	"fmt"
	"math/rand"
	"sort"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests/pkg/pdelta_tests/fuzzer"
	"google.golang.org/protobuf/proto"
)

// TestFuzzerCoverage asserts that the fuzzer (in the same mixed random/adversarial mode used by
// TestRandomReduce) exercises every branch-relevant relationship class between op pairs. The transform and
// reduce pairing functions branch on these relationships, so a class that the fuzzer never generates is a
// class with zero random test coverage - this test turns that silent gap into a failure.
func TestFuzzerCoverage(t *testing.T) {
	const iterations = 30000

	counts := map[string]int{}
	shapes := map[string]int{}

	shape := func(op *pdelta.Op) string {
		b := pdelta.GetBehaviour(op)
		typ := map[pdelta.OpType]string{pdelta.EDIT: "Edit", pdelta.SET: "Set", pdelta.INSERT: "Insert", pdelta.MOVE: "Move", pdelta.DELETE: "Delete", pdelta.RENAME: "Rename"}[b.OpType]
		loc := map[pdelta.LocatorType]string{pdelta.FIELD: "Field", pdelta.INDEX: "Index", pdelta.KEY: "Key", pdelta.ONEOF: "Oneof"}[b.LocatorType]
		return typ + loc
	}

	eq := func(a, b []*pdelta.Locator) bool { return pdelta.TreeRelationship(a, b) == pdelta.TREE_EQUAL }

	p := &Person{Name: "a"}
	for i := 0; i < iterations; i++ {
		op1 := fuzzer.Get(p)
		if err := pdelta.Apply(op1, p); err != nil {
			t.Fatal(err)
		}
		var op2 *pdelta.Op
		if rand.Intn(2) == 0 {
			op2 = fuzzer.GetRelated(p, op1)
		} else {
			op2 = fuzzer.Get(p)
		}
		if err := pdelta.Apply(op2, p); err != nil {
			t.Fatal(err)
		}
		if pdelta.IsNull(op1) || pdelta.IsNull(op2) {
			continue
		}
		if proto.Size(p) > 10000 {
			p = &Person{Name: "a"}
		}

		shapes[shape(op1)]++
		shapes[shape(op2)]++

		b1, b2 := pdelta.GetBehaviour(op1), pdelta.GetBehaviour(op2)

		switch pdelta.TreeRelationship(op1.Location, op2.Location) {
		case pdelta.TREE_EQUAL:
			counts["loc-loc:equal"]++
		case pdelta.TREE_ANCESTOR:
			counts["loc-loc:ancestor"]++
		case pdelta.TREE_DESCENDENT:
			counts["loc-loc:descendent"]++
		}
		if b2.ValueIsLocation && eq(op1.Location, op2.To()) {
			counts["loc1-to2:equal"]++
			if op1.Type == pdelta.Op_Rename && op2.Type == pdelta.Op_Rename && eq(op1.To(), op2.Location) {
				counts["rename-round-trip"]++
			}
		}
		if b1.ValueIsLocation && eq(op1.To(), op2.Location) {
			counts["to1-loc2:equal"]++
		}
		if b1.ValueIsLocation && b2.ValueIsLocation && eq(op1.To(), op2.To()) {
			counts["to-to:equal"]++
		}
		if len(op1.Location) > 0 && len(op2.Location) > 0 {
			if pdelta.TreeRelationship(op1.Parent(), op2.Parent()) == pdelta.TREE_EQUAL && !eq(op1.Location, op2.Location) {
				counts["same-collection"]++
				if op1.Type == pdelta.Op_Move && op2.Type == pdelta.Op_Move {
					counts["move-move-same-list"]++
				}
				if op1.Type == pdelta.Op_Insert && op2.Type == pdelta.Op_Delete {
					counts["insert-delete-same-list"]++
				}
				if op1.Type == pdelta.Op_Move && op2.Type == pdelta.Op_Insert {
					counts["move-insert-same-list"]++
				}
			}
			if pdelta.TreeRelationship(op1.Parent(), op2.Location) == pdelta.TREE_ANCESTOR && len(op2.Location) > len(op1.Location) {
				counts["op2-through-op1-collection"]++
				if b1.IndexShifter != nil {
					counts["op2-through-op1-shifted-list"]++
				}
			}
			if pdelta.TreeRelationship(op2.Parent(), op1.Location) == pdelta.TREE_ANCESTOR && len(op1.Location) > len(op2.Location) {
				counts["op1-through-op2-collection"]++
			}
		}
	}

	var keys []string
	for k := range counts {
		keys = append(keys, k)
	}
	sort.Strings(keys)
	for _, k := range keys {
		fmt.Printf("%8d  %s\n", counts[k], k)
	}
	fmt.Printf("shapes: %d distinct\n", len(shapes))

	// Every op shape must appear.
	if len(shapes) != 13 {
		t.Errorf("expected 13 distinct op shapes, found %d: %v", len(shapes), shapes)
	}

	// Every branch-relevant relationship class must be exercised a healthy number of times. The thresholds are
	// set far below the observed rates, so a failure here means the fuzzer's distribution has collapsed, not
	// that it had an unlucky run.
	minimums := map[string]int{
		"loc-loc:equal":                100,
		"loc-loc:ancestor":             100,
		"loc-loc:descendent":           100,
		"loc1-to2:equal":               20,
		"to1-loc2:equal":               20,
		"to-to:equal":                  8,
		"rename-round-trip":            5,
		"same-collection":              100,
		"move-move-same-list":          8,
		"insert-delete-same-list":      5,
		"move-insert-same-list":        5,
		"op2-through-op1-collection":   20,
		"op2-through-op1-shifted-list": 5,
		"op1-through-op2-collection":   20,
	}
	for class, min := range minimums {
		if counts[class] < min {
			t.Errorf("relationship class %q: %d hits, expected at least %d", class, counts[class], min)
		}
	}
}
