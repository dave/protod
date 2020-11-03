package pserver

//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_out=../ --go_opt=paths=source_relative --dart_out=../lib --proto_path=./../ ./../pserver/*.proto"
