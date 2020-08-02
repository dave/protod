package pserver

import (
	"context"
	"errors"
	"fmt"
	"sync/atomic"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/dave/protod/delta"
	"google.golang.org/api/iterator"
	"google.golang.org/appengine"
	"google.golang.org/appengine/memcache"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/proto"
)

const STATES_COLLECTION = "states"

func New(client *firestore.Client, config Config, types ...*DocumentType) *Server {
	server := &Server{
		Firestore: client,
		Config:    config,
	}
	server.RegisterTypes(types...)
	return server
}

type Server struct {
	Firestore *firestore.Client
	Config    Config
	types     map[string]*DocumentType
}

type Config struct {
	Prefix   string        // HTTP prefix - e.g. "https://groupshare.uc.r.appspot.com"
	Project  string        // google cloud project id - e.g "groupshare"
	Location string        // google cloud location id - e.g. "europe-west2"
	Queue    string        // google cloud task queue name - e.g. "tasks"
	Timeout  time.Duration // timeout for firestore requests
}

func (s *Server) FirestoreContext(ctx context.Context) context.Context {
	timeout := time.Second
	if s.Config.Timeout != 0 {
		timeout = s.Config.Timeout
	}
	ctx, _ = context.WithTimeout(ctx, timeout)
	return ctx
}

func (s *Server) RegisterTypes(types ...*DocumentType) {
	if s.types == nil {
		s.types = map[string]*DocumentType{}
	}
	for _, d := range types {
		s.types[string(d.Document.ProtoReflect().Descriptor().FullName())] = d
	}
}

func (s *Server) Type(fullName string) *DocumentType {
	if s.types == nil {
		return nil
	}
	typ, found := s.types[fullName]
	if !found {
		return nil
	}
	return typ
}

func (s *Server) Close() error {
	return s.Firestore.Close()
}

func (s *Server) FromBlob(b *Blob) ([]byte, error) {
	// TODO
	return b.Value, nil
}

func (s *Server) ToBlob(b []byte) (*Blob, error) {
	// TODO
	return &Blob{Value: b}, nil
}

func (s *Server) MarshalToBlob(m proto.Message) (*Blob, error) {
	b, err := proto.Marshal(m)
	if err != nil {
		return nil, fmt.Errorf("marshaling: %w", err)
	}
	return &Blob{Value: b}, nil
}

func (s *Server) Changes(ctx context.Context, tx *firestore.Transaction, t *DocumentType, ref *firestore.DocumentRef, before, after int64, f func(*delta.Op) error) (state int64, err error) {
	query := ref.Collection(STATES_COLLECTION).Where(t.StateFieldSelector("State"), ">", before)
	if after != 0 {
		query = query.Where(t.StateFieldSelector("State"), "<", after)
	}
	query = query.OrderBy(t.StateFieldSelector("State"), firestore.Asc)
	var iter *firestore.DocumentIterator
	if tx == nil {
		iter = query.Documents(s.FirestoreContext(ctx))
	} else {
		iter = tx.Documents(query)
	}
	current := before
	for {
		stateDoc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return 0, fmt.Errorf("iterating state data: %w", err)
		}
		state, op, err := s.UnpackState(stateDoc, t)
		if err != nil {
			return 0, fmt.Errorf("unpacking state data: %w", err)
		}
		if state.State != current+1 {
			return 0, fmt.Errorf("can't apply op (state %d) to state %d", state.State, current)
		}
		if err := f(op); err != nil {
			return 0, err
		}
		current = state.State
	}
	return current, nil
}

func (s *Server) QueryState(ctx context.Context, tx *firestore.Transaction, documentRef *firestore.DocumentRef, id string) (*firestore.DocumentSnapshot, error) {
	// get by request id
	ref := documentRef.Collection(STATES_COLLECTION).Doc(id)
	var doc *firestore.DocumentSnapshot
	var err error
	if tx == nil {
		doc, err = ref.Get(s.FirestoreContext(ctx))
	} else {
		doc, err = tx.Get(ref)
	}
	switch {
	case status.Code(err) == codes.NotFound:
		return nil, nil
	case err == nil:
		return doc, nil
	default:
		return nil, err
	}
}

