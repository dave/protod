package delta

type OpType int

const (
	EDIT   OpType = 1
	SET    OpType = 2
	INSERT OpType = 3
	MOVE   OpType = 4
	DELETE OpType = 5
	RENAME OpType = 6
)

var OpTypes = []OpType{EDIT, SET, INSERT, MOVE, DELETE, RENAME}

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
	Locators []LocatorType
	Data     map[LocatorType]OpBehaviour
}

type OpBehaviour struct {
	ItemIsDeleted        bool
	ValueIsDeleted       bool
	ValueIsLocation      bool
	IndexValueShifter    func(*Op, *Op) func(int64) int64
	IndexLocationShifter func(*Op, *Op) func(int64) int64
	KeyShifter           func(*Op, *Op) func(*Key) *Key
}

var Behaviours = map[OpType]OpData{
	EDIT: {
		Name:     "Edit",
		Type:     "Op_Edit",
		Locators: []LocatorType{FIELD, INDEX, KEY},
		Data: map[LocatorType]OpBehaviour{
			FIELD: {
				ValueIsLocation:      false,
				ItemIsDeleted:        false,
				ValueIsDeleted:       false,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
			},
			INDEX: {
				ValueIsLocation:      false,
				ItemIsDeleted:        false,
				ValueIsDeleted:       false,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
			},
			KEY: {
				ValueIsLocation:      false,
				ItemIsDeleted:        false,
				ValueIsDeleted:       false,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
			},
		},
	},
	SET: {
		Name:     "Set",
		Type:     "Op_Set",
		Locators: []LocatorType{FIELD, INDEX, KEY},
		Data: map[LocatorType]OpBehaviour{
			FIELD: {
				ValueIsLocation:      false,
				ItemIsDeleted:        true,
				ValueIsDeleted:       false,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
			},
			INDEX: {
				ValueIsLocation:      false,
				ItemIsDeleted:        true,
				ValueIsDeleted:       false,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
			},
			KEY: {
				ValueIsLocation:      false,
				ItemIsDeleted:        true,
				ValueIsDeleted:       false,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
			},
		},
	},
	INSERT: {
		Name:     "Insert",
		Type:     "Op_Insert",
		Locators: []LocatorType{INDEX},
		Data: map[LocatorType]OpBehaviour{
			INDEX: {
				ValueIsLocation: false,
				ItemIsDeleted:   false,
				ValueIsDeleted:  false,
				IndexValueShifter: func(transformer, op *Op) func(int64) int64 {
					return insertValueShifter(transformer.Item().V.(*Locator_Index).Index)
				},
				IndexLocationShifter: func(transformer, op *Op) func(int64) int64 {
					return insertLocationShifter(transformer.Item().V.(*Locator_Index).Index, false, false)
				},
				KeyShifter: nil,
			},
		},
	},
	MOVE: {
		Name:     "Move",
		Type:     "Op_Move",
		Locators: []LocatorType{INDEX},
		Data: map[LocatorType]OpBehaviour{
			INDEX: {
				ValueIsLocation: true,
				ItemIsDeleted:   false,
				ValueIsDeleted:  false,
				IndexValueShifter: func(transformer, op *Op) func(int64) int64 {
					return moveValueShifter(transformer.Item().V.(*Locator_Index).Index, transformer.Value.(*Op_Index).Index)
				},
				IndexLocationShifter: func(transformer, op *Op) func(int64) int64 {
					return moveLocationShifter(transformer.Item().V.(*Locator_Index).Index, transformer.Value.(*Op_Index).Index, false, false)
				},
				KeyShifter: nil,
			},
		},
	},
	RENAME: {
		Name:     "Rename",
		Type:     "Op_Rename",
		Locators: []LocatorType{KEY},
		Data: map[LocatorType]OpBehaviour{
			KEY: {
				ValueIsLocation:      true,
				ItemIsDeleted:        false,
				ValueIsDeleted:       true,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter: func(op *Op, op2 *Op) func(*Key) *Key {
					return renameShifter(op.Item().V.(*Locator_Key).Key, op.Value.(*Op_Key).Key)
				},
			},
		},
	},
	DELETE: {
		Name:     "Delete",
		Type:     "Op_Delete",
		Locators: []LocatorType{FIELD, INDEX, KEY},
		Data: map[LocatorType]OpBehaviour{
			FIELD: {
				ValueIsLocation:      false,
				ItemIsDeleted:        true,
				ValueIsDeleted:       false,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
			},
			INDEX: {
				ValueIsLocation: false,
				ItemIsDeleted:   true,
				ValueIsDeleted:  false,
				IndexValueShifter: func(transformer, op *Op) func(int64) int64 {
					return deleteShifter(transformer.Item().V.(*Locator_Index).Index)
				},
				IndexLocationShifter: func(transformer, op *Op) func(int64) int64 {
					return deleteShifter(transformer.Item().V.(*Locator_Index).Index)
				},
				KeyShifter: nil,
			},
			KEY: {
				ValueIsLocation:      false,
				ItemIsDeleted:        false,
				ValueIsDeleted:       true,
				IndexValueShifter:    nil,
				IndexLocationShifter: nil,
				KeyShifter:           nil,
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

func GetBehaviour(op *Op) OpBehaviour {
	var data OpData
	var behaviour OpBehaviour
	switch op.Type {
	case Op_Edit:
		data = Behaviours[EDIT]
	case Op_Set:
		data = Behaviours[SET]
	case Op_Insert:
		data = Behaviours[INSERT]
	case Op_Move:
		data = Behaviours[MOVE]
	case Op_Rename:
		data = Behaviours[RENAME]
	case Op_Delete:
		data = Behaviours[DELETE]
	}
	switch op.Item().V.(type) {
	case *Locator_Field:
		behaviour = data.Data[FIELD]
	case *Locator_Index:
		behaviour = data.Data[INDEX]
	case *Locator_Key:
		behaviour = data.Data[KEY]
	}
	return behaviour
}
