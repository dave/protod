package tests

import "github.com/dave/protod/delta"

type Company_type struct {
	location []delta.Indexer
}

func (b Company_type) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type(l []delta.Indexer) Company_type {
	return Company_type{location: l}
}

type Company_type_repeated struct {
	location []delta.Indexer
}

func (b Company_type_repeated) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type_repeated(l []delta.Indexer) Company_type_repeated {
	return Company_type_repeated{location: l}
}
func (b Company_type_repeated) Index(i int) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.IndexIndexer(i)))
}

type Company_type_bool_map struct {
	location []delta.Indexer
}

func (b Company_type_bool_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type_bool_map(l []delta.Indexer) Company_type_bool_map {
	return Company_type_bool_map{location: l}
}
func (b Company_type_bool_map) Key(k bool) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Company_type_int32_map struct {
	location []delta.Indexer
}

func (b Company_type_int32_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type_int32_map(l []delta.Indexer) Company_type_int32_map {
	return Company_type_int32_map{location: l}
}
func (b Company_type_int32_map) Key(k int32) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Company_type_int64_map struct {
	location []delta.Indexer
}

func (b Company_type_int64_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type_int64_map(l []delta.Indexer) Company_type_int64_map {
	return Company_type_int64_map{location: l}
}
func (b Company_type_int64_map) Key(k int64) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Company_type_uint32_map struct {
	location []delta.Indexer
}

func (b Company_type_uint32_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type_uint32_map(l []delta.Indexer) Company_type_uint32_map {
	return Company_type_uint32_map{location: l}
}
func (b Company_type_uint32_map) Key(k uint32) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Company_type_uint64_map struct {
	location []delta.Indexer
}

func (b Company_type_uint64_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type_uint64_map(l []delta.Indexer) Company_type_uint64_map {
	return Company_type_uint64_map{location: l}
}
func (b Company_type_uint64_map) Key(k uint64) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Company_type_string_map struct {
	location []delta.Indexer
}

func (b Company_type_string_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCompany_type_string_map(l []delta.Indexer) Company_type_string_map {
	return Company_type_string_map{location: l}
}
func (b Company_type_string_map) Key(k string) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}
func CompanyDef() Company_type {
	return Company_type{}
}
func (b Company_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, delta.FieldIndexer("name", 11)))
}

type Case_type struct {
	location []delta.Indexer
}

func (b Case_type) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type(l []delta.Indexer) Case_type {
	return Case_type{location: l}
}

type Case_type_repeated struct {
	location []delta.Indexer
}

func (b Case_type_repeated) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type_repeated(l []delta.Indexer) Case_type_repeated {
	return Case_type_repeated{location: l}
}
func (b Case_type_repeated) Index(i int) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.IndexIndexer(i)))
}

type Case_type_bool_map struct {
	location []delta.Indexer
}

func (b Case_type_bool_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type_bool_map(l []delta.Indexer) Case_type_bool_map {
	return Case_type_bool_map{location: l}
}
func (b Case_type_bool_map) Key(k bool) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Case_type_int32_map struct {
	location []delta.Indexer
}

func (b Case_type_int32_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type_int32_map(l []delta.Indexer) Case_type_int32_map {
	return Case_type_int32_map{location: l}
}
func (b Case_type_int32_map) Key(k int32) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Case_type_int64_map struct {
	location []delta.Indexer
}

func (b Case_type_int64_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type_int64_map(l []delta.Indexer) Case_type_int64_map {
	return Case_type_int64_map{location: l}
}
func (b Case_type_int64_map) Key(k int64) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Case_type_uint32_map struct {
	location []delta.Indexer
}

func (b Case_type_uint32_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type_uint32_map(l []delta.Indexer) Case_type_uint32_map {
	return Case_type_uint32_map{location: l}
}
func (b Case_type_uint32_map) Key(k uint32) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Case_type_uint64_map struct {
	location []delta.Indexer
}

func (b Case_type_uint64_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type_uint64_map(l []delta.Indexer) Case_type_uint64_map {
	return Case_type_uint64_map{location: l}
}
func (b Case_type_uint64_map) Key(k uint64) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Case_type_string_map struct {
	location []delta.Indexer
}

func (b Case_type_string_map) Location_get() []delta.Indexer {
	return b.location
}
func NewCase_type_string_map(l []delta.Indexer) Case_type_string_map {
	return Case_type_string_map{location: l}
}
func (b Case_type_string_map) Key(k string) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}
func CaseDef() Case_type {
	return Case_type{}
}
func (b Case_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, delta.FieldIndexer("name", 12)))
}

type Person_type struct {
	location []delta.Indexer
}

func (b Person_type) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type(l []delta.Indexer) Person_type {
	return Person_type{location: l}
}

type Person_type_repeated struct {
	location []delta.Indexer
}

func (b Person_type_repeated) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type_repeated(l []delta.Indexer) Person_type_repeated {
	return Person_type_repeated{location: l}
}
func (b Person_type_repeated) Index(i int) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.IndexIndexer(i)))
}

type Person_type_bool_map struct {
	location []delta.Indexer
}

func (b Person_type_bool_map) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type_bool_map(l []delta.Indexer) Person_type_bool_map {
	return Person_type_bool_map{location: l}
}
func (b Person_type_bool_map) Key(k bool) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Person_type_int32_map struct {
	location []delta.Indexer
}

func (b Person_type_int32_map) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type_int32_map(l []delta.Indexer) Person_type_int32_map {
	return Person_type_int32_map{location: l}
}
func (b Person_type_int32_map) Key(k int32) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Person_type_int64_map struct {
	location []delta.Indexer
}

func (b Person_type_int64_map) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type_int64_map(l []delta.Indexer) Person_type_int64_map {
	return Person_type_int64_map{location: l}
}
func (b Person_type_int64_map) Key(k int64) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Person_type_uint32_map struct {
	location []delta.Indexer
}

func (b Person_type_uint32_map) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type_uint32_map(l []delta.Indexer) Person_type_uint32_map {
	return Person_type_uint32_map{location: l}
}
func (b Person_type_uint32_map) Key(k uint32) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Person_type_uint64_map struct {
	location []delta.Indexer
}

func (b Person_type_uint64_map) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type_uint64_map(l []delta.Indexer) Person_type_uint64_map {
	return Person_type_uint64_map{location: l}
}
func (b Person_type_uint64_map) Key(k uint64) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}

type Person_type_string_map struct {
	location []delta.Indexer
}

func (b Person_type_string_map) Location_get() []delta.Indexer {
	return b.location
}
func NewPerson_type_string_map(l []delta.Indexer) Person_type_string_map {
	return Person_type_string_map{location: l}
}
func (b Person_type_string_map) Key(k string) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
}
func PersonDef() Person_type {
	return Person_type{}
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
func (b Person_type) CasesStringMap() Case_type_string_map {
	return NewCase_type_string_map(delta.CopyAndAppend(b.location, delta.FieldIndexer("casesStringMap", 16)))
}
func (b Person_type) CasesIntMap() Case_type_int32_map {
	return NewCase_type_int32_map(delta.CopyAndAppend(b.location, delta.FieldIndexer("casesIntMap", 17)))
}
func (b Person_type) Company() Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, delta.FieldIndexer("company", 18)))
}
