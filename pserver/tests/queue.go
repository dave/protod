package main

import (
	"context"
	"fmt"

	cloudtasks "cloud.google.com/go/cloudtasks/apiv2"
	"github.com/dave/protod/pserver"
	taskspb "google.golang.org/genproto/googleapis/cloud/tasks/v2"
	"google.golang.org/protobuf/proto"
)

func Queue(ctx context.Context, s *pserver.Server, message proto.Message) (*taskspb.Task, error) {

	client, err := cloudtasks.NewClient(ctx)
	if err != nil {
		return nil, fmt.Errorf("getting new cloudtasks client: %w", err)
	}

	body, err := proto.Marshal(message)
	if err != nil {
		return nil, fmt.Errorf("marshaling refresh message: %w", err)
	}

	req := &taskspb.CreateTaskRequest{
		Parent: fmt.Sprintf("projects/%s/locations/%s/queues/%s", s.Config.Project, s.Config.Location, s.Config.Queue),
		Task: &taskspb.Task{
			MessageType: &taskspb.Task_HttpRequest{
				HttpRequest: &taskspb.HttpRequest{
					HttpMethod: taskspb.HttpMethod_POST,
					Url:        s.Config.Prefix + httpPath(message),
					Body:       body,
					Headers:    map[string]string{"Content-Type": "application/protobuf"},
				},
			},
		},
	}

	task, err := client.CreateTask(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("creating task: %v", err)
	}

	return task, nil

}
