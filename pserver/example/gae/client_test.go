package main

import (
	"bytes"
	"context"
	"fmt"
	"io/ioutil"
	"log"
	"math/rand"
	"net/http"
	"os"
	"sync"
	"testing"
	"time"

	"github.com/dave/protod/delta/tests"
	"github.com/dave/protod/pserver"
	"github.com/dave/protod/pserver/example"
	"google.golang.org/protobuf/proto"
)

type server struct {
	srv *http.Server
	app *App
	wg  *sync.WaitGroup
}

func start(ctx context.Context) *server {

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	srv := &http.Server{Addr: ":" + port}

	app := &App{Server: example.New(ctx)}
	http.HandleFunc("/", app.indexHandler)

	wg := &sync.WaitGroup{}
	wg.Add(1)

	fmt.Println("starting server...")

	go func() {
		defer wg.Done()
		fmt.Printf("serving on %s\n", srv.Addr)
		if err := srv.ListenAndServe(); err != http.ErrServerClosed {
			log.Fatalf("listen and serve: %v", err)
		}
	}()
	return &server{
		srv: srv,
		app: app,
		wg:  wg,
	}
}

func (s *server) stop(ctx context.Context) {
	fmt.Println("stopping pserver...")
	if err := s.app.Server.Close(); err != nil {
		log.Print(err)
	}
	fmt.Println("stopping http server...")
	if err := s.srv.Shutdown(ctx); err != nil {
		log.Print(err)
	}
	fmt.Println("waiting for http server to stop...")
	s.wg.Wait()
	fmt.Println("finished!")
}

func TestClient(t *testing.T) {
	s := start(context.Background())
	defer s.stop(context.Background())
	prefix := "http://localhost:8080"

	document := &tests.Person{Name: "dave"}
	id := uniqueID()

	addResponse := req(prefix, &Person_Add_Response{}, &Person_Add_Request{
		Id:     id,
		Person: document,
	}).(*Person_Add_Response)

	if addResponse.Err != "" {
		t.Fatal(addResponse.Err)
	}

	getResponse := req(prefix, &Person_Get_Response{}, &Person_Get_Request{
		Id: id,
	}).(*Person_Get_Response)

	if getResponse.Err != "" {
		t.Fatal(getResponse.Err)
	}

	if getResponse.Person.Name != "dave" {
		t.Fatal("document not received correctly in get")
	}

	editResponse := req(prefix, &Person_Edit_Response{}, &Person_Edit_Request{
		Payload: &pserver.Payload_Request{
			DocumentId: id,
			StateId:    uniqueID(),
			State:      1,
			Op:         tests.Op().Person().Name().Edit("dave", "dave foo"),
		},
	}).(*Person_Edit_Response)

	if editResponse.Err != "" {
		t.Fatal(editResponse.Err)
	}

	if editResponse.Payload.Op != nil {
		t.Fatal("expected nil op")
	}

	if editResponse.Payload.State != 2 {
		t.Fatalf("expected state 2, got %d", editResponse.Payload.State)
	}

}

const REQUEST_RETRIES = 20

func req(prefix string, response, message proto.Message) proto.Message {
	var err error
	for i := 0; i < REQUEST_RETRIES; i++ {
		if i > 0 {
			delay := 500 + rand.Intn(500*(1<<i))
			//log.Printf("request repeating (%d/%d) after %dms (error: %v)\n", i, REQUEST_RETRIES, delay, err)
			time.Sleep(time.Duration(delay) * time.Millisecond)
		}
		path := prefix + pserver.Path(message)
		var messageBytes []byte
		messageBytes, err = proto.Marshal(message)
		if err != nil {
			err = fmt.Errorf("marshaling message: %w", err)
			continue // <- restart the loop or exit when retry count exceeded
		}
		buf := bytes.NewBuffer(messageBytes)
		var resp *http.Response
		resp, err = http.Post(path, "application/protobuf", buf)
		if err != nil {
			err = fmt.Errorf("http post: %w", err)
			continue // <- restart the loop or exit when retry count exceeded
		}
		var body []byte
		body, err = ioutil.ReadAll(resp.Body)
		if err != nil {
			err = fmt.Errorf("reading body: %w", err)
			continue // <- restart the loop or exit when retry count exceeded
		}
		// TODO: special handling for 503 busy?
		if resp.StatusCode != 200 {
			if resp.StatusCode != 503 {
				fmt.Printf("status %q: %q\n", resp.Status, string(body))
			}
			err = fmt.Errorf("status %q: %q", resp.Status, string(body))
			continue // <- restart the loop or exit when retry count exceeded
		}
		err = proto.Unmarshal(body, response)
		if err != nil {
			err = fmt.Errorf("unmarshaling response: %w", err)
			continue // <- restart the loop or exit when retry count exceeded
		}
		//if i > 0 {
		//log.Printf("request completed after %d retries\n", i)
		//}
		break // <- finish the loop and continue executing
	}
	if err != nil {
		panic(err)
	}
	return response
}

func mustMarshalBuffer(message proto.Message) *bytes.Buffer {
	b, err := proto.Marshal(message)
	if err != nil {
		panic(err)
	}
	return bytes.NewBuffer(b)
}
