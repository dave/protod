package pdelta

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
	ItemIsDeleted   bool
	ValueIsDeleted  bool
	ValueIsLocation bool
	ItemTarget      ShiftTarget
	IndexShifter    func(op1 *Op, priority PriorityType, direction ShiftDirection, target ShiftTarget) func(int64) (int64, PriorityType)
	OpType          OpType
	LocatorType     LocatorType
}

func (o *OpBehaviour) ShiftTarget() ShiftTarget {
	if o.OpType == INSERT {
		return LOCATION
	}
	return VALUE
}

var Behaviours = map[OpType]map[LocatorType]OpBehaviour{
	EDIT: {
		FIELD: {
			ValueIsLocation: false,
			ItemIsDeleted:   false,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
		INDEX: {
			ValueIsLocation: false,
			ItemIsDeleted:   false,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
		KEY: {
			ValueIsLocation: false,
			ItemIsDeleted:   false,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
	},
	SET: {
		FIELD: {
			ValueIsLocation: false,
			ItemIsDeleted:   true,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
		INDEX: {
			ValueIsLocation: false,
			ItemIsDeleted:   true,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
		KEY: {
			ValueIsLocation: false,
			ItemIsDeleted:   true,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
	},
	INSERT: {
		INDEX: {
			ValueIsLocation: false,
			ItemIsDeleted:   false,
			ValueIsDeleted:  false,
			IndexShifter: func(t *Op, priority PriorityType, direction ShiftDirection, target ShiftTarget) func(int64) (int64, PriorityType) {
				return insertShifter(t.Item().V.(*Locator_Index).Index, priority, direction, target)
			},
		},
	},
	MOVE: {
		INDEX: {
			ValueIsLocation: true,
			ItemIsDeleted:   false,
			ValueIsDeleted:  false,
			IndexShifter: func(t *Op, priority PriorityType, direction ShiftDirection, target ShiftTarget) func(int64) (int64, PriorityType) {
				return moveShifter(t.Item().V.(*Locator_Index).Index, t.Value.(*Op_Index).Index, priority, direction, target)
			},
		},
	},
	RENAME: {
		KEY: {
			ValueIsLocation: true,
			ItemIsDeleted:   false,
			ValueIsDeleted:  true,
			IndexShifter:    nil,
		},
	},
	DELETE: {
		FIELD: {
			ValueIsLocation: false,
			ItemIsDeleted:   true,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
		INDEX: {
			ValueIsLocation: false,
			ItemIsDeleted:   true,
			ValueIsDeleted:  false,
			IndexShifter: func(t *Op, priority PriorityType, direction ShiftDirection, target ShiftTarget) func(int64) (int64, PriorityType) {
				return deleteShifter(t.Item().V.(*Locator_Index).Index, direction)
			},
		},
		KEY: {
			ValueIsLocation: false,
			ItemIsDeleted:   true,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
		},
		ONEOF: {
			ValueIsLocation: false,
			ItemIsDeleted:   true,
			ValueIsDeleted:  false,
			IndexShifter:    nil,
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
	b := Behaviours[opType][locatorType]
	b.OpType = opType
	b.LocatorType = locatorType
	return b
}
