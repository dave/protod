package shared

import (
	"fmt"
	"strings"

	"github.com/dave/jennifer/jen"
	"github.com/yoheimuta/go-protoparser/v4/parser"
)

type PkgInfo struct {
	Relpath              string
	ProtoPkgName         string
	GoPkgPath, GoPkgName string
	Files                []*FileInfo
}

type FileInfo struct {
	Fname                        string
	File                         *parser.Proto
	Pkg                          *parser.Package
	Options                      []*parser.Option
	Messages                     []*MessageInfo
	Imports                      []*parser.Import
	DartImports                  map[string]string
	DartPkg, DartPath, DartAlias string
}

type MessageInfo struct {
	Message                    *parser.Message
	Name                       string
	NameCapitalised            string
	TypeName, TypeNameRepeated string
	Fields                     []*FieldInfo
}

type FieldInfo struct {
	Field                    *parser.Field
	Name, NameCapitalised    string
	Number                   int
	Kind                     FieldKind
	GoTypePath, DartTypePath string
	TypeName                 string
	KeyType                  string
	IsRepeated, IsMap        bool
}
type FieldKind int

const (
	FieldKindScalar FieldKind = 1
	FieldKindLocal  FieldKind = 2
	FieldKindRemote FieldKind = 3
)

const deltaPath = "github.com/dave/protod/delta"

func EmitDartType(sb *strings.Builder, typeName string, isRepeated, isMap bool, mapKeyType, valueType string, message *MessageInfo, file *FileInfo) {
	/*
		class Share_type extends delta.Location {
		  Share_type(List<pb.Locator> location) : super(location);
	*/
	sb.WriteString(fmt.Sprintf("class %s extends delta.Location {\n", typeName))
	sb.WriteString(fmt.Sprintf("  %s(List<pb.Locator> location) : super(location);\n", typeName))

	if isRepeated {
		/*
		  Share_type Index(int i) {
		    return Share_type([...location]..add(pb.Locator()..index = fixnum.Int64(i)));
		  }
		  Share_type Index64(fixnum.Int64 i) {
		    return Share_type([...location]..add(pb.Locator()..index = i));
		  }
		*/
		sb.WriteString(fmt.Sprintf("  %s Index(int i) {\n", valueType))
		sb.WriteString(fmt.Sprintf("    return %s([...location]..add(pb.Locator()..index = fixnum.Int64(i)));\n", valueType))
		sb.WriteString(fmt.Sprintf("  }\n"))
		sb.WriteString(fmt.Sprintf("  %s Index64(fixnum.Int64 i) {\n", valueType))
		sb.WriteString(fmt.Sprintf("    return %s([...location]..add(pb.Locator()..index = i));\n", valueType))
		sb.WriteString(fmt.Sprintf("  }\n"))
	} else if isMap {
		/*
		  Share_type Key(int k) {
		    return Share_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = fixnum.Int64(key))));
		  }
		  // for int64, uint64:
		  Share_type Key64(fixnum.Int64 k) {
		    return Share_type([...location]..add(pb.Locator()..key = (pb.Key()..int64 = key)));
		  }
		*/
		var dartKeyType, dartKeyField, dartKeyValue string
		var dartHasInt64 bool
		switch mapKeyType {
		case "bool":
			dartKeyType = "bool"
			dartKeyField = "bool_1"
			dartKeyValue = "k"
		case "int32":
			dartKeyType = "int"
			dartKeyField = "int32"
			dartKeyValue = "k"
		case "int64":
			dartHasInt64 = true
			dartKeyType = "int"
			dartKeyField = "int64"
			dartKeyValue = "fixnum.Int64(k)"
		case "uint32":
			dartKeyType = "int"
			dartKeyField = "uint32"
			dartKeyValue = "k"
		case "uint64":
			dartHasInt64 = true
			dartKeyType = "int"
			dartKeyField = "uint64"
			dartKeyValue = "fixnum.Int64(k)"
		case "string":
			dartKeyType = "String"
			dartKeyField = "string"
			dartKeyValue = "k"
		}
		sb.WriteString(fmt.Sprintf("  %s Key(%s k) {\n", valueType, dartKeyType))
		sb.WriteString(fmt.Sprintf("    return %s([...location]..add(pb.Locator()..key = (pb.Key()..%s = %s)));\n", valueType, dartKeyField, dartKeyValue))
		sb.WriteString(fmt.Sprintf("  }\n"))
		if dartHasInt64 {
			sb.WriteString(fmt.Sprintf("  %s Key64(fixnum.Int64 k) {\n", valueType))
			sb.WriteString(fmt.Sprintf("    return %s([...location]..add(pb.Locator()..key = (pb.Key()..%s = k)));\n", valueType, dartKeyField))
			sb.WriteString(fmt.Sprintf("  }\n"))
		}
	} else if message != nil {
		for _, field := range message.Fields {
			var qualifiedTypeName string
			switch field.Kind {
			case FieldKindScalar:
				qualifiedTypeName = fmt.Sprintf("delta.%s", field.TypeName)
			case FieldKindLocal:
				qualifiedTypeName = field.TypeName
			case FieldKindRemote:
				qualifiedTypeName = fmt.Sprintf("%s.%s", file.DartImports[field.DartTypePath], field.TypeName)
			}
			/*
				delta.String_scalar Id() {
				  return delta.String_scalar([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = "id"..number = 1)));
				}
			*/
			sb.WriteString(fmt.Sprintf("  %s %s() {\n", qualifiedTypeName, field.NameCapitalised))
			sb.WriteString(fmt.Sprintf("    return %s([...location]..add(pb.Locator()..field_1 = (pb.Field()..name = %q..number = %d)));\n", qualifiedTypeName, field.Name, field.Number))
			sb.WriteString("  }\n")
		}
	}
	sb.WriteString("}\n\n")
}

