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
	ONEOF LocatorType = 4
)

var LocatorTypes = []LocatorType{FIELD, INDEX, KEY, ONEOF}

type OpBehaviour struct {
	ItemIsDeleted        bool
	ValueIsDeleted       bool
	ValueIsLocation      bool
	IndexValueShifter    func(*Op, *Op) func(int64) int64
	IndexLocationShifter func(*Op, *Op) func(int64) int64
	KeyShifter           func(*Op, *Op) func(*Key) *Key
}

var Behaviours = map[OpType]map[LocatorType]OpBehaviour{
	EDIT: {
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
	SET: {
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
	INSERT: {
		INDEX: {
			ValueIsLocation: false,
			ItemIsDeleted:   false,
			ValueIsDeleted:  false,
			IndexValueShifter: func(t, op *Op) func(int64) int64 {
				return insertValueShifter(t.Item().V.(*Locator_Index).Index)
			},
			IndexLocationShifter: func(t, op *Op) func(int64) int64 {
				return insertLocationShifter(t.Item().V.(*Locator_Index).Index, false, false)
			},
			KeyShifter: nil,
		},
	},
	MOVE: {
		INDEX: {
			ValueIsLocation: true,
			ItemIsDeleted:   false,
			ValueIsDeleted:  false,
			IndexValueShifter: func(t, op *Op) func(int64) int64 {
				return moveValueShifter(t.Item().V.(*Locator_Index).Index, t.Value.(*Op_Index).Index)
			},
			IndexLocationShifter: func(t, op *Op) func(int64) int64 {
				return moveLocationShifter(t.Item().V.(*Locator_Index).Index, t.Value.(*Op_Index).Index, false, false)
			},
			KeyShifter: nil,
		},
	},
	RENAME: {
		KEY: {
			ValueIsLocation:      true,
			ItemIsDeleted:        false,
			ValueIsDeleted:       true,
			IndexValueShifter:    nil,
			IndexLocationShifter: nil,
			KeyShifter: func(t *Op, op *Op) func(*Key) *Key {
				return renameShifter(t.Item().V.(*Locator_Key).Key, t.Value.(*Op_Key).Key)
			},
		},
	},
	DELETE: {
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
			IndexValueShifter: func(t, op *Op) func(int64) int64 {
				return deleteShifter(t.Item().V.(*Locator_Index).Index)
			},
			IndexLocationShifter: func(t, op *Op) func(int64) int64 {
				return deleteShifter(t.Item().V.(*Locator_Index).Index)
			},
			KeyShifter: nil,
		},
		KEY: {
			ValueIsLocation:      false,
			ItemIsDeleted:        true,
			ValueIsDeleted:       false,
			IndexValueShifter:    nil,
			IndexLocationShifter: nil,
			KeyShifter:           nil,
		},
		ONEOF: {
			ValueIsLocation:      false,
			ItemIsDeleted:        true,
			ValueIsDeleted:       false,
			IndexValueShifter:    nil,
			IndexLocationShifter: nil,
			KeyShifter:           nil,
		},
	},
}

func GetBehaviour(op *Op) OpBehaviour {
	var opType OpType
	var locatorType LocatorType
	switch op.Type {
	case Op_Edit:
		opType = EDIT
	case Op_Set:
		opType = SET
	case Op_Insert:
		opType = INSERT
	case Op_Move:
		opType = MOVE
	case Op_Rename:
		opType = RENAME
	case Op_Delete:
		opType = DELETE
	default:
		panic("invalid op")
	}
	switch op.Item().V.(type) {
	case *Locator_Field:
		locatorType = FIELD
	case *Locator_Index:
		locatorType = INDEX
	case *Locator_Key:
		locatorType = KEY
	case *Locator_Oneof:
		locatorType = ONEOF
	default:
		panic("invalid op")
	}
	return Behaviours[opType][locatorType]
}
