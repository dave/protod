package tests

//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --dart_out=../../test/pb --go_out=./.. --go_opt=paths=source_relative --proto_path=./../../ $(find ./../../delta/tests -iname '*.proto')"
////go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --dart_out=../../test/pb --go_out=./.. --go_opt=paths=source_relative --proto_path=./../../ $(find ./../../delta/tests2 -iname '*.proto')"
////go:generate sh -c "go run ./../../gen/protodg/*.go -proto-root=.. -go-root=.. -go-pkg=github.com/dave/protod/delta -dart-root=../../test/pb -dart-pkg=protod/test/pb -go-scalars=.. -dart-scalars=../lib/delta"
