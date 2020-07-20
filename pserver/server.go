package pserver

import (
	"context"
	"fmt"
	"log"
	"math/rand"
	"strings"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/dave/protod/delta"
	"google.golang.org/api/iterator"
	"google.golang.org/protobuf/proto"
)

const STATES_COLLECTION = "states"

func New(client *firestore.Client) *Server {
	return &Server{Firestore: client}
}

type Server struct {
	Firestore *firestore.Client
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

func (s *Server) Changes(ctx context.Context, tx *firestore.Transaction, t DocumentType, ref *firestore.DocumentRef, before, after int64, f func(*delta.Op) error) (state int64, err error) {
	query := ref.Collection(STATES_COLLECTION).Where(t.StateFieldSelector("State"), ">", before)
	if after != 0 {
		query = query.Where(t.StateFieldSelector("State"), "<", after)
	}
	query = query.OrderBy(t.StateFieldSelector("State"), firestore.Asc)
	var iter *firestore.DocumentIterator
	if tx == nil {
		iter = query.Documents(ctx)
	} else {
		iter = tx.Documents(query)
	}
	current := before
	for {
		var stateDoc *firestore.DocumentSnapshot
		if tx == nil {
			stateDoc, err = s.IterNext(iter)
		} else {
			stateDoc, err = iter.Next() // <- no retry inside transaction
		}
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

func (s *Server) QueryState(ctx context.Context, tx *firestore.Transaction, t DocumentType, ref *firestore.DocumentRef, request string) (*firestore.DocumentSnapshot, error) {
	// get by request id
	query := ref.Collection(STATES_COLLECTION).Where(t.StateFieldSelector("Request"), "==", request)
	var iter *firestore.DocumentIterator
	var docs []*firestore.DocumentSnapshot
	var err error
	if tx == nil {
		iter = query.Documents(ctx)
		docs, err = s.IterGetAll(iter)
	} else {
		iter = tx.Documents(query)
		docs, err = iter.GetAll() // <- no retry inside transaction
	}
	if err != nil {
		return nil, fmt.Errorf("getting state documents: %w", err)
	}
	switch {
	case len(docs) == 1:
		return docs[0], nil
	case len(docs) == 0:
		return nil, nil
	default:
		return nil, fmt.Errorf("found %d states with same request %q", len(docs), request)
	}
}

func (s *Server) QuerySnapshot(ctx context.Context, tx *firestore.Transaction, t DocumentType, request string) (*firestore.DocumentRef, error) {
	// get by request id
	query := s.Firestore.Collection(t.Collection).Where(t.SnapshotFieldSelector("Request"), "==", request)
	var iter *firestore.DocumentIterator
	var docs []*firestore.DocumentSnapshot
	var err error
	if tx == nil {
		iter = query.Documents(ctx)
		docs, err = s.IterGetAll(iter)
	} else {
		iter = tx.Documents(query)
		docs, err = iter.GetAll() // <- no retry inside transaction
	}
	if err != nil {
		return nil, fmt.Errorf("getting snapshot documents: %w", err)
	}
	switch {
	case len(docs) == 1:
		return docs[0].Ref, nil
	case len(docs) == 0:
		return nil, nil
	default:
		return nil, fmt.Errorf("found %d documents with same request %q", len(docs), request)
	}
}

func (s *Server) UnpackState(doc *firestore.DocumentSnapshot, t DocumentType) (*State, *delta.Op, error) {
	state, _, err := t.State(doc)
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

func (s *Server) UnpackSnapshot(ctx context.Context, tx *firestore.Transaction, t DocumentType, ref *firestore.DocumentRef) (state int64, document proto.Message, snapshot proto.Message, err error) {
	var doc *firestore.DocumentSnapshot
	if tx == nil {
		doc, err = s.RefGet(ctx, ref)
	} else {
		doc, err = ref.Get(ctx) // <- no retry inside transaction
	}
	if err != nil {
		return 0, nil, nil, fmt.Errorf("getting snapshot document: %w", err)
	}
	var serverSnapshot *Snapshot
	serverSnapshot, snapshot, err = t.Snapshot(doc)
	if err != nil {
		return 0, nil, nil, fmt.Errorf("unpacking snapshot: %w", err)
	}
	b, err := s.FromBlob(serverSnapshot.Value)
	if err != nil {
		return 0, nil, nil, fmt.Errorf("getting snapshot value from blob: %w", err)
	}
	document = t.Document.ProtoReflect().New().Interface()
	if len(b) > 0 {
		if err := proto.Unmarshal(b, document); err != nil {
			return 0, nil, nil, fmt.Errorf("unmarshaling value: %w", err)
		}
	}
	return serverSnapshot.State, document, snapshot, nil
}

func (s *Server) Transform(ctx context.Context, tx *firestore.Transaction, t DocumentType, ref *firestore.DocumentRef, op2 *delta.Op, before, after int64) (state int64, op1x, op2x *delta.Op, err error) {
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
	Collection    string
	Snapshot      func(*firestore.DocumentSnapshot) (*Snapshot, proto.Message, error)
	State         func(*firestore.DocumentSnapshot) (*State, proto.Message, error)
	Document      proto.Message
	StateField    string
	SnapshotField string
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

const clientRepeats = 5

func (s *Server) ClientOperation(desc string, f func() (cancel bool, err error)) (err error) {
	for i := 0; i < clientRepeats; i++ {
		if i > 0 {
			delay := 25 + rand.Intn(50*(1<<i))
			log.Printf("%s repeating (%d/5) after %dms (error: %v)\n", desc, i, delay, err)
			time.Sleep(time.Duration(delay) * time.Millisecond)
		}
		var cancel bool
		cancel, err = f()
		if err == nil || cancel {
			if i > 0 {
				log.Printf("%s complete after %d retries", desc, i)
			}
			return err
		}
	}
	log.Printf("%s failed after %d retries, so returning error: %+v\n", desc, clientRepeats, err)
	return err
}

func (s *Server) IterNext(iter *firestore.DocumentIterator) (doc *firestore.DocumentSnapshot, err error) {
	err = s.ClientOperation("IterNext", func() (cancel bool, err error) {
		doc, err = iter.Next()
		if err == iterator.Done {
			return true, err
		}
		return false, err
	})
	return doc, err
}

func (s *Server) IterGetAll(iter *firestore.DocumentIterator) (docs []*firestore.DocumentSnapshot, err error) {
	err = s.ClientOperation("IterGetAll", func() (cancel bool, err error) {
		docs, err = iter.GetAll()
		return false, err
	})
	return docs, err
}

func (s *Server) RefGet(ctx context.Context, ref *firestore.DocumentRef) (doc *firestore.DocumentSnapshot, err error) {
	err = s.ClientOperation("RefGet", func() (cancel bool, err error) {
		doc, err = ref.Get(ctx)
		return false, err
	})
	return doc, err
}

func (s *Server) RefSet(ctx context.Context, ref *firestore.DocumentRef, data interface{}) (err error) {
	return s.ClientOperation("RefSet", func() (cancel bool, err error) {
		_, err = ref.Set(ctx, data)
		return false, err
	})
}

func (s *Server) RunTransaction(ctx context.Context, f func(context.Context, *firestore.Transaction) error) error {
	// Should we retry running a transaction? Maybe not. Transactions do automatically retry, but only
	// in a transaction conflict situation. If there is a network failure, it may error immediately, so
	// I believe we should retry? This needs more thought.
	return s.ClientOperation("RunTransaction", func() (cancel bool, err error) {
		return false, s.Firestore.RunTransaction(ctx, f)
	})
}

func Path(m proto.Message) string {
	name := fmt.Sprintf("%T", m)
	index := strings.LastIndex(name, ".")
	return "/" + name[index+1:]
}
