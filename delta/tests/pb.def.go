package tests

import "github.com/dave/protod/delta"

type Company_type struct {
	location []*delta.Locator
}

func (b Company_type) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type(l []*delta.Locator) Company_type {
	return Company_type{location: l}
}

type Company_type_repeated struct {
	location []*delta.Locator
}

func (b Company_type_repeated) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_repeated(l []*delta.Locator) Company_type_repeated {
	return Company_type_repeated{location: l}
}
func (b Company_type_repeated) Index(i int) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Index{Index: int64(i)}}))
}
func (b Company_type_repeated) Index64(i int64) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Index{Index: i}}))
}

type Company_type_bool_map struct {
	location []*delta.Locator
}

func (b Company_type_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_bool_map(l []*delta.Locator) Company_type_bool_map {
	return Company_type_bool_map{location: l}
}
func (b Company_type_bool_map) Key(k bool) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Bool{Bool: k}}}}))
}

type Company_type_int32_map struct {
	location []*delta.Locator
}

func (b Company_type_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_int32_map(l []*delta.Locator) Company_type_int32_map {
	return Company_type_int32_map{location: l}
}
func (b Company_type_int32_map) Key(k int) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int32{Int32: int32(k)}}}}))
}
func (b Company_type_int32_map) Key32(k int32) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int32{Int32: k}}}}))
}

type Company_type_int64_map struct {
	location []*delta.Locator
}

func (b Company_type_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_int64_map(l []*delta.Locator) Company_type_int64_map {
	return Company_type_int64_map{location: l}
}
func (b Company_type_int64_map) Key(k int) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int64{Int64: int64(k)}}}}))
}
func (b Company_type_int64_map) Key64(k int64) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int64{Int64: k}}}}))
}

type Company_type_uint32_map struct {
	location []*delta.Locator
}

func (b Company_type_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_uint32_map(l []*delta.Locator) Company_type_uint32_map {
	return Company_type_uint32_map{location: l}
}
func (b Company_type_uint32_map) Key(k int) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint32{Uint32: uint32(k)}}}}))
}
func (b Company_type_uint32_map) Key32(k uint32) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint32{Uint32: k}}}}))
}

type Company_type_uint64_map struct {
	location []*delta.Locator
}

func (b Company_type_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_uint64_map(l []*delta.Locator) Company_type_uint64_map {
	return Company_type_uint64_map{location: l}
}
func (b Company_type_uint64_map) Key(k int) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint64{Uint64: uint64(k)}}}}))
}
func (b Company_type_uint64_map) Key64(k uint64) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint64{Uint64: k}}}}))
}

type Company_type_string_map struct {
	location []*delta.Locator
}

func (b Company_type_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_string_map(l []*delta.Locator) Company_type_string_map {
	return Company_type_string_map{location: l}
}
func (b Company_type_string_map) Key(k string) Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_String_{String_: k}}}}))
}
func CompanyDef() Company_type {
	return Company_type{}
}
func (b Company_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "name",
		Number: int32(11),
	}}}))
}

type Case_type struct {
	location []*delta.Locator
}

func (b Case_type) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type(l []*delta.Locator) Case_type {
	return Case_type{location: l}
}

type Case_type_repeated struct {
	location []*delta.Locator
}

func (b Case_type_repeated) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_repeated(l []*delta.Locator) Case_type_repeated {
	return Case_type_repeated{location: l}
}
func (b Case_type_repeated) Index(i int) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Index{Index: int64(i)}}))
}
func (b Case_type_repeated) Index64(i int64) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Index{Index: i}}))
}

type Case_type_bool_map struct {
	location []*delta.Locator
}

func (b Case_type_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_bool_map(l []*delta.Locator) Case_type_bool_map {
	return Case_type_bool_map{location: l}
}
func (b Case_type_bool_map) Key(k bool) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Bool{Bool: k}}}}))
}

type Case_type_int32_map struct {
	location []*delta.Locator
}

func (b Case_type_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_int32_map(l []*delta.Locator) Case_type_int32_map {
	return Case_type_int32_map{location: l}
}
func (b Case_type_int32_map) Key(k int) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int32{Int32: int32(k)}}}}))
}
func (b Case_type_int32_map) Key32(k int32) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int32{Int32: k}}}}))
}

type Case_type_int64_map struct {
	location []*delta.Locator
}

func (b Case_type_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_int64_map(l []*delta.Locator) Case_type_int64_map {
	return Case_type_int64_map{location: l}
}
func (b Case_type_int64_map) Key(k int) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int64{Int64: int64(k)}}}}))
}
func (b Case_type_int64_map) Key64(k int64) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int64{Int64: k}}}}))
}

type Case_type_uint32_map struct {
	location []*delta.Locator
}

