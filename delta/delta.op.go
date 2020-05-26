package delta

type Double_scalar struct {
	location []*Locator
}

func (b Double_scalar) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar(l []*Locator) Double_scalar {
	return Double_scalar{location: l}
}
func (b Double_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar) Replace(value float64) *Op {
	return Replace(b.location, value)
}

type Double_scalar_list struct {
	location []*Locator
}

func (b Double_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar_list(l []*Locator) Double_scalar_list {
	return Double_scalar_list{location: l}
}
func (b Double_scalar_list) Index(i int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Double_scalar_list) Insert(index int, value float64) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Double_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Double_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar_list) Replace(value []float64) *Op {
	return Replace(b.location, value)
}

type Double_scalar_bool_map struct {
	location []*Locator
}

func (b Double_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar_bool_map(l []*Locator) Double_scalar_bool_map {
	return Double_scalar_bool_map{location: l}
}
func (b Double_scalar_bool_map) Key(key bool) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Double_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Double_scalar_bool_map) Insert(key bool, value float64) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), value)
}
func (b Double_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar_bool_map) Replace(value map[bool]float64) *Op {
	return Replace(b.location, value)
}

type Double_scalar_int32_map struct {
	location []*Locator
}

func (b Double_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar_int32_map(l []*Locator) Double_scalar_int32_map {
	return Double_scalar_int32_map{location: l}
}
func (b Double_scalar_int32_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Double_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Double_scalar_int32_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b Double_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar_int32_map) Replace(value map[int32]float64) *Op {
	return Replace(b.location, value)
}

type Double_scalar_int64_map struct {
	location []*Locator
}

func (b Double_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar_int64_map(l []*Locator) Double_scalar_int64_map {
	return Double_scalar_int64_map{location: l}
}
func (b Double_scalar_int64_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Double_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Double_scalar_int64_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b Double_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar_int64_map) Replace(value map[int64]float64) *Op {
	return Replace(b.location, value)
}

type Double_scalar_uint32_map struct {
	location []*Locator
}

func (b Double_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar_uint32_map(l []*Locator) Double_scalar_uint32_map {
	return Double_scalar_uint32_map{location: l}
}
func (b Double_scalar_uint32_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Double_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Double_scalar_uint32_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b Double_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar_uint32_map) Replace(value map[uint32]float64) *Op {
	return Replace(b.location, value)
}

type Double_scalar_uint64_map struct {
	location []*Locator
}

func (b Double_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar_uint64_map(l []*Locator) Double_scalar_uint64_map {
	return Double_scalar_uint64_map{location: l}
}
func (b Double_scalar_uint64_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Double_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Double_scalar_uint64_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b Double_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar_uint64_map) Replace(value map[uint64]float64) *Op {
	return Replace(b.location, value)
}

type Double_scalar_string_map struct {
	location []*Locator
}

func (b Double_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_scalar_string_map(l []*Locator) Double_scalar_string_map {
	return Double_scalar_string_map{location: l}
}
func (b Double_scalar_string_map) Key(key string) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Double_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Double_scalar_string_map) Insert(key string, value float64) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), value)
}
func (b Double_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_scalar_string_map) Replace(value map[string]float64) *Op {
	return Replace(b.location, value)
}

type Float_scalar struct {
	location []*Locator
}

func (b Float_scalar) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar(l []*Locator) Float_scalar {
	return Float_scalar{location: l}
}
func (b Float_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar) Replace(value float64) *Op {
	return Replace(b.location, float32(value))
}

type Float_scalar_list struct {
	location []*Locator
}

func (b Float_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar_list(l []*Locator) Float_scalar_list {
	return Float_scalar_list{location: l}
}
func (b Float_scalar_list) Index(i int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Float_scalar_list) Insert(index int, value float64) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), float32(value))
}
func (b Float_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Float_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar_list) Replace(value []float32) *Op {
	return Replace(b.location, value)
}

type Float_scalar_bool_map struct {
	location []*Locator
}

func (b Float_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar_bool_map(l []*Locator) Float_scalar_bool_map {
	return Float_scalar_bool_map{location: l}
}
func (b Float_scalar_bool_map) Key(key bool) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Float_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Float_scalar_bool_map) Insert(key bool, value float64) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), float32(value))
}
func (b Float_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar_bool_map) Replace(value map[bool]float32) *Op {
	return Replace(b.location, value)
}

type Float_scalar_int32_map struct {
	location []*Locator
}

func (b Float_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar_int32_map(l []*Locator) Float_scalar_int32_map {
	return Float_scalar_int32_map{location: l}
}
func (b Float_scalar_int32_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Float_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Float_scalar_int32_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), float32(value))
}
func (b Float_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar_int32_map) Replace(value map[int32]float32) *Op {
	return Replace(b.location, value)
}

type Float_scalar_int64_map struct {
	location []*Locator
}

func (b Float_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar_int64_map(l []*Locator) Float_scalar_int64_map {
	return Float_scalar_int64_map{location: l}
}
func (b Float_scalar_int64_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Float_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Float_scalar_int64_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), float32(value))
}
func (b Float_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar_int64_map) Replace(value map[int64]float32) *Op {
	return Replace(b.location, value)
}

type Float_scalar_uint32_map struct {
	location []*Locator
}

func (b Float_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar_uint32_map(l []*Locator) Float_scalar_uint32_map {
	return Float_scalar_uint32_map{location: l}
}
func (b Float_scalar_uint32_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Float_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Float_scalar_uint32_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), float32(value))
}
func (b Float_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar_uint32_map) Replace(value map[uint32]float32) *Op {
	return Replace(b.location, value)
}

type Float_scalar_uint64_map struct {
	location []*Locator
}

func (b Float_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar_uint64_map(l []*Locator) Float_scalar_uint64_map {
	return Float_scalar_uint64_map{location: l}
}
func (b Float_scalar_uint64_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Float_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Float_scalar_uint64_map) Insert(key int, value float64) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), float32(value))
}
func (b Float_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar_uint64_map) Replace(value map[uint64]float32) *Op {
	return Replace(b.location, value)
}

type Float_scalar_string_map struct {
	location []*Locator
}

func (b Float_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_scalar_string_map(l []*Locator) Float_scalar_string_map {
	return Float_scalar_string_map{location: l}
}
func (b Float_scalar_string_map) Key(key string) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Float_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Float_scalar_string_map) Insert(key string, value float64) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), float32(value))
}
func (b Float_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_scalar_string_map) Replace(value map[string]float32) *Op {
	return Replace(b.location, value)
}