func (s *Server) DocumentExists(ctx context.Context, tx *firestore.Transaction, ref *firestore.DocumentRef) (bool, error) {
	var err error
	if tx == nil {
		_, err = ref.Get(s.FirestoreContext(ctx))
	} else {
		_, err = tx.Get(ref)
	}
	switch {
	case status.Code(err) == codes.NotFound:
		return false, nil
	case err == nil:
		return true, nil
	default:
		return false, err
	}
}

func (s *Server) UnpackState(doc *firestore.DocumentSnapshot, t *DocumentType) (*State, *delta.Op, error) {
	stateUnpacker := t.UnpackState
	if stateUnpacker == nil {
		stateUnpacker = unpackState
	}
	state, _, err := stateUnpacker(doc)
	if err != nil {
		return nil, nil, fmt.Errorf("unpacking state: %w", err)
	}
	opBytes, err := s.FromBlob(state.Op)
	if err != nil {
		return nil, nil, fmt.Errorf("getting op blob: %w", err)
	}
	if len(opBytes) == 0 {
		return state, nil, nil
	}
	op := &delta.Op{}
	if err := proto.Unmarshal(opBytes, op); err != nil {
		return nil, nil, fmt.Errorf("unmarshaling op: %w", err)
	}
	return state, op, nil
}

func (s *Server) UnpackSnapshot(ctx context.Context, tx *firestore.Transaction, t *DocumentType, ref *firestore.DocumentRef) (document proto.Message, data *Snapshot, snapshot proto.Message, err error) {
	var doc *firestore.DocumentSnapshot
	if tx == nil {
		doc, err = ref.Get(s.FirestoreContext(ctx))
	} else {
		doc, err = tx.Get(ref)
	}
	if err != nil {
		return nil, nil, nil, fmt.Errorf("getting snapshot document: %w", err)
	}
	snapshotUnpacker := t.UnpackSnapshot
	if snapshotUnpacker == nil {
		snapshotUnpacker = unpackSnapshot
	}
	data, snapshot, err = snapshotUnpacker(doc)
	if err != nil {
		return nil, nil, nil, fmt.Errorf("unpacking snapshot: %w", err)
	}
	b, err := s.FromBlob(data.Value)
	if err != nil {
		return nil, nil, nil, fmt.Errorf("getting snapshot value from blob: %w", err)
	}
	document = t.Document.ProtoReflect().New().Interface()
	if len(b) > 0 {
		if err := proto.Unmarshal(b, document); err != nil {
			return nil, nil, nil, fmt.Errorf("unmarshaling value: %w", err)
		}
	}
	return document, data, snapshot, nil
}

func packSnapshot(s *Snapshot) (proto.Message, error) {
	return s, nil
}

func unpackSnapshot(s *firestore.DocumentSnapshot) (*Snapshot, proto.Message, error) {
	snap := &Snapshot{}
	if err := s.DataTo(snap); err != nil {
		return nil, nil, err
	}
	return snap, snap, nil
}

func packState(s *State) (proto.Message, error) {
	return s, nil
}

func unpackState(s *firestore.DocumentSnapshot) (*State, proto.Message, error) {
	state := &State{}
	if err := s.DataTo(state); err != nil {
		return nil, nil, err
	}
	return state, state, nil
}

