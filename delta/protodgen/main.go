package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"path"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/dave/jennifer/jen"
	"github.com/yoheimuta/go-protoparser/v4"
	"github.com/yoheimuta/go-protoparser/v4/parser"
)

func main() {
	if err := Main(); err != nil {
		fmt.Printf("%+v\n", err)
		os.Exit(1)
	}
}

func Main() error {

	in := flag.String("in", "", "proto root")
	out := flag.String("out", "", "go output root")
	dart := flag.String("dart", "", "dart output root")
	dartpkg := flag.String("dartpkg", "", "dart package - e.g. 'groupshare/pb'")
	reldartpkg := flag.Bool("reldartpkg", false, "use relative dart packages (for packages in test dir)")

	flag.Parse()

	s := &state{
		protoRoot: *in,
		outRoot:   *out,
		dartPkg:   *dartpkg,
		dartOut:   *dart,
		dartRel:   *reldartpkg,
		packages:  map[string]*pkgInfo{},
	}

	if err := filepath.Walk(s.protoRoot, s.scanFiles); err != nil {
		return fmt.Errorf("scanFiles: %w", err)
	}

	if err := s.scanMessages(); err != nil {
		return fmt.Errorf("scanMessages: %w", err)
	}

	if err := s.genGo(); err != nil {
		return fmt.Errorf("genGo: %w", err)
	}

	if s.dartOut != "" {
		if err := s.genDart(); err != nil {
			return fmt.Errorf("genDart: %w", err)
		}
	}

	return nil
}

type state struct {
	protoRoot, dartPkg, dartOut, outRoot string
	dartRel                              bool
	packages                             map[string]*pkgInfo
}

type pkgInfo struct {
	relpath              string
	protoPkgName         string
	goPkgPath, goPkgName string
	files                []*fileInfo
}

type fileInfo struct {
	fname                        string
	file                         *parser.Proto
	pkg                          *parser.Package
	options                      []*parser.Option
	messages                     []*messageInfo
	imports                      []*parser.Import
	dartImports                  map[string]string
	dartPkg, dartPath, dartAlias string
}

type messageInfo struct {
	message                    *parser.Message
	name                       string
	nameCapitalised            string
	typeName, typeNameRepeated string
	fields                     []*fieldInfo
}

type fieldInfo struct {
	field                    *parser.Field
	name, nameCapitalised    string
	number                   int
	kind                     fieldKind
	goTypePath, dartTypePath string
	typeName                 string
	keyType                  string
	isRepeated, isMap        bool
}
type fieldKind int

const (
	fieldKindScalar fieldKind = 1
	fieldKindLocal  fieldKind = 2
	fieldKindRemote fieldKind = 3
)

func (s *state) scanFiles(fpath string, info os.FileInfo, err error) error {
	if !strings.HasSuffix(fpath, ".proto") {
		return nil
	}

	dir, fnameext := filepath.Split(fpath)
	fname := strings.TrimSuffix(fnameext, ".proto")

	reader, err := os.Open(fpath)
	if err != nil {
		return fmt.Errorf("failed to open %s, err %v\n", fpath, err)
	}
	defer reader.Close()

	got, err := protoparser.Parse(reader)
	if err != nil {
		return fmt.Errorf("failed to parse, err %v\n", err)
	}
	var goPkgPath, goPkgName string
	var pkg *parser.Package
	var options []*parser.Option
	var messages []*messageInfo
	var imports []*parser.Import
	for _, v := range got.ProtoBody {
		switch v := v.(type) {
		case *parser.Package:
			pkg = v
		case *parser.Option:
			if v.OptionName == "go_package" {
				c, err := strconv.Unquote(v.Constant)
				if err != nil {
					return fmt.Errorf("unquoting go_package option: %w", err)
				}
				goPkgPath = strings.Split(c, ";")[0]
				goPkgName = strings.Split(c, ";")[1]
			} else {
				options = append(options, v)
			}
		case *parser.Message:
			var found bool
			for _, comment := range v.Comments {
				if strings.Contains(comment.Raw, "[proto:data]") {
					found = true
				}
			}
			if !found {
				continue
			}
			mi := &messageInfo{}
			mi.message = v
			mi.name = v.MessageName
			mi.nameCapitalised = strings.Title(mi.name)
			mi.typeName = fmt.Sprintf("%s_type", mi.nameCapitalised)
			mi.typeNameRepeated = fmt.Sprintf("%s_type_repeated", mi.nameCapitalised)
			messages = append(messages, mi)
		case *parser.Import:
			imports = append(imports, v)
		default:
			return fmt.Errorf("don't know what to do with %T", v)
		}
	}
	if pkg == nil {
		panic("no package")
	}
	if len(messages) == 0 {
		return nil
	}

	relpath, err := filepath.Rel(s.protoRoot, dir)

	if s.packages[pkg.Name] == nil {
		s.packages[pkg.Name] = &pkgInfo{
			relpath:      relpath,
			protoPkgName: pkg.Name,
			goPkgPath:    goPkgPath,
			goPkgName:    goPkgName,
		}
	}
	s.packages[pkg.Name].files = append(s.packages[pkg.Name].files, &fileInfo{
		fname:       fname,
		file:        got,
		pkg:         pkg,
		options:     options,
		messages:    messages,
		imports:     imports,
		dartImports: map[string]string{},
		dartPkg:     path.Join(s.dartPkg, relpath),
		dartPath:    path.Join(s.dartPkg, relpath, fmt.Sprintf("%s.def.dart", fname)),
		dartAlias:   makeAlias(relpath, fname),
	})
	return nil
}

