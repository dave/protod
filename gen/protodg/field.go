package main

import "strings"

type MessageField struct {
	Message       *MessageData
	Number        int
	Name          string
	TypeName      string
	TypeScope     *Scope
	TypeLocatable Locatable
	Key           string
	Map           bool
	Repeated      bool
	Oneof         bool
	OneofParent   *MessageField
	OneofFields   []*MessageField
}

func (f *MessageField) GoName() string {
	s := strings.Title(f.Name)
	switch s {
	case "Edit", "Insert", "Delete", "Move", "Set", "Rename":
		s += "_"
	}
	return s
}

func (f *MessageField) GoTypePackagePath() string {
	return f.TypeScope.Package().GoPackagePath
}

func (f *MessageField) GoTypeLocatableName() string {
	return f.TypeLocatable.GoLocatableTypeName(f.Repeated, f.Map, f.Key)
}
