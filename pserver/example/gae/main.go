package main

import (
	"context"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"

	"cloud.google.com/go/firestore"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
	"github.com/dave/protod/pserver/example"
	"google.golang.org/appengine"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/proto"
)

const PREFIX = "https://pserver-testing.nw.r.appspot.com"

func main() {

	fc, err := firestore.NewClient(context.Background(), example.PROJECT_ID)
	if err != nil {
		log.Fatal(err)
	}
	app := &App{Server: pserver.New(fc)}
	defer app.Server.Close()

	http.HandleFunc("/", app.indexHandler)

	//port := os.Getenv("PORT")
	//if port == "" {
	//	port = "8080"
	//	log.Printf("Defaulting to port %s", port)
	//}
	//
	//log.Printf("Listening on port %s", port)
	//if err := http.ListenAndServe(":"+port, nil); err != nil && err != http.ErrServerClosed {
	//	log.Fatal(err)
	//}

	appengine.Main()
}

type App struct {
	Server *pserver.Server
}

func (a *App) indexHandler(w http.ResponseWriter, r *http.Request) {

	ctx := appengine.NewContext(r)

	requestBytes, err := ioutil.ReadAll(r.Body)
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	response, err := a.ProcessRequest(ctx, r.URL.Path, requestBytes)
	if err == example.ServerBusy {
		http.Error(w, "503 server busy", http.StatusServiceUnavailable)
		return
	}
	if err == example.PathNotFoundError {
		http.NotFound(w, r)
		return
	}
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	if response != nil {
		responseBytes, err := proto.Marshal(response)
		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}
		if _, err = w.Write(responseBytes); err != nil {
			http.Error(w, err.Error(), 500)
			return
		}
	}
}

func (a *App) ProcessMessage(ctx context.Context, message proto.Message) proto.Message {
	path := pserver.Path(message)
	messageBytes, err := proto.Marshal(message)
	if err != nil {
		panic(err)
	}
	response, err := a.ProcessRequest(ctx, path, messageBytes)
	if err != nil {
		panic(err)
	}
	return response
}

func (a *App) ProcessRequest(ctx context.Context, path string, request []byte) (proto.Message, error) {
	switch path {
	case pserver.Path(&Person_Get_Request{}):
		return a.PersonGetRequest(ctx, request)
	case pserver.Path(&Person_Add_Request{}):
		return a.PersonAddRequest(ctx, request)
	case pserver.Path(&Person_Edit_Request{}):
		return a.PersonEditRequest(ctx, request)
	case pserver.Path(&Person_Refresh_Request{}):
		return nil, a.PersonRefreshRequest(ctx, request)
	default:
		return nil, example.PathNotFoundError
	}
}

func (a *App) PersonGetRequest(ctx context.Context, requestBytes []byte) (*Person_Get_Response, error) {
	wrap := func(err error) (*Person_Get_Response, error) {
		return &Person_Get_Response{Err: err.Error()}, err
	}
	request := &Person_Get_Request{}
	if err := proto.Unmarshal(requestBytes, request); err != nil {
		return wrap(fmt.Errorf("unmarshaling get request: %w", err))
	}
	state, document, err := example.Get(ctx, a.Server, example.PERSON, request.Id)
	if err != nil {
		return wrap(fmt.Errorf("getting: %w", err))
	}
	return &Person_Get_Response{
		Id:     request.Id,
		State:  state,
		Person: document.(*tests.Person),
		Err:    "",
	}, nil
}

func (a *App) PersonAddRequest(ctx context.Context, requestBytes []byte) (*Person_Add_Response, error) {
	wrap := func(err error) (*Person_Add_Response, error) {
		return &Person_Add_Response{Err: err.Error()}, err
	}
	request := &Person_Add_Request{}
	if err := proto.Unmarshal(requestBytes, request); err != nil {
		return wrap(fmt.Errorf("unmarshaling add request: %w", err))
	}
	id, err := example.Add(ctx, a.Server, example.PERSON, request.Request, request.Person)
	if err != nil {
		return wrap(fmt.Errorf("adding: %w", err))
	}
	return &Person_Add_Response{
		Id:  id,
		Err: "",
	}, nil
}

func (a *App) PersonEditRequest(ctx context.Context, requestBytes []byte) (*Person_Edit_Response, error) {
	wrap := func(err error) (*Person_Edit_Response, error) {
		return &Person_Edit_Response{Err: err.Error()}, err
	}
	request := &Person_Edit_Request{}
	if err := proto.Unmarshal(requestBytes, request); err != nil {
		return wrap(fmt.Errorf("unmarshaling edit request: %w", err))
	}
	state, op, err := example.Edit(ctx, a.Server, example.PERSON, request.Request, request.Id, request.State, request.Op)
	if err != nil {
		if status.Code(err) == codes.Aborted || err == example.ServerBusy {
			return wrap(example.ServerBusy)
		}
		return wrap(fmt.Errorf("editing: %w", err))
	}
	if state%example.UPDATE_SNAPSHOT_FREQUENCY == 0 {
		if _, err := example.TriggerRefreshTask(ctx, PREFIX, &Person_Refresh_Request{Id: request.Id}); err != nil {
			return wrap(fmt.Errorf("triggering refresh task: %w", err))
		}
	}
	return &Person_Edit_Response{
		State: state,
		Op:    op,
		Err:   "",
	}, nil
}

func (a *App) PersonRefreshRequest(ctx context.Context, requestBytes []byte) error {
	request := &Person_Refresh_Request{}
	if err := proto.Unmarshal(requestBytes, request); err != nil {
		return fmt.Errorf("unmarshaling edit request: %w", err)
	}
	if err := example.Refresh(ctx, a.Server, example.PERSON, request.Id); err != nil {
		return fmt.Errorf("refreshing: %w", err)
	}
	return nil
}