func makeAlias(relpath, fname string) string {
	if relpath == "" || relpath == "." {
		return fname
	}
	return strings.Join(strings.Split(relpath, "/"), "_") + "_" + fname
}

func (s *state) dartImportPath(pathCurrent, pathTarget string) (string, error) {
	if !s.dartRel {
		return fmt.Sprintf("package:%s", pathTarget), nil
	}
	rel, err := filepath.Rel(pathCurrent, pathTarget)
	if err != nil {
		return "", fmt.Errorf("rel in dartPath: %w", err)
	}
	return rel, nil
}

func (s *state) scanMessages() error {
	for _, info := range s.packages {
		for _, file := range info.files {
			for _, mi := range file.messages {
				for _, b := range mi.message.MessageBody {
					switch b := b.(type) {
					case *parser.Field, *parser.MapField:

						var fieldName string
						var fieldNumberString string
						var valueType, keyType string
						var isRepeated, isMap bool
						switch b := b.(type) {
						case *parser.Field:
							valueType = b.Type
							isRepeated = b.IsRepeated
							fieldNumberString = b.FieldNumber
							fieldName = b.FieldName
						case *parser.MapField:
							valueType = b.Type
							isMap = true
							fieldNumberString = b.FieldNumber
							fieldName = b.MapName
							keyType = b.KeyType
						}

						fieldNumber, err := strconv.Atoi(fieldNumberString)
						if err != nil {
							return fmt.Errorf("parsing field number: %w", err)
						}
						f := &fieldInfo{
							name:            fieldName,
							nameCapitalised: strings.Title(fieldName),
							number:          fieldNumber,
							keyType:         keyType,
							isRepeated:      isRepeated,
							isMap:           isMap,
						}

						if isScalar(valueType) {
							f.kind = fieldKindScalar
							f.goTypePath = "github.com/dave/protod/delta"
							f.dartTypePath = "package:protod/delta.dart"
							f.typeName = fmt.Sprintf("%s_scalar", strings.Title(valueType))
						} else if strings.Contains(valueType, ".") {
							f.kind = fieldKindRemote

							packageName := valueType[0:strings.LastIndex(valueType, ".")]
							typeName := valueType[strings.LastIndex(valueType, ".")+1:]
							pkg := s.packages[packageName]

							f.goTypePath = pkg.goPkgPath

							//TODO: find file that defines this type for Dart path
							var remoteFile *fileInfo
							for _, f := range pkg.files {
								if remoteFile != nil {
									break
								}
								for _, message := range f.messages {
									if message.name == typeName {
										remoteFile = f
										break
									}
								}
							}
							if remoteFile == nil {
								panic("can't find type")
							}
							f.dartTypePath = remoteFile.dartPath
							file.dartImports[f.dartTypePath] = remoteFile.dartAlias
							f.typeName = fmt.Sprintf("%s_type", strings.Title(typeName))

						} else {
							f.kind = fieldKindLocal
							f.goTypePath = info.goPkgPath
							f.typeName = fmt.Sprintf("%s_type", strings.Title(valueType))
						}
						if isRepeated {
							f.typeName += "_repeated"
						}
						if isMap {
							f.typeName += fmt.Sprintf("_%s_map", keyType)
						}
						mi.fields = append(mi.fields, f)

					case *parser.Message:
						// TODO: nested type - recurse?
					default:
						return fmt.Errorf("unknown type %T", b)
					}
				}
			}
		}
	}
	return nil
}

