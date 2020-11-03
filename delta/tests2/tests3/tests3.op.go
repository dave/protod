package tests3

import "github.com/dave/protod/delta"

func Op() Op_root_type {
	return Op_root_type{}
}

type Op_root_type struct{}

func (Op_root_type) Pants() Pants_type {
	return Pants_type{}
}

type Pants_type struct {
	location []*delta.Locator
}

func (b Pants_type) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_type(l []*delta.Locator) Pants_type {
	return Pants_type{location: l}
}
func (b Pants_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_type) Set(value *Pants) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Pants_type) Style() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "style", 1))
}
func (b Pants_type) Length() delta.Uint32_scalar {
	return delta.NewUint32_scalar(delta.CopyAndAppendField(b.location, "length", 2))
}
func (b Pants_type) Waist() delta.Uint32_scalar {
	return delta.NewUint32_scalar(delta.CopyAndAppendField(b.location, "waist", 3))
}

type Pants_list struct {
	location []*delta.Locator
}

func (b Pants_list) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_list(l []*delta.Locator) Pants_list {
	return Pants_list{location: l}
}
func (b Pants_list) Index(i int) Pants_type {
	return NewPants_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Pants_list) Insert(index int, value *Pants) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Pants_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Pants_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_list) Set(value []*Pants) *delta.Op {
	return delta.Set(b.location, value)
}

type Pants_bool_map struct {
	location []*delta.Locator
}

func (b Pants_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_bool_map(l []*delta.Locator) Pants_bool_map {
	return Pants_bool_map{location: l}
}
func (b Pants_bool_map) Key(key bool) Pants_type {
	return NewPants_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Pants_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Pants_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_bool_map) Set(value map[bool]*Pants) *delta.Op {
	return delta.Set(b.location, value)
}

type Pants_int32_map struct {
	location []*delta.Locator
}

func (b Pants_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_int32_map(l []*delta.Locator) Pants_int32_map {
	return Pants_int32_map{location: l}
}
func (b Pants_int32_map) Key(key int) Pants_type {
	return NewPants_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Pants_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Pants_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_int32_map) Set(value map[int32]*Pants) *delta.Op {
	return delta.Set(b.location, value)
}

type Pants_int64_map struct {
	location []*delta.Locator
}

func (b Pants_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_int64_map(l []*delta.Locator) Pants_int64_map {
	return Pants_int64_map{location: l}
}
func (b Pants_int64_map) Key(key int) Pants_type {
	return NewPants_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Pants_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Pants_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_int64_map) Set(value map[int64]*Pants) *delta.Op {
	return delta.Set(b.location, value)
}

type Pants_uint32_map struct {
	location []*delta.Locator
}

func (b Pants_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_uint32_map(l []*delta.Locator) Pants_uint32_map {
	return Pants_uint32_map{location: l}
}
func (b Pants_uint32_map) Key(key int) Pants_type {
	return NewPants_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Pants_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Pants_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_uint32_map) Set(value map[uint32]*Pants) *delta.Op {
	return delta.Set(b.location, value)
}

type Pants_uint64_map struct {
	location []*delta.Locator
}

func (b Pants_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_uint64_map(l []*delta.Locator) Pants_uint64_map {
	return Pants_uint64_map{location: l}
}
func (b Pants_uint64_map) Key(key int) Pants_type {
	return NewPants_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Pants_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Pants_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_uint64_map) Set(value map[uint64]*Pants) *delta.Op {
	return delta.Set(b.location, value)
}

type Pants_string_map struct {
	location []*delta.Locator
}

func (b Pants_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewPants_string_map(l []*delta.Locator) Pants_string_map {
	return Pants_string_map{location: l}
}
func (b Pants_string_map) Key(key string) Pants_type {
	return NewPants_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Pants_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Pants_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Pants_string_map) Set(value map[string]*Pants) *delta.Op {
	return delta.Set(b.location, value)
}
