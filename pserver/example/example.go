package example

import (
	"context"
	"fmt"
	"sync"
	"testing"

	"cloud.google.com/go/firestore"
	"github.com/dave/protod/delta"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

const UPDATE_SNAPSHOT_FREQUENCY = 5 // would be higher for real server
const PROJECT_ID = "pserver-testing"

var locks = map[string]*sync.Mutex{}

func New(ctx context.Context, t *testing.T) *pserver.Server {
	fc, err := firestore.NewClient(ctx, PROJECT_ID)
	if err != nil {
		t.Fatal(err)
	}
	return pserver.New(fc)
}

func Get(ctx context.Context, server *pserver.Server, t pserver.DocumentType, id string) (int64, proto.Message, error) {

	ref := server.Firestore.Collection(t.Collection).Doc(id)

	state, document, _, err := server.UnpackSnapshot(ctx, nil, t, ref)
	if err != nil {
		return 0, nil, err
	}

	state, err = server.Changes(ctx, nil, t, ref, state, 0, func(op *delta.Op) error {
		if err := delta.Apply(op, document); err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return 0, nil, err
	}

	return state, document, nil
}

func Add(ctx context.Context, server *pserver.Server, t pserver.DocumentType, request string, document proto.Message) (string, error) {

	// do as much marshaling and unmarshaling as we can before opening the transaction
	opBlob, err := server.MarshalToBlob(delta.Set(nil, document))
	if err != nil {
		return "", err
	}
	docBlob, err := server.MarshalToBlob(document)
	if err != nil {
		return "", err
	}

	var id string

	if err := server.Firestore.RunTransaction(ctx, func(ctx context.Context, tx *firestore.Transaction) error {

		// check for documents with the same unique request id
		duplicate, err := server.QuerySnapshot(ctx, tx, t, request)
		if err != nil {
			return err
		}
		if duplicate != nil {
			id = duplicate.ID
			return nil
		}

		ref := server.Firestore.Collection(t.Collection).NewDoc()

		snapshot := &pserver.Snapshot{Request: request, State: 1, Value: docBlob}
		if err := tx.Set(ref, snapshot); err != nil {
			return err
		}

		stateRef := ref.Collection(pserver.STATES_COLLECTION).NewDoc()
		state := &pserver.State{Request: request, State: 1, Op: opBlob}
		if err := tx.Set(stateRef, state); err != nil {
			return err
		}

		id = ref.ID
		return nil

	}); err != nil {
		return "", err
	}

	locks[id] = &sync.Mutex{}

	return id, nil
}

func Edit(ctx context.Context, server *pserver.Server, t pserver.DocumentType, request, id string, state int64, op *delta.Op) (int64, *delta.Op, error) {

	locks[id].Lock()
	defer func() { locks[id].Unlock() }()

	// 3) Let's refer to op as OP2
	op2 := op

	ref := server.Firestore.Collection(t.Collection).Doc(id)

	if op == nil {
		// just request an update (no need to store state)
		var ops []*delta.Op
		state, err := server.Changes(ctx, nil, t, ref, state, 0, func(op *delta.Op) error {
			ops = append(ops, op)
			return nil
		})
		if err != nil {
			return 0, nil, err
		}
		return state, delta.Compound(ops...), nil
	}

	var after int64
	var op1x, op2x *delta.Op
	var duplicate *firestore.DocumentSnapshot

	if err := server.Firestore.RunTransaction(ctx, func(ctx context.Context, tx *firestore.Transaction) error {

		var err error
		duplicate, err = server.QueryState(ctx, tx, t, ref, request)
		if err != nil {
			return err
		}
		if duplicate != nil {
			// exit from transaction and continue processing outside (no writes needed)
			return nil
		}

		after, op1x, op2x, err = server.Transform(ctx, tx, t, ref, op2, state, 0)
		if err != nil {
			return err
		}

		// 6) Store OP2x in the database, and increment the state counter (STATE)
		op2xBlob, err := server.MarshalToBlob(op2x)
		if err != nil {
			return err
		}
		after = after + 1
		newStateRef := ref.Collection(pserver.STATES_COLLECTION).NewDoc()
		newStateItem := &pserver.State{Request: request, State: after, Op: op2xBlob}
		if err := tx.Set(newStateRef, newStateItem); err != nil {
			return err
		}

		return nil

	}); err != nil {
		return 0, nil, err
	}

	if duplicate != nil {
		// This request has already been processed. We can recreate the correct response, and nothing
		// needs to be stored in the database.
		duplicateState, _, err := server.UnpackState(duplicate, t)
		if err != nil {
			return 0, nil, err
		}

		// note that the state provided by the client is the "before" state for the transform, and the
		// state from the duplicate record is the "after" state in the transform:
		_, op1x, _, err = server.Transform(ctx, nil, t, ref, op2, state, duplicateState.State)
		if err != nil {
			return 0, nil, err
		}

		return duplicateState.State, op1x, nil
	}

	// Update the snapshot less frequently, and outside the transaction!
	// TODO: Can we just start this in a goroutine and run asynchronously? Hmm... in App Engine?
	if after%UPDATE_SNAPSHOT_FREQUENCY == 0 {
		if err := UpdateSnapshot(ctx, server, t, ref); err != nil {
			return 0, nil, err
		}
	}

	// 7) Response: {unique: UNIQUE, state: COUNT, op: OP1x}
	return after, op1x, nil
}

func UpdateSnapshot(ctx context.Context, server *pserver.Server, t pserver.DocumentType, ref *firestore.DocumentRef) error {
	// Update the value snapshot. this doesn't need to be inside a transaction, because if the
	// snapshot is slightly out of date it doesn't matter.
	snapshotState, document, _, err := server.UnpackSnapshot(ctx, nil, t, ref)
	if err != nil {
		return fmt.Errorf("unpacking snapshot: %w", err)
	}

	state, err := server.Changes(ctx, nil, t, ref, snapshotState, 0, func(op *delta.Op) error {
		if err := delta.Apply(op, document); err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return err
	}
	if state == snapshotState {
		return nil
	}
	documentBlob, err := server.MarshalToBlob(document)
	if err != nil {
		return err
	}
	newSnapshot := &pserver.Snapshot{State: state, Value: documentBlob}
	if _, err := ref.Set(ctx, newSnapshot); err != nil {
		return err
	}
	return nil
}

var COMPANY = pserver.DocumentType{
	Collection: "company",
	Snapshot:   unpackSnapshot,
	State:      unpackState,
	Document:   &tests.Company{},
}

var PERSON = pserver.DocumentType{
	Collection: "person",
	Snapshot:   unpackSnapshot,
	State:      unpackState,
	Document:   &tests.Person{},
}

func unpackSnapshot(s *firestore.DocumentSnapshot) (*pserver.Snapshot, proto.Message, error) {
	snap := &pserver.Snapshot{}
	if err := s.DataTo(snap); err != nil {
		return nil, nil, err
	}
	return snap, snap, nil
}

func unpackState(s *firestore.DocumentSnapshot) (*pserver.State, proto.Message, error) {
	state := &pserver.State{}
	if err := s.DataTo(state); err != nil {
		return nil, nil, err
	}
	return state, state, nil
}

func mustJson(message proto.Message) string {
	b, err := protojson.Marshal(message)
	if err != nil {
		panic(err)
	}
	return string(b)
}
