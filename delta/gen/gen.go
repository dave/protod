package gen

//go:generate sh -c "protoc --go_out=../ --go_opt=paths=source_relative --dart_out=../../lib --proto_path=../../proto $(find ../../proto -iname '*.proto')"
////go:generate sh -c "protoc --dart_out=../../lib --proto_path=../../proto ../../proto/any.proto"
