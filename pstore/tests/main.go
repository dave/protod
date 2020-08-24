package main

import (
	"context"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"

	"cloud.google.com/go/firestore"
	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/perr"
	"github.com/dave/protod/pserver"
	"github.com/dave/protod/pstore"
	"google.golang.org/appengine"
	"google.golang.org/protobuf/proto"
)

const UPDATE_SNAPSHOT_FREQUENCY = 50
const PROJECT_ID = "pserver-testing"
const LOCATION_ID = "europe-west2"
const TASKS_QUEUE = "refresh"
const PREFIX = "https://pserver-testing.nw.r.appspot.com"

var PersonTypeName = string((&tests.Person{}).ProtoReflect().Descriptor().FullName())
var CompanyTypeName = string((&tests.Company{}).ProtoReflect().Descriptor().FullName())

func New(ctx context.Context, types ...*pserver.DocumentType) *pserver.Server {
	fc, err := firestore.NewClient(ctx, PROJECT_ID)
	if err != nil {
		panic(err)
	}
	config := pserver.Config{
		Prefix:   PREFIX,
		Project:  PROJECT_ID,
		Location: LOCATION_ID,
		Queue:    TASKS_QUEUE,
	}
	server := pserver.New(fc, config, types...)
	return server
}

func main() {
	app := &App{Server: New(context.Background(), PERSON, COMPANY)}
	defer app.Server.Close()
	http.HandleFunc("/", app.indexHandler)
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
	if pserver.IsBusyError(err) {
		http.Error(w, "503 server busy", http.StatusServiceUnavailable)
		return
	}
	if err == pserver.PathNotFound {
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

func httpPath(m proto.Message) string {
	// TODO: use m.ProtoReflect().Descriptor().FullName() instead?
	name := fmt.Sprintf("%T", m)
	index := strings.LastIndex(name, ".")
	return "/" + name[index+1:]
}

func (a *App) ProcessMessage(ctx context.Context, message proto.Message) proto.Message {
	path := httpPath(message)
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
	case httpPath(&Person_Get_Request{}):
		return a.PersonGetRequest(ctx, request)
	//case httpPath(&Person_Add_Request{}):
	//	return a.PersonAddRequest(ctx, request)
	case httpPath(&Person_Edit_Request{}):
		return a.PersonEditRequest(ctx, request)
	case httpPath(&Person_Refresh_Request{}):
		return nil, a.PersonRefreshRequest(ctx, request)
	default:
		return nil, pserver.PathNotFound
	}
}

func (a *App) PersonGetRequest(ctx context.Context, requestBytes []byte) (*Person_Get_Response, error) {
	wrap := func(err error) (*Person_Get_Response, error) {
		return &Person_Get_Response{Err: err.Error()}, err
	}
	request := &Person_Get_Request{}
	if err := proto.Unmarshal(requestBytes, request); err != nil {
		return wrap(perr.Wrap(err, "unmarshaling get request"))
	}
	state, document, err := pstore.Get(ctx, a.Server, PersonTypeName, pstore.DocumentId(request.DocumentId), false)
	if err != nil {
		return wrap(perr.Wrap(err, "getting"))
	}
	return &Person_Get_Response{State: state, Person: document.(*tests.Person)}, nil
}

//func (a *App) PersonAddRequest(ctx context.Context, requestBytes []byte) (*Person_Add_Response, error) {
//	wrap := func(err error) (*Person_Add_Response, error) {
//		return &Person_Add_Response{Err: err.Error()}, err
//	}
//	request := &Person_Add_Request{}
//	if err := proto.Unmarshal(requestBytes, request); err != nil {
//		return wrap(perr.Wrap(err, "unmarshaling add request"))
//	}
//	if err := pstore.Add(ctx, a.Server, PERSON, request.Id, request.Person); err != nil {
//		return wrap(perr.Wrap(err, "adding"))
//	}
//	return &Person_Add_Response{}, nil
//}

func (a *App) PersonEditRequest(ctx context.Context, requestBytes []byte) (*Person_Edit_Response, error) {
	wrap := func(err error) (*Person_Edit_Response, error) {
		return &Person_Edit_Response{Err: err.Error()}, err
	}
	request := &Person_Edit_Request{}
	if err := proto.Unmarshal(requestBytes, request); err != nil {
		return wrap(perr.Wrap(err, "unmarshaling edit request"))
	}
	state, op, err := pstore.Edit(ctx, a.Server, PersonTypeName, pstore.DocumentId(request.DocumentId), pstore.StateId(request.StateId), request.State, request.Op)
	switch {
	case pserver.IsBusyError(err):
		return wrap(pserver.ServerBusy)
	case err != nil:
		return wrap(perr.Wrap(err, "editing"))
	}
	if state%UPDATE_SNAPSHOT_FREQUENCY == 0 {
		if appengine.IsAppEngine() {
			if _, err := Queue(ctx, a.Server, &Person_Refresh_Request{DocumentId: request.DocumentId}); err != nil {
				return wrap(perr.Wrap(err, "triggering refresh task"))
			}
		} else {
			// for local tests
			reqBytes, err := proto.Marshal(&Person_Refresh_Request{DocumentId: request.DocumentId})
			if err != nil {
				return wrap(perr.Wrap(err, "marshaling refresh task"))
			}
			if err := a.PersonRefreshRequest(ctx, reqBytes); err != nil {
				return wrap(err)
			}
		}
	}
	return &Person_Edit_Response{State: state, Op: op}, nil
}

func (a *App) PersonRefreshRequest(ctx context.Context, requestBytes []byte) error {
	request := &Person_Refresh_Request{}
	if err := proto.Unmarshal(requestBytes, request); err != nil {
		return perr.Wrap(err, "unmarshaling edit request")
	}
	if err := pstore.Refresh(ctx, a.Server, PersonTypeName, pstore.DocumentId(request.DocumentId)); err != nil {
		return perr.Wrap(err, "refreshing")
	}
	return nil
}

var COMPANY = &pserver.DocumentType{
	Document: &tests.Company{},
}

var PERSON = &pserver.DocumentType{
	Document: &tests.Person{},
}
