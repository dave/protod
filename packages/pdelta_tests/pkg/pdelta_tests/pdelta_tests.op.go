package pdelta_tests

import (
	"github.com/dave/protod/packages/pdelta/pkg/pdelta"
	"github.com/dave/protod/packages/pdelta_tests_clothes/pkg/pdelta_tests_clothes"
	"github.com/dave/protod/packages/pdelta_tests_clothes/pkg/pdelta_tests_clothes/pants"
)

func Op() Op_root_type {
	return Op_root_type{}
}

type Op_root_type struct{}

func (Op_root_type) Case() Case_type {
	return Case_type{}
}
func (Op_root_type) Chooser() Chooser_type {
	return Chooser_type{}
}
func (Op_root_type) Company() Company_type {
	return Company_type{}
}
func (Op_root_type) House() House_type {
	return House_type{}
}
func (Op_root_type) Item() Item_type {
	return Item_type{}
}
func (Op_root_type) Person() Person_type {
	return Person_type{}
}
func (Op_root_type) Person_Embed() Person_Embed_type {
	return Person_Embed_type{}
}
func (Op_root_type) Person_Embed_Double() Person_Embed_Double_type {
	return Person_Embed_Double_type{}
}

type Case_type struct {
	location []*pdelta.Locator
}

func (b Case_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_type(l []*pdelta.Locator) Case_type {
	return Case_type{location: l}
}
func (b Case_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_type) Set(value *Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Case_type) Name() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Case", "name", 21))
}
func (b Case_type) Items() Item_list {
	return NewItem_list(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Case", "items", 22))
}
func (b Case_type) Flags() pdelta.String_int64_map {
	return pdelta.NewString_int64_map(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Case", "flags", 23))
}

type Case_list struct {
	location []*pdelta.Locator
}

func (b Case_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_list(l []*pdelta.Locator) Case_list {
	return Case_list{location: l}
}
func (b Case_list) Index(i int) Case_type {
	return NewCase_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Case_list) Insert(index int, value *Case) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Case_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Case_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_list) Set(value []*Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Case_bool_map struct {
	location []*pdelta.Locator
}

func (b Case_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_bool_map(l []*pdelta.Locator) Case_bool_map {
	return Case_bool_map{location: l}
}
func (b Case_bool_map) Key(key bool) Case_type {
	return NewCase_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Case_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Case_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_bool_map) Set(value map[bool]*Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Case_int32_map struct {
	location []*pdelta.Locator
}

func (b Case_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_int32_map(l []*pdelta.Locator) Case_int32_map {
	return Case_int32_map{location: l}
}
func (b Case_int32_map) Key(key int) Case_type {
	return NewCase_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Case_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Case_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_int32_map) Set(value map[int32]*Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Case_int64_map struct {
	location []*pdelta.Locator
}

func (b Case_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_int64_map(l []*pdelta.Locator) Case_int64_map {
	return Case_int64_map{location: l}
}
func (b Case_int64_map) Key(key int) Case_type {
	return NewCase_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Case_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Case_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_int64_map) Set(value map[int64]*Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Case_uint32_map struct {
	location []*pdelta.Locator
}

func (b Case_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_uint32_map(l []*pdelta.Locator) Case_uint32_map {
	return Case_uint32_map{location: l}
}
func (b Case_uint32_map) Key(key int) Case_type {
	return NewCase_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Case_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Case_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_uint32_map) Set(value map[uint32]*Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Case_uint64_map struct {
	location []*pdelta.Locator
}

func (b Case_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_uint64_map(l []*pdelta.Locator) Case_uint64_map {
	return Case_uint64_map{location: l}
}
func (b Case_uint64_map) Key(key int) Case_type {
	return NewCase_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Case_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Case_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_uint64_map) Set(value map[uint64]*Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Case_string_map struct {
	location []*pdelta.Locator
}

func (b Case_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCase_string_map(l []*pdelta.Locator) Case_string_map {
	return Case_string_map{location: l}
}
func (b Case_string_map) Key(key string) Case_type {
	return NewCase_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Case_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Case_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Case_string_map) Set(value map[string]*Case) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_type struct {
	location []*pdelta.Locator
}

func (b Chooser_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_type(l []*pdelta.Locator) Chooser_type {
	return Chooser_type{location: l}
}
func (b Chooser_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_type) Set(value *Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Chooser_type) Choice() Chooser_Choice_oneof {
	return NewChooser_Choice_oneof(pdelta.CopyAndAppendOneof(b.location, "choice", &pdelta.Field{
		MessageFullName: "pdelta_tests.Chooser",
		Name:            "str",
		Number:          1,
	}, &pdelta.Field{
		MessageFullName: "pdelta_tests.Chooser",
		Name:            "dbl",
		Number:          2,
	}, &pdelta.Field{
		MessageFullName: "pdelta_tests.Chooser",
		Name:            "itm",
		Number:          3,
	}))
}

type Chooser_list struct {
	location []*pdelta.Locator
}

func (b Chooser_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_list(l []*pdelta.Locator) Chooser_list {
	return Chooser_list{location: l}
}
func (b Chooser_list) Index(i int) Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Chooser_list) Insert(index int, value *Chooser) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Chooser_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Chooser_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_list) Set(value []*Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_bool_map struct {
	location []*pdelta.Locator
}

func (b Chooser_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_bool_map(l []*pdelta.Locator) Chooser_bool_map {
	return Chooser_bool_map{location: l}
}
func (b Chooser_bool_map) Key(key bool) Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Chooser_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Chooser_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_bool_map) Set(value map[bool]*Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_int32_map struct {
	location []*pdelta.Locator
}

func (b Chooser_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_int32_map(l []*pdelta.Locator) Chooser_int32_map {
	return Chooser_int32_map{location: l}
}
func (b Chooser_int32_map) Key(key int) Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Chooser_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Chooser_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_int32_map) Set(value map[int32]*Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_int64_map struct {
	location []*pdelta.Locator
}

func (b Chooser_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_int64_map(l []*pdelta.Locator) Chooser_int64_map {
	return Chooser_int64_map{location: l}
}
func (b Chooser_int64_map) Key(key int) Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Chooser_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Chooser_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_int64_map) Set(value map[int64]*Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_uint32_map struct {
	location []*pdelta.Locator
}

func (b Chooser_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_uint32_map(l []*pdelta.Locator) Chooser_uint32_map {
	return Chooser_uint32_map{location: l}
}
func (b Chooser_uint32_map) Key(key int) Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Chooser_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Chooser_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_uint32_map) Set(value map[uint32]*Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_uint64_map struct {
	location []*pdelta.Locator
}

func (b Chooser_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_uint64_map(l []*pdelta.Locator) Chooser_uint64_map {
	return Chooser_uint64_map{location: l}
}
func (b Chooser_uint64_map) Key(key int) Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Chooser_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Chooser_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_uint64_map) Set(value map[uint64]*Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_string_map struct {
	location []*pdelta.Locator
}

func (b Chooser_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_string_map(l []*pdelta.Locator) Chooser_string_map {
	return Chooser_string_map{location: l}
}
func (b Chooser_string_map) Key(key string) Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Chooser_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Chooser_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_string_map) Set(value map[string]*Chooser) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Chooser_Choice_oneof struct {
	location []*pdelta.Locator
}

func (b Chooser_Choice_oneof) Location_get() []*pdelta.Locator {
	return b.location
}
func NewChooser_Choice_oneof(l []*pdelta.Locator) Chooser_Choice_oneof {
	return Chooser_Choice_oneof{location: l}
}
func (b Chooser_Choice_oneof) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Chooser_Choice_oneof) Str() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Chooser", "str", 1))
}
func (b Chooser_Choice_oneof) Dbl() pdelta.Double_scalar {
	return pdelta.NewDouble_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Chooser", "dbl", 2))
}
func (b Chooser_Choice_oneof) Itm() Item_type {
	return NewItem_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Chooser", "itm", 3))
}

type Company_type struct {
	location []*pdelta.Locator
}

func (b Company_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_type(l []*pdelta.Locator) Company_type {
	return Company_type{location: l}
}
func (b Company_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_type) Set(value *Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Company_type) Name() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Company", "name", 11))
}
func (b Company_type) Revenue() pdelta.Float_scalar {
	return pdelta.NewFloat_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Company", "revenue", 12))
}
func (b Company_type) Flags() pdelta.String_int64_map {
	return pdelta.NewString_int64_map(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Company", "flags", 13))
}
func (b Company_type) Ceo() Person_type {
	return NewPerson_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Company", "ceo", 14))
}

type Company_list struct {
	location []*pdelta.Locator
}

func (b Company_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_list(l []*pdelta.Locator) Company_list {
	return Company_list{location: l}
}
func (b Company_list) Index(i int) Company_type {
	return NewCompany_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Company_list) Insert(index int, value *Company) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Company_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Company_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_list) Set(value []*Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Company_bool_map struct {
	location []*pdelta.Locator
}

func (b Company_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_bool_map(l []*pdelta.Locator) Company_bool_map {
	return Company_bool_map{location: l}
}
func (b Company_bool_map) Key(key bool) Company_type {
	return NewCompany_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Company_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Company_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_bool_map) Set(value map[bool]*Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Company_int32_map struct {
	location []*pdelta.Locator
}

func (b Company_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_int32_map(l []*pdelta.Locator) Company_int32_map {
	return Company_int32_map{location: l}
}
func (b Company_int32_map) Key(key int) Company_type {
	return NewCompany_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Company_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Company_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_int32_map) Set(value map[int32]*Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Company_int64_map struct {
	location []*pdelta.Locator
}

func (b Company_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_int64_map(l []*pdelta.Locator) Company_int64_map {
	return Company_int64_map{location: l}
}
func (b Company_int64_map) Key(key int) Company_type {
	return NewCompany_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Company_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Company_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_int64_map) Set(value map[int64]*Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Company_uint32_map struct {
	location []*pdelta.Locator
}

func (b Company_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_uint32_map(l []*pdelta.Locator) Company_uint32_map {
	return Company_uint32_map{location: l}
}
func (b Company_uint32_map) Key(key int) Company_type {
	return NewCompany_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Company_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Company_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_uint32_map) Set(value map[uint32]*Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Company_uint64_map struct {
	location []*pdelta.Locator
}

func (b Company_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_uint64_map(l []*pdelta.Locator) Company_uint64_map {
	return Company_uint64_map{location: l}
}
func (b Company_uint64_map) Key(key int) Company_type {
	return NewCompany_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Company_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Company_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_uint64_map) Set(value map[uint64]*Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Company_string_map struct {
	location []*pdelta.Locator
}

func (b Company_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewCompany_string_map(l []*pdelta.Locator) Company_string_map {
	return Company_string_map{location: l}
}
func (b Company_string_map) Key(key string) Company_type {
	return NewCompany_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Company_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Company_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Company_string_map) Set(value map[string]*Company) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type House_type struct {
	location []*pdelta.Locator
}

func (b House_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_type(l []*pdelta.Locator) House_type {
	return House_type{location: l}
}
func (b House_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_type) Set(value *House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b House_type) Name() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.House", "name", 1))
}
func (b House_type) Number() pdelta.Uint32_scalar {
	return pdelta.NewUint32_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.House", "number", 2))
}

type House_list struct {
	location []*pdelta.Locator
}

func (b House_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_list(l []*pdelta.Locator) House_list {
	return House_list{location: l}
}
func (b House_list) Index(i int) House_type {
	return NewHouse_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b House_list) Insert(index int, value *House) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b House_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b House_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_list) Set(value []*House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type House_bool_map struct {
	location []*pdelta.Locator
}

func (b House_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_bool_map(l []*pdelta.Locator) House_bool_map {
	return House_bool_map{location: l}
}
func (b House_bool_map) Key(key bool) House_type {
	return NewHouse_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b House_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b House_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_bool_map) Set(value map[bool]*House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type House_int32_map struct {
	location []*pdelta.Locator
}

func (b House_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_int32_map(l []*pdelta.Locator) House_int32_map {
	return House_int32_map{location: l}
}
func (b House_int32_map) Key(key int) House_type {
	return NewHouse_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b House_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b House_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_int32_map) Set(value map[int32]*House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type House_int64_map struct {
	location []*pdelta.Locator
}

func (b House_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_int64_map(l []*pdelta.Locator) House_int64_map {
	return House_int64_map{location: l}
}
func (b House_int64_map) Key(key int) House_type {
	return NewHouse_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b House_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b House_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_int64_map) Set(value map[int64]*House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type House_uint32_map struct {
	location []*pdelta.Locator
}

func (b House_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_uint32_map(l []*pdelta.Locator) House_uint32_map {
	return House_uint32_map{location: l}
}
func (b House_uint32_map) Key(key int) House_type {
	return NewHouse_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b House_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b House_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_uint32_map) Set(value map[uint32]*House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type House_uint64_map struct {
	location []*pdelta.Locator
}

func (b House_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_uint64_map(l []*pdelta.Locator) House_uint64_map {
	return House_uint64_map{location: l}
}
func (b House_uint64_map) Key(key int) House_type {
	return NewHouse_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b House_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b House_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_uint64_map) Set(value map[uint64]*House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type House_string_map struct {
	location []*pdelta.Locator
}

func (b House_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewHouse_string_map(l []*pdelta.Locator) House_string_map {
	return House_string_map{location: l}
}
func (b House_string_map) Key(key string) House_type {
	return NewHouse_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b House_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b House_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b House_string_map) Set(value map[string]*House) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Item_type struct {
	location []*pdelta.Locator
}

func (b Item_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_type(l []*pdelta.Locator) Item_type {
	return Item_type{location: l}
}
func (b Item_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_type) Set(value *Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Item_type) Title() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Item", "title", 31))
}
func (b Item_type) Done() pdelta.Bool_scalar {
	return pdelta.NewBool_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Item", "done", 34))
}
func (b Item_type) Flags() pdelta.String_list {
	return pdelta.NewString_list(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Item", "flags", 35))
}

type Item_list struct {
	location []*pdelta.Locator
}

func (b Item_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_list(l []*pdelta.Locator) Item_list {
	return Item_list{location: l}
}
func (b Item_list) Index(i int) Item_type {
	return NewItem_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Item_list) Insert(index int, value *Item) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Item_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Item_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_list) Set(value []*Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Item_bool_map struct {
	location []*pdelta.Locator
}

func (b Item_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_bool_map(l []*pdelta.Locator) Item_bool_map {
	return Item_bool_map{location: l}
}
func (b Item_bool_map) Key(key bool) Item_type {
	return NewItem_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Item_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Item_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_bool_map) Set(value map[bool]*Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Item_int32_map struct {
	location []*pdelta.Locator
}

func (b Item_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_int32_map(l []*pdelta.Locator) Item_int32_map {
	return Item_int32_map{location: l}
}
func (b Item_int32_map) Key(key int) Item_type {
	return NewItem_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Item_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Item_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_int32_map) Set(value map[int32]*Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Item_int64_map struct {
	location []*pdelta.Locator
}

func (b Item_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_int64_map(l []*pdelta.Locator) Item_int64_map {
	return Item_int64_map{location: l}
}
func (b Item_int64_map) Key(key int) Item_type {
	return NewItem_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Item_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Item_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_int64_map) Set(value map[int64]*Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Item_uint32_map struct {
	location []*pdelta.Locator
}

func (b Item_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_uint32_map(l []*pdelta.Locator) Item_uint32_map {
	return Item_uint32_map{location: l}
}
func (b Item_uint32_map) Key(key int) Item_type {
	return NewItem_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Item_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Item_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_uint32_map) Set(value map[uint32]*Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Item_uint64_map struct {
	location []*pdelta.Locator
}

func (b Item_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_uint64_map(l []*pdelta.Locator) Item_uint64_map {
	return Item_uint64_map{location: l}
}
func (b Item_uint64_map) Key(key int) Item_type {
	return NewItem_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Item_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Item_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_uint64_map) Set(value map[uint64]*Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Item_string_map struct {
	location []*pdelta.Locator
}

func (b Item_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewItem_string_map(l []*pdelta.Locator) Item_string_map {
	return Item_string_map{location: l}
}
func (b Item_string_map) Key(key string) Item_type {
	return NewItem_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Item_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Item_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Item_string_map) Set(value map[string]*Item) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_type struct {
	location []*pdelta.Locator
}

func (b Person_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_type(l []*pdelta.Locator) Person_type {
	return Person_type{location: l}
}
func (b Person_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_type) Set(value *Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Person_type) Name() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "name", 1))
}
func (b Person_type) Age() pdelta.Uint32_scalar {
	return pdelta.NewUint32_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "age", 2))
}
func (b Person_type) Cases() Case_string_map {
	return NewCase_string_map(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "cases", 4))
}
func (b Person_type) Company() Company_type {
	return NewCompany_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "company", 5))
}
func (b Person_type) Alias() pdelta.String_list {
	return pdelta.NewString_list(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "alias", 6))
}
func (b Person_type) Type() Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "type", 7))
}
func (b Person_type) TypeList() Person_Type_list {
	return NewPerson_Type_list(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "typeList", 8))
}
func (b Person_type) TypeMap() Person_Type_string_map {
	return NewPerson_Type_string_map(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "typeMap", 9))
}
func (b Person_type) Embedded() Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "embedded", 10))
}
func (b Person_type) Choice() Person_Choice_oneof {
	return NewPerson_Choice_oneof(pdelta.CopyAndAppendOneof(b.location, "choice", &pdelta.Field{
		MessageFullName: "pdelta_tests.Person",
		Name:            "str",
		Number:          11,
	}, &pdelta.Field{
		MessageFullName: "pdelta_tests.Person",
		Name:            "dbl",
		Number:          12,
	}, &pdelta.Field{
		MessageFullName: "pdelta_tests.Person",
		Name:            "itm",
		Number:          13,
	}, &pdelta.Field{
		MessageFullName: "pdelta_tests.Person",
		Name:            "cas",
		Number:          14,
	}, &pdelta.Field{
		MessageFullName: "pdelta_tests.Person",
		Name:            "cho",
		Number:          15,
	}))
}
func (b Person_type) House() House_type {
	return NewHouse_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "house", 16))
}
func (b Person_type) Shirt() pdelta_tests_clothes.Shirt_type {
	return pdelta_tests_clothes.NewShirt_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "shirt", 17))
}
func (b Person_type) Pants() pants.Pants_type {
	return pants.NewPants_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "pants", 18))
}
func (b Person_type) Double() Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "double", 19))
}

type Person_list struct {
	location []*pdelta.Locator
}

func (b Person_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_list(l []*pdelta.Locator) Person_list {
	return Person_list{location: l}
}
func (b Person_list) Index(i int) Person_type {
	return NewPerson_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_list) Insert(index int, value *Person) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_list) Set(value []*Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_bool_map struct {
	location []*pdelta.Locator
}

func (b Person_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_bool_map(l []*pdelta.Locator) Person_bool_map {
	return Person_bool_map{location: l}
}
func (b Person_bool_map) Key(key bool) Person_type {
	return NewPerson_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_bool_map) Set(value map[bool]*Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_int32_map struct {
	location []*pdelta.Locator
}

func (b Person_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_int32_map(l []*pdelta.Locator) Person_int32_map {
	return Person_int32_map{location: l}
}
func (b Person_int32_map) Key(key int) Person_type {
	return NewPerson_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_int32_map) Set(value map[int32]*Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_int64_map struct {
	location []*pdelta.Locator
}

func (b Person_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_int64_map(l []*pdelta.Locator) Person_int64_map {
	return Person_int64_map{location: l}
}
func (b Person_int64_map) Key(key int) Person_type {
	return NewPerson_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_int64_map) Set(value map[int64]*Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_uint32_map struct {
	location []*pdelta.Locator
}

func (b Person_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_uint32_map(l []*pdelta.Locator) Person_uint32_map {
	return Person_uint32_map{location: l}
}
func (b Person_uint32_map) Key(key int) Person_type {
	return NewPerson_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_uint32_map) Set(value map[uint32]*Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_uint64_map struct {
	location []*pdelta.Locator
}

func (b Person_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_uint64_map(l []*pdelta.Locator) Person_uint64_map {
	return Person_uint64_map{location: l}
}
func (b Person_uint64_map) Key(key int) Person_type {
	return NewPerson_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_uint64_map) Set(value map[uint64]*Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_string_map struct {
	location []*pdelta.Locator
}

func (b Person_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_string_map(l []*pdelta.Locator) Person_string_map {
	return Person_string_map{location: l}
}
func (b Person_string_map) Key(key string) Person_type {
	return NewPerson_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_string_map) Set(value map[string]*Person) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Choice_oneof struct {
	location []*pdelta.Locator
}

func (b Person_Choice_oneof) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Choice_oneof(l []*pdelta.Locator) Person_Choice_oneof {
	return Person_Choice_oneof{location: l}
}
func (b Person_Choice_oneof) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Choice_oneof) Str() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "str", 11))
}
func (b Person_Choice_oneof) Dbl() pdelta.Double_scalar {
	return pdelta.NewDouble_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "dbl", 12))
}
func (b Person_Choice_oneof) Itm() Item_type {
	return NewItem_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "itm", 13))
}
func (b Person_Choice_oneof) Cas() Case_type {
	return NewCase_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "cas", 14))
}
func (b Person_Choice_oneof) Cho() Chooser_type {
	return NewChooser_type(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Person", "cho", 15))
}

type Person_Embed_type struct {
	location []*pdelta.Locator
}

func (b Person_Embed_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_type(l []*pdelta.Locator) Person_Embed_type {
	return Person_Embed_type{location: l}
}
func (b Person_Embed_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_type) Set(value *Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Person_Embed_type) Name() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Embed", "name", 1))
}

type Person_Embed_list struct {
	location []*pdelta.Locator
}

func (b Person_Embed_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_list(l []*pdelta.Locator) Person_Embed_list {
	return Person_Embed_list{location: l}
}
func (b Person_Embed_list) Index(i int) Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_Embed_list) Insert(index int, value *Person_Embed) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_Embed_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_Embed_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_list) Set(value []*Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_bool_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_bool_map(l []*pdelta.Locator) Person_Embed_bool_map {
	return Person_Embed_bool_map{location: l}
}
func (b Person_Embed_bool_map) Key(key bool) Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_Embed_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_Embed_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_bool_map) Set(value map[bool]*Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_int32_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_int32_map(l []*pdelta.Locator) Person_Embed_int32_map {
	return Person_Embed_int32_map{location: l}
}
func (b Person_Embed_int32_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_Embed_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_Embed_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_int32_map) Set(value map[int32]*Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_int64_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_int64_map(l []*pdelta.Locator) Person_Embed_int64_map {
	return Person_Embed_int64_map{location: l}
}
func (b Person_Embed_int64_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_Embed_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_Embed_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_int64_map) Set(value map[int64]*Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_uint32_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_uint32_map(l []*pdelta.Locator) Person_Embed_uint32_map {
	return Person_Embed_uint32_map{location: l}
}
func (b Person_Embed_uint32_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_Embed_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_Embed_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_uint32_map) Set(value map[uint32]*Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_uint64_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_uint64_map(l []*pdelta.Locator) Person_Embed_uint64_map {
	return Person_Embed_uint64_map{location: l}
}
func (b Person_Embed_uint64_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_Embed_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_Embed_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_uint64_map) Set(value map[uint64]*Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_string_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_string_map(l []*pdelta.Locator) Person_Embed_string_map {
	return Person_Embed_string_map{location: l}
}
func (b Person_Embed_string_map) Key(key string) Person_Embed_type {
	return NewPerson_Embed_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_Embed_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_Embed_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_string_map) Set(value map[string]*Person_Embed) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_type struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_type(l []*pdelta.Locator) Person_Embed_Double_type {
	return Person_Embed_Double_type{location: l}
}
func (b Person_Embed_Double_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_type) Set(value *Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Person_Embed_Double_type) Name() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Double", "name", 1))
}
func (b Person_Embed_Double_type) Foo() Person_Embed_Double_Foo_oneof {
	return NewPerson_Embed_Double_Foo_oneof(pdelta.CopyAndAppendOneof(b.location, "foo", &pdelta.Field{
		MessageFullName: "pdelta_tests.Double",
		Name:            "bar",
		Number:          2,
	}, &pdelta.Field{
		MessageFullName: "pdelta_tests.Double",
		Name:            "baz",
		Number:          3,
	}))
}

type Person_Embed_Double_list struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_list(l []*pdelta.Locator) Person_Embed_Double_list {
	return Person_Embed_Double_list{location: l}
}
func (b Person_Embed_Double_list) Index(i int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_Embed_Double_list) Insert(index int, value *Person_Embed_Double) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_Embed_Double_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_Embed_Double_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_list) Set(value []*Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_bool_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_bool_map(l []*pdelta.Locator) Person_Embed_Double_bool_map {
	return Person_Embed_Double_bool_map{location: l}
}
func (b Person_Embed_Double_bool_map) Key(key bool) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_Embed_Double_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_Embed_Double_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_bool_map) Set(value map[bool]*Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_int32_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_int32_map(l []*pdelta.Locator) Person_Embed_Double_int32_map {
	return Person_Embed_Double_int32_map{location: l}
}
func (b Person_Embed_Double_int32_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_Embed_Double_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_Embed_Double_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_int32_map) Set(value map[int32]*Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_int64_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_int64_map(l []*pdelta.Locator) Person_Embed_Double_int64_map {
	return Person_Embed_Double_int64_map{location: l}
}
func (b Person_Embed_Double_int64_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_Embed_Double_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_Embed_Double_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_int64_map) Set(value map[int64]*Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_uint32_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_uint32_map(l []*pdelta.Locator) Person_Embed_Double_uint32_map {
	return Person_Embed_Double_uint32_map{location: l}
}
func (b Person_Embed_Double_uint32_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_Embed_Double_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_Embed_Double_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_uint32_map) Set(value map[uint32]*Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_uint64_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_uint64_map(l []*pdelta.Locator) Person_Embed_Double_uint64_map {
	return Person_Embed_Double_uint64_map{location: l}
}
func (b Person_Embed_Double_uint64_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_Embed_Double_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_Embed_Double_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_uint64_map) Set(value map[uint64]*Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_string_map struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_string_map(l []*pdelta.Locator) Person_Embed_Double_string_map {
	return Person_Embed_Double_string_map{location: l}
}
func (b Person_Embed_Double_string_map) Key(key string) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_Embed_Double_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_Embed_Double_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_string_map) Set(value map[string]*Person_Embed_Double) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Embed_Double_Foo_oneof struct {
	location []*pdelta.Locator
}

func (b Person_Embed_Double_Foo_oneof) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Embed_Double_Foo_oneof(l []*pdelta.Locator) Person_Embed_Double_Foo_oneof {
	return Person_Embed_Double_Foo_oneof{location: l}
}
func (b Person_Embed_Double_Foo_oneof) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Embed_Double_Foo_oneof) Bar() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Double", "bar", 2))
}
func (b Person_Embed_Double_Foo_oneof) Baz() pdelta.Int64_scalar {
	return pdelta.NewInt64_scalar(pdelta.CopyAndAppendField(b.location, "pdelta_tests.Double", "baz", 3))
}

type Person_Type_enum struct {
	location []*pdelta.Locator
}

func (b Person_Type_enum) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_enum(l []*pdelta.Locator) Person_Type_enum {
	return Person_Type_enum{location: l}
}
func (b Person_Type_enum) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_enum) Set(value Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Type_list struct {
	location []*pdelta.Locator
}

func (b Person_Type_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_list(l []*pdelta.Locator) Person_Type_list {
	return Person_Type_list{location: l}
}
func (b Person_Type_list) Index(i int) Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_Type_list) Insert(index int, value Person_Type) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_Type_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_Type_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_list) Set(value []Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Type_bool_map struct {
	location []*pdelta.Locator
}

func (b Person_Type_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_bool_map(l []*pdelta.Locator) Person_Type_bool_map {
	return Person_Type_bool_map{location: l}
}
func (b Person_Type_bool_map) Key(key bool) Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_Type_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_Type_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_bool_map) Set(value map[bool]Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Type_int32_map struct {
	location []*pdelta.Locator
}

func (b Person_Type_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_int32_map(l []*pdelta.Locator) Person_Type_int32_map {
	return Person_Type_int32_map{location: l}
}
func (b Person_Type_int32_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_Type_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_Type_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_int32_map) Set(value map[int32]Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Type_int64_map struct {
	location []*pdelta.Locator
}

func (b Person_Type_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_int64_map(l []*pdelta.Locator) Person_Type_int64_map {
	return Person_Type_int64_map{location: l}
}
func (b Person_Type_int64_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_Type_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_Type_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_int64_map) Set(value map[int64]Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Type_uint32_map struct {
	location []*pdelta.Locator
}

func (b Person_Type_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_uint32_map(l []*pdelta.Locator) Person_Type_uint32_map {
	return Person_Type_uint32_map{location: l}
}
func (b Person_Type_uint32_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_Type_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_Type_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_uint32_map) Set(value map[uint32]Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Type_uint64_map struct {
	location []*pdelta.Locator
}

func (b Person_Type_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_uint64_map(l []*pdelta.Locator) Person_Type_uint64_map {
	return Person_Type_uint64_map{location: l}
}
func (b Person_Type_uint64_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_Type_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_Type_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_uint64_map) Set(value map[uint64]Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Person_Type_string_map struct {
	location []*pdelta.Locator
}

func (b Person_Type_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPerson_Type_string_map(l []*pdelta.Locator) Person_Type_string_map {
	return Person_Type_string_map{location: l}
}
func (b Person_Type_string_map) Key(key string) Person_Type_enum {
	return NewPerson_Type_enum(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_Type_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_Type_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Person_Type_string_map) Set(value map[string]Person_Type) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