type Int32_scalar struct {
	location []*Locator
}

func (b Int32_scalar) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar(l []*Locator) Int32_scalar {
	return Int32_scalar{location: l}
}
func (b Int32_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar) Replace(value int) *Op {
	return Replace(b.location, int32(value))
}

type Int32_scalar_list struct {
	location []*Locator
}

func (b Int32_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar_list(l []*Locator) Int32_scalar_list {
	return Int32_scalar_list{location: l}
}
func (b Int32_scalar_list) Index(i int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Int32_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int32(value))
}
func (b Int32_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Int32_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar_list) Replace(value []int32) *Op {
	return Replace(b.location, value)
}

type Int32_scalar_bool_map struct {
	location []*Locator
}

func (b Int32_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar_bool_map(l []*Locator) Int32_scalar_bool_map {
	return Int32_scalar_bool_map{location: l}
}
func (b Int32_scalar_bool_map) Key(key bool) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Int32_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Int32_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), int32(value))
}
func (b Int32_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar_bool_map) Replace(value map[bool]int32) *Op {
	return Replace(b.location, value)
}

type Int32_scalar_int32_map struct {
	location []*Locator
}

func (b Int32_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar_int32_map(l []*Locator) Int32_scalar_int32_map {
	return Int32_scalar_int32_map{location: l}
}
func (b Int32_scalar_int32_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Int32_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Int32_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), int32(value))
}
func (b Int32_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar_int32_map) Replace(value map[int32]int32) *Op {
	return Replace(b.location, value)
}

type Int32_scalar_int64_map struct {
	location []*Locator
}

func (b Int32_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar_int64_map(l []*Locator) Int32_scalar_int64_map {
	return Int32_scalar_int64_map{location: l}
}
func (b Int32_scalar_int64_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Int32_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Int32_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), int32(value))
}
func (b Int32_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar_int64_map) Replace(value map[int64]int32) *Op {
	return Replace(b.location, value)
}

type Int32_scalar_uint32_map struct {
	location []*Locator
}

func (b Int32_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar_uint32_map(l []*Locator) Int32_scalar_uint32_map {
	return Int32_scalar_uint32_map{location: l}
}
func (b Int32_scalar_uint32_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Int32_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Int32_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), int32(value))
}
func (b Int32_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar_uint32_map) Replace(value map[uint32]int32) *Op {
	return Replace(b.location, value)
}

type Int32_scalar_uint64_map struct {
	location []*Locator
}

func (b Int32_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar_uint64_map(l []*Locator) Int32_scalar_uint64_map {
	return Int32_scalar_uint64_map{location: l}
}
func (b Int32_scalar_uint64_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Int32_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Int32_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), int32(value))
}
func (b Int32_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar_uint64_map) Replace(value map[uint64]int32) *Op {
	return Replace(b.location, value)
}

type Int32_scalar_string_map struct {
	location []*Locator
}

func (b Int32_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_scalar_string_map(l []*Locator) Int32_scalar_string_map {
	return Int32_scalar_string_map{location: l}
}
func (b Int32_scalar_string_map) Key(key string) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Int32_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Int32_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), int32(value))
}
func (b Int32_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_scalar_string_map) Replace(value map[string]int32) *Op {
	return Replace(b.location, value)
}

type Int64_scalar struct {
	location []*Locator
}

func (b Int64_scalar) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar(l []*Locator) Int64_scalar {
	return Int64_scalar{location: l}
}
func (b Int64_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar) Replace(value int) *Op {
	return Replace(b.location, int64(value))
}

type Int64_scalar_list struct {
	location []*Locator
}

func (b Int64_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar_list(l []*Locator) Int64_scalar_list {
	return Int64_scalar_list{location: l}
}
func (b Int64_scalar_list) Index(i int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Int64_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int64(value))
}
func (b Int64_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Int64_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar_list) Replace(value []int64) *Op {
	return Replace(b.location, value)
}

type Int64_scalar_bool_map struct {
	location []*Locator
}

func (b Int64_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar_bool_map(l []*Locator) Int64_scalar_bool_map {
	return Int64_scalar_bool_map{location: l}
}
func (b Int64_scalar_bool_map) Key(key bool) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Int64_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Int64_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), int64(value))
}
func (b Int64_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar_bool_map) Replace(value map[bool]int64) *Op {
	return Replace(b.location, value)
}

type Int64_scalar_int32_map struct {
	location []*Locator
}

func (b Int64_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar_int32_map(l []*Locator) Int64_scalar_int32_map {
	return Int64_scalar_int32_map{location: l}
}
func (b Int64_scalar_int32_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Int64_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Int64_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), int64(value))
}
func (b Int64_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar_int32_map) Replace(value map[int32]int64) *Op {
	return Replace(b.location, value)
}

type Int64_scalar_int64_map struct {
	location []*Locator
}

func (b Int64_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar_int64_map(l []*Locator) Int64_scalar_int64_map {
	return Int64_scalar_int64_map{location: l}
}
func (b Int64_scalar_int64_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Int64_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Int64_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), int64(value))
}
func (b Int64_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar_int64_map) Replace(value map[int64]int64) *Op {
	return Replace(b.location, value)
}

type Int64_scalar_uint32_map struct {
	location []*Locator
}

func (b Int64_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar_uint32_map(l []*Locator) Int64_scalar_uint32_map {
	return Int64_scalar_uint32_map{location: l}
}
func (b Int64_scalar_uint32_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Int64_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Int64_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), int64(value))
}
func (b Int64_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar_uint32_map) Replace(value map[uint32]int64) *Op {
	return Replace(b.location, value)
}

type Int64_scalar_uint64_map struct {
	location []*Locator
}

func (b Int64_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar_uint64_map(l []*Locator) Int64_scalar_uint64_map {
	return Int64_scalar_uint64_map{location: l}
}
func (b Int64_scalar_uint64_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Int64_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Int64_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), int64(value))
}
func (b Int64_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar_uint64_map) Replace(value map[uint64]int64) *Op {
	return Replace(b.location, value)
}

type Int64_scalar_string_map struct {
	location []*Locator
}

func (b Int64_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_scalar_string_map(l []*Locator) Int64_scalar_string_map {
	return Int64_scalar_string_map{location: l}
}
func (b Int64_scalar_string_map) Key(key string) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Int64_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Int64_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), int64(value))
}
func (b Int64_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_scalar_string_map) Replace(value map[string]int64) *Op {
	return Replace(b.location, value)
}

type Uint32_scalar struct {
	location []*Locator
}

