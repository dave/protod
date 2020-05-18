package main

import (
	"fmt"
	"io/ioutil"
	"strings"

	"github.com/dave/jennifer/jen"
	"github.com/dave/protod/delta/protodgen/shared"
)

//go:generate sh -c "go run *.go"

func main() {
	genGo()
	genDart()
}

func genDart() {
	fname := "../../lib/delta.types.dart"
	var sb strings.Builder

	/*
		import 'package:fixnum/fixnum.dart' as fixnum;
		import 'package:protod/delta.dart' as delta;
		import 'package:protod/delta.pb.dart' as pb;
	*/
	sb.WriteString("import 'package:fixnum/fixnum.dart' as fixnum;\n")
	sb.WriteString("import 'package:protod/delta.dart' as delta;\n")
	sb.WriteString("import 'package:protod/delta.pb.dart' as pb;\n")
	sb.WriteString("\n")

	for _, scalarType := range scalarTypes {
		shared.EmitDartType(&sb, fmt.Sprintf("%s_scalar", strings.Title(scalarType)), false, false, "", "", nil, nil)
		shared.EmitDartType(&sb, fmt.Sprintf("%s_scalar_repeated", strings.Title(scalarType)), true, false, "", fmt.Sprintf("%s_scalar", strings.Title(scalarType)), nil, nil)
		for _, keyType := range mapKeyTypes {
			shared.EmitDartType(&sb, fmt.Sprintf("%s_scalar_%s_map", strings.Title(scalarType), keyType), false, true, keyType, fmt.Sprintf("%s_scalar", strings.Title(scalarType)), nil, nil)
		}
	}

	if err := ioutil.WriteFile(fname, []byte(sb.String()), 0666); err != nil {
		panic(err)
	}
}
func genGo() {

	fname := "../delta.types.go"
	f := jen.NewFilePathName("github.com/dave/protod/delta", "delta")

	for _, scalarType := range scalarTypes {
		shared.EmitGoType(f, fmt.Sprintf("%s_scalar", strings.Title(scalarType)), false, false, "", "")
		shared.EmitGoType(f, fmt.Sprintf("%s_scalar_repeated", strings.Title(scalarType)), true, false, "", fmt.Sprintf("%s_scalar", strings.Title(scalarType)))
		for _, keyType := range mapKeyTypes {
			shared.EmitGoType(f, fmt.Sprintf("%s_scalar_%s_map", strings.Title(scalarType), keyType), false, true, keyType, fmt.Sprintf("%s_scalar", strings.Title(scalarType)))
		}
	}
	if err := f.Save(fname); err != nil {
		panic(err)
	}
}

var scalarTypes = []string{
	"double",
	"float",
	"int32",
	"int64",
	"uint32",
	"uint64",
	"sint32",
	"sint64",
	"fixed32",
	"fixed64",
	"sfixed32",
	"sfixed64",
	"bool",
	"string",
	"bytes",
}

var mapKeyTypes = []string{
	"bool",
	"int32",
	"int64",
	"uint32",
	"uint64",
	"string",
}
