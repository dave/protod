package packages

//go:generate sh -c "protoc                                                                                     --go_opt=paths=source_relative --proto_path=../packages --go_out=pstore_tests/pkg                                             $(find ../packages/pstore_tests -iname '*.proto')"
//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../packages --go_out=pdelta/pkg               --dart_out=pdelta/lib               $(find ../packages/pdelta -iname '*.proto')"
//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../packages --go_out=pmsg/pkg                 --dart_out=pmsg/lib                 $(find ../packages/pmsg -iname '*.proto')"
//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../packages --go_out=pserver/pkg              --dart_out=pserver/lib              $(find ../packages/pserver -iname '*.proto')"
//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../packages --go_out=pstore/pkg               --dart_out=pstore/lib               $(find ../packages/pstore -iname '*.proto')"
//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../packages --go_out=pdelta_tests/pkg         --dart_out=pdelta_tests/lib         $(find ../packages/pdelta_tests -iname '*.proto')"
//go:generate sh -c "protoc --plugin=protoc-gen-dart=/Users/dave/src/protobuf/protoc_plugin/bin/protoc-gen-dart --go_opt=paths=source_relative --proto_path=../packages --go_out=pdelta_tests_clothes/pkg --dart_out=pdelta_tests_clothes/lib $(find ../packages/pdelta_tests_clothes -iname '*.proto')"

//go:generate sh -c "go run ./pgen/protodg/*.go -root=. -package=pdelta_tests:pdelta_tests/pkg:pdelta_tests/lib -package=pdelta_tests_clothes:pdelta_tests_clothes/pkg:pdelta_tests_clothes/lib -scalars=pdelta/pkg:pdelta/lib"
//go:generate sh -c "go run ./pgen/transformgen/*.go -go-root=pdelta/pkg/pdelta -dart-root=pdelta/lib/pdelta"
//go:generate sh -c "go run ./pgen/reducegen/*.go -go-root=pdelta/pkg/pdelta -dart-root=pdelta/lib/pdelta"