func (b Case_type_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_uint32_map(l []*delta.Locator) Case_type_uint32_map {
	return Case_type_uint32_map{location: l}
}
func (b Case_type_uint32_map) Key(k int) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint32{Uint32: uint32(k)}}}}))
}
func (b Case_type_uint32_map) Key32(k uint32) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint32{Uint32: k}}}}))
}

type Case_type_uint64_map struct {
	location []*delta.Locator
}

func (b Case_type_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_uint64_map(l []*delta.Locator) Case_type_uint64_map {
	return Case_type_uint64_map{location: l}
}
func (b Case_type_uint64_map) Key(k int) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint64{Uint64: uint64(k)}}}}))
}
func (b Case_type_uint64_map) Key64(k uint64) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint64{Uint64: k}}}}))
}

type Case_type_string_map struct {
	location []*delta.Locator
}

func (b Case_type_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_string_map(l []*delta.Locator) Case_type_string_map {
	return Case_type_string_map{location: l}
}
func (b Case_type_string_map) Key(k string) Case_type {
	return NewCase_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_String_{String_: k}}}}))
}
func CaseDef() Case_type {
	return Case_type{}
}
func (b Case_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "name",
		Number: int32(12),
	}}}))
}

type Person_type struct {
	location []*delta.Locator
}

func (b Person_type) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type(l []*delta.Locator) Person_type {
	return Person_type{location: l}
}

type Person_type_repeated struct {
	location []*delta.Locator
}

func (b Person_type_repeated) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_repeated(l []*delta.Locator) Person_type_repeated {
	return Person_type_repeated{location: l}
}
func (b Person_type_repeated) Index(i int) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Index{Index: int64(i)}}))
}
func (b Person_type_repeated) Index64(i int64) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Index{Index: i}}))
}

type Person_type_bool_map struct {
	location []*delta.Locator
}

func (b Person_type_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_bool_map(l []*delta.Locator) Person_type_bool_map {
	return Person_type_bool_map{location: l}
}
func (b Person_type_bool_map) Key(k bool) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Bool{Bool: k}}}}))
}

type Person_type_int32_map struct {
	location []*delta.Locator
}

func (b Person_type_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_int32_map(l []*delta.Locator) Person_type_int32_map {
	return Person_type_int32_map{location: l}
}
func (b Person_type_int32_map) Key(k int) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int32{Int32: int32(k)}}}}))
}
func (b Person_type_int32_map) Key32(k int32) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int32{Int32: k}}}}))
}

type Person_type_int64_map struct {
	location []*delta.Locator
}

func (b Person_type_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_int64_map(l []*delta.Locator) Person_type_int64_map {
	return Person_type_int64_map{location: l}
}
func (b Person_type_int64_map) Key(k int) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int64{Int64: int64(k)}}}}))
}
func (b Person_type_int64_map) Key64(k int64) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Int64{Int64: k}}}}))
}

type Person_type_uint32_map struct {
	location []*delta.Locator
}

func (b Person_type_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_uint32_map(l []*delta.Locator) Person_type_uint32_map {
	return Person_type_uint32_map{location: l}
}
func (b Person_type_uint32_map) Key(k int) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint32{Uint32: uint32(k)}}}}))
}
func (b Person_type_uint32_map) Key32(k uint32) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint32{Uint32: k}}}}))
}

type Person_type_uint64_map struct {
	location []*delta.Locator
}

func (b Person_type_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_uint64_map(l []*delta.Locator) Person_type_uint64_map {
	return Person_type_uint64_map{location: l}
}
func (b Person_type_uint64_map) Key(k int) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint64{Uint64: uint64(k)}}}}))
}
func (b Person_type_uint64_map) Key64(k uint64) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_Uint64{Uint64: k}}}}))
}

type Person_type_string_map struct {
	location []*delta.Locator
}

func (b Person_type_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_string_map(l []*delta.Locator) Person_type_string_map {
	return Person_type_string_map{location: l}
}
func (b Person_type_string_map) Key(k string) Person_type {
	return NewPerson_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Key{Key: &delta.Key{V: &delta.Key_String_{String_: k}}}}))
}
func PersonDef() Person_type {
	return Person_type{}
}
func (b Person_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "name",
		Number: int32(13),
	}}}))
}
func (b Person_type) Age() delta.Int32_scalar {
	return delta.NewInt32_scalar(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "age",
		Number: int32(14),
	}}}))
}
func (b Person_type) Cases() Case_type_repeated {
	return NewCase_type_repeated(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "cases",
		Number: int32(15),
	}}}))
}
func (b Person_type) CasesStringMap() Case_type_string_map {
	return NewCase_type_string_map(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "casesStringMap",
		Number: int32(16),
	}}}))
}
func (b Person_type) CasesIntMap() Case_type_int32_map {
	return NewCase_type_int32_map(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "casesIntMap",
		Number: int32(17),
	}}}))
}
func (b Person_type) Company() Company_type {
	return NewCompany_type(delta.CopyAndAppend(b.location, &delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{
		Name:   "company",
		Number: int32(18),
	}}}))
}
