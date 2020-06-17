package tests

import (
	"encoding/json"
	"fmt"
	"reflect"
	"sort"
	"strings"
	"testing"

	"github.com/dave/protod/delta"
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

func TestTransform(t *testing.T) {
	type itemType struct {
		solo      bool
		name      string
		op1       *delta.Op
		op2       *delta.Op
		data      proto.Message
		expected  proto.Message
		expected1 proto.Message
		expected2 proto.Message
	}
	items := []itemType{
		{
			name:     "delete_field_delete_field_independent",
			op1:      Op().Person().Name().Delete(),
			op2:      Op().Person().Age().Delete(),
			data:     &Person{Name: "a", Age: 10, Alias: []string{"b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "delete_field_delete_field",
			op1:      Op().Person().Name().Delete(),
			op2:      Op().Person().Name().Delete(),
			data:     &Person{Name: "a", Age: 10, Alias: []string{"b", "c"}},
			expected: &Person{Age: 10, Alias: []string{"b", "c"}},
		},
		{
			name:     "move_move_not_bug",              // a b c d e f
			op1:      Op().Person().Alias().Move(2, 6), // a b d e f c
			op2:      Op().Person().Alias().Move(1, 3), // a c b d e f
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e", "f"}},
			expected: &Person{Alias: []string{"a", "b", "d", "e", "f", "c"}},
		},
		{
			name:     "move_index_insert_index_backward_4", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(4, "x"), // a b c d x
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "c", "x"}},
		},
		{
			name:     "move_index_insert_index_backward_3", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(3, "x"), // a b c x d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "c", "x"}},
		},
		{
			name:     "move_index_insert_index_backward_2", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(2, "x"), // a b x c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "x", "c"}},
		},
		{
			name:      "move_index_insert_index_backward_1", // a b c d
			op1:       Op().Person().Alias().Move(3, 1),     // a d b c
			op2:       Op().Person().Alias().Insert(1, "x"), // a x b c d
			data:      &Person{Alias: []string{"a", "b", "c", "d"}},
			expected1: &Person{Alias: []string{"a", "d", "x", "b", "c"}},
			expected2: &Person{Alias: []string{"a", "x", "d", "b", "c"}},
		},
		{
			name:     "move_index_insert_index_backward_0", // a b c d
			op1:      Op().Person().Alias().Move(3, 1),     // a d b c
			op2:      Op().Person().Alias().Insert(0, "x"), // x a b c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "d", "b", "c"}},
		},
		{
			name:      "move_index_insert_index_forward_4",  // a b c d
			op1:       Op().Person().Alias().Move(1, 4),     // a c d b
			op2:       Op().Person().Alias().Insert(4, "x"), // a b c d x
			data:      &Person{Alias: []string{"a", "b", "c", "d"}},
			expected1: &Person{Alias: []string{"a", "c", "d", "b", "x"}},
			expected2: &Person{Alias: []string{"a", "c", "d", "x", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_3",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(3, "x"), // a b c x d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "c", "x", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_2",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(2, "x"), // a b x c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_1",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(1, "x"), // a x b c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_forward_0",  // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(0, "x"), // x a b c d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "c", "d", "b"}},
		},
		{
			name:     "move_index_insert_index_to",         // a b c d
			op1:      Op().Person().Alias().Move(1, 4),     // a c d b
			op2:      Op().Person().Alias().Insert(3, "x"), // a b c x d
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "c", "x", "d", "b"}},
		},
		{
			name:     "insert_index_move_index_from",
			op1:      Op().Person().Alias().Insert(1, "x"),
			op2:      Op().Person().Alias().Move(1, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "insert_index_move_index_independent_end_reverse",
			op1:      Op().Person().Alias().Insert(3, "x"),
			op2:      Op().Person().Alias().Move(2, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "c", "b", "x", "d"}},
		},
		{
			name:     "insert_index_move_index_independent_mid_reverse",
			op1:      Op().Person().Alias().Insert(2, "x"),
			op2:      Op().Person().Alias().Move(3, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "d", "b", "x", "c"}},
		},
		{
			name:     "insert_index_move_index_independent_before_reverse",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Move(2, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "c", "b", "d"}},
		},
		{
			name:      "insert_index_move_index_independent_end_forward", // a b c d
			op1:       Op().Person().Alias().Insert(3, "x"),              // a b c x d
			op2:       Op().Person().Alias().Move(1, 3),                  // a c b d
			data:      &Person{Alias: []string{"a", "b", "c", "d"}},
			expected1: &Person{Alias: []string{"a", "c", "x", "b", "d"}}, // a c b x d
			expected2: &Person{Alias: []string{"a", "c", "b", "x", "d"}}, // a c x b d
		},
		{
			name:     "insert_index_move_index_independent_mid_forward",
			op1:      Op().Person().Alias().Insert(2, "x"),
			op2:      Op().Person().Alias().Move(1, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "c", "d", "b"}},
		},
		{
			name:     "insert_index_move_index_independent_before_forward",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Move(1, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "c", "b", "d"}},
		},
		{
			name:     "insert_index_move_index_null",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Move(0, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c", "d"}},
		},
		{
			name:      "set_key_rename_key_to",
			op1:       Op().Company().Flags().Key(2).Set("x"),
			op2:       Op().Company().Flags().Rename(1, 2),
			data:      &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected1: &Company{Flags: map[int64]string{2: "x"}},
			expected2: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "set_key_rename_key_from",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Rename(1, 10),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{10: "x", 2: "b"}},
		},
		{
			name:     "set_key_rename_key_independent_ancestor",
			op1:      Op().Person().Cases().Key("a").Flags().Key(1).Set("x"),
			op2:      Op().Person().Cases().Rename("a", "y"),
			data:     &Person{Cases: map[string]*Case{"a": {Flags: map[int64]string{1: "a"}}}},
			expected: &Person{Cases: map[string]*Case{"y": {Flags: map[int64]string{1: "x"}}}},
		},
		{
			name:     "set_key_rename_key_independent",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Rename(2, 10),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 10: "b"}},
		},
		{
			name:     "set_key_rename_key_null",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Rename(1, 1),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "b"}},
		},
		{
			name:     "replace_index_move_index_independent",
			op1:      Op().Person().Alias().Index(1).Set("x"),
			op2:      Op().Person().Alias().Move(0, 3),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"x", "c", "a"}},
		},
		{
			name:     "replace_index_move_index_to",
			op1:      Op().Person().Alias().Index(1).Set("x"),
			op2:      Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "a"}},
		},
		{
			name:     "replace_index_move_index_from",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "replace_index_null_move_index_from",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Move(0, 1),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "b"}},
		},
		{
			name:      "replace_index_replace_index",
			op1:       Op().Person().Alias().Index(0).Set("x"),
			op2:       Op().Person().Alias().Index(0).Set("y"),
			data:      &Person{Alias: []string{"a", "b"}},
			expected1: &Person{Alias: []string{"x", "b"}},
			expected2: &Person{Alias: []string{"y", "b"}},
		},
		{
			name:      "replace_field_delete_field",
			op1:       Op().Company().Name().Set("b"),
			op2:       Op().Company().Name().Delete(),
			data:      &Company{Name: "a"},
			expected1: &Company{Name: "b"},
			expected2: &Company{},
		},
		{
			name:     "edit_key_delete_key",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Delete(),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "b"}},
		},
		{
			name:     "edit_key_move_key_null",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Rename(1, 1),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "b"}},
		},
		{
			name:     "edit_key_move_key_independent",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Rename(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 3: "b"}},
		},
		{
			name:     "edit_key_move_key_to",
			op1:      Op().Company().Flags().Key(2).Edit("b", "x"),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "a"}},
		},
		{
			name:     "edit_key_move_key_from",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{2: "x"}},
		},
		{
			name:     "edit_key_insert_key",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "y", 2: "b"}},
		},
		{
			name:     "edit_key_replace_key_independent",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(2).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "y"}},
		},
		{
			name:     "edit_key_replace_key",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "y", 2: "b"}},
		},
		{
			name:     "edit_key_edit_key_independent",
			op1:      Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:      Op().Company().Flags().Key(2).Edit("b", "y"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "y"}},
		},
		{
			name:      "edit_key_edit_key",
			op1:       Op().Company().Flags().Key(1).Edit("a", "x"),
			op2:       Op().Company().Flags().Key(1).Edit("a", "y"),
			data:      &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected1: &Company{Flags: map[int64]string{1: "xy", 2: "b"}},
			expected2: &Company{Flags: map[int64]string{1: "yx", 2: "b"}},
		},
		{
			name:     "edit_index_delete_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "edit_index_move_index_null",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Move(0, 0),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "b"}},
		},
		{
			name:     "edit_index_replace_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Index(0).Set("y"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"y", "b"}},
		},
		{
			name:     "edit_index_edit_index_independent",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Index(1).Edit("b", "y"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:      "edit_index_edit_index",
			op1:       Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:       Op().Person().Alias().Index(0).Edit("a", "y"),
			data:      &Person{Alias: []string{"a", "b"}},
			expected1: &Person{Alias: []string{"xy", "b"}},
			expected2: &Person{Alias: []string{"yx", "b"}},
		},
		{
			name:     "edit_field_delete_field",
			op1:      Op().Person().Name().Edit("a", "b"),
			op2:      Op().Person().Name().Delete(),
			data:     &Person{Name: "a"},
			expected: &Person{},
		},
		{
			name:     "edit_index_move_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "x"),
			op2:      Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_index_insert_index",
			op1:      Op().Person().Alias().Index(0).Edit("a", "b"),
			op2:      Op().Person().Alias().Insert(0, "x"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"x", "b"}},
		},
		{
			name:     "independent_operations_in_same_list",
			op1:      Op().Person().Alias().Move(4, 0),
			op2:      Op().Person().Alias().Move(1, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"e", "a", "c", "d", "b"}},
		},
		{
			name:     "ancestor_of_deleted_value",
			op1:      Op().Person().Cases().Key("a").Name().Set("x"),
			op2:      Op().Person().Cases().Rename("b", "a"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "b"}}},
		},
		{
			name:     "edit_delta_edit_equal",
			op1:      Op().Company().Name().Edit("a", "x"),
			op2:      Op().Company().Name().Set("y"),
			data:     &Company{Name: "a"},
			expected: &Company{Name: "y"},
		},
		{
			name:     "edit_delta_edit_independent",
			op1:      Op().Company().Name().Edit("a", "x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Name: "a", Flags: map[int64]string{1: "b"}},
			expected: &Company{Name: "x", Flags: map[int64]string{1: "y"}},
		},
		{
			name:     "edit_edit_independent",
			op1:      Op().Company().Name().Set("x"),
			op2:      Op().Company().Flags().Key(1).Set("y"),
			data:     &Company{Name: "a", Flags: map[int64]string{1: "b"}},
			expected: &Company{Name: "x", Flags: map[int64]string{1: "y"}},
		},
		{
			name:     "edit_insert_key_ancestor",
			op1:      Op().Company().Set(&Company{Flags: map[int64]string{10: "x"}}),
			op2:      Op().Company().Flags().Key(2).Set("b"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{10: "x"}},
		},
		{
			name:     "edit_insert_key",
			op1:      Op().Company().Flags().Key(1).Set("x"),
			op2:      Op().Company().Flags().Key(2).Set("y"),
			data:     &Company{Flags: map[int64]string{1: "a"}},
			expected: &Company{Flags: map[int64]string{1: "x", 2: "y"}},
		},
		{
			name:      "insert_key_edit_equal",
			op1:       Op().Company().Flags().Key(1).Set("y"),
			op2:       Op().Company().Flags().Key(1).Set("x"),
			data:      &Company{Flags: map[int64]string{1: "a"}},
			expected1: &Company{Flags: map[int64]string{1: "y"}},
			expected2: &Company{Flags: map[int64]string{1: "x"}},
		},
		{
			name:     "edit_insert_index_descendent",
			op1:      Op().Case().Items().Set([]*Item{{Title: "x"}}),
			op2:      Op().Case().Items().Index(0).Flags().Insert(0, "a"),
			data:     &Case{Items: []*Item{{Title: "a"}}},
			expected: &Case{Items: []*Item{{Title: "x"}}},
		},
		{
			name:     "edit_insert_index_ancestor",
			op1:      Op().Case().Items().Set([]*Item{{Title: "x"}}),
			op2:      Op().Case().Items().Insert(1, &Item{Title: "b"}),
			data:     &Case{Items: []*Item{{Title: "a"}}},
			expected: &Case{Items: []*Item{{Title: "x"}}},
		},
		{
			name:     "edit_insert_index_after",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Insert(1, "c"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "c", "b"}},
		},
		{
			name:     "edit_insert_index_before",
			op1:      Op().Person().Alias().Index(1).Set("x"),
			op2:      Op().Person().Alias().Insert(0, "c"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"c", "a", "x"}},
		},
		{
			name:     "edit_insert_index_equal",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_insert_conflict",
			op1:      Op().Person().Alias().Index(0).Set("x"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"b", "x"}},
		},
		{
			name:     "edit_insert",
			op1:      Op().Person().Alias().Set([]string{"x"}),
			op2:      Op().Person().Alias().Insert(3, "d"),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"x"}},
		},
		{
			name:     "move_edit_1",
			op1:      Op().Person().Alias().Move(0, 2),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "move_edit_2",
			op1:      Op().Company().Flags().Rename(2, 1),
			op2:      Op().Company().Flags().Key(1).Edit("a", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "b"}},
		},
		{
			name:     "chained_move_1",
			op1:      Op().Company().Flags().Rename(1, 2),
			op2:      Op().Company().Flags().Rename(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{3: "a"}},
		},
		{
			name:     "chained_move_1_reversed",
			op1:      Op().Company().Flags().Rename(2, 3),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{3: "a"}},
		},
		{
			name:     "chained_move_1a",
			op1:      Op().Company().Flags().Rename(1, 2),
			op2:      Op().Company().Flags().Rename(2, 3),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{3: "a"}},
		},
		{
			name:     "chained_move_3",
			op1:      Op().Company().Flags().Rename(2, 1),
			op2:      Op().Company().Flags().Rename(1, 2),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{}},
		},
		{
			name:     "conflicting_map_move_and_edit",
			op1:      Op().Company().Flags().Rename(2, 3),
			op2:      Op().Company().Flags().Key(2).Edit("b", "c"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:      "conflicting_map_insert_and_delete_1",
			op1:       Op().Company().Flags().Key(3).Delete(),
			op2:       Op().Company().Flags().Key(3).Set("c"),
			data:      &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected1: &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected2: &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
		},
		{
			name:     "conflicting_deletes",
			op1:      Op().Person().Alias().Index(0).Delete(),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:     "two_deletes",
			op1:      Op().Person().Alias().Index(0).Delete(),
			op2:      Op().Person().Alias().Index(1).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"c"}},
		},
		{
			name:     "delete_move",
			op1:      Op().Person().Alias().Move(0, 1),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c"}},
			expected: &Person{Alias: []string{"b", "c"}},
		},
		{
			name:      "conflicting_replace",
			op1:       Op().Person().Company().Set(&Company{Name: "bar"}),
			op2:       Op().Person().Company().Set(&Company{Name: "baz"}),
			data:      &Person{Company: &Company{Name: "foo"}},
			expected1: &Person{Company: &Company{Name: "bar"}},
			expected2: &Person{Company: &Company{Name: "baz"}},
		},
		{
			name:     "operation_inside_replace_1",
			op1:      Op().Person().Company().Set(&Company{Name: "bar"}),
			op2:      Op().Person().Company().Name().Set("baz"),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:     "operation_inside_replace_2",
			op1:      Op().Person().Company().Name().Set("baz"),
			op2:      Op().Person().Company().Set(&Company{Name: "bar"}),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{Name: "bar"}},
		},
		{
			name:      "conflicting_diffs",
			op1:       Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:       Op().Person().Name().Edit("foo bar", "foo bar qux"),
			data:      &Person{Name: "foo bar"},
			expected1: &Person{Name: "foo bar baz qux"},
			expected2: &Person{Name: "foo bar qux baz"},
		},
		{
			name:     "transform_diffs",
			op1:      Op().Person().Name().Edit("foo bar", "foo bar baz"),
			op2:      Op().Person().Name().Edit("foo bar", "foo qux bar"),
			data:     &Person{Name: "foo bar"},
			expected: &Person{Name: "foo qux bar baz"},
		},
		{
			name:     "move_then_edit_0_to_0",
			op1:      Op().Person().Alias().Move(0, 0),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "b", "c", "d"}},
		},
		{
			name:     "move_then_edit_0_to_1",
			op1:      Op().Person().Alias().Move(0, 1),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "b", "c", "d"}},
		},
		{
			name:     "move_then_edit_0_to_2",
			op1:      Op().Person().Alias().Move(0, 2),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "x", "c", "d"}},
		},
		{
			name:     "move_then_edit_0_to_3",
			op1:      Op().Person().Alias().Move(0, 3),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "x", "d"}},
		},
		{
			name:     "move_then_edit_0_to_4",
			op1:      Op().Person().Alias().Move(0, 4),
			op2:      Op().Person().Alias().Index(0).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d", "x"}},
		},
		{
			name:     "move_then_edit_3_to_0",
			op1:      Op().Person().Alias().Move(3, 0),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c"}},
		},
		{
			name:     "move_then_edit_3_to_1",
			op1:      Op().Person().Alias().Move(3, 1),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c"}},
		},
		{
			name:     "move_then_edit_3_to_2",
			op1:      Op().Person().Alias().Move(3, 2),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c"}},
		},
		{
			name:     "move_then_edit_3_to_3",
			op1:      Op().Person().Alias().Move(3, 3),
			op2:      Op().Person().Alias().Index(3).Set("x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x"}},
		},
		{
			name:      "identical_map_inserts",
			op1:       Op().Company().Flags().Key(1).Set("a"),
			op2:       Op().Company().Flags().Key(1).Set("b"),
			data:      &Company{},
			expected1: &Company{Flags: map[int64]string{1: "a"}},
			expected2: &Company{Flags: map[int64]string{1: "b"}},
		},
		{
			name:     "insert_delete",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a"}},
			expected: &Person{Alias: []string{"x"}},
		},
		{
			name:      "identical_list_inserts",
			op1:       Op().Person().Alias().Insert(0, "x"),
			op2:       Op().Person().Alias().Insert(0, "y"),
			data:      &Person{},
			expected1: &Person{Alias: []string{"x", "y"}},
			expected2: &Person{Alias: []string{"y", "x"}},
		},
		{
			name:     "double_inserts",
			op1:      Op().Person().Alias().Insert(0, "x"),
			op2:      Op().Person().Alias().Insert(1, "y"),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "a", "y", "b"}},
		},
		{
			name:     "independent_inserts",
			op1:      Op().Person().Company().Flags().Key(1).Set("a"),
			op2:      Op().Person().Alias().Insert(0, "b"),
			data:     &Person{},
			expected: &Person{Company: &Company{Flags: map[int64]string{1: "a"}}, Alias: []string{"b"}},
		},
	}
	var solo bool
	for _, item := range items {
		if item.solo {
			solo = true
			break
		}
	}
	for _, item := range items {
		if solo && !item.solo {
			continue
		}
		t.Run(item.name, func(t *testing.T) {

			// op1 has priority
			op1xp1, op2xp1, err := delta.Transform(item.op1, item.op2, true)
			if err != nil {
				t.Fatal(err)
			}

			// op2 has priority
			op1xp2, op2xp2, err := delta.Transform(item.op1, item.op2, false)
			if err != nil {
				t.Fatal(err)
			}

			data1p1 := proto.Clone(item.data)
			if err := delta.Apply(item.op1, &data1p1); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op2xp1, &data1p1); err != nil {
				t.Fatal(err)
			}

			data2p1 := proto.Clone(item.data)
			if err := delta.Apply(item.op2, &data2p1); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op1xp1, &data2p1); err != nil {
				t.Fatal(err)
			}

			data1p2 := proto.Clone(item.data)
			if err := delta.Apply(item.op1, &data1p2); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op2xp2, &data1p2); err != nil {
				t.Fatal(err)
			}

			data2p2 := proto.Clone(item.data)
			if err := delta.Apply(item.op2, &data2p2); err != nil {
				t.Fatal(err)
			}
			if err := delta.Apply(op1xp2, &data2p2); err != nil {
				t.Fatal(err)
			}

			result1p1, err := protojson.Marshal(data1p1)
			if err != nil {
				t.Fatal(err)
			}

			result1p2, err := protojson.Marshal(data1p2)
			if err != nil {
				t.Fatal(err)
			}

			result2p1, err := protojson.Marshal(data2p1)
			if err != nil {
				t.Fatal(err)
			}

			result2p2, err := protojson.Marshal(data2p2)
			if err != nil {
				t.Fatal(err)
			}

			input, err := protojson.Marshal(item.data)
			if err != nil {
				t.Fatal(err)
			}

			var expectedp1, expectedp2 []byte
			if item.expected != nil {
				expectedp1, err = protojson.Marshal(item.expected)
				if err != nil {
					t.Fatal(err)
				}
				expectedp2, err = protojson.Marshal(item.expected)
				if err != nil {
					t.Fatal(err)
				}
			} else {
				expectedp1, err = protojson.Marshal(item.expected1)
				if err != nil {
					t.Fatal(err)
				}
				expectedp2, err = protojson.Marshal(item.expected2)
				if err != nil {
					t.Fatal(err)
				}
			}

			if !compareJson(string(result1p1), string(expectedp1)) || !compareJson(string(result1p2), string(expectedp2)) || !compareJson(string(result2p1), string(expectedp1)) || !compareJson(string(result2p2), string(expectedp2)) {
				fmt.Println("op1", item.op1)
				fmt.Println("op2xp1", op2xp1)
				fmt.Println("op2xp2", op2xp2)
				fmt.Println("op2", item.op2)
				fmt.Println("op1xp1", op1xp1)
				fmt.Println("op1xp2", op1xp2)
				if item.expected != nil {
					t.Fatalf("\ndata:        %s\nresult1-p1:  %s\nresult2-p1:  %s\nresult1-p2:  %s\nresult2-p2:  %s\nexpected:    %s", string(input), string(result1p1), string(result2p1), string(result1p2), string(result2p2), string(expectedp1))
				} else {
					t.Fatalf("\ndata:        %s\nresult1-p1:  %s\nresult2-p1:  %s\nexpected-p1: %s\nresult1-p2:  %s\nresult2-p2:  %s\nexpected-p2: %s", string(input), string(result1p1), string(result2p1), string(expectedp1), string(result1p2), string(result2p2), string(expectedp2))
				}
			}
		})
	}
	if solo {
		t.Fatal("tests skipped")
	}
}

