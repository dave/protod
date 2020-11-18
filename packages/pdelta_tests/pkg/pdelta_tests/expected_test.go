package pdelta_tests

import (
	"fmt"
	"testing"

	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

// EditEditIndex
func TestTransformEditEditIndex(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listI := []string{"0", "1", "2", "3"}
	data := &Person{Alias: listD}
	var result string
	for editA := range listI {
		for editB := range listI {
			opA := Op().Person().Alias().Index(editA).Edit(listD[editA], "X")
			opB := Op().Person().Alias().Index(editB).Edit(listD[editB], "Y")
			descA := fmt.Sprintf("edit%d", editA)
			descB := fmt.Sprintf("edit%d", editB)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
		}
	}
	compareResults(t, result, expectedTestTransformEditEditIndex)
}

// EditSetIndex
func TestTransformEditSetIndex(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listI := []string{"0", "1", "2", "3"}
	data := &Person{Alias: listD}
	var result string
	for edit := range listI {
		for set := range listI {
			opA := Op().Person().Alias().Index(edit).Edit(listD[edit], "X")
			opB := Op().Person().Alias().Index(set).Set("Y")
			descA := fmt.Sprintf("edit%d", edit)
			descB := fmt.Sprintf("set%d", set)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformEditSetIndex)
}

// EditDeleteIndex
func TestTransformEditDeleteIndex(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listX := []string{"0", "1", "2", "3"}
	data := &Person{Alias: listD}
	var result string
	for edit := range listX {
		for del := range listX {
			opA := Op().Person().Alias().Index(edit).Edit(listD[edit], "X")
			opB := Op().Person().Alias().Index(del).Delete()
			descA := fmt.Sprintf("edit%d", edit)
			descB := fmt.Sprintf("del%d", del)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformEditDeleteIndex)
}

// SetSetIndex
func TestTransformSetSetIndex(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listX := []string{"0", "1", "2", "3"}
	data := &Person{Alias: listD}
	var result string
	for setA := range listX {
		for setB := range listX {
			opA := Op().Person().Alias().Index(setA).Set("X")
			opB := Op().Person().Alias().Index(setB).Set("Y")
			descA := fmt.Sprintf("set%d", setA)
			descB := fmt.Sprintf("set%d", setB)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
		}
	}
	compareResults(t, result, expectedTestTransformSetSetIndex)
}

// EditInsert
func TestTransformEditInsert(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listE := []string{"0", "1", "2", "3"}
	listI := []string{"0", "1", "2", "3", "4"}
	data := &Person{Alias: listD}
	var result string
	for edit := range listE {
		for ins := range listI {
			opA := Op().Person().Alias().Index(edit).Edit(listD[edit], "X")
			opB := Op().Person().Alias().Insert(ins, "Y")
			descA := fmt.Sprintf("edit%d", edit)
			descB := fmt.Sprintf("ins%d", ins)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformEditInsert)
}

// SetInsert
func TestTransformSetInsert(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listX := []string{"0", "1", "2", "3"}
	listI := []string{"0", "1", "2", "3", "4"}
	data := &Person{Alias: listD}
	var result string
	for set := range listX {
		for ins := range listI {
			opA := Op().Person().Alias().Index(set).Set("X")
			opB := Op().Person().Alias().Insert(ins, "Y")
			descA := fmt.Sprintf("set%d", set)
			descB := fmt.Sprintf("ins%d", ins)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformSetInsert)
}

// SetDeleteIndex
func TestTransformSetDeleteIndex(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listX := []string{"0", "1", "2", "3"}
	data := &Person{Alias: listD}
	var result string
	for set := range listX {
		for del := range listX {
			opA := Op().Person().Alias().Index(set).Set("X")
			opB := Op().Person().Alias().Index(del).Delete()
			descA := fmt.Sprintf("set%d", set)
			descB := fmt.Sprintf("del%d", del)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformSetDeleteIndex)
}

// InsertDelete
func TestTransformInsertDelete(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listX := []string{"0", "1", "2", "3"}
	listI := []string{"0", "1", "2", "3", "4"}
	data := &Person{Alias: listD}
	var result string
	for ins := range listI {
		for del := range listX {
			opA := Op().Person().Alias().Insert(ins, "X")
			opB := Op().Person().Alias().Index(del).Delete()
			descA := fmt.Sprintf("ins%d", ins)
			descB := fmt.Sprintf("del%d", del)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformInsertDelete)
}

// DeleteDeleteIndex
func TestTransformDeleteDeleteIndex(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listX := []string{"0", "1", "2", "3"}
	data := &Person{Alias: listD}
	var result string
	for delA := range listX {
		for delB := range listX {
			opA := Op().Person().Alias().Index(delA).Delete()
			opB := Op().Person().Alias().Index(delB).Delete()
			descA := fmt.Sprintf("del%d", delA)
			descB := fmt.Sprintf("del%d", delB)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
		}
	}
	compareResults(t, result, expectedTestTransformDeleteDeleteIndex)
}

// MoveMove
func TestTransformMoveMove(t *testing.T) {
	listD := []string{"a", "b", "c", "d", "e", "f", "g"}
	listT := []string{"0", "1", "2", "3", "4", "5", "6", "7"}
	listF := []string{"0", "1", "2", "3", "4", "5", "6"}
	data := &Person{Alias: listD}
	var result string
	for fromA := range listF {
		for toA := range listT {
			for fromB := range listF {
				for toB := range listT {
					opA := Op().Person().Alias().Move(fromA, toA)
					opB := Op().Person().Alias().Move(fromB, toB)
					descA := fmt.Sprintf("%d->%d", fromA, toA)
					descB := fmt.Sprintf("%d->%d", fromB, toB)
					result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				}
			}
		}
	}
	compareResults(t, result, expectedTestTransformMoveMove)
}

// MoveInsert
func TestTransformMoveInsert(t *testing.T) {
	listD := []string{"a", "b", "c", "d", "e"}
	listT := []string{"0", "1", "2", "3", "4", "5"}
	listF := []string{"0", "1", "2", "3", "4"}
	listI := []string{"0", "1", "2", "3", "4", "5"}
	data := &Person{Alias: listD}
	var result string
	for from := range listF {
		for to := range listT {
			for ins := range listI {
				opA := Op().Person().Alias().Move(from, to)
				opB := Op().Person().Alias().Insert(ins, "X")
				descA := fmt.Sprintf("%d->%d", from, to)
				descB := fmt.Sprintf("ins%d", ins)
				result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
			}
		}
	}
	compareResults(t, result, expectedTestTransformMoveInsert)
}

// InsertInsert
func TestTransformInsertInsert(t *testing.T) {
	listD := []string{"a", "b", "c", "d"}
	listI := []string{"0", "1", "2", "3", "4"}
	data := &Person{Alias: listD}
	var result string
	for insA := range listI {
		for insB := range listI {
			opA := Op().Person().Alias().Insert(insA, "X")
			opB := Op().Person().Alias().Insert(insB, "Y")
			descA := fmt.Sprintf("ins%d", insA)
			descB := fmt.Sprintf("ins%d", insB)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
		}
	}
	compareResults(t, result, expectedTestTransformInsertInsert)
}

// MoveDelete
func TestTransformMoveDelete(t *testing.T) {
	listD := []string{"a", "b", "c", "d", "e", "f", "g"}
	listT := []string{"0", "1", "2", "3", "4", "5", "6", "7"}
	listF := []string{"0", "1", "2", "3", "4", "5", "6"}
	listX := []string{"0", "1", "2", "3", "4", "5", "6"}
	data := &Person{Alias: listD}
	var result string
	for from := range listF {
		for to := range listT {
			for del := range listX {
				opA := Op().Person().Alias().Index(del).Delete()
				opB := Op().Person().Alias().Move(from, to)
				descA := fmt.Sprintf("del%d", del)
				descB := fmt.Sprintf("%d->%d", from, to)
				result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
			}
		}
	}
	compareResults(t, result, expectedTestTransformMoveDelete)
}

// SetMove
func TestTransformMoveSet(t *testing.T) {
	listD := []string{"a", "b", "c", "d", "e", "f", "g"}
	listT := []string{"0", "1", "2", "3", "4", "5", "6", "7"}
	listF := []string{"0", "1", "2", "3", "4", "5", "6"}
	listS := []string{"0", "1", "2", "3", "4", "5", "6"}
	data := &Person{Alias: listD}
	var result string
	for from := range listF {
		for to := range listT {
			for set := range listS {
				opA := Op().Person().Alias().Index(set).Set("X")
				opB := Op().Person().Alias().Move(from, to)
				descA := fmt.Sprintf("set%d", set)
				descB := fmt.Sprintf("%d->%d", from, to)
				result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
			}
		}
	}
	compareResults(t, result, expectedTestTransformMoveSet)
}

// EditMove
func TestTransformMoveEdit(t *testing.T) {
	listD := []string{"a", "b", "c", "d", "e", "f", "g"}
	listT := []string{"0", "1", "2", "3", "4", "5", "6", "7"}
	listF := []string{"0", "1", "2", "3", "4", "5", "6"}
	listS := []string{"0", "1", "2", "3", "4", "5", "6"}
	data := &Person{Alias: listD}
	var result string
	for from := range listF {
		for to := range listT {
			for set := range listS {
				opA := Op().Person().Alias().Index(set).Edit(listD[set], "X")
				opB := Op().Person().Alias().Move(from, to)
				descA := fmt.Sprintf("edit%d", set)
				descB := fmt.Sprintf("%d->%d", from, to)
				result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
			}
		}
	}
	compareResults(t, result, expectedTestTransformMoveEdit)
}

// RenameRename
func TestTransformRenameRename(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d", 4: "e", 5: "f"}
	values := []string{"0", "1", "2", "3", "4", "5"}
	data := &Company{Flags: mapD}
	var result string
	for fromA := range values {
		for toA := range values {
			for fromB := range values {
				for toB := range values {
					opA := Op().Company().Flags().Rename(fromA, toA)
					opB := Op().Company().Flags().Rename(fromB, toB)
					descA := fmt.Sprintf("%d->%d", fromA, toA)
					descB := fmt.Sprintf("%d->%d", fromB, toB)
					result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				}
			}
		}
	}
	compareResults(t, result, expectedTestTransformRenameRename)
}

// EditEditKey
func TestTransformEditEditKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	values := []string{"0", "1", "2", "3"}
	data := &Company{Flags: mapD}
	var result string
	for editA := range values {
		for editB := range values {
			opA := Op().Company().Flags().Key(editA).Edit(mapD[int64(editA)], "X")
			opB := Op().Company().Flags().Key(editB).Edit(mapD[int64(editB)], "Y")
			descA := fmt.Sprintf("edit%d", editA)
			descB := fmt.Sprintf("edit%d", editB)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
		}
	}
	compareResults(t, result, expectedTestTransformEditEditKey)
}

// EditSetKey
func TestTransformEditSetKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	values := []string{"0", "1", "2", "3"}
	data := &Company{Flags: mapD}
	var result string
	for edit := range values {
		for set := range values {
			opA := Op().Company().Flags().Key(edit).Edit(mapD[int64(edit)], "X")
			opB := Op().Company().Flags().Key(set).Set("Y")
			descA := fmt.Sprintf("edit%d", edit)
			descB := fmt.Sprintf("set%d", set)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformEditSetKey)
}

// EditDeleteKey
func TestTransformEditDeleteKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	values := []string{"0", "1", "2", "3"}
	data := &Company{Flags: mapD}
	var result string
	for edit := range values {
		for del := range values {
			opA := Op().Company().Flags().Key(edit).Edit(mapD[int64(edit)], "X")
			opB := Op().Company().Flags().Key(del).Delete()
			descA := fmt.Sprintf("edit%d", edit)
			descB := fmt.Sprintf("del%d", del)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformEditDeleteKey)
}

// EditRename
func TestTransformEditRenameKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	editV := []string{"0", "1", "2", "3"}
	renameF := []string{"0", "1", "2", "3"}
	renameT := []string{"0", "1", "2", "3", "4", "5"}
	data := &Company{Flags: mapD}
	var result string
	for edit := range editV {
		for from := range renameF {
			for to := range renameT {
				opA := Op().Company().Flags().Key(edit).Edit(mapD[int64(edit)], "X")
				opB := Op().Company().Flags().Rename(from, to)
				descA := fmt.Sprintf("edit%d", edit)
				descB := fmt.Sprintf("%d->%d", from, to)
				result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
			}
		}
	}
	compareResults(t, result, expectedTestTransformEditRenameKey)
}

// SetRename
func TestTransformSetRenameKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	setV := []string{"0", "1", "2", "3"}
	renameF := []string{"0", "1", "2", "3"}
	renameT := []string{"0", "1", "2", "3", "4", "5"}
	data := &Company{Flags: mapD}
	var result string
	for set := range setV {
		for from := range renameF {
			for to := range renameT {
				opA := Op().Company().Flags().Key(set).Set("X")
				opB := Op().Company().Flags().Rename(from, to)
				descA := fmt.Sprintf("set%d", set)
				descB := fmt.Sprintf("%d->%d", from, to)
				result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
			}
		}
	}
	compareResults(t, result, expectedTestTransformSetRenameKey)
}

// RenameDelete
func TestTransformRenameDelete(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	delV := []string{"0", "1", "2", "3"}
	renameF := []string{"0", "1", "2", "3"}
	renameT := []string{"0", "1", "2", "3", "4", "5"}
	data := &Company{Flags: mapD}
	var result string
	for del := range delV {
		for from := range renameF {
			for to := range renameT {
				opA := Op().Company().Flags().Key(del).Delete()
				opB := Op().Company().Flags().Rename(from, to)
				descA := fmt.Sprintf("del%d", del)
				descB := fmt.Sprintf("%d->%d", from, to)
				result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
				result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
			}
		}
	}
	compareResults(t, result, expectedTestTransformRenameDelete)
}

// SetSetKey
func TestTransformSetSetKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	setV := []string{"0", "1", "2", "3"}
	data := &Company{Flags: mapD}
	var result string
	for setA := range setV {
		for setB := range setV {
			opA := Op().Company().Flags().Key(setA).Set("X")
			opB := Op().Company().Flags().Key(setB).Set("Y")
			descA := fmt.Sprintf("set%d", setA)
			descB := fmt.Sprintf("set%d", setB)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
		}
	}
	compareResults(t, result, expectedTestTransformSetSetKey)
}

// SetDeleteKey
func TestTransformSetDeleteKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	values := []string{"0", "1", "2", "3"}
	data := &Company{Flags: mapD}
	var result string
	for set := range values {
		for del := range values {
			opA := Op().Company().Flags().Key(set).Set("X")
			opB := Op().Company().Flags().Key(del).Delete()
			descA := fmt.Sprintf("set%d", set)
			descB := fmt.Sprintf("del%d", del)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
			result += testTwoOpsConverge(t, opB, opA, descB, descA, data)
		}
	}
	compareResults(t, result, expectedTestTransformSetDeleteKey)
}

// DeleteDeleteKey
func TestTransformDeleteDeleteKey(t *testing.T) {
	mapD := map[int64]string{0: "a", 1: "b", 2: "c", 3: "d"}
	values := []string{"0", "1", "2", "3"}
	data := &Company{Flags: mapD}
	var result string
	for delA := range values {
		for delB := range values {
			opA := Op().Company().Flags().Key(delA).Delete()
			opB := Op().Company().Flags().Key(delB).Delete()
			descA := fmt.Sprintf("del%d", delA)
			descB := fmt.Sprintf("del%d", delB)
			result += testTwoOpsConverge(t, opA, opB, descA, descB, data)
		}
	}
	compareResults(t, result, expectedTestTransformDeleteDeleteKey)
}

func testTwoOpsConverge(t *testing.T, opA, opB *pdelta.Op, descA, descB string, data proto.Message) string {
	// opA has priority
	opAxpA, opBxpA, err := pdelta.Transform(opA, opB, true)
	if err != nil {
		t.Fatal(err)
	}

	// opB has priority
	opAxpB, opBxpB, err := pdelta.Transform(opA, opB, false)
	if err != nil {
		t.Fatal(err)
	}

	dataApA := proto.Clone(data)
	if err := pdelta.Apply(opA, dataApA); err != nil {
		t.Fatal(err)
	}
	if err := pdelta.Apply(opBxpA, dataApA); err != nil {
		t.Fatal(err)
	}

	dataBpA := proto.Clone(data)
	if err := pdelta.Apply(opB, dataBpA); err != nil {
		t.Fatal(err)
	}
	if err := pdelta.Apply(opAxpA, dataBpA); err != nil {
		t.Fatal(err)
	}

	dataApB := proto.Clone(data)
	if err := pdelta.Apply(opA, dataApB); err != nil {
		t.Fatal(err)
	}
	if err := pdelta.Apply(opBxpB, dataApB); err != nil {
		t.Fatal(err)
	}

	dataBpB := proto.Clone(data)
	if err := pdelta.Apply(opB, dataBpB); err != nil {
		t.Fatal(err)
	}
	if err := pdelta.Apply(opAxpB, dataBpB); err != nil {
		t.Fatal(err)
	}

	resultApA, err := protojson.Marshal(dataApA)
	if err != nil {
		t.Fatal(err)
	}

	resultApB, err := protojson.Marshal(dataApB)
	if err != nil {
		t.Fatal(err)
	}

	resultBpA, err := protojson.Marshal(dataBpA)
	if err != nil {
		t.Fatal(err)
	}

	resultBpB, err := protojson.Marshal(dataBpB)
	if err != nil {
		t.Fatal(err)
	}

	if !compareJson(string(resultApA), string(resultBpA)) {
		t.Fatalf("\nA: %s\nB: %s\npriority: A\nresult-A-Bx: %s\nresult-B-Ax: %s\n", descA, descB, resultApA, resultBpA)
	}

	if !compareJson(string(resultApB), string(resultBpB)) {
		t.Fatalf("\nA: %s\nB: %s\npriority: B\nresult-A-Bx: %s\nresult-B-Ax: %s\n", descA, descB, resultApB, resultBpB)
	}

	var printer func(proto.Message) string
	switch data.(type) {
	case *Person:
		printer = printAlias
	case *Company:
		printer = printFlags
	default:
		panic("")
	}
	var out string
	out += fmt.Sprintf("%s* %s : %s\n", descA, descB, printer(dataApA))
	out += fmt.Sprintf("%s  %s*: %s\n", descA, descB, printer(dataApB))
	return out
}
