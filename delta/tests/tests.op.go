package tests

import (
	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/tests2"
	"github.com/dave/protod/delta/tests2/tests3"
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
	location []*delta.Locator
}

func (b Case_type) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type(l []*delta.Locator) Case_type {
	return Case_type{location: l}
}
func (b Case_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type) Set(value *Case) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Case_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 21))
}
func (b Case_type) Items() Item_list {
	return NewItem_list(delta.CopyAndAppendField(b.location, "items", 22))
}
func (b Case_type) Flags() delta.String_int64_map {
	return delta.NewString_int64_map(delta.CopyAndAppendField(b.location, "flags", 23))
}

type Case_list struct {
	location []*delta.Locator
}

func (b Case_list) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_list(l []*delta.Locator) Case_list {
	return Case_list{location: l}
}
func (b Case_list) Index(i int) Case_type {
	return NewCase_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Case_list) Insert(index int, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Case_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Case_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_list) Set(value []*Case) *delta.Op {
	return delta.Set(b.location, value)
}

type Case_bool_map struct {
	location []*delta.Locator
}

func (b Case_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_bool_map(l []*delta.Locator) Case_bool_map {
	return Case_bool_map{location: l}
}
func (b Case_bool_map) Key(key bool) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Case_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Case_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_bool_map) Set(value map[bool]*Case) *delta.Op {
	return delta.Set(b.location, value)
}

type Case_int32_map struct {
	location []*delta.Locator
}

