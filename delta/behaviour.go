package delta

type OpType int

const (
	EDIT    OpType = 1
	REPLACE OpType = 2
	INSERT  OpType = 3
	MOVE    OpType = 4
	DELETE  OpType = 5
)

var OpTypes = []OpType{EDIT, REPLACE, INSERT, MOVE, DELETE}

type LocatorType int

const (
	FIELD LocatorType = 1
	INDEX LocatorType = 2
	KEY   LocatorType = 3
)

var LocatorTypes = []LocatorType{FIELD, INDEX, KEY}

type OpData struct {
	Name     string
	Type     string
	Locators map[LocatorType]OpBehaviour
}

type OpBehaviour struct {
	ItemIsDeleted   bool
	ValueIsDeleted  bool
	ValueIsLocation bool
	IndexShifter    func(*Op, *Op, bool) func(int64) int64
	KeyShifter      func(*Op, *Op, bool) func(*Key) *Key
}

var Behaviours = map[OpType]OpData{
	EDIT: {
		Name: "Edit",
		Type: "Op_Edit",
		Locators: map[LocatorType]OpBehaviour{
			FIELD: {
				ValueIsLocation: false,
				ItemIsDeleted:   false,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
			INDEX: {
				ValueIsLocation: false,
				ItemIsDeleted:   false,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
			KEY: {
				ValueIsLocation: false,
				ItemIsDeleted:   false,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
		},
	},
	REPLACE: {
		Name: "Replace",
		Type: "Op_Edit",
		Locators: map[LocatorType]OpBehaviour{
			FIELD: {
				ValueIsLocation: false,
				ItemIsDeleted:   true,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
			INDEX: {
				ValueIsLocation: false,
				ItemIsDeleted:   true,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
			KEY: {
				ValueIsLocation: false,
				ItemIsDeleted:   true,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
		},
	},
	INSERT: {
		Name: "Insert",
		Type: "Op_Insert",
		Locators: map[LocatorType]OpBehaviour{
			INDEX: {
				ValueIsLocation: false,
				ItemIsDeleted:   false,
				ValueIsDeleted:  false,
				IndexShifter: func(transformer, op *Op, priority bool) func(int64) int64 {
					return insertShifter(transformer.Item().V.(*Locator_Index).Index, priority, op.Type == Op_Insert)
				},
				KeyShifter: nil,
			},
			KEY: {
				ValueIsLocation: false,
				ItemIsDeleted:   true,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
		},
	},
	MOVE: {
		Name: "Move",
		Type: "Op_Move",
		Locators: map[LocatorType]OpBehaviour{
			INDEX: {
				ValueIsLocation: true,
				ItemIsDeleted:   false,
				ValueIsDeleted:  false,
				IndexShifter: func(transformer, op *Op, priority bool) func(int64) int64 {
					return moveShifter(transformer.Item().V.(*Locator_Index).Index, transformer.Value.(*Op_Index).Index, priority)
				},
				KeyShifter: nil,
			},
			KEY: {
				ValueIsLocation: true,
				ItemIsDeleted:   false,
				ValueIsDeleted:  true,
				IndexShifter:    nil,
				KeyShifter: func(op *Op, op2 *Op, b bool) func(*Key) *Key {
					return moveKeyShifter(op.Item().V.(*Locator_Key).Key, op.Value.(*Op_Key).Key)
				},
			},
		},
	},
	DELETE: {
		Name: "Delete",
		Type: "Op_Delete",
		Locators: map[LocatorType]OpBehaviour{
			FIELD: {
				ValueIsLocation: false,
				ItemIsDeleted:   true,
				ValueIsDeleted:  false,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
			INDEX: {
				ValueIsLocation: false,
				ItemIsDeleted:   true,
				ValueIsDeleted:  false,
				IndexShifter: func(transformer, op *Op, priority bool) func(int64) int64 {
					return deleteShifter(transformer.Item().V.(*Locator_Index).Index)
				},
				KeyShifter: nil,
			},
			KEY: {
				ValueIsLocation: false,
				ItemIsDeleted:   false,
				ValueIsDeleted:  true,
				IndexShifter:    nil,
				KeyShifter:      nil,
			},
		},
	},
}

type LocatorData struct {
	Name string
	Type string
}

var Locators = map[LocatorType]LocatorData{
	FIELD: {
		Name: "Field",
		Type: "Locator_Field",
	},
	INDEX: {
		Name: "Index",
		Type: "Locator_Index",
	},
	KEY: {
		Name: "Key",
		Type: "Locator_Key",
	},
}

func getBehaviour(op *Op) OpBehaviour {
	var data OpData
	var behaviour OpBehaviour
	switch op.Type {
	case Op_Edit:
		switch op.Value.(type) {
		case *Op_Delta:
			data = Behaviours[EDIT]
		default:
			data = Behaviours[REPLACE]
		}
	case Op_Insert:
		data = Behaviours[INSERT]
	case Op_Move:
		data = Behaviours[MOVE]
	case Op_Delete:
		data = Behaviours[DELETE]
	}
	switch op.Item().V.(type) {
	case *Locator_Field:
		behaviour = data.Locators[FIELD]
	case *Locator_Index:
		behaviour = data.Locators[INDEX]
	case *Locator_Key:
		behaviour = data.Locators[KEY]
	}
	return behaviour
}

func (t *Op) Transform3(op *Op, priority bool) *Op {
	tBehaviour := getBehaviour(t)
	//opBehaviour := getBehaviour(op)

	if tBehaviour.ItemIsDeleted {
		if rel := TreeRelationship(t.Location, op.Location); rel == TREE_ANCESTOR || rel == TREE_EQUAL {
			// t deleted the value at
		}
	}

	return nil
	//f := jen.NewFilePathName("github.com/dave/protod/delta", "delta")
	//for _, op1Type := range OpTypes {
	//	op1Data := Types[op1Type]
	//	for _, locator1Type := range op1Data.Locators {
	//		locator1Data := Locators[locator1Type]
	//
	//		for _, op2Type := range OpTypes {
	//			op2Data := Types[op2Type]
	//			for _, locator2Type := range op2Data.Locators {
	//				locator2Data := Locators[locator2Type]
	//
	//				f.Commentf("%s (%s), %s, %s (%s), %s", op1Data.Name, op1Data.Type, locator1Data.Type, op2Data.Name, op2Data.Type, locator2Data.Type)
	//
	//			}
	//		}
	//
	//	}
	//}
	//if err := f.Save("./delta/transform3.go"); err != nil {
	//	panic(err)
	//}
}