func (s *Server) Transform(ctx context.Context, tx *firestore.Transaction, t *DocumentType, ref *firestore.DocumentRef, op2 *delta.Op, before, after int64) (state int64, op1x, op2x *delta.Op, err error) {
	if after > 0 && before+1 == after {
		// after is set and there are no states between before and after => no need to run query... the
		// client was applying to the latest version, so no transform needed e.g. op1 == nil
		op1x = nil
		op2x = op2
		return after, op1x, op2x, nil
	}

	var ops []*delta.Op
	state, err = s.Changes(ctx, tx, t, ref, before, after, func(op *delta.Op) error {
		ops = append(ops, op)
		return nil
	})
	if err != nil {
		return 0, nil, nil, err
	}

	if len(ops) == 0 {
		// the client was applying to the latest version, so no transform needed e.g. op1 == nil
		op1x = nil
		op2x = op2
		return state, op1x, op2x, nil
	}

	// 4) OP1.transform(OP2) = OP2x
	// 5) OP2.transform(OP1) = OP1x
	op1 := delta.Compound(ops...)
	op1x, op2x, err = delta.Transform(op1, op2, true)
	if err != nil {
		return 0, nil, nil, fmt.Errorf("transforming: %w", err)
	}
	return state, op1x, op2x, nil
}

type DocumentType struct {
	Document       proto.Message
	PackSnapshot   func(ctx context.Context, data *Snapshot, old proto.Message, document proto.Message) (proto.Message, error)
	PackState      func(ctx context.Context, data *State) (proto.Message, error)
	UnpackSnapshot func(*firestore.DocumentSnapshot) (*Snapshot, proto.Message, error)
	UnpackState    func(*firestore.DocumentSnapshot) (*State, proto.Message, error)
	Collection     string // default if empty: the full type name of the document is used.
	StateField     string // default if empty: no field
	SnapshotField  string // default if empty: no field
	PreAdd         func(ctx context.Context, server *Server, id string) error
	OnAdd          func(ctx context.Context, server *Server, tx *firestore.Transaction, id string) error
	PreEdit        func(ctx context.Context, server *Server, id string) error
	OnEdit         func(ctx context.Context, server *Server, tx *firestore.Transaction, id string) error
}

func (d DocumentType) CollectionName() string {
	if d.Collection == "" {
		return string(d.Document.ProtoReflect().Descriptor().FullName())
	}
	return d.Collection
}

func (d DocumentType) StateFieldSelector(name string) string {
	if d.StateField == "" {
		return name
	}
	return fmt.Sprintf("%s.%s", d.StateField, name)
}

func (d DocumentType) SnapshotFieldSelector(name string) string {
	if d.SnapshotField == "" {
		return name
	}
	return fmt.Sprintf("%s.%s", d.SnapshotField, name)
}

// for locking with test server
var locker uint32 = 0

func Lock(ctx context.Context, key string, f func() error) (returnedError error) {
	requestLock := func() error {

		if !appengine.IsAppEngine() {
			if !atomic.CompareAndSwapUint32(&locker, 0, 1) {
				return ServerBusy
			}
			return nil
		}

		item := &memcache.Item{
			Key:        key,
			Value:      []byte{},
			Expiration: time.Second * 2, // lock is released automatically after 2 seconds in case of server failure etc.
		}
		switch err := memcache.Add(ctx, item); err {
		case nil:
			// item was added
			return nil
		case memcache.ErrNotStored:
			// item already exists
			return ServerBusy
		default:
			// all other errors
			return err
		}
	}
	releaseLock := func() error {

		if !appengine.IsAppEngine() {
			atomic.StoreUint32(&locker, 0)
			return nil
		}

		switch err := memcache.Delete(ctx, key); err {
		case nil:
			// item was deleted
			return nil
		case memcache.ErrCacheMiss:
			// item did not exist
			return nil
		default:
			// all other errors
			return err
		}
	}
	if err := requestLock(); err != nil {
		return err
	}
	defer func() {
		if err := releaseLock(); err != nil {
			returnedError = err
		}
	}()
	return f()
}

var PathNotFound = errors.New("path not found")
var ServerBusy = errors.New("server busy")
