package delta

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
func (b Bool_scalar) Set(value bool) *Op {
	return Set(b.location, value)
}

type Bool_list struct {
	location []*Locator
}

func (b Bool_list) Location_get() []*Locator {
	return b.location
}
func NewBool_list(l []*Locator) Bool_list {
	return Bool_list{location: l}
}
func (b Bool_list) Index(i int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Bool_list) Insert(index int, value bool) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Bool_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Bool_list) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_list) Set(value []bool) *Op {
	return Set(b.location, value)
}

type Bool_bool_map struct {
	location []*Locator
}

func (b Bool_bool_map) Location_get() []*Locator {
	return b.location
}
func NewBool_bool_map(l []*Locator) Bool_bool_map {
	return Bool_bool_map{location: l}
}
func (b Bool_bool_map) Key(key bool) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Bool_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Bool_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_bool_map) Set(value map[bool]bool) *Op {
	return Set(b.location, value)
}

type Bool_int32_map struct {
	location []*Locator
}

func (b Bool_int32_map) Location_get() []*Locator {
	return b.location
}
func NewBool_int32_map(l []*Locator) Bool_int32_map {
	return Bool_int32_map{location: l}
}
func (b Bool_int32_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Bool_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Bool_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_int32_map) Set(value map[int32]bool) *Op {
	return Set(b.location, value)
}

type Bool_int64_map struct {
	location []*Locator
}

func (b Bool_int64_map) Location_get() []*Locator {
	return b.location
}
func NewBool_int64_map(l []*Locator) Bool_int64_map {
	return Bool_int64_map{location: l}
}
func (b Bool_int64_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Bool_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Bool_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_int64_map) Set(value map[int64]bool) *Op {
	return Set(b.location, value)
}

type Bool_uint32_map struct {
	location []*Locator
}

func (b Bool_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewBool_uint32_map(l []*Locator) Bool_uint32_map {
	return Bool_uint32_map{location: l}
}
func (b Bool_uint32_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Bool_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Bool_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_uint32_map) Set(value map[uint32]bool) *Op {
	return Set(b.location, value)
}

type Bool_uint64_map struct {
	location []*Locator
}

func (b Bool_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewBool_uint64_map(l []*Locator) Bool_uint64_map {
	return Bool_uint64_map{location: l}
}
func (b Bool_uint64_map) Key(key int) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Bool_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Bool_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_uint64_map) Set(value map[uint64]bool) *Op {
	return Set(b.location, value)
}

type Bool_string_map struct {
	location []*Locator
}

func (b Bool_string_map) Location_get() []*Locator {
	return b.location
}
func NewBool_string_map(l []*Locator) Bool_string_map {
	return Bool_string_map{location: l}
}
func (b Bool_string_map) Key(key string) Bool_scalar {
	return NewBool_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Bool_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Bool_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bool_string_map) Set(value map[string]bool) *Op {
	return Set(b.location, value)
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
func (b Bytes_scalar) Set(value []byte) *Op {
	return Set(b.location, value)
}

type Bytes_list struct {
	location []*Locator
}

func (b Bytes_list) Location_get() []*Locator {
	return b.location
}
func NewBytes_list(l []*Locator) Bytes_list {
	return Bytes_list{location: l}
}
func (b Bytes_list) Index(i int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Bytes_list) Insert(index int, value []byte) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Bytes_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Bytes_list) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_list) Set(value [][]byte) *Op {
	return Set(b.location, value)
}

type Bytes_bool_map struct {
	location []*Locator
}

func (b Bytes_bool_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_bool_map(l []*Locator) Bytes_bool_map {
	return Bytes_bool_map{location: l}
}
func (b Bytes_bool_map) Key(key bool) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Bytes_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Bytes_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_bool_map) Set(value map[bool][]byte) *Op {
	return Set(b.location, value)
}

type Bytes_int32_map struct {
	location []*Locator
}