func EmitGoType(f *jen.File, typeName string, isRepeated, isMap bool, mapKeyType, valueType string) {
	/*
		type String_scalar struct {
			location []*Locator
		}
	*/
	f.Type().Id(typeName).Struct(
		jen.Id("location").Index().Op("*").Qual(deltaPath, "Locator"),
	)
	/*
		func (b String_scalar) Location_get() []*Locator {
			return b.location
		}
	*/
	f.Func().Params(jen.Id("b").Id(typeName)).Id("Location_get").Params().Index().Op("*").Qual(deltaPath, "Locator").Block(
		jen.Return(jen.Id("b").Dot("location")),
	)
	/*
		func NewString_scalar(l []*Locator) String_scalar {
			return String_scalar{location: l}
		}
	*/
	f.Func().Id("New" + typeName).Params(jen.Id("l").Index().Op("*").Qual(deltaPath, "Locator")).Id(typeName).Block(
		jen.Return(jen.Id(typeName).Values(jen.Dict{jen.Id("location"): jen.Id("l")})),
	)
	if isRepeated {
		/*
			func (b Person_type_repeated) Index(i int) Person_type {
				return NewPerson_type(
					delta.CopyAndAppend(
						b.location,
						&delta.Locator{V: &delta.Locator_Index{Index: int64(i)}},
					),
				)
			}
			func (b Person_type_repeated) Index64(i int64) Person_type {
				return NewPerson_type(
					delta.CopyAndAppend(
						b.location,
						&delta.Locator{V: &delta.Locator_Index{Index: i}},
					),
				)
			}
		*/
		f.Func().Params(jen.Id("b").Id(typeName)).Id("Index").Params(jen.Id("i").Int()).Id(valueType).Block(
			jen.Return(jen.Id(fmt.Sprintf("New%s", valueType)).Call(
				jen.Qual(deltaPath, "CopyAndAppend").Call(
					jen.Id("b").Dot("location"),
					//&delta.Locator{V: &delta.Locator_Index{Index: int64(i)}},
					jen.Op("&").Qual(deltaPath, "Locator").Values(jen.Dict{
						jen.Id("V"): jen.Op("&").Qual(deltaPath, "Locator_Index").Values(jen.Dict{
							jen.Id("Index"): jen.Int64().Parens(jen.Id("i")),
						}),
					}),
				),
			)),
		)
		f.Func().Params(jen.Id("b").Id(typeName)).Id("Index64").Params(jen.Id("i").Int64()).Id(valueType).Block(
			jen.Return(jen.Id(fmt.Sprintf("New%s", valueType)).Call(
				jen.Qual(deltaPath, "CopyAndAppend").Call(
					jen.Id("b").Dot("location"),
					//&delta.Locator{V: &delta.Locator_Index{Index: i}},
					jen.Op("&").Qual(deltaPath, "Locator").Values(jen.Dict{
						jen.Id("V"): jen.Op("&").Qual(deltaPath, "Locator_Index").Values(jen.Dict{
							jen.Id("Index"): jen.Id("i"),
						}),
					}),
				),
			)),
		)
	}
	if isMap {
		/*
			func (b Person_type_repeated) Key(k int32) Person_type {
				return NewPerson_type(delta.CopyAndAppend(b.location, &Locator{V: &Locator_Key{Key: &Key{V: &Key_Bool{Bool: key}}}}))
			}
		*/
		var vType, vField string
		switch mapKeyType {
		case "bool":
			vType, vField = "Key_Bool", "Bool"
		case "int32":
			vType, vField = "Key_Int32", "Int32"
		case "int64":
			vType, vField = "Key_Int64", "Int64"
		case "uint32":
			vType, vField = "Key_Uint32", "Uint32"
		case "uint64":
			vType, vField = "Key_Uint64", "Uint64"
		case "string":
			vType, vField = "Key_String_", "String_"
		}
		mapMethod := func(methodSuffix string, paramType, keyValue jen.Code) {
			f.Func().Params(jen.Id("b").Id(typeName)).Id("Key" + methodSuffix).Params(jen.Id("k").Add(paramType)).Id(valueType).Block(
				jen.Return(jen.Id(fmt.Sprintf("New%s", valueType)).Call(
					jen.Qual(deltaPath, "CopyAndAppend").Call(
						jen.Id("b").Dot("location"),
						//&Locator{V: &Locator_Key{Key: &Key{V: &Key_Bool{Bool: key}}}}
						jen.Op("&").Qual(deltaPath, "Locator").Values(jen.Dict{
							jen.Id("V"): jen.Op("&").Qual(deltaPath, "Locator_Key").Values(jen.Dict{
								jen.Id("Key"): jen.Op("&").Qual(deltaPath, "Key").Values(jen.Dict{
									jen.Id("V"): jen.Op("&").Qual(deltaPath, vType).Values(jen.Dict{
										jen.Id(vField): keyValue,
									}),
								}),
							}),
						}),
					),
				)),
			)
		}
		switch mapKeyType {
		case "int32", "int64", "uint32", "uint64":
			var methodSuffix = "64"
			if strings.HasSuffix(mapKeyType, "32") {
				methodSuffix = "32"
			}
			mapMethod("", jen.Int(), jen.Id(mapKeyType).Parens(jen.Id("k")))
			mapMethod(methodSuffix, jen.Id(mapKeyType), jen.Id("k"))
		default:
			mapMethod("", jen.Id(mapKeyType), jen.Id("k"))
		}
	}
}
