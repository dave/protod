package pserver

import (
	"context"
	"fmt"

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

func (s *Server) Close() {
	_ = s.Firestore.Close()
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

func (s *Server) QueryState(ctx context.Context, tx *firestore.Transaction, t DocumentType, ref *firestore.DocumentRef, request string) (*firestore.DocumentSnapshot, error) {
	// get by request id
	query := ref.Collection(STATES_COLLECTION).Where(t.StateFieldSelector("Request"), "==", request)
	var iter *firestore.DocumentIterator
	if tx == nil {
		iter = query.Documents(ctx)
	} else {
		iter = tx.Documents(query)
	}
	docs, err := iter.GetAll()
	if err != nil {
		return nil, fmt.Errorf("getting state document: %w", err)
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
	if tx == nil {
		iter = query.Documents(ctx)
	} else {
		iter = tx.Documents(query)
	}
	docs, err := iter.GetAll()
	if err != nil {
		return nil, fmt.Errorf("getting snapshot document: %w", err)
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
		doc, err = ref.Get(ctx)
		if err != nil {
			return 0, nil, nil, fmt.Errorf("getting snapshot document: %w", err)
		}
	} else {
		doc, err = tx.Get(ref)
		if err != nil {
			return 0, nil, nil, fmt.Errorf("getting snapshot document: %w", err)
		}
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
	var op1 *delta.Op
	if len(ops) == 1 {
		op1 = ops[0]
	} else {
		op1 = delta.Compound(ops...)
	}
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