func (b Uint32_scalar) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar(l []*Locator) Uint32_scalar {
	return Uint32_scalar{location: l}
}
func (b Uint32_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar) Replace(value int) *Op {
	return Replace(b.location, uint32(value))
}

type Uint32_scalar_list struct {
	location []*Locator
}

func (b Uint32_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar_list(l []*Locator) Uint32_scalar_list {
	return Uint32_scalar_list{location: l}
}
func (b Uint32_scalar_list) Index(i int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Uint32_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint32(value))
}
func (b Uint32_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Uint32_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar_list) Replace(value []uint32) *Op {
	return Replace(b.location, value)
}

type Uint32_scalar_bool_map struct {
	location []*Locator
}

func (b Uint32_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar_bool_map(l []*Locator) Uint32_scalar_bool_map {
	return Uint32_scalar_bool_map{location: l}
}
func (b Uint32_scalar_bool_map) Key(key bool) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Uint32_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Uint32_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), uint32(value))
}
func (b Uint32_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar_bool_map) Replace(value map[bool]uint32) *Op {
	return Replace(b.location, value)
}

type Uint32_scalar_int32_map struct {
	location []*Locator
}

func (b Uint32_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar_int32_map(l []*Locator) Uint32_scalar_int32_map {
	return Uint32_scalar_int32_map{location: l}
}
func (b Uint32_scalar_int32_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Uint32_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Uint32_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), uint32(value))
}
func (b Uint32_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar_int32_map) Replace(value map[int32]uint32) *Op {
	return Replace(b.location, value)
}

type Uint32_scalar_int64_map struct {
	location []*Locator
}

func (b Uint32_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar_int64_map(l []*Locator) Uint32_scalar_int64_map {
	return Uint32_scalar_int64_map{location: l}
}
func (b Uint32_scalar_int64_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Uint32_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Uint32_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), uint32(value))
}
func (b Uint32_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar_int64_map) Replace(value map[int64]uint32) *Op {
	return Replace(b.location, value)
}

type Uint32_scalar_uint32_map struct {
	location []*Locator
}

func (b Uint32_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar_uint32_map(l []*Locator) Uint32_scalar_uint32_map {
	return Uint32_scalar_uint32_map{location: l}
}
func (b Uint32_scalar_uint32_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Uint32_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Uint32_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), uint32(value))
}
func (b Uint32_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar_uint32_map) Replace(value map[uint32]uint32) *Op {
	return Replace(b.location, value)
}

type Uint32_scalar_uint64_map struct {
	location []*Locator
}

func (b Uint32_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar_uint64_map(l []*Locator) Uint32_scalar_uint64_map {
	return Uint32_scalar_uint64_map{location: l}
}
func (b Uint32_scalar_uint64_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Uint32_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Uint32_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), uint32(value))
}
func (b Uint32_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar_uint64_map) Replace(value map[uint64]uint32) *Op {
	return Replace(b.location, value)
}

type Uint32_scalar_string_map struct {
	location []*Locator
}

func (b Uint32_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_scalar_string_map(l []*Locator) Uint32_scalar_string_map {
	return Uint32_scalar_string_map{location: l}
}
func (b Uint32_scalar_string_map) Key(key string) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Uint32_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Uint32_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), uint32(value))
}
func (b Uint32_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_scalar_string_map) Replace(value map[string]uint32) *Op {
	return Replace(b.location, value)
}

type Uint64_scalar struct {
	location []*Locator
}

func (b Uint64_scalar) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar(l []*Locator) Uint64_scalar {
	return Uint64_scalar{location: l}
}
func (b Uint64_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar) Replace(value int) *Op {
	return Replace(b.location, uint64(value))
}

type Uint64_scalar_list struct {
	location []*Locator
}

func (b Uint64_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar_list(l []*Locator) Uint64_scalar_list {
	return Uint64_scalar_list{location: l}
}
func (b Uint64_scalar_list) Index(i int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Uint64_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint64(value))
}
func (b Uint64_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Uint64_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar_list) Replace(value []uint64) *Op {
	return Replace(b.location, value)
}

type Uint64_scalar_bool_map struct {
	location []*Locator
}

func (b Uint64_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar_bool_map(l []*Locator) Uint64_scalar_bool_map {
	return Uint64_scalar_bool_map{location: l}
}
func (b Uint64_scalar_bool_map) Key(key bool) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Uint64_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Uint64_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), uint64(value))
}
func (b Uint64_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar_bool_map) Replace(value map[bool]uint64) *Op {
	return Replace(b.location, value)
}

type Uint64_scalar_int32_map struct {
	location []*Locator
}

func (b Uint64_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar_int32_map(l []*Locator) Uint64_scalar_int32_map {
	return Uint64_scalar_int32_map{location: l}
}
func (b Uint64_scalar_int32_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Uint64_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Uint64_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), uint64(value))
}
func (b Uint64_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar_int32_map) Replace(value map[int32]uint64) *Op {
	return Replace(b.location, value)
}

type Uint64_scalar_int64_map struct {
	location []*Locator
}

func (b Uint64_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar_int64_map(l []*Locator) Uint64_scalar_int64_map {
	return Uint64_scalar_int64_map{location: l}
}
func (b Uint64_scalar_int64_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Uint64_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Uint64_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), uint64(value))
}
func (b Uint64_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar_int64_map) Replace(value map[int64]uint64) *Op {
	return Replace(b.location, value)
}

type Uint64_scalar_uint32_map struct {
	location []*Locator
}

func (b Uint64_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar_uint32_map(l []*Locator) Uint64_scalar_uint32_map {
	return Uint64_scalar_uint32_map{location: l}
}
func (b Uint64_scalar_uint32_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Uint64_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Uint64_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), uint64(value))
}
func (b Uint64_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar_uint32_map) Replace(value map[uint32]uint64) *Op {
	return Replace(b.location, value)
}

type Uint64_scalar_uint64_map struct {
	location []*Locator
}

func (b Uint64_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar_uint64_map(l []*Locator) Uint64_scalar_uint64_map {
	return Uint64_scalar_uint64_map{location: l}
}
func (b Uint64_scalar_uint64_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Uint64_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Uint64_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), uint64(value))
}
func (b Uint64_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar_uint64_map) Replace(value map[uint64]uint64) *Op {
	return Replace(b.location, value)
}

type Uint64_scalar_string_map struct {
	location []*Locator
}

