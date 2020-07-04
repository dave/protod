package gen

//go:generate sh -c "protoc --go_out=../../ --go_opt=paths=source_relative --proto_path=../proto $(find ../proto/pserver -iname '*.proto')"
