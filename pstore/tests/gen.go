package main

//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_out=. --go_opt=paths=source_relative --proto_path=./ --proto_path=./../../delta --proto_path=./../../ ./messages.proto"
