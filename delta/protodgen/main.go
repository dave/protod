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
	"github.com/dave/protod/delta/protodgen/shared"
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
		packages:  map[string]*shared.PkgInfo{},
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
	packages                             map[string]*shared.PkgInfo
}

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
	var messages []*shared.MessageInfo
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
				parts := strings.Split(c, ";")
				if len(parts) == 1 {
					goPkgPath = parts[0]
					goPkgName = ""
				} else {
					goPkgPath = strings.Split(c, ";")[0]
					goPkgName = strings.Split(c, ";")[1]
				}
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
			mi := &shared.MessageInfo{}
			mi.Message = v
			mi.Name = v.MessageName
			mi.NameCapitalised = strings.Title(mi.Name)
			mi.TypeName = fmt.Sprintf("%s_type", mi.NameCapitalised)
			mi.TypeNameRepeated = fmt.Sprintf("%s_type_repeated", mi.NameCapitalised)
			messages = append(messages, mi)
		case *parser.Import:
			imports = append(imports, v)
		case *parser.Enum:
			// TODO
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
		s.packages[pkg.Name] = &shared.PkgInfo{
			Relpath:      relpath,
			ProtoPkgName: pkg.Name,
			GoPkgPath:    goPkgPath,
			GoPkgName:    goPkgName,
		}
	}
	s.packages[pkg.Name].Files = append(s.packages[pkg.Name].Files, &shared.FileInfo{
		Fname:       fname,
		File:        got,
		Pkg:         pkg,
		Options:     options,
		Messages:    messages,
		Imports:     imports,
		DartImports: map[string]string{},
		DartPkg:     path.Join(s.dartPkg, relpath),
		DartPath:    path.Join(s.dartPkg, relpath, fmt.Sprintf("%s.def.dart", fname)),
		DartAlias:   makeAlias(relpath, fname),
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
		for _, file := range info.Files {
			for _, mi := range file.Messages {
				for _, b := range mi.Message.MessageBody {
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
						f := &shared.FieldInfo{
							Name:            fieldName,
							NameCapitalised: strings.Title(fieldName),
							Number:          fieldNumber,
							KeyType:         keyType,
							IsRepeated:      isRepeated,
							IsMap:           isMap,
						}

						if isScalar(valueType) {
							f.Kind = shared.FieldKindScalar
							f.GoTypePath = "github.com/dave/protod/delta"
							f.DartTypePath = "package:protod/delta.dart"
							f.TypeName = fmt.Sprintf("%s_scalar", strings.Title(valueType))
						} else if strings.Contains(valueType, ".") {
							f.Kind = shared.FieldKindRemote

							packageName := valueType[0:strings.LastIndex(valueType, ".")]
							typeName := valueType[strings.LastIndex(valueType, ".")+1:]
							pkg := s.packages[packageName]

							f.GoTypePath = pkg.GoPkgPath

							//TODO: find file that defines this type for Dart path
							var remoteFile *shared.FileInfo
							for _, f := range pkg.Files {
								if remoteFile != nil {
									break
								}
								for _, message := range f.Messages {
									if message.Name == typeName {
										remoteFile = f
										break
									}
								}
							}
							if remoteFile == nil {
								panic("can't find type")
							}
							f.DartTypePath = remoteFile.DartPath
							file.DartImports[f.DartTypePath] = remoteFile.DartAlias
							f.TypeName = fmt.Sprintf("%s_type", strings.Title(typeName))

						} else {
							f.Kind = shared.FieldKindLocal
							f.GoTypePath = info.GoPkgPath
							f.TypeName = fmt.Sprintf("%s_type", strings.Title(valueType))
						}
						if isRepeated {
							f.TypeName += "_repeated"
						}
						if isMap {
							f.TypeName += fmt.Sprintf("_%s_map", keyType)
						}
						mi.Fields = append(mi.Fields, f)

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
		for _, file := range info.Files {

			dirOut := filepath.Join(s.outRoot, info.Relpath)
			fpathOut := filepath.Join(dirOut, fmt.Sprintf("%s.def.go", file.Fname))

			f := jen.NewFilePathName(info.GoPkgPath, info.GoPkgName)

			f.ImportName("github.com/dave/protod/delta", "delta")
			for _, p := range s.packages {
				f.ImportName(p.GoPkgPath, p.GoPkgName)
			}

			deltaPath := "github.com/dave/protod/delta"
			for _, m := range file.Messages {

				shared.EmitGoType(f, m.TypeName, false, false, "", "")
				shared.EmitGoType(f, fmt.Sprintf("%s_repeated", m.TypeName), true, false, "", m.TypeName)
				for _, keyType := range mapKeyTypes {
					shared.EmitGoType(f, fmt.Sprintf("%s_%s_map", m.TypeName, keyType), false, true, keyType, m.TypeName)
				}

				//func PersonDef() Person_type {
				//	return Person_type{}
				//}
				f.Func().Id(m.NameCapitalised + "Def").Params().Id(m.TypeName).Block(
					jen.Return(jen.Id(m.TypeName).Block()),
				)

				for _, field := range m.Fields {
					//func (b Person_type) Name() delta.String_scalar {
					//	return delta.NewString_scalar(
					//		delta.CopyAndAppend(
					//			b.location,
					//			&delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{Name: name, Number: int32(number)}}},
					//		),
					//	)
					//}
					f.Func().Params(jen.Id("b").Id(m.TypeName)).Id(field.NameCapitalised).Params().Qual(field.GoTypePath, field.TypeName).Block(
						jen.Return(
							jen.Qual(field.GoTypePath, fmt.Sprintf("New%s", field.TypeName)).Call(
								jen.Qual(deltaPath, "CopyAndAppend").Call(
									jen.Id("b").Dot("location"),
									//&delta.Locator{V: &delta.Locator_Field{Field: &delta.Field{Name: name, Number: int32(number)}}},
									jen.Op("&").Qual(deltaPath, "Locator").Values(jen.Dict{
										jen.Id("V"): jen.Op("&").Qual(deltaPath, "Locator_Field").Values(jen.Dict{
											jen.Id("Field"): jen.Op("&").Qual(deltaPath, "Field").Values(jen.Dict{
												jen.Id("Name"):   jen.Lit(field.Name),
												jen.Id("Number"): jen.Lit(field.Number),
											}),
										}),
									}),
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
		for _, file := range info.Files {

			dirOut := filepath.Join(s.dartOut, info.Relpath)
			fpathOut := filepath.Join(dirOut, fmt.Sprintf("%s.def.dart", file.Fname))

			var sb strings.Builder

			sb.WriteString("import 'package:protod/delta.dart' as delta;\n")
			sb.WriteString("import 'package:protod/delta.pb.dart' as pb;\n")
			sb.WriteString("import 'package:fixnum/fixnum.dart' as fixnum;\n")
			for dartPath, dartAlias := range file.DartImports {

				importPath, err := s.dartImportPath(file.DartPkg, dartPath)
				if err != nil {
					return err
				}

				sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", importPath, dartAlias))
			}
			sb.WriteString("\n")
			for _, message := range file.Messages {
				/*
					Share_type ShareDef() {
					  return Share_type([]);
					}
				*/
				sb.WriteString(fmt.Sprintf("%s %s() {\n", message.TypeName, message.NameCapitalised+"Def"))
				sb.WriteString(fmt.Sprintf("  return %s([]);\n", message.TypeName))
				sb.WriteString("}\n\n")

				shared.EmitDartType(&sb, message.TypeName, false, false, "", "", message, file)
				shared.EmitDartType(&sb, fmt.Sprintf("%s_repeated", message.TypeName), true, false, "", message.TypeName, message, file)
				for _, keyType := range mapKeyTypes {
					shared.EmitDartType(&sb, fmt.Sprintf("%s_%s_map", message.TypeName, keyType), false, true, keyType, message.TypeName, message, file)
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
		for _, file := range info.Files {
			importPath, err := s.dartImportPath(s.dartPkg, file.DartPkg+"/"+file.Fname+".pb.dart")
			if err != nil {
				return err
			}
			sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", importPath, file.DartAlias))
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
		for _, file := range info.Files {
			for _, message := range file.Messages {
				sb.WriteString(fmt.Sprintf("  %s.%s(),\n", file.DartAlias, message.Name))
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
