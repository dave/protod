package pserver

import (
	"context"
	"errors"
	"fmt"
	"sync"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/dave/protod/delta"
	"github.com/dave/protod/perr"
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

//func (s *Server) FromBlob(b *Blob) ([]byte, error) {
//	// TODO
//	return b.Value, nil
//}
//
//func (s *Server) ToBlob(b []byte) (*Blob, error) {
//	// TODO
//	return &Blob{Value: b}, nil
//}
//
//func (s *Server) MarshalToBlob(m proto.Message) (*Blob, error) {
//	b, err := proto.Marshal(m)
//	if err != nil {
//		return nil, perr.Wrap(err, "marshaling")
//	}
//	return &Blob{Value: b}, nil
//}

func (s *Server) Latest(ctx context.Context, tx *firestore.Transaction, t *DocumentType, ref *firestore.DocumentRef) (state int64, err error) {
	query := ref.Collection(STATES_COLLECTION).OrderBy(t.StateQueryFieldPath(), firestore.Desc).Limit(1)
	var docs []*firestore.DocumentSnapshot
	if tx == nil {
		docs, err = query.Documents(s.FirestoreContext(ctx)).GetAll()
	} else {
		docs, err = tx.Documents(query).GetAll()
	}
	if err != nil {
		return 0, err
	}
	if len(docs) == 0 {
		return 0, nil
	}
	stateMessage := t.NewState()
	if err := docs[0].DataTo(stateMessage); err != nil {
		return 0, err
	}
	latest, _, err := stateMessage.UnpackState(ctx)
	if err != nil {
		return 0, err
	}
	return latest, nil
}

func (s *Server) Changes(ctx context.Context, tx *firestore.Transaction, t *DocumentType, ref *firestore.DocumentRef, before, after int64, f func(*delta.Op) error) (state int64, err error) {
	query := ref.Collection(STATES_COLLECTION).Where(t.StateQueryFieldPath(), ">", before)
	if after != 0 {
		query = query.Where(t.StateQueryFieldPath(), "<", after)
	}
	query = query.OrderBy(t.StateQueryFieldPath(), firestore.Asc)
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
			return 0, perr.Wrap(err, "iterating state data")
		}
		state, op, err := s.UnpackState(ctx, stateDoc, t)
		if err != nil {
			return 0, perr.Wrap(err, "unpacking state data")
		}
		if state != current+1 {
			return 0, fmt.Errorf("can't apply op (state %d) to state %d", state, current)
		}
		if err := f(op); err != nil {
			return 0, err
		}
		current = state
	}
	return current, nil
}

