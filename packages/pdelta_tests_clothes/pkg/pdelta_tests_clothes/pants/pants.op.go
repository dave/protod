package pants

import "github.com/dave/protod/packages/pdelta/pkg/pdelta"

func Op() Op_root_type {
	return Op_root_type{}
}

type Op_root_type struct{}

func (Op_root_type) Pants() Pants_type {
	return Pants_type{}
}

type Pants_type struct {
	location []*pdelta.Locator
}

func (b Pants_type) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_type(l []*pdelta.Locator) Pants_type {
	return Pants_type{location: l}
}
func (b Pants_type) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_type) Set(value *Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
func (b Pants_type) Style() pdelta.String_scalar {
	return pdelta.NewString_scalar(pdelta.CopyAndAppendField(b.location, "pants.Pants", "style", 1))
}
func (b Pants_type) Length() pdelta.Uint32_scalar {
	return pdelta.NewUint32_scalar(pdelta.CopyAndAppendField(b.location, "pants.Pants", "length", 2))
}
func (b Pants_type) Waist() pdelta.Uint32_scalar {
	return pdelta.NewUint32_scalar(pdelta.CopyAndAppendField(b.location, "pants.Pants", "waist", 3))
}

type Pants_list struct {
	location []*pdelta.Locator
}

func (b Pants_list) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_list(l []*pdelta.Locator) Pants_list {
	return Pants_list{location: l}
}
func (b Pants_list) Index(i int) Pants_type {
	return NewPants_type(pdelta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Pants_list) Insert(index int, value *Pants) *pdelta.Op {
	return pdelta.Insert(pdelta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Pants_list) Move(from, to int) *pdelta.Op {
	return pdelta.Move(pdelta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Pants_list) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_list) Set(value []*Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Pants_bool_map struct {
	location []*pdelta.Locator
}

func (b Pants_bool_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_bool_map(l []*pdelta.Locator) Pants_bool_map {
	return Pants_bool_map{location: l}
}
func (b Pants_bool_map) Key(key bool) Pants_type {
	return NewPants_type(pdelta.CopyAndAppendKeyBool(b.location, key))
}
func (b Pants_bool_map) Rename(from, to bool) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Pants_bool_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_bool_map) Set(value map[bool]*Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Pants_int32_map struct {
	location []*pdelta.Locator
}

func (b Pants_int32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_int32_map(l []*pdelta.Locator) Pants_int32_map {
	return Pants_int32_map{location: l}
}
func (b Pants_int32_map) Key(key int) Pants_type {
	return NewPants_type(pdelta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Pants_int32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Pants_int32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_int32_map) Set(value map[int32]*Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Pants_int64_map struct {
	location []*pdelta.Locator
}

func (b Pants_int64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_int64_map(l []*pdelta.Locator) Pants_int64_map {
	return Pants_int64_map{location: l}
}
func (b Pants_int64_map) Key(key int) Pants_type {
	return NewPants_type(pdelta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Pants_int64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Pants_int64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_int64_map) Set(value map[int64]*Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Pants_uint32_map struct {
	location []*pdelta.Locator
}

func (b Pants_uint32_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_uint32_map(l []*pdelta.Locator) Pants_uint32_map {
	return Pants_uint32_map{location: l}
}
func (b Pants_uint32_map) Key(key int) Pants_type {
	return NewPants_type(pdelta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Pants_uint32_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Pants_uint32_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_uint32_map) Set(value map[uint32]*Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Pants_uint64_map struct {
	location []*pdelta.Locator
}

func (b Pants_uint64_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_uint64_map(l []*pdelta.Locator) Pants_uint64_map {
	return Pants_uint64_map{location: l}
}
func (b Pants_uint64_map) Key(key int) Pants_type {
	return NewPants_type(pdelta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Pants_uint64_map) Rename(from, to int) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Pants_uint64_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_uint64_map) Set(value map[uint64]*Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}

type Pants_string_map struct {
	location []*pdelta.Locator
}

func (b Pants_string_map) Location_get() []*pdelta.Locator {
	return b.location
}
func NewPants_string_map(l []*pdelta.Locator) Pants_string_map {
	return Pants_string_map{location: l}
}
func (b Pants_string_map) Key(key string) Pants_type {
	return NewPants_type(pdelta.CopyAndAppendKeyString(b.location, key))
}
func (b Pants_string_map) Rename(from, to string) *pdelta.Op {
	return pdelta.Rename(pdelta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Pants_string_map) Delete() *pdelta.Op {
	return pdelta.Delete(b.location)
}
func (b Pants_string_map) Set(value map[string]*Pants) *pdelta.Op {
	return pdelta.Set(b.location, value)
}