func (b Uint64_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_scalar_string_map(l []*Locator) Uint64_scalar_string_map {
	return Uint64_scalar_string_map{location: l}
}
func (b Uint64_scalar_string_map) Key(key string) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Uint64_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Uint64_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), uint64(value))
}
func (b Uint64_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_scalar_string_map) Replace(value map[string]uint64) *Op {
	return Replace(b.location, value)
}

type Sint32_scalar struct {
	location []*Locator
}

func (b Sint32_scalar) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar(l []*Locator) Sint32_scalar {
	return Sint32_scalar{location: l}
}
func (b Sint32_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar) Replace(value int) *Op {
	return Replace(b.location, int32(value))
}

type Sint32_scalar_list struct {
	location []*Locator
}

func (b Sint32_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar_list(l []*Locator) Sint32_scalar_list {
	return Sint32_scalar_list{location: l}
}
func (b Sint32_scalar_list) Index(i int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sint32_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int32(value))
}
func (b Sint32_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sint32_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar_list) Replace(value []int32) *Op {
	return Replace(b.location, value)
}

type Sint32_scalar_bool_map struct {
	location []*Locator
}

func (b Sint32_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar_bool_map(l []*Locator) Sint32_scalar_bool_map {
	return Sint32_scalar_bool_map{location: l}
}
func (b Sint32_scalar_bool_map) Key(key bool) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sint32_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sint32_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), int32(value))
}
func (b Sint32_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar_bool_map) Replace(value map[bool]int32) *Op {
	return Replace(b.location, value)
}

type Sint32_scalar_int32_map struct {
	location []*Locator
}

func (b Sint32_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar_int32_map(l []*Locator) Sint32_scalar_int32_map {
	return Sint32_scalar_int32_map{location: l}
}
func (b Sint32_scalar_int32_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sint32_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sint32_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), int32(value))
}
func (b Sint32_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar_int32_map) Replace(value map[int32]int32) *Op {
	return Replace(b.location, value)
}

type Sint32_scalar_int64_map struct {
	location []*Locator
}

func (b Sint32_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar_int64_map(l []*Locator) Sint32_scalar_int64_map {
	return Sint32_scalar_int64_map{location: l}
}
func (b Sint32_scalar_int64_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sint32_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sint32_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), int32(value))
}
func (b Sint32_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar_int64_map) Replace(value map[int64]int32) *Op {
	return Replace(b.location, value)
}

type Sint32_scalar_uint32_map struct {
	location []*Locator
}

func (b Sint32_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar_uint32_map(l []*Locator) Sint32_scalar_uint32_map {
	return Sint32_scalar_uint32_map{location: l}
}
func (b Sint32_scalar_uint32_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sint32_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sint32_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), int32(value))
}
func (b Sint32_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar_uint32_map) Replace(value map[uint32]int32) *Op {
	return Replace(b.location, value)
}

type Sint32_scalar_uint64_map struct {
	location []*Locator
}

func (b Sint32_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar_uint64_map(l []*Locator) Sint32_scalar_uint64_map {
	return Sint32_scalar_uint64_map{location: l}
}
func (b Sint32_scalar_uint64_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sint32_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sint32_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), int32(value))
}
func (b Sint32_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar_uint64_map) Replace(value map[uint64]int32) *Op {
	return Replace(b.location, value)
}

type Sint32_scalar_string_map struct {
	location []*Locator
}

func (b Sint32_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_scalar_string_map(l []*Locator) Sint32_scalar_string_map {
	return Sint32_scalar_string_map{location: l}
}
func (b Sint32_scalar_string_map) Key(key string) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sint32_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sint32_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), int32(value))
}
func (b Sint32_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_scalar_string_map) Replace(value map[string]int32) *Op {
	return Replace(b.location, value)
}

type Sint64_scalar struct {
	location []*Locator
}

func (b Sint64_scalar) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar(l []*Locator) Sint64_scalar {
	return Sint64_scalar{location: l}
}
func (b Sint64_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar) Replace(value int) *Op {
	return Replace(b.location, int64(value))
}

type Sint64_scalar_list struct {
	location []*Locator
}

func (b Sint64_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar_list(l []*Locator) Sint64_scalar_list {
	return Sint64_scalar_list{location: l}
}
func (b Sint64_scalar_list) Index(i int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sint64_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int64(value))
}
func (b Sint64_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sint64_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar_list) Replace(value []int64) *Op {
	return Replace(b.location, value)
}

type Sint64_scalar_bool_map struct {
	location []*Locator
}

func (b Sint64_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar_bool_map(l []*Locator) Sint64_scalar_bool_map {
	return Sint64_scalar_bool_map{location: l}
}
func (b Sint64_scalar_bool_map) Key(key bool) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sint64_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sint64_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), int64(value))
}
func (b Sint64_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar_bool_map) Replace(value map[bool]int64) *Op {
	return Replace(b.location, value)
}

type Sint64_scalar_int32_map struct {
	location []*Locator
}

func (b Sint64_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar_int32_map(l []*Locator) Sint64_scalar_int32_map {
	return Sint64_scalar_int32_map{location: l}
}
func (b Sint64_scalar_int32_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sint64_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sint64_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), int64(value))
}
func (b Sint64_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar_int32_map) Replace(value map[int32]int64) *Op {
	return Replace(b.location, value)
}

type Sint64_scalar_int64_map struct {
	location []*Locator
}

func (b Sint64_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar_int64_map(l []*Locator) Sint64_scalar_int64_map {
	return Sint64_scalar_int64_map{location: l}
}
func (b Sint64_scalar_int64_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sint64_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sint64_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), int64(value))
}
func (b Sint64_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar_int64_map) Replace(value map[int64]int64) *Op {
	return Replace(b.location, value)
}

type Sint64_scalar_uint32_map struct {
	location []*Locator
}

func (b Sint64_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar_uint32_map(l []*Locator) Sint64_scalar_uint32_map {
	return Sint64_scalar_uint32_map{location: l}
}
func (b Sint64_scalar_uint32_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sint64_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sint64_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), int64(value))
}
func (b Sint64_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar_uint32_map) Replace(value map[uint32]int64) *Op {
	return Replace(b.location, value)
}

type Sint64_scalar_uint64_map struct {
	location []*Locator
}

func (b Sint64_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar_uint64_map(l []*Locator) Sint64_scalar_uint64_map {
	return Sint64_scalar_uint64_map{location: l}
}
func (b Sint64_scalar_uint64_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sint64_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sint64_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), int64(value))
}
func (b Sint64_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar_uint64_map) Replace(value map[uint64]int64) *Op {
	return Replace(b.location, value)
}

type Sint64_scalar_string_map struct {
	location []*Locator
}

