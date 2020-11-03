package tests2

import "github.com/dave/protod/delta"

func Op() Op_root_type {
	return Op_root_type{}
}

type Op_root_type struct{}

func (Op_root_type) Shirt() Shirt_type {
	return Shirt_type{}
}

type Shirt_type struct {
	location []*delta.Locator
}

func (b Shirt_type) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_type(l []*delta.Locator) Shirt_type {
	return Shirt_type{location: l}
}
func (b Shirt_type) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_type) Set(value *Shirt) *delta.Op {
	return delta.Set(b.location, value)
}
func (b Shirt_type) Designer() delta.String_scalar {
	return delta.NewString_scalar(delta.CopyAndAppendField(b.location, "designer", 1))
}
func (b Shirt_type) Size() delta.Uint32_scalar {
	return delta.NewUint32_scalar(delta.CopyAndAppendField(b.location, "size", 2))
}

type Shirt_list struct {
	location []*delta.Locator
}

func (b Shirt_list) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_list(l []*delta.Locator) Shirt_list {
	return Shirt_list{location: l}
}
func (b Shirt_list) Index(i int) Shirt_type {
	return NewShirt_type(delta.CopyAndAppendIndex(b.location, int64(i)))
}
func (b Shirt_list) Insert(index int, value *Shirt) *delta.Op {
	return delta.Insert(delta.CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Shirt_list) Move(from, to int) *delta.Op {
	return delta.Move(delta.CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Shirt_list) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_list) Set(value []*Shirt) *delta.Op {
	return delta.Set(b.location, value)
}

type Shirt_bool_map struct {
	location []*delta.Locator
}

func (b Shirt_bool_map) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_bool_map(l []*delta.Locator) Shirt_bool_map {
	return Shirt_bool_map{location: l}
}
func (b Shirt_bool_map) Key(key bool) Shirt_type {
	return NewShirt_type(delta.CopyAndAppendKeyBool(b.location, key))
}
func (b Shirt_bool_map) Rename(from, to bool) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyBool(b.location, from), to)
}
func (b Shirt_bool_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_bool_map) Set(value map[bool]*Shirt) *delta.Op {
	return delta.Set(b.location, value)
}

type Shirt_int32_map struct {
	location []*delta.Locator
}

func (b Shirt_int32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_int32_map(l []*delta.Locator) Shirt_int32_map {
	return Shirt_int32_map{location: l}
}
func (b Shirt_int32_map) Key(key int) Shirt_type {
	return NewShirt_type(delta.CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Shirt_int32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Shirt_int32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_int32_map) Set(value map[int32]*Shirt) *delta.Op {
	return delta.Set(b.location, value)
}

type Shirt_int64_map struct {
	location []*delta.Locator
}

func (b Shirt_int64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_int64_map(l []*delta.Locator) Shirt_int64_map {
	return Shirt_int64_map{location: l}
}
func (b Shirt_int64_map) Key(key int) Shirt_type {
	return NewShirt_type(delta.CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Shirt_int64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Shirt_int64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_int64_map) Set(value map[int64]*Shirt) *delta.Op {
	return delta.Set(b.location, value)
}

type Shirt_uint32_map struct {
	location []*delta.Locator
}

func (b Shirt_uint32_map) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_uint32_map(l []*delta.Locator) Shirt_uint32_map {
	return Shirt_uint32_map{location: l}
}
func (b Shirt_uint32_map) Key(key int) Shirt_type {
	return NewShirt_type(delta.CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Shirt_uint32_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Shirt_uint32_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_uint32_map) Set(value map[uint32]*Shirt) *delta.Op {
	return delta.Set(b.location, value)
}

type Shirt_uint64_map struct {
	location []*delta.Locator
}

func (b Shirt_uint64_map) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_uint64_map(l []*delta.Locator) Shirt_uint64_map {
	return Shirt_uint64_map{location: l}
}
func (b Shirt_uint64_map) Key(key int) Shirt_type {
	return NewShirt_type(delta.CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Shirt_uint64_map) Rename(from, to int) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Shirt_uint64_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_uint64_map) Set(value map[uint64]*Shirt) *delta.Op {
	return delta.Set(b.location, value)
}

type Shirt_string_map struct {
	location []*delta.Locator
}

func (b Shirt_string_map) Location_get() []*delta.Locator {
	return b.location
}
func NewShirt_string_map(l []*delta.Locator) Shirt_string_map {
	return Shirt_string_map{location: l}
}
func (b Shirt_string_map) Key(key string) Shirt_type {
	return NewShirt_type(delta.CopyAndAppendKeyString(b.location, key))
}
func (b Shirt_string_map) Rename(from, to string) *delta.Op {
	return delta.Rename(delta.CopyAndAppendKeyString(b.location, from), to)
}
func (b Shirt_string_map) Delete() *delta.Op {
	return delta.Delete(b.location)
}
func (b Shirt_string_map) Set(value map[string]*Shirt) *delta.Op {
	return delta.Set(b.location, value)
}
