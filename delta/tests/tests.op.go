package tests

import "github.com/dave/protod/delta"

func Op() Op_root_type {
	return Op_root_type{}
}

type Op_root_type struct{}

func (Op_root_type) Person() Person_type {
	return Person_type{}
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
func (b Person_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 1))
}
func (b Person_type) Age() delta.Uint32_scalar {
	return delta.NewUint32_scalar(delta.CopyAndAppendField(b.location, "age", 2))
}
func (b Person_type) Cases() Case_type_string_map {
	return NewCase_type_string_map(delta.CopyAndAppendField(b.location, "cases", 4))
}
func (b Person_type) Company() Company_type {
	return NewCompany_type(delta.CopyAndAppendField(b.location, "company", 5))
}
func (b Person_type) Alias() delta.String_scalar_list {
	return delta.NewString_scalar_list(delta.CopyAndAppendField(b.location, "alias", 6))
}
func (b Person_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type) Replace(value *Person) *delta.Op {
	return delta.Replace(b.location, value)
}

type Person_type_list struct {
	location []*delta.Locator
}

func (b Person_type_list) Location_get() []*delta.Locator {
	return b.location
}
func NewPerson_type_list(l []*delta.Locator) Person_type_list {
	return Person_type_list{location: l}
}
func (b Person_type_list) Index(i int) Person_type {
	return NewPerson_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Person_type_list) Insert(index int, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Person_type_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Person_type_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type_list) Replace(value []*Person) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Person_type_bool_map) Key(key bool) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Person_type_bool_map) Move(from, to bool) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Person_type_bool_map) Insert(key bool, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyBool(b.location, key), value)
}
func (b Person_type_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type_bool_map) Replace(value map[bool]*Person) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Person_type_int32_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Person_type_int32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Person_type_int32_map) Insert(key int, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b Person_type_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type_int32_map) Replace(value map[int32]*Person) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Person_type_int64_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Person_type_int64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Person_type_int64_map) Insert(key int, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b Person_type_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type_int64_map) Replace(value map[int64]*Person) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Person_type_uint32_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Person_type_uint32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Person_type_uint32_map) Insert(key int, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b Person_type_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type_uint32_map) Replace(value map[uint32]*Person) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Person_type_uint64_map) Key(key int) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Person_type_uint64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Person_type_uint64_map) Insert(key int, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b Person_type_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type_uint64_map) Replace(value map[uint64]*Person) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Person_type_string_map) Key(key string) Person_type {
	return NewPerson_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Person_type_string_map) Move(from, to string) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Person_type_string_map) Insert(key string, value *Person) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyString(b.location, key), value)
}
func (b Person_type_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Person_type_string_map) Replace(value map[string]*Person) *delta.Op {
	return delta.Replace(b.location, value)
}
func (Op_root_type) Company() Company_type {
	return Company_type{}
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
func (b Company_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 11))
}
func (b Company_type) Revenue() delta.Float_scalar {
	return delta.NewFloat_scalar(delta.CopyAndAppendField(b.location, "revenue", 12))
}
func (b Company_type) Flags() delta.String_scalar_int64_map {
	return delta.NewString_scalar_int64_map(delta.CopyAndAppendField(b.location, "flags", 13))
}
func (b Company_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type) Replace(value *Company) *delta.Op {
	return delta.Replace(b.location, value)
}

type Company_type_list struct {
	location []*delta.Locator
}

func (b Company_type_list) Location_get() []*delta.Locator {
	return b.location
}
func NewCompany_type_list(l []*delta.Locator) Company_type_list {
	return Company_type_list{location: l}
}
func (b Company_type_list) Index(i int) Company_type {
	return NewCompany_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Company_type_list) Insert(index int, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Company_type_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Company_type_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type_list) Replace(value []*Company) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Company_type_bool_map) Key(key bool) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Company_type_bool_map) Move(from, to bool) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Company_type_bool_map) Insert(key bool, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyBool(b.location, key), value)
}
func (b Company_type_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type_bool_map) Replace(value map[bool]*Company) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Company_type_int32_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Company_type_int32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Company_type_int32_map) Insert(key int, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b Company_type_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type_int32_map) Replace(value map[int32]*Company) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Company_type_int64_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Company_type_int64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Company_type_int64_map) Insert(key int, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b Company_type_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type_int64_map) Replace(value map[int64]*Company) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Company_type_uint32_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Company_type_uint32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Company_type_uint32_map) Insert(key int, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b Company_type_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type_uint32_map) Replace(value map[uint32]*Company) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Company_type_uint64_map) Key(key int) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Company_type_uint64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Company_type_uint64_map) Insert(key int, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b Company_type_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type_uint64_map) Replace(value map[uint64]*Company) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Company_type_string_map) Key(key string) Company_type {
	return NewCompany_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Company_type_string_map) Move(from, to string) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Company_type_string_map) Insert(key string, value *Company) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyString(b.location, key), value)
}
func (b Company_type_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Company_type_string_map) Replace(value map[string]*Company) *delta.Op {
	return delta.Replace(b.location, value)
}
func (Op_root_type) Case() Case_type {
	return Case_type{}
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
func (b Case_type) Name() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "name", 21))
}
func (b Case_type) Items() Item_type_list {
	return NewItem_type_list(delta.CopyAndAppendField(b.location, "items", 22))
}
func (b Case_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type) Replace(value *Case) *delta.Op {
	return delta.Replace(b.location, value)
}

type Case_type_list struct {
	location []*delta.Locator
}