func (b Sint64_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_scalar_string_map(l []*Locator) Sint64_scalar_string_map {
	return Sint64_scalar_string_map{location: l}
}
func (b Sint64_scalar_string_map) Key(key string) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sint64_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sint64_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), int64(value))
}
func (b Sint64_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_scalar_string_map) Replace(value map[string]int64) *Op {
	return Replace(b.location, value)
}

type Fixed32_scalar struct {
	location []*Locator
}

func (b Fixed32_scalar) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar(l []*Locator) Fixed32_scalar {
	return Fixed32_scalar{location: l}
}
func (b Fixed32_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar) Replace(value int) *Op {
	return Replace(b.location, uint32(value))
}

type Fixed32_scalar_list struct {
	location []*Locator
}

func (b Fixed32_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar_list(l []*Locator) Fixed32_scalar_list {
	return Fixed32_scalar_list{location: l}
}
func (b Fixed32_scalar_list) Index(i int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Fixed32_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint32(value))
}
func (b Fixed32_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Fixed32_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar_list) Replace(value []uint32) *Op {
	return Replace(b.location, value)
}

type Fixed32_scalar_bool_map struct {
	location []*Locator
}

func (b Fixed32_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar_bool_map(l []*Locator) Fixed32_scalar_bool_map {
	return Fixed32_scalar_bool_map{location: l}
}
func (b Fixed32_scalar_bool_map) Key(key bool) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Fixed32_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Fixed32_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), uint32(value))
}
func (b Fixed32_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar_bool_map) Replace(value map[bool]uint32) *Op {
	return Replace(b.location, value)
}

type Fixed32_scalar_int32_map struct {
	location []*Locator
}

func (b Fixed32_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar_int32_map(l []*Locator) Fixed32_scalar_int32_map {
	return Fixed32_scalar_int32_map{location: l}
}
func (b Fixed32_scalar_int32_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Fixed32_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Fixed32_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), uint32(value))
}
func (b Fixed32_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar_int32_map) Replace(value map[int32]uint32) *Op {
	return Replace(b.location, value)
}

type Fixed32_scalar_int64_map struct {
	location []*Locator
}

func (b Fixed32_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar_int64_map(l []*Locator) Fixed32_scalar_int64_map {
	return Fixed32_scalar_int64_map{location: l}
}
func (b Fixed32_scalar_int64_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Fixed32_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Fixed32_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), uint32(value))
}
func (b Fixed32_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar_int64_map) Replace(value map[int64]uint32) *Op {
	return Replace(b.location, value)
}

type Fixed32_scalar_uint32_map struct {
	location []*Locator
}

func (b Fixed32_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar_uint32_map(l []*Locator) Fixed32_scalar_uint32_map {
	return Fixed32_scalar_uint32_map{location: l}
}
func (b Fixed32_scalar_uint32_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Fixed32_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Fixed32_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), uint32(value))
}
func (b Fixed32_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar_uint32_map) Replace(value map[uint32]uint32) *Op {
	return Replace(b.location, value)
}

type Fixed32_scalar_uint64_map struct {
	location []*Locator
}

func (b Fixed32_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar_uint64_map(l []*Locator) Fixed32_scalar_uint64_map {
	return Fixed32_scalar_uint64_map{location: l}
}
func (b Fixed32_scalar_uint64_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Fixed32_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Fixed32_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), uint32(value))
}
func (b Fixed32_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar_uint64_map) Replace(value map[uint64]uint32) *Op {
	return Replace(b.location, value)
}

type Fixed32_scalar_string_map struct {
	location []*Locator
}

func (b Fixed32_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_scalar_string_map(l []*Locator) Fixed32_scalar_string_map {
	return Fixed32_scalar_string_map{location: l}
}
func (b Fixed32_scalar_string_map) Key(key string) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Fixed32_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Fixed32_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), uint32(value))
}
func (b Fixed32_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_scalar_string_map) Replace(value map[string]uint32) *Op {
	return Replace(b.location, value)
}

type Fixed64_scalar struct {
	location []*Locator
}

func (b Fixed64_scalar) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar(l []*Locator) Fixed64_scalar {
	return Fixed64_scalar{location: l}
}
func (b Fixed64_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar) Replace(value int) *Op {
	return Replace(b.location, uint64(value))
}

type Fixed64_scalar_list struct {
	location []*Locator
}

func (b Fixed64_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar_list(l []*Locator) Fixed64_scalar_list {
	return Fixed64_scalar_list{location: l}
}
func (b Fixed64_scalar_list) Index(i int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Fixed64_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint64(value))
}
func (b Fixed64_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Fixed64_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar_list) Replace(value []uint64) *Op {
	return Replace(b.location, value)
}

type Fixed64_scalar_bool_map struct {
	location []*Locator
}

func (b Fixed64_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar_bool_map(l []*Locator) Fixed64_scalar_bool_map {
	return Fixed64_scalar_bool_map{location: l}
}
func (b Fixed64_scalar_bool_map) Key(key bool) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Fixed64_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Fixed64_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), uint64(value))
}
func (b Fixed64_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar_bool_map) Replace(value map[bool]uint64) *Op {
	return Replace(b.location, value)
}

type Fixed64_scalar_int32_map struct {
	location []*Locator
}

func (b Fixed64_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar_int32_map(l []*Locator) Fixed64_scalar_int32_map {
	return Fixed64_scalar_int32_map{location: l}
}
func (b Fixed64_scalar_int32_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Fixed64_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Fixed64_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), uint64(value))
}
func (b Fixed64_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar_int32_map) Replace(value map[int32]uint64) *Op {
	return Replace(b.location, value)
}

type Fixed64_scalar_int64_map struct {
	location []*Locator
}

func (b Fixed64_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar_int64_map(l []*Locator) Fixed64_scalar_int64_map {
	return Fixed64_scalar_int64_map{location: l}
}
func (b Fixed64_scalar_int64_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Fixed64_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Fixed64_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), uint64(value))
}
func (b Fixed64_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar_int64_map) Replace(value map[int64]uint64) *Op {
	return Replace(b.location, value)
}

type Fixed64_scalar_uint32_map struct {
	location []*Locator
}

func (b Fixed64_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar_uint32_map(l []*Locator) Fixed64_scalar_uint32_map {
	return Fixed64_scalar_uint32_map{location: l}
}
func (b Fixed64_scalar_uint32_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Fixed64_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Fixed64_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), uint64(value))
}
func (b Fixed64_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar_uint32_map) Replace(value map[uint32]uint64) *Op {
	return Replace(b.location, value)
}

