package tests

//go:generate sh -c "protoc --dart_out=../../test/pb --go_out=. --go_opt=paths=source_relative --proto_path=. *.proto"
//go:generate sh -c "go run ./../protodgen/main.go -in=. -go-root=. -dart-root=../../test/pb -dart-pkg=protod/test/pb -dart-pkg-rel -dart-types-root=../../lib/ -go-types-root=../"

// generate tests task:
// package path: github.com/dave/protod/delta/protodgen
// working dir: /Users/dave/src/protod/delta/tests
// program arguments: -in=. -go-root=. -dart-root=../../test/pb -dart-pkg=protod/test/pb -dart-pkg-rel -dart-types-root=../../lib/ -go-types-root=../
