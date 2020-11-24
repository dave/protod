package packages

// No need to run this if you run ../gen.go

//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../../packages --go_out=pkg                                     --dart_out=lib                                     $(find ../../packages/pdelta_tests -iname '*.proto')"
//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../../packages --go_out=../../packages/pdelta_tests_clothes/pkg --dart_out=../../packages/pdelta_tests_clothes/lib $(find ../../packages/pdelta_tests_clothes -iname '*.proto')"

//go:generate sh -c "go run ../pgen/protodg/*.go -root=.. -package=pdelta_tests:pkg:lib -package=pdelta_tests_clothes:../pdelta_tests_clothes/pkg:../pdelta_tests_clothes/lib -scalars=../pdelta/pkg:../pdelta/lib"