func (b Bytes_int32_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_int32_map(l []*Locator) Bytes_int32_map {
	return Bytes_int32_map{location: l}
}
func (b Bytes_int32_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Bytes_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Bytes_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_int32_map) Set(value map[int32][]byte) *Op {
	return Set(b.location, value)
}

type Bytes_int64_map struct {
	location []*Locator
}

func (b Bytes_int64_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_int64_map(l []*Locator) Bytes_int64_map {
	return Bytes_int64_map{location: l}
}
func (b Bytes_int64_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Bytes_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Bytes_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_int64_map) Set(value map[int64][]byte) *Op {
	return Set(b.location, value)
}

type Bytes_uint32_map struct {
	location []*Locator
}

func (b Bytes_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_uint32_map(l []*Locator) Bytes_uint32_map {
	return Bytes_uint32_map{location: l}
}
func (b Bytes_uint32_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Bytes_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Bytes_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_uint32_map) Set(value map[uint32][]byte) *Op {
	return Set(b.location, value)
}

type Bytes_uint64_map struct {
	location []*Locator
}

func (b Bytes_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_uint64_map(l []*Locator) Bytes_uint64_map {
	return Bytes_uint64_map{location: l}
}
func (b Bytes_uint64_map) Key(key int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Bytes_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Bytes_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_uint64_map) Set(value map[uint64][]byte) *Op {
	return Set(b.location, value)
}

type Bytes_string_map struct {
	location []*Locator
}

func (b Bytes_string_map) Location_get() []*Locator {
	return b.location
}
func NewBytes_string_map(l []*Locator) Bytes_string_map {
	return Bytes_string_map{location: l}
}
func (b Bytes_string_map) Key(key string) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Bytes_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Bytes_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Bytes_string_map) Set(value map[string][]byte) *Op {
	return Set(b.location, value)
}

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
func (b Double_scalar) Set(value float64) *Op {
	return Set(b.location, value)
}

type Double_list struct {
	location []*Locator
}

func (b Double_list) Location_get() []*Locator {
	return b.location
}
func NewDouble_list(l []*Locator) Double_list {
	return Double_list{location: l}
}
func (b Double_list) Index(i int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Double_list) Insert(index int, value float64) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b Double_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Double_list) Delete() *Op {
	return Delete(b.location)
}
func (b Double_list) Set(value []float64) *Op {
	return Set(b.location, value)
}

type Double_bool_map struct {
	location []*Locator
}

func (b Double_bool_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_bool_map(l []*Locator) Double_bool_map {
	return Double_bool_map{location: l}
}
func (b Double_bool_map) Key(key bool) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Double_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Double_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_bool_map) Set(value map[bool]float64) *Op {
	return Set(b.location, value)
}

type Double_int32_map struct {
	location []*Locator
}

func (b Double_int32_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_int32_map(l []*Locator) Double_int32_map {
	return Double_int32_map{location: l}
}
func (b Double_int32_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Double_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Double_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_int32_map) Set(value map[int32]float64) *Op {
	return Set(b.location, value)
}

type Double_int64_map struct {
	location []*Locator
}

func (b Double_int64_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_int64_map(l []*Locator) Double_int64_map {
	return Double_int64_map{location: l}
}
func (b Double_int64_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Double_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Double_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_int64_map) Set(value map[int64]float64) *Op {
	return Set(b.location, value)
}

type Double_uint32_map struct {
	location []*Locator
}

func (b Double_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_uint32_map(l []*Locator) Double_uint32_map {
	return Double_uint32_map{location: l}
}
func (b Double_uint32_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Double_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Double_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_uint32_map) Set(value map[uint32]float64) *Op {
	return Set(b.location, value)
}

type Double_uint64_map struct {
	location []*Locator
}

func (b Double_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_uint64_map(l []*Locator) Double_uint64_map {
	return Double_uint64_map{location: l}
}
func (b Double_uint64_map) Key(key int) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Double_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Double_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_uint64_map) Set(value map[uint64]float64) *Op {
	return Set(b.location, value)
}

type Double_string_map struct {
	location []*Locator
}

func (b Double_string_map) Location_get() []*Locator {
	return b.location
}
func NewDouble_string_map(l []*Locator) Double_string_map {
	return Double_string_map{location: l}
}
func (b Double_string_map) Key(key string) Double_scalar {
	return NewDouble_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Double_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Double_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Double_string_map) Set(value map[string]float64) *Op {
	return Set(b.location, value)
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
func (b Fixed32_scalar) Set(value int) *Op {
	return Set(b.location, uint32(value))
}

type Fixed32_list struct {
	location []*Locator
}

func (b Fixed32_list) Location_get() []*Locator {
	return b.location
}
func NewFixed32_list(l []*Locator) Fixed32_list {
	return Fixed32_list{location: l}
}
func (b Fixed32_list) Index(i int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Fixed32_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint32(value))
}
func (b Fixed32_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Fixed32_list) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_list) Set(value []uint32) *Op {
	return Set(b.location, value)
}

type Fixed32_bool_map struct {
	location []*Locator
}

func (b Fixed32_bool_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_bool_map(l []*Locator) Fixed32_bool_map {
	return Fixed32_bool_map{location: l}
}
func (b Fixed32_bool_map) Key(key bool) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Fixed32_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Fixed32_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_bool_map) Set(value map[bool]uint32) *Op {
	return Set(b.location, value)
}

type Fixed32_int32_map struct {
	location []*Locator
}

func (b Fixed32_int32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_int32_map(l []*Locator) Fixed32_int32_map {
	return Fixed32_int32_map{location: l}
}
func (b Fixed32_int32_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Fixed32_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Fixed32_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_int32_map) Set(value map[int32]uint32) *Op {
	return Set(b.location, value)
}

type Fixed32_int64_map struct {
	location []*Locator
}

func (b Fixed32_int64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_int64_map(l []*Locator) Fixed32_int64_map {
	return Fixed32_int64_map{location: l}
}
func (b Fixed32_int64_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Fixed32_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Fixed32_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_int64_map) Set(value map[int64]uint32) *Op {
	return Set(b.location, value)
}

type Fixed32_uint32_map struct {
	location []*Locator
}

func (b Fixed32_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_uint32_map(l []*Locator) Fixed32_uint32_map {
	return Fixed32_uint32_map{location: l}
}
func (b Fixed32_uint32_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Fixed32_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Fixed32_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_uint32_map) Set(value map[uint32]uint32) *Op {
	return Set(b.location, value)
}

type Fixed32_uint64_map struct {
	location []*Locator
}

func (b Fixed32_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_uint64_map(l []*Locator) Fixed32_uint64_map {
	return Fixed32_uint64_map{location: l}
}
func (b Fixed32_uint64_map) Key(key int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Fixed32_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Fixed32_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_uint64_map) Set(value map[uint64]uint32) *Op {
	return Set(b.location, value)
}

type Fixed32_string_map struct {
	location []*Locator
}

func (b Fixed32_string_map) Location_get() []*Locator {
	return b.location
}
func NewFixed32_string_map(l []*Locator) Fixed32_string_map {
	return Fixed32_string_map{location: l}
}
func (b Fixed32_string_map) Key(key string) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Fixed32_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Fixed32_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed32_string_map) Set(value map[string]uint32) *Op {
	return Set(b.location, value)
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
func (b Fixed64_scalar) Set(value int) *Op {
	return Set(b.location, uint64(value))
}

type Fixed64_list struct {
	location []*Locator
}

func (b Fixed64_list) Location_get() []*Locator {
	return b.location
}
func NewFixed64_list(l []*Locator) Fixed64_list {
	return Fixed64_list{location: l}
}
func (b Fixed64_list) Index(i int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Fixed64_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint64(value))
}
func (b Fixed64_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Fixed64_list) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_list) Set(value []uint64) *Op {
	return Set(b.location, value)
}

type Fixed64_bool_map struct {
	location []*Locator
}

func (b Fixed64_bool_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_bool_map(l []*Locator) Fixed64_bool_map {
	return Fixed64_bool_map{location: l}
}
func (b Fixed64_bool_map) Key(key bool) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Fixed64_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Fixed64_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_bool_map) Set(value map[bool]uint64) *Op {
	return Set(b.location, value)
}

type Fixed64_int32_map struct {
	location []*Locator
}

func (b Fixed64_int32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_int32_map(l []*Locator) Fixed64_int32_map {
	return Fixed64_int32_map{location: l}
}
func (b Fixed64_int32_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Fixed64_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Fixed64_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_int32_map) Set(value map[int32]uint64) *Op {
	return Set(b.location, value)
}

type Fixed64_int64_map struct {
	location []*Locator
}

func (b Fixed64_int64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_int64_map(l []*Locator) Fixed64_int64_map {
	return Fixed64_int64_map{location: l}
}
func (b Fixed64_int64_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Fixed64_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Fixed64_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_int64_map) Set(value map[int64]uint64) *Op {
	return Set(b.location, value)
}

type Fixed64_uint32_map struct {
	location []*Locator
}

func (b Fixed64_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_uint32_map(l []*Locator) Fixed64_uint32_map {
	return Fixed64_uint32_map{location: l}
}
func (b Fixed64_uint32_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Fixed64_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Fixed64_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_uint32_map) Set(value map[uint32]uint64) *Op {
	return Set(b.location, value)
}

type Fixed64_uint64_map struct {
	location []*Locator
}

func (b Fixed64_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_uint64_map(l []*Locator) Fixed64_uint64_map {
	return Fixed64_uint64_map{location: l}
}
func (b Fixed64_uint64_map) Key(key int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Fixed64_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Fixed64_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_uint64_map) Set(value map[uint64]uint64) *Op {
	return Set(b.location, value)
}

type Fixed64_string_map struct {
	location []*Locator
}

func (b Fixed64_string_map) Location_get() []*Locator {
	return b.location
}
func NewFixed64_string_map(l []*Locator) Fixed64_string_map {
	return Fixed64_string_map{location: l}
}
func (b Fixed64_string_map) Key(key string) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Fixed64_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Fixed64_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Fixed64_string_map) Set(value map[string]uint64) *Op {
	return Set(b.location, value)
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
func (b Float_scalar) Set(value float64) *Op {
	return Set(b.location, float32(value))
}

type Float_list struct {
	location []*Locator
}

func (b Float_list) Location_get() []*Locator {
	return b.location
}
func NewFloat_list(l []*Locator) Float_list {
	return Float_list{location: l}
}
func (b Float_list) Index(i int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Float_list) Insert(index int, value float64) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), float32(value))
}
func (b Float_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Float_list) Delete() *Op {
	return Delete(b.location)
}
func (b Float_list) Set(value []float32) *Op {
	return Set(b.location, value)
}

type Float_bool_map struct {
	location []*Locator
}

func (b Float_bool_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_bool_map(l []*Locator) Float_bool_map {
	return Float_bool_map{location: l}
}
func (b Float_bool_map) Key(key bool) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Float_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Float_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_bool_map) Set(value map[bool]float32) *Op {
	return Set(b.location, value)
}

type Float_int32_map struct {
	location []*Locator
}

func (b Float_int32_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_int32_map(l []*Locator) Float_int32_map {
	return Float_int32_map{location: l}
}
func (b Float_int32_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Float_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Float_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_int32_map) Set(value map[int32]float32) *Op {
	return Set(b.location, value)
}

type Float_int64_map struct {
	location []*Locator
}

func (b Float_int64_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_int64_map(l []*Locator) Float_int64_map {
	return Float_int64_map{location: l}
}
func (b Float_int64_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Float_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Float_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_int64_map) Set(value map[int64]float32) *Op {
	return Set(b.location, value)
}

type Float_uint32_map struct {
	location []*Locator
}

func (b Float_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_uint32_map(l []*Locator) Float_uint32_map {
	return Float_uint32_map{location: l}
}
func (b Float_uint32_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Float_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Float_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_uint32_map) Set(value map[uint32]float32) *Op {
	return Set(b.location, value)
}

type Float_uint64_map struct {
	location []*Locator
}

func (b Float_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_uint64_map(l []*Locator) Float_uint64_map {
	return Float_uint64_map{location: l}
}
func (b Float_uint64_map) Key(key int) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Float_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Float_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_uint64_map) Set(value map[uint64]float32) *Op {
	return Set(b.location, value)
}

type Float_string_map struct {
	location []*Locator
}

func (b Float_string_map) Location_get() []*Locator {
	return b.location
}
func NewFloat_string_map(l []*Locator) Float_string_map {
	return Float_string_map{location: l}
}
func (b Float_string_map) Key(key string) Float_scalar {
	return NewFloat_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Float_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Float_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Float_string_map) Set(value map[string]float32) *Op {
	return Set(b.location, value)
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
func (b Int32_scalar) Set(value int) *Op {
	return Set(b.location, int32(value))
}

type Int32_list struct {
	location []*Locator
}

func (b Int32_list) Location_get() []*Locator {
	return b.location
}
func NewInt32_list(l []*Locator) Int32_list {
	return Int32_list{location: l}
}
func (b Int32_list) Index(i int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Int32_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int32(value))
}
func (b Int32_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Int32_list) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_list) Set(value []int32) *Op {
	return Set(b.location, value)
}

type Int32_bool_map struct {
	location []*Locator
}

func (b Int32_bool_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_bool_map(l []*Locator) Int32_bool_map {
	return Int32_bool_map{location: l}
}
func (b Int32_bool_map) Key(key bool) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Int32_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Int32_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_bool_map) Set(value map[bool]int32) *Op {
	return Set(b.location, value)
}

type Int32_int32_map struct {
	location []*Locator
}

func (b Int32_int32_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_int32_map(l []*Locator) Int32_int32_map {
	return Int32_int32_map{location: l}
}
func (b Int32_int32_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Int32_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Int32_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_int32_map) Set(value map[int32]int32) *Op {
	return Set(b.location, value)
}

type Int32_int64_map struct {
	location []*Locator
}

func (b Int32_int64_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_int64_map(l []*Locator) Int32_int64_map {
	return Int32_int64_map{location: l}
}
func (b Int32_int64_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Int32_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Int32_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_int64_map) Set(value map[int64]int32) *Op {
	return Set(b.location, value)
}

type Int32_uint32_map struct {
	location []*Locator
}

func (b Int32_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_uint32_map(l []*Locator) Int32_uint32_map {
	return Int32_uint32_map{location: l}
}
func (b Int32_uint32_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Int32_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Int32_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_uint32_map) Set(value map[uint32]int32) *Op {
	return Set(b.location, value)
}

type Int32_uint64_map struct {
	location []*Locator
}

func (b Int32_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_uint64_map(l []*Locator) Int32_uint64_map {
	return Int32_uint64_map{location: l}
}
func (b Int32_uint64_map) Key(key int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Int32_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Int32_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_uint64_map) Set(value map[uint64]int32) *Op {
	return Set(b.location, value)
}

type Int32_string_map struct {
	location []*Locator
}

func (b Int32_string_map) Location_get() []*Locator {
	return b.location
}
func NewInt32_string_map(l []*Locator) Int32_string_map {
	return Int32_string_map{location: l}
}
func (b Int32_string_map) Key(key string) Int32_scalar {
	return NewInt32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Int32_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Int32_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int32_string_map) Set(value map[string]int32) *Op {
	return Set(b.location, value)
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
func (b Int64_scalar) Set(value int) *Op {
	return Set(b.location, int64(value))
}

type Int64_list struct {
	location []*Locator
}

func (b Int64_list) Location_get() []*Locator {
	return b.location
}
func NewInt64_list(l []*Locator) Int64_list {
	return Int64_list{location: l}
}
func (b Int64_list) Index(i int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Int64_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int64(value))
}
func (b Int64_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Int64_list) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_list) Set(value []int64) *Op {
	return Set(b.location, value)
}

type Int64_bool_map struct {
	location []*Locator
}

func (b Int64_bool_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_bool_map(l []*Locator) Int64_bool_map {
	return Int64_bool_map{location: l}
}
func (b Int64_bool_map) Key(key bool) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Int64_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Int64_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_bool_map) Set(value map[bool]int64) *Op {
	return Set(b.location, value)
}

type Int64_int32_map struct {
	location []*Locator
}

func (b Int64_int32_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_int32_map(l []*Locator) Int64_int32_map {
	return Int64_int32_map{location: l}
}
func (b Int64_int32_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Int64_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Int64_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_int32_map) Set(value map[int32]int64) *Op {
	return Set(b.location, value)
}

type Int64_int64_map struct {
	location []*Locator
}

func (b Int64_int64_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_int64_map(l []*Locator) Int64_int64_map {
	return Int64_int64_map{location: l}
}
func (b Int64_int64_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Int64_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Int64_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_int64_map) Set(value map[int64]int64) *Op {
	return Set(b.location, value)
}

type Int64_uint32_map struct {
	location []*Locator
}

func (b Int64_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_uint32_map(l []*Locator) Int64_uint32_map {
	return Int64_uint32_map{location: l}
}
func (b Int64_uint32_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Int64_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Int64_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_uint32_map) Set(value map[uint32]int64) *Op {
	return Set(b.location, value)
}

type Int64_uint64_map struct {
	location []*Locator
}

func (b Int64_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_uint64_map(l []*Locator) Int64_uint64_map {
	return Int64_uint64_map{location: l}
}
func (b Int64_uint64_map) Key(key int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Int64_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Int64_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_uint64_map) Set(value map[uint64]int64) *Op {
	return Set(b.location, value)
}

type Int64_string_map struct {
	location []*Locator
}

func (b Int64_string_map) Location_get() []*Locator {
	return b.location
}
func NewInt64_string_map(l []*Locator) Int64_string_map {
	return Int64_string_map{location: l}
}
func (b Int64_string_map) Key(key string) Int64_scalar {
	return NewInt64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Int64_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Int64_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Int64_string_map) Set(value map[string]int64) *Op {
	return Set(b.location, value)
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
func (b Sfixed32_scalar) Set(value int) *Op {
	return Set(b.location, int32(value))
}

type Sfixed32_list struct {
	location []*Locator
}

func (b Sfixed32_list) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_list(l []*Locator) Sfixed32_list {
	return Sfixed32_list{location: l}
}
func (b Sfixed32_list) Index(i int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sfixed32_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int32(value))
}
func (b Sfixed32_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sfixed32_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_list) Set(value []int32) *Op {
	return Set(b.location, value)
}

type Sfixed32_bool_map struct {
	location []*Locator
}

func (b Sfixed32_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_bool_map(l []*Locator) Sfixed32_bool_map {
	return Sfixed32_bool_map{location: l}
}
func (b Sfixed32_bool_map) Key(key bool) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sfixed32_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sfixed32_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_bool_map) Set(value map[bool]int32) *Op {
	return Set(b.location, value)
}

type Sfixed32_int32_map struct {
	location []*Locator
}

func (b Sfixed32_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_int32_map(l []*Locator) Sfixed32_int32_map {
	return Sfixed32_int32_map{location: l}
}
func (b Sfixed32_int32_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sfixed32_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sfixed32_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_int32_map) Set(value map[int32]int32) *Op {
	return Set(b.location, value)
}

type Sfixed32_int64_map struct {
	location []*Locator
}

func (b Sfixed32_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_int64_map(l []*Locator) Sfixed32_int64_map {
	return Sfixed32_int64_map{location: l}
}
func (b Sfixed32_int64_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sfixed32_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sfixed32_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_int64_map) Set(value map[int64]int32) *Op {
	return Set(b.location, value)
}

type Sfixed32_uint32_map struct {
	location []*Locator
}

func (b Sfixed32_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_uint32_map(l []*Locator) Sfixed32_uint32_map {
	return Sfixed32_uint32_map{location: l}
}
func (b Sfixed32_uint32_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sfixed32_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sfixed32_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_uint32_map) Set(value map[uint32]int32) *Op {
	return Set(b.location, value)
}

type Sfixed32_uint64_map struct {
	location []*Locator
}

func (b Sfixed32_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_uint64_map(l []*Locator) Sfixed32_uint64_map {
	return Sfixed32_uint64_map{location: l}
}
func (b Sfixed32_uint64_map) Key(key int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sfixed32_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sfixed32_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_uint64_map) Set(value map[uint64]int32) *Op {
	return Set(b.location, value)
}

type Sfixed32_string_map struct {
	location []*Locator
}

func (b Sfixed32_string_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed32_string_map(l []*Locator) Sfixed32_string_map {
	return Sfixed32_string_map{location: l}
}
func (b Sfixed32_string_map) Key(key string) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sfixed32_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sfixed32_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed32_string_map) Set(value map[string]int32) *Op {
	return Set(b.location, value)
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
func (b Sfixed64_scalar) Set(value int) *Op {
	return Set(b.location, int64(value))
}

type Sfixed64_list struct {
	location []*Locator
}

func (b Sfixed64_list) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_list(l []*Locator) Sfixed64_list {
	return Sfixed64_list{location: l}
}
func (b Sfixed64_list) Index(i int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sfixed64_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int64(value))
}
func (b Sfixed64_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sfixed64_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_list) Set(value []int64) *Op {
	return Set(b.location, value)
}

type Sfixed64_bool_map struct {
	location []*Locator
}

func (b Sfixed64_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_bool_map(l []*Locator) Sfixed64_bool_map {
	return Sfixed64_bool_map{location: l}
}
func (b Sfixed64_bool_map) Key(key bool) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sfixed64_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sfixed64_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_bool_map) Set(value map[bool]int64) *Op {
	return Set(b.location, value)
}

type Sfixed64_int32_map struct {
	location []*Locator
}

func (b Sfixed64_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_int32_map(l []*Locator) Sfixed64_int32_map {
	return Sfixed64_int32_map{location: l}
}
func (b Sfixed64_int32_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sfixed64_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sfixed64_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_int32_map) Set(value map[int32]int64) *Op {
	return Set(b.location, value)
}

type Sfixed64_int64_map struct {
	location []*Locator
}

func (b Sfixed64_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_int64_map(l []*Locator) Sfixed64_int64_map {
	return Sfixed64_int64_map{location: l}
}
func (b Sfixed64_int64_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sfixed64_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sfixed64_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_int64_map) Set(value map[int64]int64) *Op {
	return Set(b.location, value)
}

type Sfixed64_uint32_map struct {
	location []*Locator
}

func (b Sfixed64_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_uint32_map(l []*Locator) Sfixed64_uint32_map {
	return Sfixed64_uint32_map{location: l}
}
func (b Sfixed64_uint32_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sfixed64_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sfixed64_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_uint32_map) Set(value map[uint32]int64) *Op {
	return Set(b.location, value)
}

type Sfixed64_uint64_map struct {
	location []*Locator
}

func (b Sfixed64_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_uint64_map(l []*Locator) Sfixed64_uint64_map {
	return Sfixed64_uint64_map{location: l}
}
func (b Sfixed64_uint64_map) Key(key int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sfixed64_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sfixed64_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_uint64_map) Set(value map[uint64]int64) *Op {
	return Set(b.location, value)
}

type Sfixed64_string_map struct {
	location []*Locator
}

func (b Sfixed64_string_map) Location_get() []*Locator {
	return b.location
}
func NewSfixed64_string_map(l []*Locator) Sfixed64_string_map {
	return Sfixed64_string_map{location: l}
}
func (b Sfixed64_string_map) Key(key string) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sfixed64_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sfixed64_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sfixed64_string_map) Set(value map[string]int64) *Op {
	return Set(b.location, value)
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
func (b Sint32_scalar) Set(value int) *Op {
	return Set(b.location, int32(value))
}

type Sint32_list struct {
	location []*Locator
}

func (b Sint32_list) Location_get() []*Locator {
	return b.location
}
func NewSint32_list(l []*Locator) Sint32_list {
	return Sint32_list{location: l}
}
func (b Sint32_list) Index(i int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sint32_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int32(value))
}
func (b Sint32_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sint32_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_list) Set(value []int32) *Op {
	return Set(b.location, value)
}

type Sint32_bool_map struct {
	location []*Locator
}

func (b Sint32_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_bool_map(l []*Locator) Sint32_bool_map {
	return Sint32_bool_map{location: l}
}
func (b Sint32_bool_map) Key(key bool) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sint32_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sint32_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_bool_map) Set(value map[bool]int32) *Op {
	return Set(b.location, value)
}

type Sint32_int32_map struct {
	location []*Locator
}

func (b Sint32_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_int32_map(l []*Locator) Sint32_int32_map {
	return Sint32_int32_map{location: l}
}
func (b Sint32_int32_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sint32_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sint32_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_int32_map) Set(value map[int32]int32) *Op {
	return Set(b.location, value)
}

type Sint32_int64_map struct {
	location []*Locator
}

func (b Sint32_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_int64_map(l []*Locator) Sint32_int64_map {
	return Sint32_int64_map{location: l}
}
func (b Sint32_int64_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sint32_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sint32_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_int64_map) Set(value map[int64]int32) *Op {
	return Set(b.location, value)
}

type Sint32_uint32_map struct {
	location []*Locator
}

func (b Sint32_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_uint32_map(l []*Locator) Sint32_uint32_map {
	return Sint32_uint32_map{location: l}
}
func (b Sint32_uint32_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sint32_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sint32_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_uint32_map) Set(value map[uint32]int32) *Op {
	return Set(b.location, value)
}

type Sint32_uint64_map struct {
	location []*Locator
}

func (b Sint32_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_uint64_map(l []*Locator) Sint32_uint64_map {
	return Sint32_uint64_map{location: l}
}
func (b Sint32_uint64_map) Key(key int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sint32_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sint32_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_uint64_map) Set(value map[uint64]int32) *Op {
	return Set(b.location, value)
}

type Sint32_string_map struct {
	location []*Locator
}

func (b Sint32_string_map) Location_get() []*Locator {
	return b.location
}
func NewSint32_string_map(l []*Locator) Sint32_string_map {
	return Sint32_string_map{location: l}
}
func (b Sint32_string_map) Key(key string) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sint32_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sint32_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint32_string_map) Set(value map[string]int32) *Op {
	return Set(b.location, value)
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
func (b Sint64_scalar) Set(value int) *Op {
	return Set(b.location, int64(value))
}

type Sint64_list struct {
	location []*Locator
}

func (b Sint64_list) Location_get() []*Locator {
	return b.location
}
func NewSint64_list(l []*Locator) Sint64_list {
	return Sint64_list{location: l}
}
func (b Sint64_list) Index(i int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Sint64_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), int64(value))
}
func (b Sint64_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Sint64_list) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_list) Set(value []int64) *Op {
	return Set(b.location, value)
}

type Sint64_bool_map struct {
	location []*Locator
}

func (b Sint64_bool_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_bool_map(l []*Locator) Sint64_bool_map {
	return Sint64_bool_map{location: l}
}
func (b Sint64_bool_map) Key(key bool) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Sint64_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Sint64_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_bool_map) Set(value map[bool]int64) *Op {
	return Set(b.location, value)
}

type Sint64_int32_map struct {
	location []*Locator
}

func (b Sint64_int32_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_int32_map(l []*Locator) Sint64_int32_map {
	return Sint64_int32_map{location: l}
}
func (b Sint64_int32_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Sint64_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Sint64_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_int32_map) Set(value map[int32]int64) *Op {
	return Set(b.location, value)
}

type Sint64_int64_map struct {
	location []*Locator
}

func (b Sint64_int64_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_int64_map(l []*Locator) Sint64_int64_map {
	return Sint64_int64_map{location: l}
}
func (b Sint64_int64_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Sint64_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Sint64_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_int64_map) Set(value map[int64]int64) *Op {
	return Set(b.location, value)
}

type Sint64_uint32_map struct {
	location []*Locator
}

func (b Sint64_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_uint32_map(l []*Locator) Sint64_uint32_map {
	return Sint64_uint32_map{location: l}
}
func (b Sint64_uint32_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Sint64_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Sint64_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_uint32_map) Set(value map[uint32]int64) *Op {
	return Set(b.location, value)
}

type Sint64_uint64_map struct {
	location []*Locator
}

func (b Sint64_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_uint64_map(l []*Locator) Sint64_uint64_map {
	return Sint64_uint64_map{location: l}
}
func (b Sint64_uint64_map) Key(key int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Sint64_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Sint64_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_uint64_map) Set(value map[uint64]int64) *Op {
	return Set(b.location, value)
}

type Sint64_string_map struct {
	location []*Locator
}

func (b Sint64_string_map) Location_get() []*Locator {
	return b.location
}
func NewSint64_string_map(l []*Locator) Sint64_string_map {
	return Sint64_string_map{location: l}
}
func (b Sint64_string_map) Key(key string) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Sint64_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Sint64_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Sint64_string_map) Set(value map[string]int64) *Op {
	return Set(b.location, value)
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
func (b String_scalar) Edit(from, to string) *Op {
	return Edit(b.location, from, to)
}
func (b String_scalar) Delete() *Op {
	return Delete(b.location)
}
func (b String_scalar) Set(value string) *Op {
	return Set(b.location, value)
}

type String_list struct {
	location []*Locator
}

func (b String_list) Location_get() []*Locator {
	return b.location
}
func NewString_list(l []*Locator) String_list {
	return String_list{location: l}
}
func (b String_list) Index(i int) String_scalar {
	return NewString_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b String_list) Insert(index int, value string) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), value)
}
func (b String_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b String_list) Delete() *Op {
	return Delete(b.location)
}
func (b String_list) Set(value []string) *Op {
	return Set(b.location, value)
}

type String_bool_map struct {
	location []*Locator
}

func (b String_bool_map) Location_get() []*Locator {
	return b.location
}
func NewString_bool_map(l []*Locator) String_bool_map {
	return String_bool_map{location: l}
}
func (b String_bool_map) Key(key bool) String_scalar {
	return NewString_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b String_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b String_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_bool_map) Set(value map[bool]string) *Op {
	return Set(b.location, value)
}

type String_int32_map struct {
	location []*Locator
}

func (b String_int32_map) Location_get() []*Locator {
	return b.location
}
func NewString_int32_map(l []*Locator) String_int32_map {
	return String_int32_map{location: l}
}
func (b String_int32_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b String_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b String_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_int32_map) Set(value map[int32]string) *Op {
	return Set(b.location, value)
}

type String_int64_map struct {
	location []*Locator
}

func (b String_int64_map) Location_get() []*Locator {
	return b.location
}
func NewString_int64_map(l []*Locator) String_int64_map {
	return String_int64_map{location: l}
}
func (b String_int64_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b String_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b String_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_int64_map) Set(value map[int64]string) *Op {
	return Set(b.location, value)
}

type String_uint32_map struct {
	location []*Locator
}

func (b String_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewString_uint32_map(l []*Locator) String_uint32_map {
	return String_uint32_map{location: l}
}
func (b String_uint32_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b String_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b String_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_uint32_map) Set(value map[uint32]string) *Op {
	return Set(b.location, value)
}

type String_uint64_map struct {
	location []*Locator
}

func (b String_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewString_uint64_map(l []*Locator) String_uint64_map {
	return String_uint64_map{location: l}
}
func (b String_uint64_map) Key(key int) String_scalar {
	return NewString_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b String_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b String_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_uint64_map) Set(value map[uint64]string) *Op {
	return Set(b.location, value)
}

type String_string_map struct {
	location []*Locator
}

func (b String_string_map) Location_get() []*Locator {
	return b.location
}
func NewString_string_map(l []*Locator) String_string_map {
	return String_string_map{location: l}
}
func (b String_string_map) Key(key string) String_scalar {
	return NewString_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b String_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b String_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b String_string_map) Set(value map[string]string) *Op {
	return Set(b.location, value)
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
func (b Uint32_scalar) Set(value int) *Op {
	return Set(b.location, uint32(value))
}

type Uint32_list struct {
	location []*Locator
}

func (b Uint32_list) Location_get() []*Locator {
	return b.location
}
func NewUint32_list(l []*Locator) Uint32_list {
	return Uint32_list{location: l}
}
func (b Uint32_list) Index(i int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Uint32_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint32(value))
}
func (b Uint32_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Uint32_list) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_list) Set(value []uint32) *Op {
	return Set(b.location, value)
}

type Uint32_bool_map struct {
	location []*Locator
}

func (b Uint32_bool_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_bool_map(l []*Locator) Uint32_bool_map {
	return Uint32_bool_map{location: l}
}
func (b Uint32_bool_map) Key(key bool) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Uint32_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Uint32_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_bool_map) Set(value map[bool]uint32) *Op {
	return Set(b.location, value)
}

type Uint32_int32_map struct {
	location []*Locator
}

func (b Uint32_int32_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_int32_map(l []*Locator) Uint32_int32_map {
	return Uint32_int32_map{location: l}
}
func (b Uint32_int32_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Uint32_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Uint32_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_int32_map) Set(value map[int32]uint32) *Op {
	return Set(b.location, value)
}

type Uint32_int64_map struct {
	location []*Locator
}

func (b Uint32_int64_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_int64_map(l []*Locator) Uint32_int64_map {
	return Uint32_int64_map{location: l}
}
func (b Uint32_int64_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Uint32_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Uint32_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_int64_map) Set(value map[int64]uint32) *Op {
	return Set(b.location, value)
}

type Uint32_uint32_map struct {
	location []*Locator
}

func (b Uint32_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_uint32_map(l []*Locator) Uint32_uint32_map {
	return Uint32_uint32_map{location: l}
}
func (b Uint32_uint32_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Uint32_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Uint32_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_uint32_map) Set(value map[uint32]uint32) *Op {
	return Set(b.location, value)
}

type Uint32_uint64_map struct {
	location []*Locator
}

func (b Uint32_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_uint64_map(l []*Locator) Uint32_uint64_map {
	return Uint32_uint64_map{location: l}
}
func (b Uint32_uint64_map) Key(key int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Uint32_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Uint32_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_uint64_map) Set(value map[uint64]uint32) *Op {
	return Set(b.location, value)
}

type Uint32_string_map struct {
	location []*Locator
}

func (b Uint32_string_map) Location_get() []*Locator {
	return b.location
}
func NewUint32_string_map(l []*Locator) Uint32_string_map {
	return Uint32_string_map{location: l}
}
func (b Uint32_string_map) Key(key string) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Uint32_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Uint32_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint32_string_map) Set(value map[string]uint32) *Op {
	return Set(b.location, value)
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
func (b Uint64_scalar) Set(value int) *Op {
	return Set(b.location, uint64(value))
}

type Uint64_list struct {
	location []*Locator
}

func (b Uint64_list) Location_get() []*Locator {
	return b.location
}
func NewUint64_list(l []*Locator) Uint64_list {
	return Uint64_list{location: l}
}
func (b Uint64_list) Index(i int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendIndex(b.location, int64(i)))
}
func (b Uint64_list) Insert(index int, value int) *Op {
	return Insert(CopyAndAppendIndex(b.location, int64(index)), uint64(value))
}
func (b Uint64_list) Move(from, to int) *Op {
	return Move(CopyAndAppendIndex(b.location, int64(from)), int64(to))
}
func (b Uint64_list) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_list) Set(value []uint64) *Op {
	return Set(b.location, value)
}

type Uint64_bool_map struct {
	location []*Locator
}

func (b Uint64_bool_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_bool_map(l []*Locator) Uint64_bool_map {
	return Uint64_bool_map{location: l}
}
func (b Uint64_bool_map) Key(key bool) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyBool(b.location, key))
}
func (b Uint64_bool_map) Rename(from, to bool) *Op {
	return Rename(CopyAndAppendKeyBool(b.location, from), to)
}
func (b Uint64_bool_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_bool_map) Set(value map[bool]uint64) *Op {
	return Set(b.location, value)
}

type Uint64_int32_map struct {
	location []*Locator
}

func (b Uint64_int32_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_int32_map(l []*Locator) Uint64_int32_map {
	return Uint64_int32_map{location: l}
}
func (b Uint64_int32_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyInt32(b.location, int32(key)))
}
func (b Uint64_int32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt32(b.location, int32(from)), int32(to))
}
func (b Uint64_int32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_int32_map) Set(value map[int32]uint64) *Op {
	return Set(b.location, value)
}

type Uint64_int64_map struct {
	location []*Locator
}

func (b Uint64_int64_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_int64_map(l []*Locator) Uint64_int64_map {
	return Uint64_int64_map{location: l}
}
func (b Uint64_int64_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyInt64(b.location, int64(key)))
}
func (b Uint64_int64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyInt64(b.location, int64(from)), int64(to))
}
func (b Uint64_int64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_int64_map) Set(value map[int64]uint64) *Op {
	return Set(b.location, value)
}

type Uint64_uint32_map struct {
	location []*Locator
}

func (b Uint64_uint32_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_uint32_map(l []*Locator) Uint64_uint32_map {
	return Uint64_uint32_map{location: l}
}
func (b Uint64_uint32_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyUint32(b.location, uint32(key)))
}
func (b Uint64_uint32_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint32(b.location, uint32(from)), uint32(to))
}
func (b Uint64_uint32_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_uint32_map) Set(value map[uint32]uint64) *Op {
	return Set(b.location, value)
}

type Uint64_uint64_map struct {
	location []*Locator
}

func (b Uint64_uint64_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_uint64_map(l []*Locator) Uint64_uint64_map {
	return Uint64_uint64_map{location: l}
}
func (b Uint64_uint64_map) Key(key int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyUint64(b.location, uint64(key)))
}
func (b Uint64_uint64_map) Rename(from, to int) *Op {
	return Rename(CopyAndAppendKeyUint64(b.location, uint64(from)), uint64(to))
}
func (b Uint64_uint64_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_uint64_map) Set(value map[uint64]uint64) *Op {
	return Set(b.location, value)
}

type Uint64_string_map struct {
	location []*Locator
}

func (b Uint64_string_map) Location_get() []*Locator {
	return b.location
}
func NewUint64_string_map(l []*Locator) Uint64_string_map {
	return Uint64_string_map{location: l}
}
func (b Uint64_string_map) Key(key string) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppendKeyString(b.location, key))
}
func (b Uint64_string_map) Rename(from, to string) *Op {
	return Rename(CopyAndAppendKeyString(b.location, from), to)
}
func (b Uint64_string_map) Delete() *Op {
	return Delete(b.location)
}
func (b Uint64_string_map) Set(value map[string]uint64) *Op {
	return Set(b.location, value)
}