func (s *state) genGo() error {
	for _, info := range s.packages {
		for _, file := range info.files {

			dirOut := filepath.Join(s.outRoot, info.relpath)
			fpathOut := filepath.Join(dirOut, fmt.Sprintf("%s.def.go", file.fname))

			f := jen.NewFilePathName(info.goPkgPath, info.goPkgName)

			f.ImportName("github.com/dave/protod/delta", "delta")
			for _, p := range s.packages {
				f.ImportName(p.goPkgPath, p.goPkgName)
			}

			deltaPath := "github.com/dave/protod/delta"
			for _, m := range file.messages {

				emitType := func(typeName string, isRepeated, isMap bool, mapKeyType, valueType string) {
					/*
						type String_scalar struct {
							location []Indexer
						}
					*/
					f.Type().Id(typeName).Struct(
						jen.Id("location").Index().Qual(deltaPath, "Indexer"),
					)
					/*
						func (b String_scalar) Location_get() []Indexer {
							return b.location
						}
					*/
					f.Func().Params(jen.Id("b").Id(typeName)).Id("Location_get").Params().Index().Qual(deltaPath, "Indexer").Block(
						jen.Return(jen.Id("b").Dot("location")),
					)
					/*
						func NewString_scalar(l []Indexer) String_scalar {
							return String_scalar{location: l}
						}
					*/
					f.Func().Id("New" + typeName).Params(jen.Id("l").Index().Qual(deltaPath, "Indexer")).Id(typeName).Block(
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
								jen.Qual(deltaPath, "CopyAndAppend").Call(
									jen.Id("b").Dot("location"),
									jen.Qual(deltaPath, "IndexIndexer").Call(jen.Id("i")),
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
								jen.Qual(deltaPath, "CopyAndAppend").Call(
									jen.Id("b").Dot("location"),
									jen.Qual(deltaPath, "KeyIndexer").Call(jen.Id("k")),
								),
							)),
						)
					}
				}
				emitType(m.typeName, false, false, "", "")
				emitType(fmt.Sprintf("%s_repeated", m.typeName), true, false, "", m.typeName)
				for _, keyType := range mapKeyTypes {
					emitType(fmt.Sprintf("%s_%s_map", m.typeName, keyType), false, true, keyType, m.typeName)
				}

				//func PersonDef() Person_type {
				//	return Person_type{}
				//}
				f.Func().Id(m.nameCapitalised + "Def").Params().Id(m.typeName).Block(
					jen.Return(jen.Id(m.typeName).Block()),
				)

				for _, field := range m.fields {
					//func (b Person_type) Name() delta.String_scalar {
					//	return delta.NewString_scalar(delta.CopyAndAppend(b.location, delta.Field("name")))
					//}
					f.Func().Params(jen.Id("b").Id(m.typeName)).Id(field.nameCapitalised).Params().Qual(field.goTypePath, field.typeName).Block(
						jen.Return(
							jen.Qual(field.goTypePath, fmt.Sprintf("New%s", field.typeName)).Call(
								jen.Qual(deltaPath, "CopyAndAppend").Call(
									jen.Id("b").Dot("location"),
									jen.Qual(deltaPath, "FieldIndexer").Call(jen.Lit(field.name), jen.Lit(field.number)),
								),
							),
						),
					)
				}
			}

			//if err := f.Render(os.Stdout); err != nil {
			//	return err
			//}

			if err := os.MkdirAll(dirOut, 0777); err != nil {
				return err
			}

			if err := f.Save(fpathOut); err != nil {
				return err
			}

		}
	}
	return nil
}

