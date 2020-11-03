package delta

//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_out=.. --go_opt=paths=source_relative --dart_out=../lib --proto_path=.. ../delta/delta.proto"
//go:generate sh -c "go run ../gen/protodg/*.go -go-scalars=. -dart-scalars=../lib/delta"
//go:generate sh -c "go run ../gen/transformgen/*.go"
//go:generate sh -c "go run ../gen/reducegen/*.go"