func (b Case_type_list) Location_get() []*delta.Locator {
	return b.location
}
func NewCase_type_list(l []*delta.Locator) Case_type_list {
	return Case_type_list{location: l}
}
func (b Case_type_list) Index(i int) Case_type {
	return NewCase_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Case_type_list) Insert(index int, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Case_type_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Case_type_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type_list) Replace(value []*Case) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Case_type_bool_map) Key(key bool) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Case_type_bool_map) Move(from, to bool) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Case_type_bool_map) Insert(key bool, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyBool(b.location, key), value)
}
func (b Case_type_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type_bool_map) Replace(value map[bool]*Case) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Case_type_int32_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Case_type_int32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Case_type_int32_map) Insert(key int, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b Case_type_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type_int32_map) Replace(value map[int32]*Case) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Case_type_int64_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Case_type_int64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Case_type_int64_map) Insert(key int, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b Case_type_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type_int64_map) Replace(value map[int64]*Case) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Case_type_uint32_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Case_type_uint32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Case_type_uint32_map) Insert(key int, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b Case_type_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type_uint32_map) Replace(value map[uint32]*Case) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Case_type_uint64_map) Key(key int) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Case_type_uint64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Case_type_uint64_map) Insert(key int, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b Case_type_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type_uint64_map) Replace(value map[uint64]*Case) *delta.Op {
	return delta.Replace(b.location, value)
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
func (b Case_type_string_map) Key(key string) Case_type {
	return NewCase_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Case_type_string_map) Move(from, to string) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Case_type_string_map) Insert(key string, value *Case) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyString(b.location, key), value)
}
func (b Case_type_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Case_type_string_map) Replace(value map[string]*Case) *delta.Op {
	return delta.Replace(b.location, value)
}
func (Op_root_type) Item() Item_type {
	return Item_type{}
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
func (b Item_type) Title() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "title", 31))
}
func (b Item_type) Done() delta.Bool_scalar {
	return delta.NewBool_scalar(delta.CopyAndAppendField(b.location, "done", 34))
}
func (b Item_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type) Replace(value *Item) *delta.Op {
	return delta.Replace(b.location, value)
}

type Item_type_list struct {
	location []*delta.Locator
}

func (b Item_type_list) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type_list(l []*delta.Locator) Item_type_list {
	return Item_type_list{location: l}
}
func (b Item_type_list) Index(i int) Item_type {
	return NewItem_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Item_type_list) Insert(index int, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Item_type_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Item_type_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type_list) Replace(value []*Item) *delta.Op {
	return delta.Replace(b.location, value)
}

type Item_type_bool_map struct {
	location []*delta.Locator
}

func (b Item_type_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type_bool_map(l []*delta.Locator) Item_type_bool_map {
	return Item_type_bool_map{location: l}
}
func (b Item_type_bool_map) Key(key bool) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Item_type_bool_map) Move(from, to bool) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Item_type_bool_map) Insert(key bool, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyBool(b.location, key), value)
}
func (b Item_type_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type_bool_map) Replace(value map[bool]*Item) *delta.Op {
	return delta.Replace(b.location, value)
}

type Item_type_int32_map struct {
	location []*delta.Locator
}

func (b Item_type_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type_int32_map(l []*delta.Locator) Item_type_int32_map {
	return Item_type_int32_map{location: l}
}
func (b Item_type_int32_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Item_type_int32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Item_type_int32_map) Insert(key int, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b Item_type_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type_int32_map) Replace(value map[int32]*Item) *delta.Op {
	return delta.Replace(b.location, value)
}

type Item_type_int64_map struct {
	location []*delta.Locator
}

func (b Item_type_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type_int64_map(l []*delta.Locator) Item_type_int64_map {
	return Item_type_int64_map{location: l}
}
func (b Item_type_int64_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Item_type_int64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Item_type_int64_map) Insert(key int, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b Item_type_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type_int64_map) Replace(value map[int64]*Item) *delta.Op {
	return delta.Replace(b.location, value)
}

type Item_type_uint32_map struct {
	location []*delta.Locator
}

func (b Item_type_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type_uint32_map(l []*delta.Locator) Item_type_uint32_map {
	return Item_type_uint32_map{location: l}
}
func (b Item_type_uint32_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Item_type_uint32_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Item_type_uint32_map) Insert(key int, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b Item_type_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type_uint32_map) Replace(value map[uint32]*Item) *delta.Op {
	return delta.Replace(b.location, value)
}

type Item_type_uint64_map struct {
	location []*delta.Locator
}

func (b Item_type_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type_uint64_map(l []*delta.Locator) Item_type_uint64_map {
	return Item_type_uint64_map{location: l}
}
func (b Item_type_uint64_map) Key(key int) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Item_type_uint64_map) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Item_type_uint64_map) Insert(key int, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b Item_type_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type_uint64_map) Replace(value map[uint64]*Item) *delta.Op {
	return delta.Replace(b.location, value)
}

type Item_type_string_map struct {
	location []*delta.Locator
}

func (b Item_type_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewItem_type_string_map(l []*delta.Locator) Item_type_string_map {
	return Item_type_string_map{location: l}
}
func (b Item_type_string_map) Key(key string) Item_type {
	return NewItem_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Item_type_string_map) Move(from, to string) *delta.Op {
	return delta.Move(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Item_type_string_map) Insert(key string, value *Item) *delta.Op {
	return delta.Insert(delta.CopyAndAppendKeyString(b.location, key), value)
}
func (b Item_type_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Item_type_string_map) Replace(value map[string]*Item) *delta.Op {
	return delta.Replace(b.location, value)
}
