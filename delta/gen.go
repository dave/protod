package delta

//go:generate sh -c "protoc --go_out=../ --go_opt=paths=source_relative --dart_out=../lib --proto_path=./../ ./../delta/*.proto"
//go:generate sh -c "go run ../gen/protodgen/main.go -dart-types-root=../lib/delta -go-types-root=."
//go:generate sh -c "go run ../gen/transformgen/*.go"