func (s *state) genDart() error {
	for _, info := range s.packages {
		for _, file := range info.files {

			dirOut := filepath.Join(s.dartOut, info.relpath)
			fpathOut := filepath.Join(dirOut, fmt.Sprintf("%s.def.dart", file.fname))

			var sb strings.Builder

			sb.WriteString("import 'package:protod/delta.dart' as delta;\n")
			sb.WriteString("import 'package:fixnum/fixnum.dart' as fixnum;\n")
			for dartPath, dartAlias := range file.dartImports {

				importPath, err := s.dartImportPath(file.dartPkg, dartPath)
				if err != nil {
					return err
				}

				sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", importPath, dartAlias))
			}
			sb.WriteString("\n")
			for _, message := range file.messages {
				/*
					Share_type ShareDef() {
					  return Share_type([]);
					}
				*/
				sb.WriteString(fmt.Sprintf("%s %s() {\n", message.typeName, message.nameCapitalised+"Def"))
				sb.WriteString(fmt.Sprintf("  return %s([]);\n", message.typeName))
				sb.WriteString("}\n\n")

				emitType := func(typeName string, isRepeated, isMap bool, mapKeyType, valueType string) {

					/*
						class Share_type extends delta.Locator {
						  Share_type(List<delta.Indexer> location) : super(location);
					*/
					sb.WriteString(fmt.Sprintf("class %s extends delta.Locator {\n", typeName))
					sb.WriteString(fmt.Sprintf("  %s(List<delta.Indexer> location) : super(location);\n", typeName))

					if isRepeated {
						/*
						  Share_type Index(int i) {
						    return Share_type([...location]..add(delta.Index(i)));
						  }
						*/
						sb.WriteString(fmt.Sprintf("  %s Index(int i) {\n", valueType))
						sb.WriteString(fmt.Sprintf("    return %s([...location]..add(delta.Index(i)));\n", valueType))
						sb.WriteString(fmt.Sprintf("  }\n"))
					} else if isMap {
						/*
						  Share_type Key(int32 k) {
						    return Share_type([...location]..add(delta.Key(k)));
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
					} else {
						for _, field := range message.fields {
							var qualifiedTypeName string
							switch field.kind {
							case fieldKindScalar:
								qualifiedTypeName = fmt.Sprintf("delta.%s", field.typeName)
							case fieldKindLocal:
								qualifiedTypeName = field.typeName
							case fieldKindRemote:
								qualifiedTypeName = fmt.Sprintf("%s.%s", file.dartImports[field.dartTypePath], field.typeName)
							}
							/*
								delta.String_scalar Id() {
								  return delta.String_scalar([...location]..add(delta.Field("id", 1)));
								}
							*/
							sb.WriteString(fmt.Sprintf("  %s %s() {\n", qualifiedTypeName, field.nameCapitalised))
							sb.WriteString(fmt.Sprintf("    return %s([...location]..add(delta.Field(%q, %d)));\n", qualifiedTypeName, field.name, field.number))
							sb.WriteString("  }\n")
						}
					}
					sb.WriteString("}\n\n")

				}
				emitType(message.typeName, false, false, "", "")
				emitType(fmt.Sprintf("%s_repeated", message.typeName), true, false, "", message.typeName)
				for _, keyType := range mapKeyTypes {
					emitType(fmt.Sprintf("%s_%s_map", message.typeName, keyType), false, true, keyType, message.typeName)
				}
			}

			if err := os.MkdirAll(dirOut, 0777); err != nil {
				return err
			}

			if err := ioutil.WriteFile(fpathOut, []byte(sb.String()), 0666); err != nil {
				return err
			}
		}
	}

	unpackFpath := filepath.Join(s.dartOut, "registry.dart")
	var sb strings.Builder

	//import 'package:protobuf/protobuf.dart';
	sb.WriteString(fmt.Sprintf("import 'package:protobuf/protobuf.dart';\n"))
	for _, info := range s.packages {
		for _, file := range info.files {
			importPath, err := s.dartImportPath(s.dartPkg, file.dartPkg+"/"+file.fname+".pb.dart")
			if err != nil {
				return err
			}
			sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", importPath, file.dartAlias))
		}
	}
	sb.WriteString("\n")

	/*
		final types = TypeRegistry([
		  storepb_foopb_foo.Foo(),
		  storepb_share.Share(),
		]);
	*/
	sb.WriteString(fmt.Sprintf("final types = TypeRegistry([\n"))
	for _, info := range s.packages {
		for _, file := range info.files {
			for _, message := range file.messages {
				sb.WriteString(fmt.Sprintf("  %s.%s(),\n", file.dartAlias, message.name))
			}
		}
	}
	sb.WriteString(fmt.Sprintf("]);\n\n"))

	//sb.WriteString(fmt.Sprintf("dynamic unpacker(Any any) {\n"))
	//sb.WriteString(fmt.Sprintf("  switch (any.typeUrl) {\n"))
	//for _, info := range s.packages {
	//	for _, file := range info.files {
	//		/*
	//			dynamic unpacker(Any any) {
	//			  switch (any.typeUrl) {
	//			    case 'type.googleapis.com/XXX':
	//			      return any.unpackInto(XXX());
	//			  }
	//			}
	//		*/
	//		for _, message := range file.messages {
	//			sb.WriteString(fmt.Sprintf("    case 'type.googleapis.com/%s.%s':\n", info.protoPkgName, message.name))
	//			sb.WriteString(fmt.Sprintf("      return any.unpackInto(%s.%s());\n", file.dartAlias, message.name))
	//		}
	//	}
	//}
	//sb.WriteString(fmt.Sprintf("  }\n"))
	//sb.WriteString("  throw Exception('unknown type ${any.typeUrl}');\n")
	//sb.WriteString(fmt.Sprintf("}\n\n"))

	if err := ioutil.WriteFile(unpackFpath, []byte(sb.String()), 0666); err != nil {
		return err
	}

	return nil
}

func isScalar(t string) bool {
	switch t {
	case "double",
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
		"bytes":
		return true
	}
	return false
}

func camelCase(in string) string {
	return strings.ToLower(in[0:1]) + in[1:]
}

var mapKeyTypes = []string{
	"bool",
	"int32",
	"int64",
	"uint32",
	"uint64",
	"string",
}
