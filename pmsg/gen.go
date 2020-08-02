package pmsg

//go:generate sh -c "protoc --go_out=../ --go_opt=paths=source_relative --dart_out=../lib --proto_path=./../ ./../pmsg/*.proto"