type Fixed64_scalar_uint64_map struct {
	location []*Locator
}

func (b Fixed64_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar_uint64_map(l []*Locator) Fixed64_scalar_uint64_map {
	return Fixed64_scalar_uint64_map{location: l}
}
func (b Fixed64_scalar_uint64_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Fixed64_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Fixed64_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), uint64(value))
}
func (b Fixed64_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar_uint64_map) Replace(value map[uint64]uint64) *Op {
	return Replace(b.location, value)
}

type Fixed64_scalar_string_map struct {
	location []*Locator
}

func (b Fixed64_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_scalar_string_map(l []*Locator) Fixed64_scalar_string_map {
	return Fixed64_scalar_string_map{location: l}
}
func (b Fixed64_scalar_string_map) Key(key string) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Fixed64_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Fixed64_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), uint64(value))
}
func (b Fixed64_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_scalar_string_map) Replace(value map[string]uint64) *Op {
	return Replace(b.location, value)
}

type Sfixed32_scalar struct {
	location []*Locator
}

func (b Sfixed32_scalar) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar(l []*Locator) Sfixed32_scalar {
	return Sfixed32_scalar{location: l}
}
func (b Sfixed32_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar) Replace(value int) *Op {
	return Replace(b.location, int32(value))
}

type Sfixed32_scalar_list struct {
	location []*Locator
}

func (b Sfixed32_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar_list(l []*Locator) Sfixed32_scalar_list {
	return Sfixed32_scalar_list{location: l}
}
func (b Sfixed32_scalar_list) Index(i int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sfixed32_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int32(value))
}
func (b Sfixed32_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sfixed32_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar_list) Replace(value []int32) *Op {
	return Replace(b.location, value)
}

type Sfixed32_scalar_bool_map struct {
	location []*Locator
}

func (b Sfixed32_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar_bool_map(l []*Locator) Sfixed32_scalar_bool_map {
	return Sfixed32_scalar_bool_map{location: l}
}
func (b Sfixed32_scalar_bool_map) Key(key bool) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sfixed32_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sfixed32_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), int32(value))
}
func (b Sfixed32_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar_bool_map) Replace(value map[bool]int32) *Op {
	return Replace(b.location, value)
}

type Sfixed32_scalar_int32_map struct {
	location []*Locator
}

func (b Sfixed32_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar_int32_map(l []*Locator) Sfixed32_scalar_int32_map {
	return Sfixed32_scalar_int32_map{location: l}
}
func (b Sfixed32_scalar_int32_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sfixed32_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sfixed32_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), int32(value))
}
func (b Sfixed32_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar_int32_map) Replace(value map[int32]int32) *Op {
	return Replace(b.location, value)
}

type Sfixed32_scalar_int64_map struct {
	location []*Locator
}

func (b Sfixed32_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar_int64_map(l []*Locator) Sfixed32_scalar_int64_map {
	return Sfixed32_scalar_int64_map{location: l}
}
func (b Sfixed32_scalar_int64_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sfixed32_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sfixed32_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), int32(value))
}
func (b Sfixed32_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar_int64_map) Replace(value map[int64]int32) *Op {
	return Replace(b.location, value)
}

type Sfixed32_scalar_uint32_map struct {
	location []*Locator
}

func (b Sfixed32_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar_uint32_map(l []*Locator) Sfixed32_scalar_uint32_map {
	return Sfixed32_scalar_uint32_map{location: l}
}
func (b Sfixed32_scalar_uint32_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sfixed32_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sfixed32_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), int32(value))
}
func (b Sfixed32_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar_uint32_map) Replace(value map[uint32]int32) *Op {
	return Replace(b.location, value)
}

type Sfixed32_scalar_uint64_map struct {
	location []*Locator
}

func (b Sfixed32_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar_uint64_map(l []*Locator) Sfixed32_scalar_uint64_map {
	return Sfixed32_scalar_uint64_map{location: l}
}
func (b Sfixed32_scalar_uint64_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sfixed32_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sfixed32_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), int32(value))
}
func (b Sfixed32_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar_uint64_map) Replace(value map[uint64]int32) *Op {
	return Replace(b.location, value)
}

type Sfixed32_scalar_string_map struct {
	location []*Locator
}

func (b Sfixed32_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_scalar_string_map(l []*Locator) Sfixed32_scalar_string_map {
	return Sfixed32_scalar_string_map{location: l}
}
func (b Sfixed32_scalar_string_map) Key(key string) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sfixed32_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sfixed32_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), int32(value))
}
func (b Sfixed32_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_scalar_string_map) Replace(value map[string]int32) *Op {
	return Replace(b.location, value)
}

type Sfixed64_scalar struct {
	location []*Locator
}

func (b Sfixed64_scalar) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar(l []*Locator) Sfixed64_scalar {
	return Sfixed64_scalar{location: l}
}
func (b Sfixed64_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar) Replace(value int) *Op {
	return Replace(b.location, int64(value))
}

type Sfixed64_scalar_list struct {
	location []*Locator
}

func (b Sfixed64_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar_list(l []*Locator) Sfixed64_scalar_list {
	return Sfixed64_scalar_list{location: l}
}
func (b Sfixed64_scalar_list) Index(i int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sfixed64_scalar_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int64(value))
}
func (b Sfixed64_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sfixed64_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar_list) Replace(value []int64) *Op {
	return Replace(b.location, value)
}

type Sfixed64_scalar_bool_map struct {
	location []*Locator
}

func (b Sfixed64_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar_bool_map(l []*Locator) Sfixed64_scalar_bool_map {
	return Sfixed64_scalar_bool_map{location: l}
}
func (b Sfixed64_scalar_bool_map) Key(key bool) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sfixed64_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sfixed64_scalar_bool_map) Insert(key bool, value int) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), int64(value))
}
func (b Sfixed64_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar_bool_map) Replace(value map[bool]int64) *Op {
	return Replace(b.location, value)
}

type Sfixed64_scalar_int32_map struct {
	location []*Locator
}

func (b Sfixed64_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar_int32_map(l []*Locator) Sfixed64_scalar_int32_map {
	return Sfixed64_scalar_int32_map{location: l}
}
func (b Sfixed64_scalar_int32_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sfixed64_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sfixed64_scalar_int32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), int64(value))
}
func (b Sfixed64_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar_int32_map) Replace(value map[int32]int64) *Op {
	return Replace(b.location, value)
}

type Sfixed64_scalar_int64_map struct {
	location []*Locator
}