func TestApply(t *testing.T) {
	type itemType struct {
		solo     bool
		name     string
		op       *delta.Op
		diff     string
		data     proto.Message
		expected proto.Message
	}
	items := []itemType{
		{
			name:     "replace_message_with_enum",
			op:       Op().Company().Ceo().Set(&Person{Name: "a", TypeList: []Person_Type{Person_Bravo}}),
			data:     &Company{Name: "a"},
			expected: &Company{Name: "a", Ceo: &Person{Name: "a", TypeList: []Person_Type{Person_Bravo}}},
		},
		{
			name:     "insert_map_enum",
			op:       Op().Person().TypeMap().Key("b").Set(Person_Charlie),
			data:     &Person{Name: "a", TypeMap: map[string]Person_Type{"a": Person_Alpha, "b": Person_Bravo}},
			expected: &Person{Name: "a", TypeMap: map[string]Person_Type{"a": Person_Alpha, "b": Person_Charlie}},
		},
		{
			name:     "insert_list_enum",
			op:       Op().Person().TypeList().Insert(0, Person_Bravo),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "a", TypeList: []Person_Type{Person_Bravo}},
		},
		{
			name:     "replace_enum",
			op:       Op().Person().Type().Set(Person_Alpha),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "a", Type: Person_Alpha},
		},
		{
			name:     "delete_root",
			op:       Op().Person().Delete(),
			data:     &Person{Name: "a"},
			expected: nil,
		},
		{
			name:     "replace_root",
			op:       Op().Person().Set(&Person{Name: "x"}),
			data:     &Person{Name: "a"},
			expected: &Person{Name: "x"},
		},
		{
			name:     "empty_list",
			op:       Op().Person().Alias().Insert(0, "b"),
			data:     &Person{Alias: []string{}},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "nil_list",
			op:       Op().Person().Alias().Insert(0, "b"),
			data:     &Person{},
			expected: &Person{Alias: []string{"b"}},
		},
		{
			name:     "empty_map",
			op:       Op().Company().Flags().Key(1).Set("a"),
			data:     &Company{Flags: map[int64]string{}},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "nil_map",
			op:       Op().Company().Flags().Key(1).Set("a"),
			data:     &Company{},
			expected: &Company{Flags: map[int64]string{1: "a"}},
		},
		{
			name:     "insert_list_scalar_0",
			op:       Op().Person().Alias().Insert(0, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"x", "a", "b", "c", "d"}},
		},
		{
			name:     "insert_list_scalar_1",
			op:       Op().Person().Alias().Insert(1, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "x", "b", "c", "d"}},
		},
		{
			name:     "insert_list_scalar_2",
			op:       Op().Person().Alias().Insert(2, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "x", "c", "d"}},
		},
		{
			name:     "insert_list_scalar_3",
			op:       Op().Person().Alias().Insert(3, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "x", "d"}},
		},
		{
			name:     "insert_list_scalar_4",
			op:       Op().Person().Alias().Insert(4, "x"),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c", "d", "x"}},
		},
		{
			name:     "insert_list_message",
			op:       Op().Case().Items().Insert(0, &Item{Title: "x"}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "a"}, {Title: "b"}}},
		},
		{
			name:     "insert_map_scalar",
			op:       Op().Company().Flags().Key(10).Set("x"),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 2: "b", 10: "x"}},
		},
		{
			name:     "insert_map_message",
			op:       Op().Person().Cases().Key("x").Set(&Case{Name: "x"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}, "x": {Name: "x"}}},
		},
		{
			name:     "delete_scalar",
			op:       Op().Person().Name().Delete(),
			data:     &Person{Name: "foo"},
			expected: &Person{},
		},
		{
			name:     "delete_field_scalar",
			op:       Op().Person().Company().Name().Delete(),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{Company: &Company{}},
		},
		{
			name:     "delete_message",
			op:       Op().Person().Company().Delete(),
			data:     &Person{Company: &Company{Name: "foo"}},
			expected: &Person{},
		},
		{
			name:     "delete_list_scalar_start",
			op:       Op().Person().Alias().Index(0).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"b", "c", "d"}},
		},
		{
			name:     "delete_list_scalar_mid",
			op:       Op().Person().Alias().Index(2).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "d"}},
		},
		{
			name:     "delete_list_scalar_end",
			op:       Op().Person().Alias().Index(3).Delete(),
			data:     &Person{Alias: []string{"a", "b", "c", "d"}},
			expected: &Person{Alias: []string{"a", "b", "c"}},
		},
		{
			name:     "delete_list_message",
			op:       Op().Case().Items().Index(0).Delete(),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}}},
		},
		{
			name:     "delete_map_scalar",
			op:       Op().Company().Flags().Key(2).Delete(),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b", 3: "c"}},
			expected: &Company{Flags: map[int64]string{1: "a", 3: "c"}},
		},
		{
			name:     "move_list_scalar_start_next",
			op:       Op().Person().Alias().Move(0, 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "a", "c", "d", "e"}},
		},
		{
			name:     "move_list_scalar_start_mid",
			op:       Op().Person().Alias().Move(0, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "a", "d", "e"}},
		},
		{
			name:     "move_list_scalar_start_end",
			op:       Op().Person().Alias().Move(0, 5),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"b", "c", "d", "e", "a"}},
		},
		{
			name:     "move_list_scalar_mid_next",
			op:       Op().Person().Alias().Move(2, 4),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "c", "e"}},
		},
		{
			name:     "move_list_scalar_mid_prev",
			op:       Op().Person().Alias().Move(2, 1),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "c", "b", "d", "e"}},
		},
		{
			name:     "move_list_scalar_mid_end",
			op:       Op().Person().Alias().Move(2, 5),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "d", "e", "c"}},
		},
		{
			name:     "move_list_scalar_mid_start",
			op:       Op().Person().Alias().Move(2, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"c", "a", "b", "d", "e"}},
		},
		{
			name:     "move_list_scalar_end_prev",
			op:       Op().Person().Alias().Move(4, 3),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "c", "e", "d"}},
		},
		{
			name:     "move_list_scalar_end_mid",
			op:       Op().Person().Alias().Move(4, 2),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"a", "b", "e", "c", "d"}},
		},
		{
			name:     "move_list_scalar_end_start",
			op:       Op().Person().Alias().Move(4, 0),
			data:     &Person{Alias: []string{"a", "b", "c", "d", "e"}},
			expected: &Person{Alias: []string{"e", "a", "b", "c", "d"}},
		},
		{
			name:     "move_list_message",
			op:       Op().Case().Items().Move(0, 3),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}, {Title: "c"}}},
			expected: &Case{Items: []*Item{{Title: "b"}, {Title: "c"}, {Title: "a"}}},
		},
		{
			name:     "move_map_scalar",
			op:       Op().Company().Flags().Rename(2, 5),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{1: "a", 5: "b"}},
		},
		{
			name:     "move_map_message",
			op:       Op().Person().Cases().Rename("b", "c"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "a"}, "c": {Name: "b"}}},
		},
		{
			name:     "replace_scalar",
			op:       Op().Person().Name().Set("john"),
			data:     &Person{Name: "dave"},
			expected: &Person{Name: "john"},
		},
		{
			name:     "replace_field_scalar",
			op:       Op().Person().Company().Name().Set("apple"),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace_field",
			op:       Op().Person().Company().Set(&Company{Name: "apple"}),
			data:     &Person{Company: &Company{Name: "google"}},
			expected: &Person{Company: &Company{Name: "apple"}},
		},
		{
			name:     "replace_index_scalar",
			op:       Op().Person().Alias().Index(1).Set("alex"),
			data:     &Person{Alias: []string{"jim", "bob", "dave"}},
			expected: &Person{Alias: []string{"jim", "alex", "dave"}},
		},
		{
			name:     "replace_index_field",
			op:       Op().Case().Items().Index(1).Set(&Item{Title: "baz"}),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "foo"}, {Title: "baz"}}},
		},
		{
			name:     "replace_index_field_scalar",
			op:       Op().Case().Items().Index(0).Title().Set("baz"),
			data:     &Case{Items: []*Item{{Title: "foo"}, {Title: "bar"}}},
			expected: &Case{Items: []*Item{{Title: "baz"}, {Title: "bar"}}},
		},
		{
			name:     "replace_map_scalar",
			op:       Op().Company().Flags().Key(2).Set("qux"),
			data:     &Company{Flags: map[int64]string{1: "foo", 2: "bar", 3: "baz"}},
			expected: &Company{Flags: map[int64]string{1: "foo", 2: "qux", 3: "baz"}},
		},
		{
			name:     "replace_map_field",
			op:       Op().Person().Cases().Key("c").Set(&Case{Name: "foo"}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "caseC"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}, "c": {Name: "foo"}}},
		},
		{
			name:     "replace_map_field_scalar",
			op:       Op().Person().Cases().Key("a").Name().Set("foo"),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "caseA"}, "b": {Name: "caseB"}}},
			expected: &Person{Cases: map[string]*Case{"a": {Name: "foo"}, "b": {Name: "caseB"}}},
		},
		{
			name:     "replace_replace_list_scalar",
			op:       Op().Person().Alias().Set([]string{"x", "y"}),
			data:     &Person{Alias: []string{"a", "b"}},
			expected: &Person{Alias: []string{"x", "y"}},
		},
		{
			name:     "replace_replace_list_message",
			op:       Op().Case().Items().Set([]*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}),
			data:     &Case{Items: []*Item{{Title: "a"}, {Title: "b"}}},
			expected: &Case{Items: []*Item{{Title: "x"}, {Title: "y"}, {Title: "z"}}},
		},
		{
			name:     "replace_replace_map_message",
			op:       Op().Person().Cases().Set(map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}),
			data:     &Person{Cases: map[string]*Case{"a": {Name: "a"}, "b": {Name: "b"}}},
			expected: &Person{Cases: map[string]*Case{"x": {Name: "x"}, "y": {Name: "y"}, "z": {Name: "z"}}},
		},
		{
			name:     "replace_replace_map_scalar",
			op:       Op().Company().Flags().Set(map[int64]string{10: "x", 11: "y"}),
			data:     &Company{Flags: map[int64]string{1: "a", 2: "b"}},
			expected: &Company{Flags: map[int64]string{10: "x", 11: "y"}},
		},
		{
			name:     "edit_lorem_ipsum",
			op:       Op().Person().Name().Edit("Lorem ipsum dolor.", "Lorem dolor sit amet."),
			diff:     `{"ops":[{"retain":"6"},{"delete":"11"},{"insert":"dolor sit amet"},{"retain":"1"}]}`,
			data:     &Person{Name: "Lorem ipsum dolor."},
			expected: &Person{Name: "Lorem dolor sit amet."},
		},
		{
			name:     "edit_quick_brown_fox",
			op:       Op().Person().Name().Edit("the quick brown fox jumped over the lazy dog.", "the quick orange fox jumped over me."),
			diff:     `{"ops":[{"retain":"10"},{"delete":"5"},{"insert":"orange"},{"retain":"17"},{"delete":"12"},{"insert":"me"},{"retain":"1"}]}`,
			data:     &Person{Name: "the quick brown fox jumped over the lazy dog."},
			expected: &Person{Name: "the quick orange fox jumped over me."},
		},
	}
	var solo bool
	for _, item := range items {
		if item.solo {
			solo = true
			break
		}
	}
	for _, item := range items {
		if solo && !item.solo {
			continue
		}
		t.Run(item.name, func(t *testing.T) {
			if item.diff != "" {
				diff, err := protojson.Marshal(item.op.Value.(*delta.Op_Delta).Delta)
				if err != nil {
					t.Fatal(err)
				}
				if !compareJson(string(diff), item.diff) {
					t.Fatalf("\ndiff result:   %s\ndiff expected: %s", string(diff), item.diff)
				}
			}
			if err := delta.Apply(item.op, &item.data); err != nil {
				t.Fatal(err)
			}
			var result, expected []byte
			var err error
			if item.data != nil {
				result, err = protojson.Marshal(item.data)
				if err != nil {
					t.Fatal(err)
				}
			} else {
				result = []byte("nil")
			}
			if item.expected != nil {
				expected, err = protojson.Marshal(item.expected)
				if err != nil {
					t.Fatal(err)
				}
			} else {
				expected = []byte("nil")
			}
			if string(result) != string(expected) && !compareJson(string(result), string(expected)) {
				t.Fatalf("\nresult:   %s\nexpected: %s", string(result), string(expected))
			}
		})
	}
	if solo {
		t.Fatal("tests skipped")
	}
}

