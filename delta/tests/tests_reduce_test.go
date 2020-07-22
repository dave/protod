package tests

import (
	"testing"
)

func TestReduce(t *testing.T) {
	t.Skip("not implemented")
	//type itemType struct {
	//	solo     bool
	//	name     string
	//	op       *delta.Op
	//	expected *delta.Op
	//}
	//items := []itemType{
	//	{
	//		name: "first",
	//		op: delta.Compound(
	//			Op().Person().Name().Set("a"),
	//			Op().Person().Name().Delete(),
	//		),
	//		expected: Op().Person().Name().Delete(),
	//	},
	//	{
	//		name: "move",
	//		op: delta.Compound(
	//			Op().Person().Alias().Move(5, 2),
	//			Op().Person().Alias().Move(2, 0),
	//		),
	//		expected: Op().Person().Alias().Move(5, 0),
	//	},
	//}
	//var solo bool
	//for _, item := range items {
	//	if item.solo {
	//		solo = true
	//		break
	//	}
	//}
	////var cases string
	//for _, item := range items {
	//	if solo && !item.solo {
	//		continue
	//	}
	//	t.Run(item.name, func(t *testing.T) {
	//		result := delta.Reduce(item.op)
	//		if !compareJson(mustJson(result), mustJson(item.expected)) {
	//			t.Fatalf("\nop:\n%s\nresult:\n%s\nexpect:\n%s\n", item.op.Debug(), result.Debug(), item.expected.Debug())
	//		}
	//	})
	//}
}
