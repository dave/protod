package pdelta_tests

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func TestShifterCases(t *testing.T) {
	casesBytes, err := ioutil.ReadFile("../../assets/cases_shifter_manual.json")
	if err != nil {
		t.Fatal(err)
	}
	caseStrings := strings.Split(string(casesBytes), "\n")
	for _, caseString := range caseStrings {
		caseString = strings.TrimPrefix(caseString, "[")
		caseString = strings.TrimSuffix(caseString, "]")
		caseString = strings.TrimSuffix(caseString, ",")
		var tc ShifterTestCase
		if err := protojson.Unmarshal([]byte(caseString), &tc); err != nil {
			t.Fatal(err)
		}
		runShifterCase(t, &tc)
	}
}

func TestShifter(t *testing.T) {

	const write = false

	var items []*ShifterTestCase

	for from := 0; from < 7; from++ {
		for to := 0; to < 7; to++ {
			op := Op().Person().Alias().Move(from, to)
			data1 := &Person{Alias: []string{"0", "1", "2", "3", "4", "5", "6", "7"}}
			data2 := proto.Clone(data1).(*Person)
			if err := pdelta.Apply(op, data2); err != nil {
				t.Fatal(err)
			}
			values := make([]int64, 8)
			locations := make([]int64, 8)
			for i, alias := range data2.Alias {
				origin, _ := strconv.Atoi(alias)
				destination := i
				values[origin] = int64(destination)
				if origin == from {
					if to < from {
						locations[origin] = int64(from + 1)
					} else {
						locations[origin] = int64(from)
					}
				} else {
					locations[origin] = int64(destination)
				}
			}
			item := &ShifterTestCase{
				Name:      fmt.Sprintf("MOVE_FROM_%d_TO_%d", from, to),
				Op:        op,
				Locations: locations,
				Values:    values,
			}
			items = append(items, item)
		}
	}

	var solo bool
	for _, item := range items {
		if item.Solo {
			solo = true
			break
		}
	}
	var sbj strings.Builder
	sbj.WriteString("[")
	for i, item := range items {
		if solo && !item.Solo {
			continue
		}

		b, err := protojson.Marshal(item)
		if err != nil {
			t.Fatal(err)
		}
		if i > 0 {
			sbj.WriteString(",\n")
		}
		sbj.Write(b)

		runShifterCase(t, item)

	}
	if solo {
		t.Fatal("solo")
	}
	sbj.WriteString("]")
	if write {
		if err := ioutil.WriteFile("../../assets/cases_shifter_manual.json", []byte(sbj.String()), 0666); err != nil {
			t.Fatal(err)
		}
	}
}

func runShifterCase(t *testing.T, item *ShifterTestCase) {

	valueShifterNormal := pdelta.Behaviours[pdelta.MOVE][pdelta.INDEX].IndexShifter(item.Op, pdelta.DISABLED, pdelta.NORMAL, pdelta.VALUE)
	valueShifterReverse := pdelta.Behaviours[pdelta.MOVE][pdelta.INDEX].IndexShifter(item.Op, pdelta.DISABLED, pdelta.REVERSE, pdelta.VALUE)
	locationShifterNormal := pdelta.Behaviours[pdelta.MOVE][pdelta.INDEX].IndexShifter(item.Op, pdelta.DISABLED, pdelta.NORMAL, pdelta.LOCATION)
	locationShifterReverse := pdelta.Behaviours[pdelta.MOVE][pdelta.INDEX].IndexShifter(item.Op, pdelta.DISABLED, pdelta.REVERSE, pdelta.LOCATION)

	for i := 0; i < 8; i++ {
		valueShifted, _ := valueShifterNormal(int64(i))
		if valueShifted != item.Values[i] {
			t.Fatalf("%s valueShifterNormal(%d) = %d, expected %d", item.Name, i, valueShifted, item.Values[i])
		}
		valueReverseShifted, _ := valueShifterReverse(item.Values[i])
		if valueReverseShifted != int64(i) {
			t.Fatalf("%s valueShifterReverse(%d) = %d, expected %d", item.Name, item.Values[i], valueReverseShifted, i)
		}
		locationShifted, _ := locationShifterNormal(int64(i))
		if locationShifted != item.Locations[i] {
			t.Fatalf("%s locationShifterNormal(%d) = %d, expected %d", item.Name, i, locationShifted, item.Locations[i])
		}
		if item.Locations[i] != item.Op.ItemIndex() && item.Locations[i] != item.Op.ItemIndex()+1 && item.Locations[i] != item.Op.ToIndex() {
			locationReverseShifted, _ := locationShifterReverse(item.Locations[i])
			if locationReverseShifted != int64(i) {
				t.Fatalf("%s locationShifterReverse(%d) = %d, expected %d", item.Name, item.Locations[i], locationReverseShifted, i)
			}
		}
	}
}
