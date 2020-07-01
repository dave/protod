package gen

//go:generate sh -c "protoc --go_out=../ --go_opt=paths=source_relative --dart_out=../lib --proto_path=../proto $(find ../proto/delta -iname '*.proto')"
//go:generate sh -c "go run protodgen/main.go -dart-types-root=../lib/delta -go-types-root=../delta/"
//go:generate sh -c "go run transformgen/*.go"