func (b Case_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_int32_map(l []*delta.Locator) Case_int32_map {
	return Case_int32_map{location: l}
}
func (b Case_int32_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Case_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Case_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_int32_map) Set(value map[int32]*Case) *delta.Op {
	return delta.Set(b.location, value)
}

type Case_int64_map struct {
	location []*delta.Locator
}

func (b Case_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_int64_map(l []*delta.Locator) Case_int64_map {
	return Case_int64_map{location: l}
}
func (b Case_int64_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Case_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Case_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_int64_map) Set(value map[int64]*Case) *delta.Op {
	return delta.Set(b.location, value)
}

type Case_uint32_map struct {
	location []*delta.Locator
}

func (b Case_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_uint32_map(l []*delta.Locator) Case_uint32_map {
	return Case_uint32_map{location: l}
}
func (b Case_uint32_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Case_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Case_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_uint32_map) Set(value map[uint32]*Case) *delta.Op {
	return delta.Set(b.location, value)
}

type Case_uint64_map struct {
	location []*delta.Locator
}

func (b Case_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_uint64_map(l []*delta.Locator) Case_uint64_map {
	return Case_uint64_map{location: l}
}
func (b Case_uint64_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Case_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Case_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_uint64_map) Set(value map[uint64]*Case) *delta.Op {
	return delta.Set(b.location, value)
}

type Case_string_map struct {
	location []*delta.Locator
}

func (b Case_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_string_map(l []*delta.Locator) Case_string_map {
	return Case_string_map{location: l}
}
func (b Case_string_map) Key(key string) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Case_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Case_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_string_map) Set(value map[string]*Case) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_type struct {
	location []*delta.Locator
}

func (b Chooser_type) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_type(l []*delta.Locator) Chooser_type {
	return Chooser_type{location: l}
}
func (b Chooser_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_type) Set(value *Chooser) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Chooser_type) Choice() Chooser_Choice_oneof {
	return NewChooser_Choice_oneof(delta.CopyAndAppendOneof(b.location, "choice", &delta.Field{
		Name:   "str",
		Number: 1,
	}, &delta.Field{
		Name:   "dbl",
		Number: 2,
	}, &delta.Field{
		Name:   "itm",
		Number: 3,
	}))
}

type Chooser_list struct {
	location []*delta.Locator
}

func (b Chooser_list) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_list(l []*delta.Locator) Chooser_list {
	return Chooser_list{location: l}
}
func (b Chooser_list) Index(i int) Chooser_type {
	return NewChooser_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Chooser_list) Insert(index int, value *Chooser) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Chooser_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Chooser_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_list) Set(value []*Chooser) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_bool_map struct {
	location []*delta.Locator
}

func (b Chooser_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_bool_map(l []*delta.Locator) Chooser_bool_map {
	return Chooser_bool_map{location: l}
}
func (b Chooser_bool_map) Key(key bool) Chooser_type {
	return NewChooser_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Chooser_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Chooser_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_bool_map) Set(value map[bool]*Chooser) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_int32_map struct {
	location []*delta.Locator
}

func (b Chooser_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_int32_map(l []*delta.Locator) Chooser_int32_map {
	return Chooser_int32_map{location: l}
}
func (b Chooser_int32_map) Key(key int) Chooser_type {
	return NewChooser_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Chooser_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Chooser_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_int32_map) Set(value map[int32]*Chooser) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_int64_map struct {
	location []*delta.Locator
}

func (b Chooser_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_int64_map(l []*delta.Locator) Chooser_int64_map {
	return Chooser_int64_map{location: l}
}
func (b Chooser_int64_map) Key(key int) Chooser_type {
	return NewChooser_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Chooser_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Chooser_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_int64_map) Set(value map[int64]*Chooser) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_uint32_map struct {
	location []*delta.Locator
}

func (b Chooser_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_uint32_map(l []*delta.Locator) Chooser_uint32_map {
	return Chooser_uint32_map{location: l}
}
func (b Chooser_uint32_map) Key(key int) Chooser_type {
	return NewChooser_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Chooser_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Chooser_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_uint32_map) Set(value map[uint32]*Chooser) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_uint64_map struct {
	location []*delta.Locator
}

func (b Chooser_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_uint64_map(l []*delta.Locator) Chooser_uint64_map {
	return Chooser_uint64_map{location: l}
}
func (b Chooser_uint64_map) Key(key int) Chooser_type {
	return NewChooser_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Chooser_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Chooser_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_uint64_map) Set(value map[uint64]*Chooser) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_string_map struct {
	location []*delta.Locator
}

func (b Chooser_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_string_map(l []*delta.Locator) Chooser_string_map {
	return Chooser_string_map{location: l}
}
func (b Chooser_string_map) Key(key string) Chooser_type {
	return NewChooser_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Chooser_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Chooser_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_string_map) Set(value map[string]*Chooser) *delta.Op {
	return delta.Set(b.location, value)
}

type Chooser_Choice_oneof struct {
	location []*delta.Locator
}

func (b Chooser_Choice_oneof) Location_get() []*delta.Locator {
	return b.location
}
func NewChooser_Choice_oneof(l []*delta.Locator) Chooser_Choice_oneof {
	return Chooser_Choice_oneof{location: l}
}
func (b Chooser_Choice_oneof) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Chooser_Choice_oneof) Str() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "str", 1))
}
func (b Chooser_Choice_oneof) Dbl() delta.Double_scalar {
	return delta.NewDouble_scalar(delta.CopyAndAppendField(b.location, "dbl", 2))
}
func (b Chooser_Choice_oneof) Itm() Item_type {
	return NewItem_type(delta.CopyAndAppendField(b.location, "itm", 3))
}

type Company_type struct {
	location []*delta.Locator
}

func (b Company_type) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type(l []*delta.Locator) Company_type {
	return Company_type{location: l}
}
func (b Company_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type) Set(value *Company) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Company_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 11))
}
func (b Company_type) Revenue() delta.Float_scalar {
	return delta.NewFloat_scalar(delta.CopyAndAppendField(b.location, "revenue", 12))
}
func (b Company_type) Flags() delta.String_int64_map {
	return delta.NewString_int64_map(delta.CopyAndAppendField(b.location, "flags", 13))
}
func (b Company_type) Ceo() Person_type {
	return NewPerson_type(delta.CopyAndAppendField(b.location, "ceo", 14))
}

type Company_list struct {
	location []*delta.Locator
}

func (b Company_list) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_list(l []*delta.Locator) Company_list {
	return Company_list{location: l}
}
func (b Company_list) Index(i int) Company_type {
	return NewCompany_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Company_list) Insert(index int, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Company_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Company_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_list) Set(value []*Company) *delta.Op {
	return delta.Set(b.location, value)
}

type Company_bool_map struct {
	location []*delta.Locator
}

func (b Company_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_bool_map(l []*delta.Locator) Company_bool_map {
	return Company_bool_map{location: l}
}
func (b Company_bool_map) Key(key bool) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Company_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Company_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_bool_map) Set(value map[bool]*Company) *delta.Op {
	return delta.Set(b.location, value)
}

type Company_int32_map struct {
	location []*delta.Locator
}

func (b Company_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_int32_map(l []*delta.Locator) Company_int32_map {
	return Company_int32_map{location: l}
}
func (b Company_int32_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Company_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Company_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_int32_map) Set(value map[int32]*Company) *delta.Op {
	return delta.Set(b.location, value)
}

type Company_int64_map struct {
	location []*delta.Locator
}

func (b Company_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_int64_map(l []*delta.Locator) Company_int64_map {
	return Company_int64_map{location: l}
}
func (b Company_int64_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Company_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Company_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_int64_map) Set(value map[int64]*Company) *delta.Op {
	return delta.Set(b.location, value)
}

type Company_uint32_map struct {
	location []*delta.Locator
}

func (b Company_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_uint32_map(l []*delta.Locator) Company_uint32_map {
	return Company_uint32_map{location: l}
}
func (b Company_uint32_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Company_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Company_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_uint32_map) Set(value map[uint32]*Company) *delta.Op {
	return delta.Set(b.location, value)
}

type Company_uint64_map struct {
	location []*delta.Locator
}

func (b Company_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_uint64_map(l []*delta.Locator) Company_uint64_map {
	return Company_uint64_map{location: l}
}
func (b Company_uint64_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Company_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Company_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_uint64_map) Set(value map[uint64]*Company) *delta.Op {
	return delta.Set(b.location, value)
}

type Company_string_map struct {
	location []*delta.Locator
}

func (b Company_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_string_map(l []*delta.Locator) Company_string_map {
	return Company_string_map{location: l}
}
func (b Company_string_map) Key(key string) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Company_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Company_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_string_map) Set(value map[string]*Company) *delta.Op {
	return delta.Set(b.location, value)
}

type House_type struct {
	location []*delta.Locator
}

func (b House_type) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_type(l []*delta.Locator) House_type {
	return House_type{location: l}
}
func (b House_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_type) Set(value *House) *delta.Op {
	return delta.Set(b.location, value)
}
func (b House_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 1))
}
func (b House_type) Number() delta.Uint32_scalar {
	return delta.NewUint32_scalar(delta.CopyAndAppendField(b.location, "number", 2))
}

type House_list struct {
	location []*delta.Locator
}

func (b House_list) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_list(l []*delta.Locator) House_list {
	return House_list{location: l}
}
func (b House_list) Index(i int) House_type {
	return NewHouse_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b House_list) Insert(index int, value *House) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b House_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b House_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_list) Set(value []*House) *delta.Op {
	return delta.Set(b.location, value)
}

type House_bool_map struct {
	location []*delta.Locator
}

func (b House_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_bool_map(l []*delta.Locator) House_bool_map {
	return House_bool_map{location: l}
}
func (b House_bool_map) Key(key bool) House_type {
	return NewHouse_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b House_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b House_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_bool_map) Set(value map[bool]*House) *delta.Op {
	return delta.Set(b.location, value)
}

type House_int32_map struct {
	location []*delta.Locator
}

func (b House_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_int32_map(l []*delta.Locator) House_int32_map {
	return House_int32_map{location: l}
}
func (b House_int32_map) Key(key int) House_type {
	return NewHouse_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b House_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b House_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_int32_map) Set(value map[int32]*House) *delta.Op {
	return delta.Set(b.location, value)
}

type House_int64_map struct {
	location []*delta.Locator
}

func (b House_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_int64_map(l []*delta.Locator) House_int64_map {
	return House_int64_map{location: l}
}
func (b House_int64_map) Key(key int) House_type {
	return NewHouse_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b House_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b House_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_int64_map) Set(value map[int64]*House) *delta.Op {
	return delta.Set(b.location, value)
}

type House_uint32_map struct {
	location []*delta.Locator
}

func (b House_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_uint32_map(l []*delta.Locator) House_uint32_map {
	return House_uint32_map{location: l}
}
func (b House_uint32_map) Key(key int) House_type {
	return NewHouse_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b House_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b House_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_uint32_map) Set(value map[uint32]*House) *delta.Op {
	return delta.Set(b.location, value)
}

type House_uint64_map struct {
	location []*delta.Locator
}

func (b House_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_uint64_map(l []*delta.Locator) House_uint64_map {
	return House_uint64_map{location: l}
}
func (b House_uint64_map) Key(key int) House_type {
	return NewHouse_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b House_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b House_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_uint64_map) Set(value map[uint64]*House) *delta.Op {
	return delta.Set(b.location, value)
}

type House_string_map struct {
	location []*delta.Locator
}

func (b House_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewHouse_string_map(l []*delta.Locator) House_string_map {
	return House_string_map{location: l}
}
func (b House_string_map) Key(key string) House_type {
	return NewHouse_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b House_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b House_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b House_string_map) Set(value map[string]*House) *delta.Op {
	return delta.Set(b.location, value)
}

type Item_type struct {
	location []*delta.Locator
}

func (b Item_type) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type(l []*delta.Locator) Item_type {
	return Item_type{location: l}
}
func (b Item_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type) Set(value *Item) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Item_type) Title() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "title", 31))
}
func (b Item_type) Done() delta.Bool_scalar {
	return delta.NewBool_scalar(delta.CopyAndAppendField(b.location, "done", 34))
}
func (b Item_type) Flags() delta.String_list {
	return delta.NewString_list(delta.CopyAndAppendField(b.location, "flags", 35))
}

type Item_list struct {
	location []*delta.Locator
}

func (b Item_list) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_list(l []*delta.Locator) Item_list {
	return Item_list{location: l}
}
func (b Item_list) Index(i int) Item_type {
	return NewItem_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Item_list) Insert(index int, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Item_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Item_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_list) Set(value []*Item) *delta.Op {
	return delta.Set(b.location, value)
}

type Item_bool_map struct {
	location []*delta.Locator
}

func (b Item_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_bool_map(l []*delta.Locator) Item_bool_map {
	return Item_bool_map{location: l}
}
func (b Item_bool_map) Key(key bool) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Item_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Item_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_bool_map) Set(value map[bool]*Item) *delta.Op {
	return delta.Set(b.location, value)
}

type Item_int32_map struct {
	location []*delta.Locator
}

func (b Item_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_int32_map(l []*delta.Locator) Item_int32_map {
	return Item_int32_map{location: l}
}
func (b Item_int32_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Item_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Item_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_int32_map) Set(value map[int32]*Item) *delta.Op {
	return delta.Set(b.location, value)
}

type Item_int64_map struct {
	location []*delta.Locator
}

func (b Item_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_int64_map(l []*delta.Locator) Item_int64_map {
	return Item_int64_map{location: l}
}
func (b Item_int64_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Item_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Item_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_int64_map) Set(value map[int64]*Item) *delta.Op {
	return delta.Set(b.location, value)
}

type Item_uint32_map struct {
	location []*delta.Locator
}

func (b Item_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_uint32_map(l []*delta.Locator) Item_uint32_map {
	return Item_uint32_map{location: l}
}
func (b Item_uint32_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Item_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Item_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_uint32_map) Set(value map[uint32]*Item) *delta.Op {
	return delta.Set(b.location, value)
}

type Item_uint64_map struct {
	location []*delta.Locator
}

func (b Item_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_uint64_map(l []*delta.Locator) Item_uint64_map {
	return Item_uint64_map{location: l}
}
func (b Item_uint64_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Item_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Item_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_uint64_map) Set(value map[uint64]*Item) *delta.Op {
	return delta.Set(b.location, value)
}

type Item_string_map struct {
	location []*delta.Locator
}

func (b Item_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_string_map(l []*delta.Locator) Item_string_map {
	return Item_string_map{location: l}
}
func (b Item_string_map) Key(key string) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Item_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Item_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_string_map) Set(value map[string]*Item) *delta.Op {
	return delta.Set(b.location, value)
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
func (b Person_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type) Set(value *Person) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Person_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 1))
}
func (b Person_type) Age() delta.Uint32_scalar {
	return delta.NewUint32_scalar(delta.CopyAndAppendField(b.location, "age", 2))
}
func (b Person_type) Cases() Case_string_map {
	return NewCase_string_map(delta.CopyAndAppendField(b.location, "cases", 4))
}
func (b Person_type) Company() Company_type {
	return NewCompany_type(delta.CopyAndAppendField(b.location, "company", 5))
}
func (b Person_type) Alias() delta.String_list {
	return delta.NewString_list(delta.CopyAndAppendField(b.location, "alias", 6))
}
func (b Person_type) Type() Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendField(b.location, "type", 7))
}
func (b Person_type) TypeList() Person_Type_list {
	return NewPerson_Type_list(delta.CopyAndAppendField(b.location, "typeList", 8))
}
func (b Person_type) TypeMap() Person_Type_string_map {
	return NewPerson_Type_string_map(delta.CopyAndAppendField(b.location, "typeMap", 9))
}
func (b Person_type) Embedded() Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendField(b.location, "embedded", 10))
}
func (b Person_type) Choice() Person_Choice_oneof {
	return NewPerson_Choice_oneof(delta.CopyAndAppendOneof(b.location, "choice", &delta.Field{
		Name:   "str",
		Number: 11,
	}, &delta.Field{
		Name:   "dbl",
		Number: 12,
	}, &delta.Field{
		Name:   "itm",
		Number: 13,
	}, &delta.Field{
		Name:   "cas",
		Number: 14,
	}, &delta.Field{
		Name:   "cho",
		Number: 15,
	}))
}
func (b Person_type) House() House_type {
	return NewHouse_type(delta.CopyAndAppendField(b.location, "house", 16))
}
func (b Person_type) Shirt() tests2.Shirt_type {
	return tests2.NewShirt_type(delta.CopyAndAppendField(b.location, "shirt", 17))
}
func (b Person_type) Pants() tests3.Pants_type {
	return tests3.NewPants_type(delta.CopyAndAppendField(b.location, "pants", 18))
}
func (b Person_type) Double() Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendField(b.location, "double", 19))
}

