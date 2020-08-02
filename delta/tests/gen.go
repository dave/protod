package tests

//go:generate sh -c "protoc --dart_out=../../test/pb --go_out=. --go_opt=paths=source_relative --proto_path=. --proto_path=./../../ *.proto"
//go:generate sh -c "sed -i '' \"s/import '\\(\\.\\.\\/\\)*delta\\/delta\\\\.pb\\\\.dart'/import 'package:protod\\/delta\\/delta\\.pb\\.dart'/g\" ../../test/pb/*.pb.dart"
//go:generate sh -c "sed -i '' \"s/import '\\(\\.\\.\\/\\)*google\\/protobuf\\//import 'package:protod\\/google\\/protobuf\\//g\" ../../test/pb/*.pb.dart"
//go:generate sh -c "go run ./../../gen/protodgen/main.go -in=. -go-root=. -dart-root=../../test/pb -dart-pkg=protod/test/pb -dart-pkg-rel"

// generate tests task:
// package path: github.com/dave/protod/delta/protodgen
// working dir: /Users/dave/src/protod/delta/tests
// program arguments: -in=. -go-root=. -dart-root=../../test/pb -dart-pkg=protod/test/pb -dart-pkg-rel -dart-types-root=../../lib/ -go-types-root=../