func (b Sfixed64_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar_int64_map(l []*Locator) Sfixed64_scalar_int64_map {
	return Sfixed64_scalar_int64_map{location: l}
}
func (b Sfixed64_scalar_int64_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sfixed64_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sfixed64_scalar_int64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), int64(value))
}
func (b Sfixed64_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar_int64_map) Replace(value map[int64]int64) *Op {
	return Replace(b.location, value)
}

type Sfixed64_scalar_uint32_map struct {
	location []*Locator
}

func (b Sfixed64_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar_uint32_map(l []*Locator) Sfixed64_scalar_uint32_map {
	return Sfixed64_scalar_uint32_map{location: l}
}
func (b Sfixed64_scalar_uint32_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sfixed64_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sfixed64_scalar_uint32_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), int64(value))
}
func (b Sfixed64_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar_uint32_map) Replace(value map[uint32]int64) *Op {
	return Replace(b.location, value)
}

type Sfixed64_scalar_uint64_map struct {
	location []*Locator
}

func (b Sfixed64_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar_uint64_map(l []*Locator) Sfixed64_scalar_uint64_map {
	return Sfixed64_scalar_uint64_map{location: l}
}
func (b Sfixed64_scalar_uint64_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sfixed64_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sfixed64_scalar_uint64_map) Insert(key int, value int) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), int64(value))
}
func (b Sfixed64_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar_uint64_map) Replace(value map[uint64]int64) *Op {
	return Replace(b.location, value)
}

type Sfixed64_scalar_string_map struct {
	location []*Locator
}

func (b Sfixed64_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_scalar_string_map(l []*Locator) Sfixed64_scalar_string_map {
	return Sfixed64_scalar_string_map{location: l}
}
func (b Sfixed64_scalar_string_map) Key(key string) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sfixed64_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sfixed64_scalar_string_map) Insert(key string, value int) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), int64(value))
}
func (b Sfixed64_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_scalar_string_map) Replace(value map[string]int64) *Op {
	return Replace(b.location, value)
}

type Bool_scalar struct {
	location []*Locator
}

func (b Bool_scalar) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar(l []*Locator) Bool_scalar {
	return Bool_scalar{location: l}
}
func (b Bool_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar) Replace(value bool) *Op {
	return Replace(b.location, value)
}

type Bool_scalar_list struct {
	location []*Locator
}

func (b Bool_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar_list(l []*Locator) Bool_scalar_list {
	return Bool_scalar_list{location: l}
}
func (b Bool_scalar_list) Index(i int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Bool_scalar_list) Insert(index int, value bool) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Bool_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Bool_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar_list) Replace(value []bool) *Op {
	return Replace(b.location, value)
}

type Bool_scalar_bool_map struct {
	location []*Locator
}

func (b Bool_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar_bool_map(l []*Locator) Bool_scalar_bool_map {
	return Bool_scalar_bool_map{location: l}
}
func (b Bool_scalar_bool_map) Key(key bool) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Bool_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Bool_scalar_bool_map) Insert(key bool, value bool) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), value)
}
func (b Bool_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar_bool_map) Replace(value map[bool]bool) *Op {
	return Replace(b.location, value)
}

type Bool_scalar_int32_map struct {
	location []*Locator
}

func (b Bool_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar_int32_map(l []*Locator) Bool_scalar_int32_map {
	return Bool_scalar_int32_map{location: l}
}
func (b Bool_scalar_int32_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Bool_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Bool_scalar_int32_map) Insert(key int, value bool) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b Bool_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar_int32_map) Replace(value map[int32]bool) *Op {
	return Replace(b.location, value)
}

type Bool_scalar_int64_map struct {
	location []*Locator
}

func (b Bool_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar_int64_map(l []*Locator) Bool_scalar_int64_map {
	return Bool_scalar_int64_map{location: l}
}
func (b Bool_scalar_int64_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Bool_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Bool_scalar_int64_map) Insert(key int, value bool) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b Bool_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar_int64_map) Replace(value map[int64]bool) *Op {
	return Replace(b.location, value)
}

type Bool_scalar_uint32_map struct {
	location []*Locator
}

func (b Bool_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar_uint32_map(l []*Locator) Bool_scalar_uint32_map {
	return Bool_scalar_uint32_map{location: l}
}
func (b Bool_scalar_uint32_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Bool_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Bool_scalar_uint32_map) Insert(key int, value bool) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b Bool_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar_uint32_map) Replace(value map[uint32]bool) *Op {
	return Replace(b.location, value)
}

type Bool_scalar_uint64_map struct {
	location []*Locator
}

func (b Bool_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar_uint64_map(l []*Locator) Bool_scalar_uint64_map {
	return Bool_scalar_uint64_map{location: l}
}
func (b Bool_scalar_uint64_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Bool_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Bool_scalar_uint64_map) Insert(key int, value bool) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b Bool_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar_uint64_map) Replace(value map[uint64]bool) *Op {
	return Replace(b.location, value)
}

type Bool_scalar_string_map struct {
	location []*Locator
}

func (b Bool_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewBool_scalar_string_map(l []*Locator) Bool_scalar_string_map {
	return Bool_scalar_string_map{location: l}
}
func (b Bool_scalar_string_map) Key(key string) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Bool_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Bool_scalar_string_map) Insert(key string, value bool) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), value)
}
func (b Bool_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_scalar_string_map) Replace(value map[string]bool) *Op {
	return Replace(b.location, value)
}

type String_scalar struct {
	location []*Locator
}

func (b String_scalar) Location_get() []*Locator {
	return b.location
}
func NewString_scalar(l []*Locator) String_scalar {
	return String_scalar{location: l}
}
func (b String_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar) Replace(value string) *Op {
	return Replace(b.location, value)
}
func (b String_scalar) Edit(from, to string) *Op {
	return Edit(b.location, from, to)
}

type String_scalar_list struct {
	location []*Locator
}

func (b String_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewString_scalar_list(l []*Locator) String_scalar_list {
	return String_scalar_list{location: l}
}
func (b String_scalar_list) Index(i int) String_scalar {
	return NewString_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b String_scalar_list) Insert(index int, value string) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b String_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b String_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar_list) Replace(value []string) *Op {
	return Replace(b.location, value)
}

type String_scalar_bool_map struct {
	location []*Locator
}

func (b String_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewString_scalar_bool_map(l []*Locator) String_scalar_bool_map {
	return String_scalar_bool_map{location: l}
}
func (b String_scalar_bool_map) Key(key bool) String_scalar {
	return NewString_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b String_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b String_scalar_bool_map) Insert(key bool, value string) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), value)
}
func (b String_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar_bool_map) Replace(value map[bool]string) *Op {
	return Replace(b.location, value)
}

