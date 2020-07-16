package main

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

type OpData struct {
	Name     string
	Type     string
	Locators []LocatorType
}

var Behaviours = map[OpType]OpData{
	EDIT: {
		Name:     "Edit",
		Type:     "Op_Edit",
		Locators: []LocatorType{FIELD, INDEX, KEY},
	},
	SET: {
		Name:     "Set",
		Type:     "Op_Set",
		Locators: []LocatorType{FIELD, INDEX, KEY},
	},
	INSERT: {
		Name:     "Insert",
		Type:     "Op_Insert",
		Locators: []LocatorType{INDEX},
	},
	MOVE: {
		Name:     "Move",
		Type:     "Op_Move",
		Locators: []LocatorType{INDEX},
	},
	RENAME: {
		Name:     "Rename",
		Type:     "Op_Rename",
		Locators: []LocatorType{KEY},
	},
	DELETE: {
		Name:     "Delete",
		Type:     "Op_Delete",
		Locators: []LocatorType{FIELD, INDEX, KEY, ONEOF},
	},
}

type LocatorData struct {
	Name string
	Type string
	Dart string
}

var Locators = map[LocatorType]LocatorData{
	FIELD: {
		Name: "Field",
		Type: "Locator_Field",
		Dart: "hasField_1",
	},
	INDEX: {
		Name: "Index",
		Type: "Locator_Index",
		Dart: "hasIndex",
	},
	KEY: {
		Name: "Key",
		Type: "Locator_Key",
		Dart: "hasKey",
	},
	ONEOF: {
		Name: "Oneof",
		Type: "Locator_Oneof",
		Dart: "hasOneof",
	},
}
