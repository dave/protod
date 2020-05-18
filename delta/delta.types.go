package delta

type Double_scalar struct {
	location []Locator
}

func (b Double_scalar) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar(l []Locator) Double_scalar {
	return Double_scalar{location: l}
}

type Double_scalar_repeated struct {
	location []Locator
}

func (b Double_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar_repeated(l []Locator) Double_scalar_repeated {
	return Double_scalar_repeated{location: l}
}
func (b Double_scalar_repeated) Index(i int) Double_scalar {
	return NewDouble_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Double_scalar_bool_map struct {
	location []Locator
}

func (b Double_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar_bool_map(l []Locator) Double_scalar_bool_map {
	return Double_scalar_bool_map{location: l}
}
func (b Double_scalar_bool_map) Key(k bool) Double_scalar {
	return NewDouble_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Double_scalar_int32_map struct {
	location []Locator
}

func (b Double_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar_int32_map(l []Locator) Double_scalar_int32_map {
	return Double_scalar_int32_map{location: l}
}
func (b Double_scalar_int32_map) Key(k int32) Double_scalar {
	return NewDouble_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Double_scalar_int64_map struct {
	location []Locator
}

func (b Double_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar_int64_map(l []Locator) Double_scalar_int64_map {
	return Double_scalar_int64_map{location: l}
}
func (b Double_scalar_int64_map) Key(k int64) Double_scalar {
	return NewDouble_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Double_scalar_uint32_map struct {
	location []Locator
}

func (b Double_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar_uint32_map(l []Locator) Double_scalar_uint32_map {
	return Double_scalar_uint32_map{location: l}
}
func (b Double_scalar_uint32_map) Key(k uint32) Double_scalar {
	return NewDouble_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Double_scalar_uint64_map struct {
	location []Locator
}

func (b Double_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar_uint64_map(l []Locator) Double_scalar_uint64_map {
	return Double_scalar_uint64_map{location: l}
}
func (b Double_scalar_uint64_map) Key(k uint64) Double_scalar {
	return NewDouble_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Double_scalar_string_map struct {
	location []Locator
}

func (b Double_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewDouble_scalar_string_map(l []Locator) Double_scalar_string_map {
	return Double_scalar_string_map{location: l}
}
func (b Double_scalar_string_map) Key(k string) Double_scalar {
	return NewDouble_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Float_scalar struct {
	location []Locator
}

func (b Float_scalar) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar(l []Locator) Float_scalar {
	return Float_scalar{location: l}
}

type Float_scalar_repeated struct {
	location []Locator
}

func (b Float_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar_repeated(l []Locator) Float_scalar_repeated {
	return Float_scalar_repeated{location: l}
}
func (b Float_scalar_repeated) Index(i int) Float_scalar {
	return NewFloat_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Float_scalar_bool_map struct {
	location []Locator
}

func (b Float_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar_bool_map(l []Locator) Float_scalar_bool_map {
	return Float_scalar_bool_map{location: l}
}
func (b Float_scalar_bool_map) Key(k bool) Float_scalar {
	return NewFloat_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Float_scalar_int32_map struct {
	location []Locator
}

func (b Float_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar_int32_map(l []Locator) Float_scalar_int32_map {
	return Float_scalar_int32_map{location: l}
}
func (b Float_scalar_int32_map) Key(k int32) Float_scalar {
	return NewFloat_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Float_scalar_int64_map struct {
	location []Locator
}

func (b Float_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar_int64_map(l []Locator) Float_scalar_int64_map {
	return Float_scalar_int64_map{location: l}
}
func (b Float_scalar_int64_map) Key(k int64) Float_scalar {
	return NewFloat_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Float_scalar_uint32_map struct {
	location []Locator
}

func (b Float_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar_uint32_map(l []Locator) Float_scalar_uint32_map {
	return Float_scalar_uint32_map{location: l}
}
func (b Float_scalar_uint32_map) Key(k uint32) Float_scalar {
	return NewFloat_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Float_scalar_uint64_map struct {
	location []Locator
}

func (b Float_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar_uint64_map(l []Locator) Float_scalar_uint64_map {
	return Float_scalar_uint64_map{location: l}
}
func (b Float_scalar_uint64_map) Key(k uint64) Float_scalar {
	return NewFloat_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Float_scalar_string_map struct {
	location []Locator
}

func (b Float_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewFloat_scalar_string_map(l []Locator) Float_scalar_string_map {
	return Float_scalar_string_map{location: l}
}
func (b Float_scalar_string_map) Key(k string) Float_scalar {
	return NewFloat_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int32_scalar struct {
	location []Locator
}

func (b Int32_scalar) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar(l []Locator) Int32_scalar {
	return Int32_scalar{location: l}
}

type Int32_scalar_repeated struct {
	location []Locator
}

func (b Int32_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar_repeated(l []Locator) Int32_scalar_repeated {
	return Int32_scalar_repeated{location: l}
}
func (b Int32_scalar_repeated) Index(i int) Int32_scalar {
	return NewInt32_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Int32_scalar_bool_map struct {
	location []Locator
}

func (b Int32_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar_bool_map(l []Locator) Int32_scalar_bool_map {
	return Int32_scalar_bool_map{location: l}
}
func (b Int32_scalar_bool_map) Key(k bool) Int32_scalar {
	return NewInt32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int32_scalar_int32_map struct {
	location []Locator
}

func (b Int32_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar_int32_map(l []Locator) Int32_scalar_int32_map {
	return Int32_scalar_int32_map{location: l}
}
func (b Int32_scalar_int32_map) Key(k int32) Int32_scalar {
	return NewInt32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int32_scalar_int64_map struct {
	location []Locator
}

func (b Int32_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar_int64_map(l []Locator) Int32_scalar_int64_map {
	return Int32_scalar_int64_map{location: l}
}
func (b Int32_scalar_int64_map) Key(k int64) Int32_scalar {
	return NewInt32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int32_scalar_uint32_map struct {
	location []Locator
}

func (b Int32_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar_uint32_map(l []Locator) Int32_scalar_uint32_map {
	return Int32_scalar_uint32_map{location: l}
}
func (b Int32_scalar_uint32_map) Key(k uint32) Int32_scalar {
	return NewInt32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int32_scalar_uint64_map struct {
	location []Locator
}

func (b Int32_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar_uint64_map(l []Locator) Int32_scalar_uint64_map {
	return Int32_scalar_uint64_map{location: l}
}
func (b Int32_scalar_uint64_map) Key(k uint64) Int32_scalar {
	return NewInt32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int32_scalar_string_map struct {
	location []Locator
}

func (b Int32_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewInt32_scalar_string_map(l []Locator) Int32_scalar_string_map {
	return Int32_scalar_string_map{location: l}
}
func (b Int32_scalar_string_map) Key(k string) Int32_scalar {
	return NewInt32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int64_scalar struct {
	location []Locator
}

func (b Int64_scalar) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar(l []Locator) Int64_scalar {
	return Int64_scalar{location: l}
}

type Int64_scalar_repeated struct {
	location []Locator
}

func (b Int64_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar_repeated(l []Locator) Int64_scalar_repeated {
	return Int64_scalar_repeated{location: l}
}
func (b Int64_scalar_repeated) Index(i int) Int64_scalar {
	return NewInt64_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Int64_scalar_bool_map struct {
	location []Locator
}

func (b Int64_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar_bool_map(l []Locator) Int64_scalar_bool_map {
	return Int64_scalar_bool_map{location: l}
}
func (b Int64_scalar_bool_map) Key(k bool) Int64_scalar {
	return NewInt64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int64_scalar_int32_map struct {
	location []Locator
}

func (b Int64_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar_int32_map(l []Locator) Int64_scalar_int32_map {
	return Int64_scalar_int32_map{location: l}
}
func (b Int64_scalar_int32_map) Key(k int32) Int64_scalar {
	return NewInt64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int64_scalar_int64_map struct {
	location []Locator
}

func (b Int64_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar_int64_map(l []Locator) Int64_scalar_int64_map {
	return Int64_scalar_int64_map{location: l}
}
func (b Int64_scalar_int64_map) Key(k int64) Int64_scalar {
	return NewInt64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int64_scalar_uint32_map struct {
	location []Locator
}

func (b Int64_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar_uint32_map(l []Locator) Int64_scalar_uint32_map {
	return Int64_scalar_uint32_map{location: l}
}
func (b Int64_scalar_uint32_map) Key(k uint32) Int64_scalar {
	return NewInt64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int64_scalar_uint64_map struct {
	location []Locator
}

func (b Int64_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar_uint64_map(l []Locator) Int64_scalar_uint64_map {
	return Int64_scalar_uint64_map{location: l}
}
func (b Int64_scalar_uint64_map) Key(k uint64) Int64_scalar {
	return NewInt64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Int64_scalar_string_map struct {
	location []Locator
}

func (b Int64_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewInt64_scalar_string_map(l []Locator) Int64_scalar_string_map {
	return Int64_scalar_string_map{location: l}
}
func (b Int64_scalar_string_map) Key(k string) Int64_scalar {
	return NewInt64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint32_scalar struct {
	location []Locator
}

func (b Uint32_scalar) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar(l []Locator) Uint32_scalar {
	return Uint32_scalar{location: l}
}

type Uint32_scalar_repeated struct {
	location []Locator
}

func (b Uint32_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar_repeated(l []Locator) Uint32_scalar_repeated {
	return Uint32_scalar_repeated{location: l}
}
func (b Uint32_scalar_repeated) Index(i int) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Uint32_scalar_bool_map struct {
	location []Locator
}

func (b Uint32_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar_bool_map(l []Locator) Uint32_scalar_bool_map {
	return Uint32_scalar_bool_map{location: l}
}
func (b Uint32_scalar_bool_map) Key(k bool) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint32_scalar_int32_map struct {
	location []Locator
}

func (b Uint32_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar_int32_map(l []Locator) Uint32_scalar_int32_map {
	return Uint32_scalar_int32_map{location: l}
}
func (b Uint32_scalar_int32_map) Key(k int32) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint32_scalar_int64_map struct {
	location []Locator
}

func (b Uint32_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar_int64_map(l []Locator) Uint32_scalar_int64_map {
	return Uint32_scalar_int64_map{location: l}
}
func (b Uint32_scalar_int64_map) Key(k int64) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint32_scalar_uint32_map struct {
	location []Locator
}

func (b Uint32_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar_uint32_map(l []Locator) Uint32_scalar_uint32_map {
	return Uint32_scalar_uint32_map{location: l}
}
func (b Uint32_scalar_uint32_map) Key(k uint32) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint32_scalar_uint64_map struct {
	location []Locator
}

func (b Uint32_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar_uint64_map(l []Locator) Uint32_scalar_uint64_map {
	return Uint32_scalar_uint64_map{location: l}
}
func (b Uint32_scalar_uint64_map) Key(k uint64) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint32_scalar_string_map struct {
	location []Locator
}

func (b Uint32_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewUint32_scalar_string_map(l []Locator) Uint32_scalar_string_map {
	return Uint32_scalar_string_map{location: l}
}
func (b Uint32_scalar_string_map) Key(k string) Uint32_scalar {
	return NewUint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint64_scalar struct {
	location []Locator
}

func (b Uint64_scalar) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar(l []Locator) Uint64_scalar {
	return Uint64_scalar{location: l}
}

type Uint64_scalar_repeated struct {
	location []Locator
}

func (b Uint64_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar_repeated(l []Locator) Uint64_scalar_repeated {
	return Uint64_scalar_repeated{location: l}
}
func (b Uint64_scalar_repeated) Index(i int) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Uint64_scalar_bool_map struct {
	location []Locator
}

func (b Uint64_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar_bool_map(l []Locator) Uint64_scalar_bool_map {
	return Uint64_scalar_bool_map{location: l}
}
func (b Uint64_scalar_bool_map) Key(k bool) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint64_scalar_int32_map struct {
	location []Locator
}

func (b Uint64_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar_int32_map(l []Locator) Uint64_scalar_int32_map {
	return Uint64_scalar_int32_map{location: l}
}
func (b Uint64_scalar_int32_map) Key(k int32) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint64_scalar_int64_map struct {
	location []Locator
}

func (b Uint64_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar_int64_map(l []Locator) Uint64_scalar_int64_map {
	return Uint64_scalar_int64_map{location: l}
}
func (b Uint64_scalar_int64_map) Key(k int64) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint64_scalar_uint32_map struct {
	location []Locator
}

func (b Uint64_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar_uint32_map(l []Locator) Uint64_scalar_uint32_map {
	return Uint64_scalar_uint32_map{location: l}
}
func (b Uint64_scalar_uint32_map) Key(k uint32) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint64_scalar_uint64_map struct {
	location []Locator
}

func (b Uint64_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar_uint64_map(l []Locator) Uint64_scalar_uint64_map {
	return Uint64_scalar_uint64_map{location: l}
}
func (b Uint64_scalar_uint64_map) Key(k uint64) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Uint64_scalar_string_map struct {
	location []Locator
}

func (b Uint64_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewUint64_scalar_string_map(l []Locator) Uint64_scalar_string_map {
	return Uint64_scalar_string_map{location: l}
}
func (b Uint64_scalar_string_map) Key(k string) Uint64_scalar {
	return NewUint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint32_scalar struct {
	location []Locator
}

func (b Sint32_scalar) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar(l []Locator) Sint32_scalar {
	return Sint32_scalar{location: l}
}

type Sint32_scalar_repeated struct {
	location []Locator
}

func (b Sint32_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar_repeated(l []Locator) Sint32_scalar_repeated {
	return Sint32_scalar_repeated{location: l}
}
func (b Sint32_scalar_repeated) Index(i int) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Sint32_scalar_bool_map struct {
	location []Locator
}

func (b Sint32_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar_bool_map(l []Locator) Sint32_scalar_bool_map {
	return Sint32_scalar_bool_map{location: l}
}
func (b Sint32_scalar_bool_map) Key(k bool) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint32_scalar_int32_map struct {
	location []Locator
}

func (b Sint32_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar_int32_map(l []Locator) Sint32_scalar_int32_map {
	return Sint32_scalar_int32_map{location: l}
}
func (b Sint32_scalar_int32_map) Key(k int32) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint32_scalar_int64_map struct {
	location []Locator
}

func (b Sint32_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar_int64_map(l []Locator) Sint32_scalar_int64_map {
	return Sint32_scalar_int64_map{location: l}
}
func (b Sint32_scalar_int64_map) Key(k int64) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint32_scalar_uint32_map struct {
	location []Locator
}

func (b Sint32_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar_uint32_map(l []Locator) Sint32_scalar_uint32_map {
	return Sint32_scalar_uint32_map{location: l}
}
func (b Sint32_scalar_uint32_map) Key(k uint32) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint32_scalar_uint64_map struct {
	location []Locator
}

func (b Sint32_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar_uint64_map(l []Locator) Sint32_scalar_uint64_map {
	return Sint32_scalar_uint64_map{location: l}
}
func (b Sint32_scalar_uint64_map) Key(k uint64) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint32_scalar_string_map struct {
	location []Locator
}

func (b Sint32_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewSint32_scalar_string_map(l []Locator) Sint32_scalar_string_map {
	return Sint32_scalar_string_map{location: l}
}
func (b Sint32_scalar_string_map) Key(k string) Sint32_scalar {
	return NewSint32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint64_scalar struct {
	location []Locator
}

func (b Sint64_scalar) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar(l []Locator) Sint64_scalar {
	return Sint64_scalar{location: l}
}

type Sint64_scalar_repeated struct {
	location []Locator
}

func (b Sint64_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar_repeated(l []Locator) Sint64_scalar_repeated {
	return Sint64_scalar_repeated{location: l}
}
func (b Sint64_scalar_repeated) Index(i int) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Sint64_scalar_bool_map struct {
	location []Locator
}

func (b Sint64_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar_bool_map(l []Locator) Sint64_scalar_bool_map {
	return Sint64_scalar_bool_map{location: l}
}
func (b Sint64_scalar_bool_map) Key(k bool) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint64_scalar_int32_map struct {
	location []Locator
}

func (b Sint64_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar_int32_map(l []Locator) Sint64_scalar_int32_map {
	return Sint64_scalar_int32_map{location: l}
}
func (b Sint64_scalar_int32_map) Key(k int32) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint64_scalar_int64_map struct {
	location []Locator
}

func (b Sint64_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar_int64_map(l []Locator) Sint64_scalar_int64_map {
	return Sint64_scalar_int64_map{location: l}
}
func (b Sint64_scalar_int64_map) Key(k int64) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint64_scalar_uint32_map struct {
	location []Locator
}

func (b Sint64_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar_uint32_map(l []Locator) Sint64_scalar_uint32_map {
	return Sint64_scalar_uint32_map{location: l}
}
func (b Sint64_scalar_uint32_map) Key(k uint32) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint64_scalar_uint64_map struct {
	location []Locator
}

func (b Sint64_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar_uint64_map(l []Locator) Sint64_scalar_uint64_map {
	return Sint64_scalar_uint64_map{location: l}
}
func (b Sint64_scalar_uint64_map) Key(k uint64) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sint64_scalar_string_map struct {
	location []Locator
}

func (b Sint64_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewSint64_scalar_string_map(l []Locator) Sint64_scalar_string_map {
	return Sint64_scalar_string_map{location: l}
}
func (b Sint64_scalar_string_map) Key(k string) Sint64_scalar {
	return NewSint64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed32_scalar struct {
	location []Locator
}

func (b Fixed32_scalar) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar(l []Locator) Fixed32_scalar {
	return Fixed32_scalar{location: l}
}

type Fixed32_scalar_repeated struct {
	location []Locator
}

func (b Fixed32_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar_repeated(l []Locator) Fixed32_scalar_repeated {
	return Fixed32_scalar_repeated{location: l}
}
func (b Fixed32_scalar_repeated) Index(i int) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Fixed32_scalar_bool_map struct {
	location []Locator
}

func (b Fixed32_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar_bool_map(l []Locator) Fixed32_scalar_bool_map {
	return Fixed32_scalar_bool_map{location: l}
}
func (b Fixed32_scalar_bool_map) Key(k bool) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed32_scalar_int32_map struct {
	location []Locator
}

func (b Fixed32_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar_int32_map(l []Locator) Fixed32_scalar_int32_map {
	return Fixed32_scalar_int32_map{location: l}
}
func (b Fixed32_scalar_int32_map) Key(k int32) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed32_scalar_int64_map struct {
	location []Locator
}

func (b Fixed32_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar_int64_map(l []Locator) Fixed32_scalar_int64_map {
	return Fixed32_scalar_int64_map{location: l}
}
func (b Fixed32_scalar_int64_map) Key(k int64) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed32_scalar_uint32_map struct {
	location []Locator
}

func (b Fixed32_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar_uint32_map(l []Locator) Fixed32_scalar_uint32_map {
	return Fixed32_scalar_uint32_map{location: l}
}
func (b Fixed32_scalar_uint32_map) Key(k uint32) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed32_scalar_uint64_map struct {
	location []Locator
}

func (b Fixed32_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar_uint64_map(l []Locator) Fixed32_scalar_uint64_map {
	return Fixed32_scalar_uint64_map{location: l}
}
func (b Fixed32_scalar_uint64_map) Key(k uint64) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed32_scalar_string_map struct {
	location []Locator
}

func (b Fixed32_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewFixed32_scalar_string_map(l []Locator) Fixed32_scalar_string_map {
	return Fixed32_scalar_string_map{location: l}
}
func (b Fixed32_scalar_string_map) Key(k string) Fixed32_scalar {
	return NewFixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed64_scalar struct {
	location []Locator
}

func (b Fixed64_scalar) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar(l []Locator) Fixed64_scalar {
	return Fixed64_scalar{location: l}
}

type Fixed64_scalar_repeated struct {
	location []Locator
}

func (b Fixed64_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar_repeated(l []Locator) Fixed64_scalar_repeated {
	return Fixed64_scalar_repeated{location: l}
}
func (b Fixed64_scalar_repeated) Index(i int) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Fixed64_scalar_bool_map struct {
	location []Locator
}

func (b Fixed64_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar_bool_map(l []Locator) Fixed64_scalar_bool_map {
	return Fixed64_scalar_bool_map{location: l}
}
func (b Fixed64_scalar_bool_map) Key(k bool) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed64_scalar_int32_map struct {
	location []Locator
}

func (b Fixed64_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar_int32_map(l []Locator) Fixed64_scalar_int32_map {
	return Fixed64_scalar_int32_map{location: l}
}
func (b Fixed64_scalar_int32_map) Key(k int32) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed64_scalar_int64_map struct {
	location []Locator
}

func (b Fixed64_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar_int64_map(l []Locator) Fixed64_scalar_int64_map {
	return Fixed64_scalar_int64_map{location: l}
}
func (b Fixed64_scalar_int64_map) Key(k int64) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed64_scalar_uint32_map struct {
	location []Locator
}

func (b Fixed64_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar_uint32_map(l []Locator) Fixed64_scalar_uint32_map {
	return Fixed64_scalar_uint32_map{location: l}
}
func (b Fixed64_scalar_uint32_map) Key(k uint32) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed64_scalar_uint64_map struct {
	location []Locator
}

func (b Fixed64_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar_uint64_map(l []Locator) Fixed64_scalar_uint64_map {
	return Fixed64_scalar_uint64_map{location: l}
}
func (b Fixed64_scalar_uint64_map) Key(k uint64) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Fixed64_scalar_string_map struct {
	location []Locator
}

func (b Fixed64_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewFixed64_scalar_string_map(l []Locator) Fixed64_scalar_string_map {
	return Fixed64_scalar_string_map{location: l}
}
func (b Fixed64_scalar_string_map) Key(k string) Fixed64_scalar {
	return NewFixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed32_scalar struct {
	location []Locator
}

func (b Sfixed32_scalar) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar(l []Locator) Sfixed32_scalar {
	return Sfixed32_scalar{location: l}
}

type Sfixed32_scalar_repeated struct {
	location []Locator
}

func (b Sfixed32_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar_repeated(l []Locator) Sfixed32_scalar_repeated {
	return Sfixed32_scalar_repeated{location: l}
}
func (b Sfixed32_scalar_repeated) Index(i int) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Sfixed32_scalar_bool_map struct {
	location []Locator
}

func (b Sfixed32_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar_bool_map(l []Locator) Sfixed32_scalar_bool_map {
	return Sfixed32_scalar_bool_map{location: l}
}
func (b Sfixed32_scalar_bool_map) Key(k bool) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed32_scalar_int32_map struct {
	location []Locator
}

func (b Sfixed32_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar_int32_map(l []Locator) Sfixed32_scalar_int32_map {
	return Sfixed32_scalar_int32_map{location: l}
}
func (b Sfixed32_scalar_int32_map) Key(k int32) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed32_scalar_int64_map struct {
	location []Locator
}

func (b Sfixed32_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar_int64_map(l []Locator) Sfixed32_scalar_int64_map {
	return Sfixed32_scalar_int64_map{location: l}
}
func (b Sfixed32_scalar_int64_map) Key(k int64) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed32_scalar_uint32_map struct {
	location []Locator
}

func (b Sfixed32_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar_uint32_map(l []Locator) Sfixed32_scalar_uint32_map {
	return Sfixed32_scalar_uint32_map{location: l}
}
func (b Sfixed32_scalar_uint32_map) Key(k uint32) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed32_scalar_uint64_map struct {
	location []Locator
}

func (b Sfixed32_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar_uint64_map(l []Locator) Sfixed32_scalar_uint64_map {
	return Sfixed32_scalar_uint64_map{location: l}
}
func (b Sfixed32_scalar_uint64_map) Key(k uint64) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed32_scalar_string_map struct {
	location []Locator
}

func (b Sfixed32_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewSfixed32_scalar_string_map(l []Locator) Sfixed32_scalar_string_map {
	return Sfixed32_scalar_string_map{location: l}
}
func (b Sfixed32_scalar_string_map) Key(k string) Sfixed32_scalar {
	return NewSfixed32_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed64_scalar struct {
	location []Locator
}

func (b Sfixed64_scalar) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar(l []Locator) Sfixed64_scalar {
	return Sfixed64_scalar{location: l}
}

type Sfixed64_scalar_repeated struct {
	location []Locator
}

func (b Sfixed64_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar_repeated(l []Locator) Sfixed64_scalar_repeated {
	return Sfixed64_scalar_repeated{location: l}
}
func (b Sfixed64_scalar_repeated) Index(i int) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Sfixed64_scalar_bool_map struct {
	location []Locator
}

func (b Sfixed64_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar_bool_map(l []Locator) Sfixed64_scalar_bool_map {
	return Sfixed64_scalar_bool_map{location: l}
}
func (b Sfixed64_scalar_bool_map) Key(k bool) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed64_scalar_int32_map struct {
	location []Locator
}

func (b Sfixed64_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar_int32_map(l []Locator) Sfixed64_scalar_int32_map {
	return Sfixed64_scalar_int32_map{location: l}
}
func (b Sfixed64_scalar_int32_map) Key(k int32) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed64_scalar_int64_map struct {
	location []Locator
}

func (b Sfixed64_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar_int64_map(l []Locator) Sfixed64_scalar_int64_map {
	return Sfixed64_scalar_int64_map{location: l}
}
func (b Sfixed64_scalar_int64_map) Key(k int64) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed64_scalar_uint32_map struct {
	location []Locator
}

func (b Sfixed64_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar_uint32_map(l []Locator) Sfixed64_scalar_uint32_map {
	return Sfixed64_scalar_uint32_map{location: l}
}
func (b Sfixed64_scalar_uint32_map) Key(k uint32) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed64_scalar_uint64_map struct {
	location []Locator
}

func (b Sfixed64_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar_uint64_map(l []Locator) Sfixed64_scalar_uint64_map {
	return Sfixed64_scalar_uint64_map{location: l}
}
func (b Sfixed64_scalar_uint64_map) Key(k uint64) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Sfixed64_scalar_string_map struct {
	location []Locator
}

func (b Sfixed64_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewSfixed64_scalar_string_map(l []Locator) Sfixed64_scalar_string_map {
	return Sfixed64_scalar_string_map{location: l}
}
func (b Sfixed64_scalar_string_map) Key(k string) Sfixed64_scalar {
	return NewSfixed64_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bool_scalar struct {
	location []Locator
}

func (b Bool_scalar) Location_get() []Locator {
	return b.location
}
func NewBool_scalar(l []Locator) Bool_scalar {
	return Bool_scalar{location: l}
}

type Bool_scalar_repeated struct {
	location []Locator
}

func (b Bool_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewBool_scalar_repeated(l []Locator) Bool_scalar_repeated {
	return Bool_scalar_repeated{location: l}
}
func (b Bool_scalar_repeated) Index(i int) Bool_scalar {
	return NewBool_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Bool_scalar_bool_map struct {
	location []Locator
}

func (b Bool_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewBool_scalar_bool_map(l []Locator) Bool_scalar_bool_map {
	return Bool_scalar_bool_map{location: l}
}
func (b Bool_scalar_bool_map) Key(k bool) Bool_scalar {
	return NewBool_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bool_scalar_int32_map struct {
	location []Locator
}

func (b Bool_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewBool_scalar_int32_map(l []Locator) Bool_scalar_int32_map {
	return Bool_scalar_int32_map{location: l}
}
func (b Bool_scalar_int32_map) Key(k int32) Bool_scalar {
	return NewBool_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bool_scalar_int64_map struct {
	location []Locator
}

func (b Bool_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewBool_scalar_int64_map(l []Locator) Bool_scalar_int64_map {
	return Bool_scalar_int64_map{location: l}
}
func (b Bool_scalar_int64_map) Key(k int64) Bool_scalar {
	return NewBool_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bool_scalar_uint32_map struct {
	location []Locator
}

func (b Bool_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewBool_scalar_uint32_map(l []Locator) Bool_scalar_uint32_map {
	return Bool_scalar_uint32_map{location: l}
}
func (b Bool_scalar_uint32_map) Key(k uint32) Bool_scalar {
	return NewBool_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bool_scalar_uint64_map struct {
	location []Locator
}

func (b Bool_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewBool_scalar_uint64_map(l []Locator) Bool_scalar_uint64_map {
	return Bool_scalar_uint64_map{location: l}
}
func (b Bool_scalar_uint64_map) Key(k uint64) Bool_scalar {
	return NewBool_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bool_scalar_string_map struct {
	location []Locator
}

func (b Bool_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewBool_scalar_string_map(l []Locator) Bool_scalar_string_map {
	return Bool_scalar_string_map{location: l}
}
func (b Bool_scalar_string_map) Key(k string) Bool_scalar {
	return NewBool_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type String_scalar struct {
	location []Locator
}

func (b String_scalar) Location_get() []Locator {
	return b.location
}
func NewString_scalar(l []Locator) String_scalar {
	return String_scalar{location: l}
}

type String_scalar_repeated struct {
	location []Locator
}

func (b String_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewString_scalar_repeated(l []Locator) String_scalar_repeated {
	return String_scalar_repeated{location: l}
}
func (b String_scalar_repeated) Index(i int) String_scalar {
	return NewString_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type String_scalar_bool_map struct {
	location []Locator
}

func (b String_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewString_scalar_bool_map(l []Locator) String_scalar_bool_map {
	return String_scalar_bool_map{location: l}
}
func (b String_scalar_bool_map) Key(k bool) String_scalar {
	return NewString_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type String_scalar_int32_map struct {
	location []Locator
}

func (b String_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewString_scalar_int32_map(l []Locator) String_scalar_int32_map {
	return String_scalar_int32_map{location: l}
}
func (b String_scalar_int32_map) Key(k int32) String_scalar {
	return NewString_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type String_scalar_int64_map struct {
	location []Locator
}

func (b String_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewString_scalar_int64_map(l []Locator) String_scalar_int64_map {
	return String_scalar_int64_map{location: l}
}
func (b String_scalar_int64_map) Key(k int64) String_scalar {
	return NewString_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type String_scalar_uint32_map struct {
	location []Locator
}

func (b String_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewString_scalar_uint32_map(l []Locator) String_scalar_uint32_map {
	return String_scalar_uint32_map{location: l}
}
func (b String_scalar_uint32_map) Key(k uint32) String_scalar {
	return NewString_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type String_scalar_uint64_map struct {
	location []Locator
}

func (b String_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewString_scalar_uint64_map(l []Locator) String_scalar_uint64_map {
	return String_scalar_uint64_map{location: l}
}
func (b String_scalar_uint64_map) Key(k uint64) String_scalar {
	return NewString_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type String_scalar_string_map struct {
	location []Locator
}

func (b String_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewString_scalar_string_map(l []Locator) String_scalar_string_map {
	return String_scalar_string_map{location: l}
}
func (b String_scalar_string_map) Key(k string) String_scalar {
	return NewString_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bytes_scalar struct {
	location []Locator
}

func (b Bytes_scalar) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar(l []Locator) Bytes_scalar {
	return Bytes_scalar{location: l}
}

type Bytes_scalar_repeated struct {
	location []Locator
}

func (b Bytes_scalar_repeated) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar_repeated(l []Locator) Bytes_scalar_repeated {
	return Bytes_scalar_repeated{location: l}
}
func (b Bytes_scalar_repeated) Index(i int) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppend(b.location, IndexIndexer(i)))
}

type Bytes_scalar_bool_map struct {
	location []Locator
}

func (b Bytes_scalar_bool_map) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar_bool_map(l []Locator) Bytes_scalar_bool_map {
	return Bytes_scalar_bool_map{location: l}
}
func (b Bytes_scalar_bool_map) Key(k bool) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bytes_scalar_int32_map struct {
	location []Locator
}

func (b Bytes_scalar_int32_map) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar_int32_map(l []Locator) Bytes_scalar_int32_map {
	return Bytes_scalar_int32_map{location: l}
}
func (b Bytes_scalar_int32_map) Key(k int32) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bytes_scalar_int64_map struct {
	location []Locator
}

func (b Bytes_scalar_int64_map) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar_int64_map(l []Locator) Bytes_scalar_int64_map {
	return Bytes_scalar_int64_map{location: l}
}
func (b Bytes_scalar_int64_map) Key(k int64) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bytes_scalar_uint32_map struct {
	location []Locator
}

func (b Bytes_scalar_uint32_map) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar_uint32_map(l []Locator) Bytes_scalar_uint32_map {
	return Bytes_scalar_uint32_map{location: l}
}
func (b Bytes_scalar_uint32_map) Key(k uint32) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bytes_scalar_uint64_map struct {
	location []Locator
}

func (b Bytes_scalar_uint64_map) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar_uint64_map(l []Locator) Bytes_scalar_uint64_map {
	return Bytes_scalar_uint64_map{location: l}
}
func (b Bytes_scalar_uint64_map) Key(k uint64) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}

type Bytes_scalar_string_map struct {
	location []Locator
}

func (b Bytes_scalar_string_map) Location_get() []Locator {
	return b.location
}
func NewBytes_scalar_string_map(l []Locator) Bytes_scalar_string_map {
	return Bytes_scalar_string_map{location: l}
}
func (b Bytes_scalar_string_map) Key(k string) Bytes_scalar {
	return NewBytes_scalar(CopyAndAppend(b.location, KeyIndexer(k)))
}