type String_scalar_int32_map struct {
	location []*Locator
}

func (b String_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewString_scalar_int32_map(l []*Locator) String_scalar_int32_map {
	return String_scalar_int32_map{location: l}
}
func (b String_scalar_int32_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b String_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b String_scalar_int32_map) Insert(key int, value string) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b String_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar_int32_map) Replace(value map[int32]string) *Op {
	return Replace(b.location, value)
}

type String_scalar_int64_map struct {
	location []*Locator
}

func (b String_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewString_scalar_int64_map(l []*Locator) String_scalar_int64_map {
	return String_scalar_int64_map{location: l}
}
func (b String_scalar_int64_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b String_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b String_scalar_int64_map) Insert(key int, value string) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b String_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar_int64_map) Replace(value map[int64]string) *Op {
	return Replace(b.location, value)
}

type String_scalar_uint32_map struct {
	location []*Locator
}

func (b String_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewString_scalar_uint32_map(l []*Locator) String_scalar_uint32_map {
	return String_scalar_uint32_map{location: l}
}
func (b String_scalar_uint32_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b String_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b String_scalar_uint32_map) Insert(key int, value string) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b String_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar_uint32_map) Replace(value map[uint32]string) *Op {
	return Replace(b.location, value)
}

type String_scalar_uint64_map struct {
	location []*Locator
}

func (b String_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewString_scalar_uint64_map(l []*Locator) String_scalar_uint64_map {
	return String_scalar_uint64_map{location: l}
}
func (b String_scalar_uint64_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b String_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b String_scalar_uint64_map) Insert(key int, value string) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b String_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar_uint64_map) Replace(value map[uint64]string) *Op {
	return Replace(b.location, value)
}

type String_scalar_string_map struct {
	location []*Locator
}

func (b String_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewString_scalar_string_map(l []*Locator) String_scalar_string_map {
	return String_scalar_string_map{location: l}
}
func (b String_scalar_string_map) Key(key string) String_scalar {
	return NewString_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b String_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b String_scalar_string_map) Insert(key string, value string) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), value)
}
func (b String_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar_string_map) Replace(value map[string]string) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar struct {
	location []*Locator
}

func (b Bytes_scalar) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar(l []*Locator) Bytes_scalar {
	return Bytes_scalar{location: l}
}
func (b Bytes_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar) Replace(value []byte) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar_list struct {
	location []*Locator
}

func (b Bytes_scalar_list) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar_list(l []*Locator) Bytes_scalar_list {
	return Bytes_scalar_list{location: l}
}
func (b Bytes_scalar_list) Index(i int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Bytes_scalar_list) Insert(index int, value []byte) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Bytes_scalar_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Bytes_scalar_list) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar_list) Replace(value [][]byte) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar_bool_map struct {
	location []*Locator
}

func (b Bytes_scalar_bool_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar_bool_map(l []*Locator) Bytes_scalar_bool_map {
	return Bytes_scalar_bool_map{location: l}
}
func (b Bytes_scalar_bool_map) Key(key bool) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Bytes_scalar_bool_map) Move(from, to bool) *Op {
	return Move(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Bytes_scalar_bool_map) Insert(key bool, value []byte) *Op {
	return Insert(CopyAndAppendKeyBool(b.location, key), value)
}
func (b Bytes_scalar_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar_bool_map) Replace(value map[bool][]byte) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar_int32_map struct {
	location []*Locator
}

func (b Bytes_scalar_int32_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar_int32_map(l []*Locator) Bytes_scalar_int32_map {
	return Bytes_scalar_int32_map{location: l}
}
func (b Bytes_scalar_int32_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Bytes_scalar_int32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Bytes_scalar_int32_map) Insert(key int, value []byte) *Op {
	return Insert(CopyAndAppendKeyInt32(b.location, int32(key)), value)
}
func (b Bytes_scalar_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar_int32_map) Replace(value map[int32][]byte) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar_int64_map struct {
	location []*Locator
}

func (b Bytes_scalar_int64_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar_int64_map(l []*Locator) Bytes_scalar_int64_map {
	return Bytes_scalar_int64_map{location: l}
}
func (b Bytes_scalar_int64_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Bytes_scalar_int64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Bytes_scalar_int64_map) Insert(key int, value []byte) *Op {
	return Insert(CopyAndAppendKeyInt64(b.location, int64(key)), value)
}
func (b Bytes_scalar_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar_int64_map) Replace(value map[int64][]byte) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar_uint32_map struct {
	location []*Locator
}

func (b Bytes_scalar_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar_uint32_map(l []*Locator) Bytes_scalar_uint32_map {
	return Bytes_scalar_uint32_map{location: l}
}
func (b Bytes_scalar_uint32_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Bytes_scalar_uint32_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Bytes_scalar_uint32_map) Insert(key int, value []byte) *Op {
	return Insert(CopyAndAppendKeyUint32(b.location, uint32(key)), value)
}
func (b Bytes_scalar_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar_uint32_map) Replace(value map[uint32][]byte) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar_uint64_map struct {
	location []*Locator
}

func (b Bytes_scalar_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar_uint64_map(l []*Locator) Bytes_scalar_uint64_map {
	return Bytes_scalar_uint64_map{location: l}
}
func (b Bytes_scalar_uint64_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Bytes_scalar_uint64_map) Move(from, to int) *Op {
	return Move(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Bytes_scalar_uint64_map) Insert(key int, value []byte) *Op {
	return Insert(CopyAndAppendKeyUint64(b.location, uint64(key)), value)
}
func (b Bytes_scalar_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar_uint64_map) Replace(value map[uint64][]byte) *Op {
	return Replace(b.location, value)
}

type Bytes_scalar_string_map struct {
	location []*Locator
}

func (b Bytes_scalar_string_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_scalar_string_map(l []*Locator) Bytes_scalar_string_map {
	return Bytes_scalar_string_map{location: l}
}
func (b Bytes_scalar_string_map) Key(key string) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Bytes_scalar_string_map) Move(from, to string) *Op {
	return Move(CopyAndAppendKeyString(b.location, from), to)
}
func (b Bytes_scalar_string_map) Insert(key string, value []byte) *Op {
	return Insert(CopyAndAppendKeyString(b.location, key), value)
}
func (b Bytes_scalar_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_scalar_string_map) Replace(value map[string][]byte) *Op {
	return Replace(b.location, value)
}
