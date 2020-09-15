package pmsg

import (
	"github.com/dave/protod/delta"
	"github.com/dave/protod/perr"
	any "github.com/golang/protobuf/ptypes/any"
	"google.golang.org/protobuf/proto"
)

func New() *Bundle {
	return &Bundle{Messages: map[string]*any.Any{}}
}

func (b *Bundle) Set(m proto.Message) error {
	a, err := delta.MarshalAny(m)
	if err != nil {
		return perr.Wrap(err).Debug("marshaling message")
	}
	b.Messages[string(m.ProtoReflect().Descriptor().FullName())] = a
	return nil
}

func (b *Bundle) Has(m proto.Message) bool {
	_, found := b.Messages[string(m.ProtoReflect().Descriptor().FullName())]
	return found
}

func (b *Bundle) Get(m proto.Message) (bool, error) {
	a, found := b.Messages[string(m.ProtoReflect().Descriptor().FullName())]
	if !found {
		return false, nil
	}
	if err := delta.UnmarshalAnyInto(a, m); err != nil {
		return false, perr.Wrap(err).Debug("unmarshaling message")
	}
	return true, nil
}

func (b *Bundle) MustSet(m proto.Message) {
	err := b.Set(m)
	if err != nil {
		panic(err)
	}
}

func (b *Bundle) MustGet(m proto.Message) {
	_, err := b.Get(m)
	if err != nil {
		panic(err)
	}
}
