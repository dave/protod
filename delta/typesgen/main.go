package main

import (
	"fmt"
	"io/ioutil"
	"strings"

	"github.com/dave/jennifer/jen"
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
	*/
	sb.WriteString("import 'package:fixnum/fixnum.dart' as fixnum;\n")
	sb.WriteString("import 'package:protod/delta.dart' as delta;\n")
	sb.WriteString("\n")

	for _, scalarType := range scalarTypes {
		emitType := func(typeName string, isRepeated, isMap bool, mapKeyType, valueType string) {
			/*
				class String_scalar extends delta.Locator {
				  String_scalar(List<delta.Indexer> location) : super(location);
				}
			*/
			sb.WriteString(fmt.Sprintf("class %s extends delta.Locator {\n", typeName))
			sb.WriteString(fmt.Sprintf("  %s(List<delta.Indexer> location) : super(location);\n", typeName))

			if isRepeated {
				/*
					String_scalar Index(int i) {
					  return String_scalar([...location]..add(delta.Index(i)));
					}
				*/
				sb.WriteString(fmt.Sprintf("  %s Index(int i) {\n", valueType))
				sb.WriteString(fmt.Sprintf("    return %s([...location]..add(delta.Index(i)));\n", valueType))
				sb.WriteString(fmt.Sprintf("  }\n"))
			}
			if isMap {
				/*
					String_scalar Key(bool k) {
					  return String_scalar([...location]..add(delta.Key(k)));
					}
				*/
				var dartKeyType, dartKeyFunction string
				switch mapKeyType {
				case "bool":
					dartKeyType = "bool"
					dartKeyFunction = "Key"
				case "int32":
					dartKeyType = "int"
					dartKeyFunction = "Key"
				case "int64":
					dartKeyType = "fixnum.Int64"
					dartKeyFunction = "Key"
				case "uint32":
					dartKeyType = "fixnum.Int64"
					dartKeyFunction = "KeyUint32"
				case "uint64":
					dartKeyType = "fixnum.Int64"
					dartKeyFunction = "KeyUint64"
				case "string":
					dartKeyType = "String"
					dartKeyFunction = "Key"
				}
				sb.WriteString(fmt.Sprintf("  %s Key(%s k) {\n", valueType, dartKeyType))
				sb.WriteString(fmt.Sprintf("    return %s([...location]..add(delta.%s(k)));\n", valueType, dartKeyFunction))
				sb.WriteString(fmt.Sprintf("  }\n"))
			}
			sb.WriteString(fmt.Sprintf("}\n"))
			sb.WriteString(fmt.Sprintf("\n"))
		}
		emitType(fmt.Sprintf("%s_scalar", strings.Title(scalarType)), false, false, "", "")
		emitType(fmt.Sprintf("%s_scalar_repeated", strings.Title(scalarType)), true, false, "", fmt.Sprintf("%s_scalar", strings.Title(scalarType)))
		for _, keyType := range mapKeyTypes {
			emitType(fmt.Sprintf("%s_scalar_%s_map", strings.Title(scalarType), keyType), false, true, keyType, fmt.Sprintf("%s_scalar", strings.Title(scalarType)))
		}
	}

	if err := ioutil.WriteFile(fname, []byte(sb.String()), 0666); err != nil {
		panic(err)
	}
}
func genGo() {

	fname := "../delta.types.go"
	f := jen.NewFilePathName("github.com/dave/protod/delta", "delta")

	/*
		type String_scalar struct {
			location []Indexer
		}

		func (b String_scalar) Location_get() []Indexer {
			return b.location
		}

		func NewString_scalar(l []Indexer) String_scalar {
			return String_scalar{location: l}
		}
	*/
	for _, scalarType := range scalarTypes {
		emitType := func(typeName string, isRepeated, isMap bool, mapKeyType, valueType string) {
			/*
				type String_scalar struct {
					location []Indexer
				}
			*/
			f.Type().Id(typeName).Struct(
				jen.Id("location").Index().Id("Indexer"),
			)
			/*
				func (b String_scalar) Location_get() []Indexer {
					return b.location
				}
			*/
			f.Func().Params(jen.Id("b").Id(typeName)).Id("Location_get").Params().Index().Id("Indexer").Block(
				jen.Return(jen.Id("b").Dot("location")),
			)
			/*
				func NewString_scalar(l []Indexer) String_scalar {
					return String_scalar{location: l}
				}
			*/
			f.Func().Id("New" + typeName).Params(jen.Id("l").Index().Id("Indexer")).Id(typeName).Block(
				jen.Return(jen.Id(typeName).Values(jen.Dict{jen.Id("location"): jen.Id("l")})),
			)
			if isRepeated {
				/*
					func (b Person_type_repeated) Index(i int) Person_type {
						return NewPerson_type(delta.CopyAndAppend(b.location, delta.IndexIndexer(i)))
					}
				*/
				f.Func().Params(jen.Id("b").Id(typeName)).Id("Index").Params(jen.Id("i").Int()).Id(valueType).Block(
					jen.Return(jen.Id(fmt.Sprintf("New%s", valueType)).Call(
						jen.Qual("github.com/dave/protod/delta", "CopyAndAppend").Call(
							jen.Id("b").Dot("location"),
							jen.Qual("github.com/dave/protod/delta", "IndexIndexer").Call(jen.Id("i")),
						),
					)),
				)
			}
			if isMap {
				/*
					func (b Person_type_repeated) Key(k int32) Person_type {
						return NewPerson_type(delta.CopyAndAppend(b.location, delta.KeyIndexer(k)))
					}
				*/
				f.Func().Params(jen.Id("b").Id(typeName)).Id("Key").Params(jen.Id("k").Id(mapKeyType)).Id(valueType).Block(
					jen.Return(jen.Id(fmt.Sprintf("New%s", valueType)).Call(
						jen.Qual("github.com/dave/protod/delta", "CopyAndAppend").Call(
							jen.Id("b").Dot("location"),
							jen.Qual("github.com/dave/protod/delta", "KeyIndexer").Call(jen.Id("k")),
						),
					)),
				)
			}
		}
		emitType(fmt.Sprintf("%s_scalar", strings.Title(scalarType)), false, false, "", "")
		emitType(fmt.Sprintf("%s_scalar_repeated", strings.Title(scalarType)), true, false, "", fmt.Sprintf("%s_scalar", strings.Title(scalarType)))
		for _, keyType := range mapKeyTypes {
			emitType(fmt.Sprintf("%s_scalar_%s_map", strings.Title(scalarType), keyType), false, true, keyType, fmt.Sprintf("%s_scalar", strings.Title(scalarType)))
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