type Person_list struct {
	location []*delta.Locator
}

func (b Person_list) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_list(l []*delta.Locator) Person_list {
	return Person_list{location: l}
}
func (b Person_list) Index(i int) Person_type {
	return NewPerson_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_list) Insert(index int, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_list) Set(value []*Person) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_bool_map struct {
	location []*delta.Locator
}

func (b Person_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_bool_map(l []*delta.Locator) Person_bool_map {
	return Person_bool_map{location: l}
}
func (b Person_bool_map) Key(key bool) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_bool_map) Set(value map[bool]*Person) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_int32_map struct {
	location []*delta.Locator
}

func (b Person_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_int32_map(l []*delta.Locator) Person_int32_map {
	return Person_int32_map{location: l}
}
func (b Person_int32_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_int32_map) Set(value map[int32]*Person) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_int64_map struct {
	location []*delta.Locator
}

func (b Person_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_int64_map(l []*delta.Locator) Person_int64_map {
	return Person_int64_map{location: l}
}
func (b Person_int64_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_int64_map) Set(value map[int64]*Person) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_uint32_map struct {
	location []*delta.Locator
}

func (b Person_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_uint32_map(l []*delta.Locator) Person_uint32_map {
	return Person_uint32_map{location: l}
}
func (b Person_uint32_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_uint32_map) Set(value map[uint32]*Person) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_uint64_map struct {
	location []*delta.Locator
}

func (b Person_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_uint64_map(l []*delta.Locator) Person_uint64_map {
	return Person_uint64_map{location: l}
}
func (b Person_uint64_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_uint64_map) Set(value map[uint64]*Person) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_string_map struct {
	location []*delta.Locator
}

func (b Person_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_string_map(l []*delta.Locator) Person_string_map {
	return Person_string_map{location: l}
}
func (b Person_string_map) Key(key string) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_string_map) Set(value map[string]*Person) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Choice_oneof struct {
	location []*delta.Locator
}

func (b Person_Choice_oneof) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Choice_oneof(l []*delta.Locator) Person_Choice_oneof {
	return Person_Choice_oneof{location: l}
}
func (b Person_Choice_oneof) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Choice_oneof) Str() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "str", 11))
}
func (b Person_Choice_oneof) Dbl() delta.Double_scalar {
	return delta.NewDouble_scalar(delta.CopyAndAppendField(b.location, "dbl", 12))
}
func (b Person_Choice_oneof) Itm() Item_type {
	return NewItem_type(delta.CopyAndAppendField(b.location, "itm", 13))
}
func (b Person_Choice_oneof) Cas() Case_type {
	return NewCase_type(delta.CopyAndAppendField(b.location, "cas", 14))
}
func (b Person_Choice_oneof) Cho() Chooser_type {
	return NewChooser_type(delta.CopyAndAppendField(b.location, "cho", 15))
}

