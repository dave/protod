package main

//go:generate sh -c "protoc --go_out=. --go_opt=paths=source_relative --proto_path=. --proto_path=../../../delta/ --proto_path=../../../proto/ --proto_path=../../../pserver/proto messages.proto"