func (s *Server) QueryState(ctx context.Context, tx *firestore.Transaction, stateRef *firestore.DocumentRef) (*firestore.DocumentSnapshot, error) {
	// get by request id
	var doc *firestore.DocumentSnapshot
	var err error
	if tx == nil {
		doc, err = stateRef.Get(s.FirestoreContext(ctx))
	} else {
		doc, err = tx.Get(stateRef)
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

func (s *Server) UnpackState(ctx context.Context, doc *firestore.DocumentSnapshot, t *DocumentType) (state int64, op *delta.Op, err error) {
	stateMessage := t.NewState()
	if err := doc.DataTo(stateMessage); err != nil {
		return 0, nil, perr.Wrap(err, "unpacking state document")
	}
	state, opBlob, err := stateMessage.UnpackState(ctx)
	if err != nil {
		return 0, nil, perr.Wrap(err, "unpacking state message")
	}
	opBytes, err := opBlob.UnpackBlob(ctx)
	if err != nil {
		return 0, nil, perr.Wrap(err, "getting op blob")
	}
	if len(opBytes) == 0 {
		return state, nil, nil
	}
	op = &delta.Op{}
	if err := proto.Unmarshal(opBytes, op); err != nil {
		return 0, nil, perr.Wrap(err, "unmarshaling op")
	}
	return state, op, nil
}

func (s *Server) UnpackSnapshot(ctx context.Context, tx *firestore.Transaction, t *DocumentType, ref *firestore.DocumentRef) (state int64, document proto.Message, snapshot SnapshotInterface, err error) {
	var doc *firestore.DocumentSnapshot
	if tx == nil {
		doc, err = ref.Get(s.FirestoreContext(ctx))
	} else {
		doc, err = tx.Get(ref)
	}
	switch {
	case status.Code(err) == codes.NotFound:
		return 0, nil, nil, err
	case err != nil:
		return 0, nil, nil, perr.Wrap(err, "getting snapshot document")
	}
	snapshot = t.NewSnapshot()
	if err := doc.DataTo(snapshot); err != nil {
		return 0, nil, nil, perr.Wrap(err, "unpacking snapshot")
	}
	state, valueBlob, err := snapshot.UnpackSnapshot(ctx)
	if err != nil {
		return 0, nil, nil, perr.Wrap(err, "unpacking snapshot")
	}
	b, err := valueBlob.UnpackBlob(ctx)
	if err != nil {
		return 0, nil, nil, perr.Wrap(err, "getting snapshot value from blob")
	}
	document = t.NewDocument()
	if len(b) > 0 {
		if err := proto.Unmarshal(b, document); err != nil {
			return 0, nil, nil, perr.Wrap(err, "unmarshaling value")
		}
	}
	return state, document, snapshot, nil
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
		return 0, nil, nil, perr.Wrap(err, "transforming")
	}
	return state, op1x, op2x, nil
}

// DocumentType defines a type of document stored in pserver. All fields are optional except Document.
type DocumentType struct {
	Document proto.Message
	Snapshot SnapshotInterface
	State    StateInterface
	Blob     BlobInterface

	//PackSnapshot    func(ctx context.Context, data *Snapshot, old proto.Message, document proto.Message) (proto.Message, error)
	//PackState       func(ctx context.Context, data *State) (proto.Message, error)
	//StateQueryField string // If a custom state is returned by PackState, the query path of the "State" field must be specified here - e.g. "Value.State".
	//UnpackSnapshot  func(proto.Message) (*Snapshot, error)
	//UnpackState     func(proto.Message) (*State, error)

	Collection string // if empty, this defaults to the full type name of the document
	OnAdd      func(ctx context.Context, server *Server, tx *firestore.Transaction, id string) error
	OnEdit     func(ctx context.Context, server *Server, tx *firestore.Transaction, id string) error
	OnGet      func(ctx context.Context, server *Server, id string) error
}

func (d DocumentType) Type() string {
	return string(d.Document.ProtoReflect().Descriptor().FullName())
}

//func (d DocumentType) PackSnapshotFunc(ctx context.Context, data *Snapshot, old proto.Message, document proto.Message) (proto.Message, error) {
//	if d.PackSnapshot == nil {
//		return data, nil
//	}
//	return d.PackSnapshot(ctx, data, old, document)
//}
//
//func (d DocumentType) PackStateFunc(ctx context.Context, data *State) (proto.Message, error) {
//	if d.PackState == nil {
//		return data, nil
//	}
//	return d.PackState(ctx, data)
//}
//
//func (d DocumentType) UnpackSnapshotFunc(snap proto.Message) (*Snapshot, error) {
//	if d.UnpackSnapshot == nil {
//		return snap.(*Snapshot), nil
//	}
//	return d.UnpackSnapshot(snap)
//}
//
//func (d DocumentType) UnpackStateFunc(state proto.Message) (*State, error) {
//	if d.UnpackState == nil {
//		return state.(*State), nil
//	}
//	return d.UnpackState(state)
//}

func (d DocumentType) CollectionName() string {
	if d.Collection == "" {
		return string(d.Document.ProtoReflect().Descriptor().FullName())
	}
	return d.Collection
}

func (d DocumentType) NewDocument() proto.Message {
	return d.Document.ProtoReflect().New().Interface()
}

func (d DocumentType) NewSnapshot() SnapshotInterface {
	if d.Snapshot == nil {
		return &Snapshot{}
	}
	return d.Snapshot.ProtoReflect().New().Interface().(SnapshotInterface)
}

func (d DocumentType) NewState() StateInterface {
	if d.State == nil {
		return &State{}
	}
	return d.State.ProtoReflect().New().Interface().(StateInterface)
}

func (d DocumentType) NewBlob() BlobInterface {
	if d.Blob == nil {
		return &Blob{}
	}
	return d.State.ProtoReflect().New().Interface().(BlobInterface)
}

func (d DocumentType) StateQueryFieldPath() string {
	if sfi, ok := d.State.(StateFieldInterface); ok {
		return sfi.StateField()
	}
	return "State"
}

// for locking with test server
var lock = &sync.Map{}

//const GLOBAL_LOCK_KEY = "key"

func Lock(ctx context.Context, key string, f func() error) (returnedError error) {
	requestLock := func() error {

		if !appengine.IsAppEngine() {
			//if _, loaded := lock.LoadOrStore(GLOBAL_LOCK_KEY, 1); loaded {
			if _, loaded := lock.LoadOrStore(key, 1); loaded {
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
			lock.Delete(key)
			//lock.Delete(GLOBAL_LOCK_KEY)
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

func IsBusyError(err error) bool {
	return err == ServerBusy ||
		err == context.DeadlineExceeded ||
		status.Code(err) == codes.Aborted ||
		status.Code(err) == codes.DeadlineExceeded
}

type SnapshotInterface interface {
	proto.Message
	PackSnapshot(ctx context.Context, state int64, value BlobInterface, previous, document proto.Message) error
	UnpackSnapshot(ctx context.Context) (state int64, value BlobInterface, err error)
}

func (s *Snapshot) PackSnapshot(ctx context.Context, state int64, value BlobInterface, previous, document proto.Message) error {
	s.State = state
	s.Value = value.(*Blob)
	return nil
}

func (s *Snapshot) UnpackSnapshot(ctx context.Context) (state int64, value BlobInterface, err error) {
	return s.State, s.Value, nil
}

type StateInterface interface {
	proto.Message
	PackState(ctx context.Context, state int64, op BlobInterface) error
	UnpackState(ctx context.Context) (state int64, op BlobInterface, err error)
}

type StateFieldInterface interface {
	StateField() string
}

func (s *State) PackState(ctx context.Context, state int64, op BlobInterface) error {
	s.State = state
	s.Op = op.(*Blob)
	return nil
}

func (s *State) UnpackState(ctx context.Context) (state int64, op BlobInterface, err error) {
	return s.State, s.Op, nil
}

func (s *State) StateField() string {
	return "State"
}

type BlobInterface interface {
	proto.Message
	PackBlob(ctx context.Context, value []byte) error
	UnpackBlob(ctx context.Context) ([]byte, error)
	MarshalBlob(ctx context.Context, value proto.Message) error
	UnmarshalBlob(ctx context.Context, value proto.Message) error
}

func (b *Blob) PackBlob(ctx context.Context, value []byte) error {
	b.Value = value
	return nil
}

func (b *Blob) UnpackBlob(ctx context.Context) (value []byte, err error) {
	return b.Value, nil
}

func (b *Blob) MarshalBlob(ctx context.Context, value proto.Message) error {
	valueBytes, err := proto.Marshal(value)
	if err != nil {
		return perr.Wrap(err, "marshaling")
	}
	if err := b.PackBlob(ctx, valueBytes); err != nil {
		return perr.Wrap(err, "packing")
	}
	return nil
}

func (b *Blob) UnmarshalBlob(ctx context.Context, value proto.Message) error {
	valueBytes, err := b.UnpackBlob(ctx)
	if err != nil {
		return perr.Wrap(err, "unpacking")
	}
	if err := proto.Unmarshal(valueBytes, value); err != nil {
		return perr.Wrap(err, "unmarshalling")
	}
	return nil
}