type Person_Embed_type struct {
	location []*delta.Locator
}

func (b Person_Embed_type) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_type(l []*delta.Locator) Person_Embed_type {
	return Person_Embed_type{location: l}
}
func (b Person_Embed_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_type) Set(value *Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Person_Embed_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 1))
}

type Person_Embed_list struct {
	location []*delta.Locator
}

func (b Person_Embed_list) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_list(l []*delta.Locator) Person_Embed_list {
	return Person_Embed_list{location: l}
}
func (b Person_Embed_list) Index(i int) Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_Embed_list) Insert(index int, value *Person_Embed) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_Embed_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_Embed_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_list) Set(value []*Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_bool_map struct {
	location []*delta.Locator
}

func (b Person_Embed_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_bool_map(l []*delta.Locator) Person_Embed_bool_map {
	return Person_Embed_bool_map{location: l}
}
func (b Person_Embed_bool_map) Key(key bool) Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_Embed_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_Embed_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_bool_map) Set(value map[bool]*Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_int32_map struct {
	location []*delta.Locator
}

func (b Person_Embed_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_int32_map(l []*delta.Locator) Person_Embed_int32_map {
	return Person_Embed_int32_map{location: l}
}
func (b Person_Embed_int32_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_Embed_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_Embed_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_int32_map) Set(value map[int32]*Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_int64_map struct {
	location []*delta.Locator
}

func (b Person_Embed_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_int64_map(l []*delta.Locator) Person_Embed_int64_map {
	return Person_Embed_int64_map{location: l}
}
func (b Person_Embed_int64_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_Embed_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_Embed_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_int64_map) Set(value map[int64]*Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_uint32_map struct {
	location []*delta.Locator
}

func (b Person_Embed_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_uint32_map(l []*delta.Locator) Person_Embed_uint32_map {
	return Person_Embed_uint32_map{location: l}
}
func (b Person_Embed_uint32_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_Embed_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_Embed_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_uint32_map) Set(value map[uint32]*Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_uint64_map struct {
	location []*delta.Locator
}

func (b Person_Embed_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_uint64_map(l []*delta.Locator) Person_Embed_uint64_map {
	return Person_Embed_uint64_map{location: l}
}
func (b Person_Embed_uint64_map) Key(key int) Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_Embed_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_Embed_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_uint64_map) Set(value map[uint64]*Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_string_map struct {
	location []*delta.Locator
}

func (b Person_Embed_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_string_map(l []*delta.Locator) Person_Embed_string_map {
	return Person_Embed_string_map{location: l}
}
func (b Person_Embed_string_map) Key(key string) Person_Embed_type {
	return NewPerson_Embed_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_Embed_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_Embed_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_string_map) Set(value map[string]*Person_Embed) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_type struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_type) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_type(l []*delta.Locator) Person_Embed_Double_type {
	return Person_Embed_Double_type{location: l}
}
func (b Person_Embed_Double_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_type) Set(value *Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Person_Embed_Double_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 1))
}
func (b Person_Embed_Double_type) Foo() Person_Embed_Double_Foo_oneof {
	return NewPerson_Embed_Double_Foo_oneof(delta.CopyAndAppendOneof(b.location, "foo", &delta.Field{
		Name:   "bar",
		Number: 2,
	}, &delta.Field{
		Name:   "baz",
		Number: 3,
	}))
}

type Person_Embed_Double_list struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_list) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_list(l []*delta.Locator) Person_Embed_Double_list {
	return Person_Embed_Double_list{location: l}
}
func (b Person_Embed_Double_list) Index(i int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_Embed_Double_list) Insert(index int, value *Person_Embed_Double) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_Embed_Double_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_Embed_Double_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_list) Set(value []*Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_bool_map struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_bool_map(l []*delta.Locator) Person_Embed_Double_bool_map {
	return Person_Embed_Double_bool_map{location: l}
}
func (b Person_Embed_Double_bool_map) Key(key bool) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_Embed_Double_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_Embed_Double_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_bool_map) Set(value map[bool]*Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_int32_map struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_int32_map(l []*delta.Locator) Person_Embed_Double_int32_map {
	return Person_Embed_Double_int32_map{location: l}
}
func (b Person_Embed_Double_int32_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_Embed_Double_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_Embed_Double_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_int32_map) Set(value map[int32]*Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_int64_map struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_int64_map(l []*delta.Locator) Person_Embed_Double_int64_map {
	return Person_Embed_Double_int64_map{location: l}
}
func (b Person_Embed_Double_int64_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_Embed_Double_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_Embed_Double_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_int64_map) Set(value map[int64]*Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_uint32_map struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_uint32_map(l []*delta.Locator) Person_Embed_Double_uint32_map {
	return Person_Embed_Double_uint32_map{location: l}
}
func (b Person_Embed_Double_uint32_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_Embed_Double_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_Embed_Double_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_uint32_map) Set(value map[uint32]*Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_uint64_map struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_uint64_map(l []*delta.Locator) Person_Embed_Double_uint64_map {
	return Person_Embed_Double_uint64_map{location: l}
}
func (b Person_Embed_Double_uint64_map) Key(key int) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_Embed_Double_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_Embed_Double_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_uint64_map) Set(value map[uint64]*Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_string_map struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_string_map(l []*delta.Locator) Person_Embed_Double_string_map {
	return Person_Embed_Double_string_map{location: l}
}
func (b Person_Embed_Double_string_map) Key(key string) Person_Embed_Double_type {
	return NewPerson_Embed_Double_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_Embed_Double_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_Embed_Double_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_string_map) Set(value map[string]*Person_Embed_Double) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Embed_Double_Foo_oneof struct {
	location []*delta.Locator
}

func (b Person_Embed_Double_Foo_oneof) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Embed_Double_Foo_oneof(l []*delta.Locator) Person_Embed_Double_Foo_oneof {
	return Person_Embed_Double_Foo_oneof{location: l}
}
func (b Person_Embed_Double_Foo_oneof) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Embed_Double_Foo_oneof) Bar() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "bar", 2))
}
func (b Person_Embed_Double_Foo_oneof) Baz() delta.Int64_scalar {
	return delta.NewInt64_scalar(delta.CopyAndAppendField(b.location, "baz", 3))
}

type Person_Type_enum struct {
	location []*delta.Locator
}

func (b Person_Type_enum) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_enum(l []*delta.Locator) Person_Type_enum {
	return Person_Type_enum{location: l}
}
func (b Person_Type_enum) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_enum) Set(value Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Type_list struct {
	location []*delta.Locator
}

func (b Person_Type_list) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_list(l []*delta.Locator) Person_Type_list {
	return Person_Type_list{location: l}
}
func (b Person_Type_list) Index(i int) Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_Type_list) Insert(index int, value Person_Type) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_Type_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_Type_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_list) Set(value []Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Type_bool_map struct {
	location []*delta.Locator
}

func (b Person_Type_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_bool_map(l []*delta.Locator) Person_Type_bool_map {
	return Person_Type_bool_map{location: l}
}
func (b Person_Type_bool_map) Key(key bool) Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_Type_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_Type_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_bool_map) Set(value map[bool]Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Type_int32_map struct {
	location []*delta.Locator
}

func (b Person_Type_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_int32_map(l []*delta.Locator) Person_Type_int32_map {
	return Person_Type_int32_map{location: l}
}
func (b Person_Type_int32_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_Type_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_Type_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_int32_map) Set(value map[int32]Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Type_int64_map struct {
	location []*delta.Locator
}

func (b Person_Type_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_int64_map(l []*delta.Locator) Person_Type_int64_map {
	return Person_Type_int64_map{location: l}
}
func (b Person_Type_int64_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_Type_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_Type_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_int64_map) Set(value map[int64]Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Type_uint32_map struct {
	location []*delta.Locator
}

func (b Person_Type_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_uint32_map(l []*delta.Locator) Person_Type_uint32_map {
	return Person_Type_uint32_map{location: l}
}
func (b Person_Type_uint32_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_Type_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_Type_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_uint32_map) Set(value map[uint32]Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Type_uint64_map struct {
	location []*delta.Locator
}

func (b Person_Type_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_uint64_map(l []*delta.Locator) Person_Type_uint64_map {
	return Person_Type_uint64_map{location: l}
}
func (b Person_Type_uint64_map) Key(key int) Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_Type_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_Type_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_uint64_map) Set(value map[uint64]Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}

type Person_Type_string_map struct {
	location []*delta.Locator
}

func (b Person_Type_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_Type_string_map(l []*delta.Locator) Person_Type_string_map {
	return Person_Type_string_map{location: l}
}
func (b Person_Type_string_map) Key(key string) Person_Type_enum {
	return NewPerson_Type_enum(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_Type_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_Type_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_Type_string_map) Set(value map[string]Person_Type) *delta.Op {
	return delta.Set(b.location, value)
}
