package tests

//go:generate sh -c "protoc --dart_out=../../test/pb --go_out=. --go_opt=paths=source_relative --proto_path=. *.proto"
////go:generate sh -c "go run ./../protodgen/main.go -in=. -out=. -dart=../../test/pb -dartpkg=protod/test/pb -reldartpkg"
