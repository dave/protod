package main

import (
	"fmt"
)

func (m *Main) lookupTypes() error {

	for _, message := range m.Root.Messages() {
		for _, field := range message.Fields {
			if err := m.lookupField(message, field); err != nil {
				return err
			}
			if field.Oneof {
				for _, oneofField := range field.OneofFields {
					if err := m.lookupField(message, oneofField); err != nil {
						return err
					}
				}
			}
		}
	}
	return nil
}

func (m *Main) lookupField(message *MessageData, field *MessageField) error {
	if field.Oneof {
		// TypeScope is added for Oneof fields during scan
		return nil
	}
	if isScalar(field.TypeName) {
		field.TypeScope = Scalars.Scope
		field.TypeLocatable = Scalars.Scope.Children[field.TypeName].Data.(Locatable)
		return nil
	}
	typeScope := message.Scope.Lookup(field.TypeName)
	if typeScope == nil {
		return fmt.Errorf("can't resolve type %s", field.TypeName)
	}
	field.TypeScope = typeScope
	field.TypeLocatable = typeScope.Data.(Locatable)
	return nil
}
