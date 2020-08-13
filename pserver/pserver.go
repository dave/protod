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
		return nil, perr.Wrap(err, "marshaling")
	}
	return &Blob{Value: b}, nil
}

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
	stateUnpacked, err := t.UnpackStateFunc(stateMessage)
	if err != nil {
		return 0, err
	}
	return stateUnpacked.State, nil
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
		state, op, err := s.UnpackState(stateDoc, t)
		if err != nil {
			return 0, perr.Wrap(err, "unpacking state data")
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

func (s *Server) UnpackState(doc *firestore.DocumentSnapshot, t *DocumentType) (data *State, op *delta.Op, err error) {
	stateMessage := t.NewState()
	if err := doc.DataTo(stateMessage); err != nil {
		return nil, nil, perr.Wrap(err, "unpacking state document")
	}
	data, err = t.UnpackStateFunc(stateMessage)
	if err != nil {
		return nil, nil, perr.Wrap(err, "unpacking state message")
	}
	opBytes, err := s.FromBlob(data.Op)
	if err != nil {
		return nil, nil, perr.Wrap(err, "getting op blob")
	}
	if len(opBytes) == 0 {
		return data, nil, nil
	}
	op = &delta.Op{}
	if err := proto.Unmarshal(opBytes, op); err != nil {
		return nil, nil, perr.Wrap(err, "unmarshaling op")
	}
	return data, op, nil
}

func (s *Server) UnpackSnapshot(ctx context.Context, tx *firestore.Transaction, t *DocumentType, ref *firestore.DocumentRef) (document proto.Message, data *Snapshot, snapshot proto.Message, err error) {
	var doc *firestore.DocumentSnapshot
	if tx == nil {
		doc, err = ref.Get(s.FirestoreContext(ctx))
	} else {
		doc, err = tx.Get(ref)
	}
	switch {
	case status.Code(err) == codes.NotFound:
		return nil, nil, nil, err
	case err != nil:
		return nil, nil, nil, perr.Wrap(err, "getting snapshot document")
	}
	snapshot = t.NewSnapshot()
	if err := doc.DataTo(snapshot); err != nil {
		return nil, nil, nil, perr.Wrap(err, "unpacking snapshot")
	}
	data, err = t.UnpackSnapshotFunc(snapshot)
	if err != nil {
		return nil, nil, nil, perr.Wrap(err, "unpacking snapshot")
	}
	b, err := s.FromBlob(data.Value)
	if err != nil {
		return nil, nil, nil, perr.Wrap(err, "getting snapshot value from blob")
	}
	document = t.NewDocument()
	if len(b) > 0 {
		if err := proto.Unmarshal(b, document); err != nil {
			return nil, nil, nil, perr.Wrap(err, "unmarshaling value")
		}
	}
	return document, data, snapshot, nil
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
	Document        proto.Message
	Snapshot        proto.Message
	State           proto.Message
	PackSnapshot    func(ctx context.Context, data *Snapshot, old proto.Message, document proto.Message) (proto.Message, error)
	PackState       func(ctx context.Context, data *State) (proto.Message, error)
	StateQueryField string // If a custom state is returned by PackState, the query path of the "State" field must be specified here - e.g. "Value.State".
	UnpackSnapshot  func(proto.Message) (*Snapshot, error)
	UnpackState     func(proto.Message) (*State, error)
	Collection      string // default if empty: the full type name of the document is used.
	OnAdd           func(ctx context.Context, server *Server, tx *firestore.Transaction, id string) error
	OnEdit          func(ctx context.Context, server *Server, tx *firestore.Transaction, id string) error
	OnGet           func(ctx context.Context, server *Server, id string) error
}

func (d DocumentType) Type() string {
	return string(d.Document.ProtoReflect().Descriptor().FullName())
}

func (d DocumentType) PackSnapshotFunc(ctx context.Context, data *Snapshot, old proto.Message, document proto.Message) (proto.Message, error) {
	if d.PackSnapshot == nil {
		return data, nil
	}
	return d.PackSnapshot(ctx, data, old, document)
}

func (d DocumentType) PackStateFunc(ctx context.Context, data *State) (proto.Message, error) {
	if d.PackState == nil {
		return data, nil
	}
	return d.PackState(ctx, data)
}

func (d DocumentType) UnpackSnapshotFunc(snap proto.Message) (*Snapshot, error) {
	if d.UnpackSnapshot == nil {
		return snap.(*Snapshot), nil
	}
	return d.UnpackSnapshot(snap)
}

func (d DocumentType) UnpackStateFunc(state proto.Message) (*State, error) {
	if d.UnpackState == nil {
		return state.(*State), nil
	}
	return d.UnpackState(state)
}

func (d DocumentType) CollectionName() string {
	if d.Collection == "" {
		return string(d.Document.ProtoReflect().Descriptor().FullName())
	}
	return d.Collection
}

func (d DocumentType) NewDocument() proto.Message {
	return d.Document.ProtoReflect().New().Interface()
}

func (d DocumentType) NewSnapshot() proto.Message {
	if d.Snapshot == nil {
		return &Snapshot{}
	}
	return d.Snapshot.ProtoReflect().New().Interface()
}

func (d DocumentType) NewState() proto.Message {
	if d.State == nil {
		return &State{}
	}
	return d.State.ProtoReflect().New().Interface()
}

func (d DocumentType) StateQueryFieldPath() string {
	if d.StateQueryField == "" {
		return "State"
	}
	return d.StateQueryField
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
