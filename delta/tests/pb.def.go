package tests

import "github.com/dave/protod/delta"

func CompanyDef() Company_type {
	return Company_type{}
}

type Company_type struct {
	location []delta.Indexer
}

func NewCompany_type(l []delta.Indexer) Company_type {
	return Company_type{location: l}
}
func (b Company_type) Location_get() []delta.Indexer {
	return b.location
}

type Company_type_repeated struct {
	location []delta.Indexer
}

func NewCompany_type_repeated(l []delta.Indexer) Company_type_repeated {
	return Company_type_repeated{location: l}
}
func (b Company_type_repeated) Location_get() []delta.Indexer {
	return b.location
}
func (b Company_type_repeated) Index(i int) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.IndexIndexer(i)))
}
func (b Company_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, delta.FieldIndexer("name", 11)))
}
func CaseDef() Case_type {
	return Case_type{}
}

type Case_type struct {
	location []delta.Indexer
}

func NewCase_type(l []delta.Indexer) Case_type {
	return Case_type{location: l}
}
func (b Case_type) Location_get() []delta.Indexer {
	return b.location
}

type Case_type_repeated struct {
	location []delta.Indexer
}

func NewCase_type_repeated(l []delta.Indexer) Case_type_repeated {
	return Case_type_repeated{location: l}
}
func (b Case_type_repeated) Location_get() []delta.Indexer {
	return b.location
}
func (b Case_type_repeated) Index(i int) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.IndexIndexer(i)))
}
func (b Case_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, delta.FieldIndexer("name", 12)))
}
func PersonDef() Person_type {
	return Person_type{}
}

type Person_type struct {
	location []delta.Indexer
}

func NewPerson_type(l []delta.Indexer) Person_type {
	return Person_type{location: l}
}
func (b Person_type) Location_get() []delta.Indexer {
	return b.location
}

type Person_type_repeated struct {
	location []delta.Indexer
}

func NewPerson_type_repeated(l []delta.Indexer) Person_type_repeated {
	return Person_type_repeated{location: l}
}
func (b Person_type_repeated) Location_get() []delta.Indexer {
	return b.location
}
func (b Person_type_repeated) Index(i int) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.IndexIndexer(i)))
}
func (b Person_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, delta.FieldIndexer("name", 13)))
}
func (b Person_type) Age() delta.Int32_scalar {
	return delta.NewInt32_scalar(delta.CopyAndAppend(b.location, delta.FieldIndexer("age", 14)))
}
func (b Person_type) Cases() Case_type_repeated {
	return NewCase_type_repeated(delta.CopyAndAppend(b.location, delta.FieldIndexer("cases", 15)))
}
func (b Person_type) Company() Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.FieldIndexer("company", 16)))
}