func testTwoOpsConverge(t *testing.T, opA, opB *delta.Op, descA, descB string, data proto.Message) string {
	// opA has priority
	opAxpA, opBxpA, err := delta.Transform(opA, opB, true)
	if err != nil {
		t.Fatal(err)
	}

	// opB has priority
	opAxpB, opBxpB, err := delta.Transform(opA, opB, false)
	if err != nil {
		t.Fatal(err)
	}

	dataApA := proto.Clone(data)
	if err := delta.Apply(opA, &dataApA); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(opBxpA, &dataApA); err != nil {
		t.Fatal(err)
	}

	dataBpA := proto.Clone(data)
	if err := delta.Apply(opB, &dataBpA); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(opAxpA, &dataBpA); err != nil {
		t.Fatal(err)
	}

	dataApB := proto.Clone(data)
	if err := delta.Apply(opA, &dataApB); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(opBxpB, &dataApB); err != nil {
		t.Fatal(err)
	}

	dataBpB := proto.Clone(data)
	if err := delta.Apply(opB, &dataBpB); err != nil {
		t.Fatal(err)
	}
	if err := delta.Apply(opAxpB, &dataBpB); err != nil {
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

func printAlias(m proto.Message) string {
	p := m.(*Person)
	return strings.Join(p.Alias, " ")
}
func printFlags(m proto.Message) string {
	c := m.(*Company)
	var keys []int64
	for key := range c.Flags {
		keys = append(keys, key)
	}
	sort.Slice(keys, func(i, j int) bool { return keys[i] < keys[j] })
	var out string
	for i, key := range keys {
		if i != 0 {
			out += " "
		}
		out += fmt.Sprintf("%d:%s", key, c.Flags[key])
	}
	return out
}

func compareResults(t *testing.T, result, expected string) {
	expected = strings.TrimSpace(expected)
	expected = strings.ReplaceAll(expected, "\t", "")
	result = strings.TrimSpace(result)
	result = strings.ReplaceAll(result, "\t", "")
	if expected != result {
		//fmt.Println(result)
		//t.Fatalf("")
		t.Fatalf("Unexpected result. Expected:\n%s\n\nResult:\n%s\n", expected, result)
	}
}
