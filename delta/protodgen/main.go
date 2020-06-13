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
	if err := run(); err != nil {
		fmt.Printf("%+v\n", err)
		os.Exit(1)
	}
}

func run() error {

	in := flag.String("in", "", "proto root")
	goRoot := flag.String("go-root", "", "go output root")
	dartRoot := flag.String("dart-root", "", "dart output root")
	dartPkg := flag.String("dart-pkg", "", "dart package - e.g. 'groupshare/pb'")
	dartPkgRel := flag.Bool("dart-pkg-rel", false, "use relative dart packages (for packages in test dir)")
	goTypesRoot := flag.String("go-types-root", "", "types go output root (only needed if developing the protod library)")
	dartTypesRoot := flag.String("dart-types-root", "", "types dart output root (only needed if developing the protod library)")

	flag.Parse()

	if *goRoot != "" || *dartRoot != "" {

		s := &state{
			scalars:   false,
			registry:  true,
			protoRoot: *in,
			goRoot:    *goRoot,
			dartRoot:  *dartRoot,
			dartPkg:   *dartPkg,
			dartRel:   *dartPkgRel,
			packages:  map[string]*Package{},
		}

		if err := filepath.Walk(s.protoRoot, s.scanFiles); err != nil {
			return fmt.Errorf("scanFiles: %w", err)
		}

		if err := s.scanMessages(); err != nil {
			return fmt.Errorf("scanMessages: %w", err)
		}

		if err := s.gen(); err != nil {
			return fmt.Errorf("gen: %w", err)
		}
	}

	if *goTypesRoot != "" || *dartTypesRoot != "" {
		s := &state{
			scalars:  true,
			registry: false,
			goRoot:   *goTypesRoot,
			dartRoot: *dartTypesRoot,
			packages: map[string]*Package{},
		}

		if err := s.initScalars(); err != nil {
			return fmt.Errorf("initScalars: %w", err)
		}

		if err := s.gen(); err != nil {
			return fmt.Errorf("gen: %w", err)
		}
	}

	return nil
}

func (s *state) initScalars() error {
	p := &Package{
		Root:                 false,
		ProtoName:            "delta",
		ProtoDir:             s.protoRoot,
		GoDir:                s.goRoot,
		DartDir:              s.dartRoot,
		RelDir:               ".",
		GoPackagePath:        deltaPath,
		GoPackageName:        "delta",
		DartPackagePath:      "protod",
		DartPackageAlias:     "delta",
		DartLocatorsFilePath: "protod/delta.op.dart",
	}
	s.packages["delta"] = p
	f := &File{
		ProtoFilename: "delta",
		Package:       p,
	}
	p.Files = append(p.Files, f)
	for _, scalarType := range ProtoScalarTypes {
		f.Types = append(f.Types, &Type{
			File:             f,
			ValueType:        SCALAR,
			CollectionType:   BASE,
			Key:              "",
			Value:            scalarType,
			ValueName:        strings.Title(scalarType),
			LocatorName:      fmt.Sprintf("%s_scalar", strings.Title(scalarType)),
			ValueLocatorName: fmt.Sprintf("%s_scalar", strings.Title(scalarType)),
		})
		f.Types = append(f.Types, &Type{
			File:             f,
			ValueType:        SCALAR,
			CollectionType:   LIST,
			Key:              "",
			Value:            scalarType,
			ValueName:        strings.Title(scalarType),
			LocatorName:      fmt.Sprintf("%s_scalar_list", strings.Title(scalarType)),
			ValueLocatorName: fmt.Sprintf("%s_scalar", strings.Title(scalarType)),
		})
		for _, keyType := range ProtoKeyTypes {
			f.Types = append(f.Types, &Type{
				File:             f,
				ValueType:        SCALAR,
				CollectionType:   MAP,
				Key:              keyType,
				Value:            scalarType,
				ValueName:        strings.Title(scalarType),
				LocatorName:      fmt.Sprintf("%s_scalar_%s_map", strings.Title(scalarType), keyType),
				ValueLocatorName: fmt.Sprintf("%s_scalar", strings.Title(scalarType)),
			})
		}
	}
	return nil
}

func (s *state) gen() error {
	if s.goRoot != "" {
		if err := s.genGo(); err != nil {
			return fmt.Errorf("genGo: %w", err)
		}
	}

	if s.dartRoot != "" {
		if err := s.genDart(); err != nil {
			return fmt.Errorf("genDart: %w", err)
		}
	}
	return nil
}

type state struct {
	registry  bool
	scalars   bool
	protoRoot string
	goRoot    string
	dartRoot  string
	dartPkg   string
	dartRel   bool
	packages  map[string]*Package
}

func (s *state) scanFiles(fpath string, info os.FileInfo, err error) error {
	if !strings.HasSuffix(fpath, ".proto") {
		return nil
	}

	f := &File{}

	protoDir, protoFilename := filepath.Split(fpath)
	protoFilename = strings.TrimSuffix(protoFilename, ".proto")

	f.ProtoFilename = protoFilename

	reader, err := os.Open(fpath)
	if err != nil {
		return fmt.Errorf("failed to open %s, err %v\n", fpath, err)
	}
	defer reader.Close()

	parsedFile, err := protoparser.Parse(reader)
	if err != nil {
		return fmt.Errorf("failed to parse, err %v\n", err)
	}
	var goPkgPath, goPkgName string
	var pkg *parser.Package
	var options []*parser.Option
	var imports []*parser.Import
	scope := &Scope{
		Prefix: "",
		Types:  map[string]*Type{},
		Scopes: map[string]*Scope{},
	}
	for _, v := range parsedFile.ProtoBody {
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
			s.scanMessage(scope, v, f)
		case *parser.Enum:
			s.scanEnum(scope, v, f)
		case *parser.Import:
			imports = append(imports, v)
		default:
			return fmt.Errorf("don't know what to do with %T", v)
		}
	}
	if pkg == nil {
		panic("no package")
	}
	if len(f.Types) == 0 {
		return nil
	}

	relDir, err := filepath.Rel(s.protoRoot, protoDir)
	if err != nil {
		return err
	}

	var p *Package
	if s.packages[pkg.Name] == nil {
		s.packages[pkg.Name] = &Package{
			Root:                 true,
			ProtoName:            pkg.Name,
			ProtoDir:             protoDir,
			RelDir:               relDir,
			GoDir:                filepath.Join(s.goRoot, relDir),
			DartDir:              filepath.Join(s.dartRoot, relDir),
			GoPackageName:        goPkgName,
			GoPackagePath:        goPkgPath,
			DartPackagePath:      path.Join(s.dartPkg, relDir),
			DartLocatorsFilePath: path.Join(s.dartPkg, relDir, fmt.Sprintf("%s.op.dart", pkg.Name)),
			DartPackageAlias:     makeAlias(relDir, pkg.Name),
			DartImports:          map[string]string{},
			//MessageFileLookup:    map[string]*File{},
		}
	}
	p = s.packages[pkg.Name]
	p.Files = append(p.Files, f)
	if p.Scope == nil {
		p.Scope = scope
	} else {
		// merge scope
		for name, typ := range scope.Types {
			_, found := p.Scope.Types[name]
			if found {
				return fmt.Errorf("duplicate type name %q", name)
			}
			p.Scope.Types[name] = typ
		}
		for name, s := range scope.Scopes {
			_, found := p.Scope.Scopes[name]
			if found {
				return fmt.Errorf("duplicate scope name %q", name)
			}
			p.Scope.Scopes[name] = s
		}
	}

	f.Package = p
	for _, t := range f.Types {
		t.File = f
		//p.MessageFileLookup[t.Value] = f
	}

	return nil
}

func (s *state) scanEnum(scope *Scope, v *parser.Enum, f *File) {
	addEnum := func(ct CollectionType, key string) {
		t := &Type{
			Scope:          scope,
			File:           f,
			ValueType:      ENUM,
			CollectionType: ct,
			Key:            key,
			Value:          scope.Prefix + v.EnumName,
			ValueName:      scope.Prefix + strings.Title(v.EnumName),
			Enum:           v,
		}
		switch ct {
		case BASE:
			t.LocatorName = fmt.Sprintf("%s_type", t.ValueName)
			t.ValueLocatorName = fmt.Sprintf("%s_type", t.ValueName)
		case LIST:
			t.LocatorName = fmt.Sprintf("%s_type_list", t.ValueName)
			t.ValueLocatorName = fmt.Sprintf("%s_type", t.ValueName)
		case MAP:
			t.LocatorName = fmt.Sprintf("%s_type_%s_map", t.ValueName, key)
			t.ValueLocatorName = fmt.Sprintf("%s_type", t.ValueName)
		}
		f.Types = append(f.Types, t)
		scope.Types[v.EnumName] = t
	}
	addEnum(BASE, "")
	addEnum(LIST, "")
	for _, keyType := range ProtoKeyTypes {
		addEnum(MAP, keyType)
	}
}

func (s *state) scanMessage(scope *Scope, v *parser.Message, f *File) {
	var found bool
	for _, comment := range v.Comments {
		if strings.Contains(comment.Raw, "[proto:data]") {
			found = true
		}
	}
	if !found {
		return
	}
	innerScope := &Scope{
		Parent: scope,
		Prefix: fmt.Sprintf("%s_%s", strings.Title(v.MessageName), scope.Prefix),
		Types:  map[string]*Type{},
		Scopes: map[string]*Scope{},
	}
	scope.Scopes[v.MessageName] = innerScope
	addType := func(ct CollectionType, key string) {
		t := &Type{
			Scope:          innerScope,
			File:           f,
			ValueType:      MESSAGE,
			CollectionType: ct,
			Key:            key,
			Value:          scope.Prefix + v.MessageName,
			ValueName:      scope.Prefix + strings.Title(v.MessageName),
			Message:        v,
		}
		switch ct {
		case BASE:
			t.LocatorName = fmt.Sprintf("%s_type", t.ValueName)
			t.ValueLocatorName = fmt.Sprintf("%s_type", t.ValueName)
		case LIST:
			t.LocatorName = fmt.Sprintf("%s_type_list", t.ValueName)
			t.ValueLocatorName = fmt.Sprintf("%s_type", t.ValueName)
		case MAP:
			t.LocatorName = fmt.Sprintf("%s_type_%s_map", t.ValueName, key)
			t.ValueLocatorName = fmt.Sprintf("%s_type", t.ValueName)
		}
		f.Types = append(f.Types, t)
		if ct == BASE {
			scope.Types[v.MessageName] = t
		}
	}
	addType(BASE, "")
	addType(LIST, "")
	for _, keyType := range ProtoKeyTypes {
		addType(MAP, keyType)
	}

	for _, visitee := range v.MessageBody {
		switch vv := visitee.(type) {
		case *parser.Message:
			s.scanMessage(innerScope, vv, f)
		case *parser.Enum:
			s.scanEnum(innerScope, vv, f)
		}
	}

}

func makeAlias(relDir, pkgName string) string {
	if relDir == "" || relDir == "." {
		return pkgName
	}
	return strings.Join(strings.Split(relDir, "/"), "_") + "_" + pkgName
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
	for _, pkg := range s.packages {
		for _, file := range pkg.Files {
			for _, typ := range file.Types {
				if typ.ValueType == ENUM {
					continue
				}
				for _, protoField := range typ.Message.MessageBody {
					switch protoField := protoField.(type) {
					case *parser.Field, *parser.MapField:
						field := &Field{Message: typ}
						var valueRaw string
						switch b := protoField.(type) {
						case *parser.Field:
							field.Name = b.FieldName
							field.NameTitle = strings.Title(field.Name)
							valueRaw = b.Type
							if b.IsRepeated {
								field.CollectionType = LIST
							} else {
								field.CollectionType = BASE
							}
							fieldNumber, err := strconv.Atoi(b.FieldNumber)
							if err != nil {
								return fmt.Errorf("parsing field number: %w", err)
							}
							field.Number = fieldNumber
						case *parser.MapField:
							field.Name = b.MapName
							field.NameTitle = strings.Title(field.Name)
							valueRaw = b.Type
							field.CollectionType = MAP
							fieldNumber, err := strconv.Atoi(b.FieldNumber)
							if err != nil {
								return fmt.Errorf("parsing field number: %w", err)
							}
							field.Number = fieldNumber
							field.Key = b.KeyType
						}

						// reserved method names
						switch field.NameTitle {
						case "Edit", "Insert", "Delete", "Move", "Replace":
							field.NameTitle += "_"
						}

						if isScalar(valueRaw) {
							field.Value = valueRaw
							field.ValueType = SCALAR
							field.ValueGoPackage = "github.com/dave/protod/delta"
							field.ValueDartPackage = "protod/delta.dart"
							field.ValueDartAlias = "delta"
							pkg.DartImports["protod/delta.dart"] = "delta"
							field.ValueLocator = fmt.Sprintf("%s_scalar", strings.Title(field.Value))
						} else if strings.Contains(valueRaw, ".") {
							packageName := valueRaw[0:strings.LastIndex(valueRaw, ".")]
							typeName := valueRaw[strings.LastIndex(valueRaw, ".")+1:]
							valuePkg := s.packages[packageName]
							t := valuePkg.Scope.Lookup(typeName)
							if t == nil {
								return fmt.Errorf("can't find %q in package %q", valueRaw, valuePkg.ProtoName)
							}
							field.ValueType = t.ValueType
							field.Value = typeName
							field.ValueProtoPackage = packageName
							field.ValueGoPackage = valuePkg.GoPackagePath
							field.ValueDartPackage = valuePkg.DartLocatorsFilePath
							field.ValueDartAlias = valuePkg.DartPackageAlias
							pkg.DartImports[valuePkg.DartLocatorsFilePath] = valuePkg.DartPackageAlias
							field.ValueLocator = fmt.Sprintf("%s_type", t.ValueName)

						} else {
							t := typ.Scope.Lookup(valueRaw)
							if t == nil {
								return fmt.Errorf("can't find %q in scope", valueRaw)
							}
							field.ValueType = t.ValueType
							field.Value = valueRaw
							field.ValueProtoPackage = pkg.ProtoName
							field.ValueGoPackage = pkg.GoPackagePath
							field.ValueDartPackage = pkg.DartPackagePath
							field.ValueDartAlias = ""
							field.ValueLocator = fmt.Sprintf("%s_type", t.ValueName)
						}
						switch field.CollectionType {
						case LIST:
							field.ValueLocator += "_list"
						case MAP:
							field.ValueLocator += fmt.Sprintf("_%s_map", field.Key)
						}
						typ.Fields = append(typ.Fields, field)

					case *parser.Message:
						// TODO: nested type - recurse?
					case *parser.Enum:
						// TODO: enums?
					default:
						return fmt.Errorf("unknown type %T", protoField)
					}
				}
			}
		}
	}
	return nil
}

func (s *state) genGo() error {
	for _, pkg := range s.packages {
		dirOut := filepath.Join(s.goRoot, pkg.RelDir)
		fpathOut := filepath.Join(dirOut, fmt.Sprintf("%s.op.go", pkg.ProtoName))

		f := jen.NewFilePathName(pkg.GoPackagePath, pkg.GoPackageName)

		f.ImportName("github.com/dave/protod/delta", "delta")
		for _, p := range s.packages {
			f.ImportName(p.GoPackagePath, p.GoPackageName)
		}

		if pkg.Root {
			f.Func().Id("Op").Params().Id("Op_root_type").Block(
				jen.Return(jen.Id("Op_root_type").Values()),
			)
			f.Type().Id("Op_root_type").Struct()
		}

		for _, file := range pkg.Files {

			for _, typ := range file.Types {

				if pkg.Root && typ.CollectionType == BASE {
					//func (Op_root_type)Person() Person_type {
					//	return Person_type{}
					//}
					f.Func().Params(jen.Id("Op_root_type")).Id(typ.ValueName).Params().Id(typ.LocatorName).Block(
						jen.Return(jen.Id(typ.LocatorName).Block()),
					)
				}

				typ.EmitGo(f)

				//shared.EmitGoType(f, m.TypeName, false, false, "", "", m.NameCapitalised, m)
				//shared.EmitGoType(f, fmt.Sprintf("%s_list", m.TypeName), true, false, "", m.TypeName, m.NameCapitalised, m)
				//for _, keyType := range mapKeyTypes {
				//	shared.EmitGoType(f, fmt.Sprintf("%s_%s_map", m.TypeName, keyType), false, true, keyType, m.TypeName, m.NameCapitalised, m)
				//}

			}

		}

		if err := os.MkdirAll(dirOut, 0777); err != nil {
			return err
		}

		if err := f.Save(fpathOut); err != nil {
			return err
		}
	}
	return nil
}

func (s *state) genDart() error {
	for _, pkg := range s.packages {

		dirOut := filepath.Join(s.dartRoot, pkg.RelDir)
		fpathOut := filepath.Join(dirOut, fmt.Sprintf("%s.op.dart", pkg.ProtoName))

		var sb strings.Builder

		sb.WriteString("import 'package:protod/delta.dart' as delta;\n")
		sb.WriteString("import 'package:protod/delta.pb.dart' as delta;\n")
		sb.WriteString("import 'package:fixnum/fixnum.dart' as fixnum;\n")
		for dartPath, dartAlias := range pkg.DartImports {
			if dartPath == "protod/delta.dart" {
				// included manually above
				continue
			}

			importPath, err := s.dartImportPath(pkg.DartPackagePath, dartPath)
			if err != nil {
				return err
			}

			sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", importPath, dartAlias))
		}
		if !s.scalars {
			// not needed for scalars because we already manually import protod/delta.pb.dart above
			for _, file := range pkg.Files {
				dartPath := path.Join(pkg.DartPackagePath, fmt.Sprintf("%s.pb.dart", file.ProtoFilename))
				importPath, err := s.dartImportPath(pkg.DartPackagePath, dartPath)
				if err != nil {
					return err
				}
				sb.WriteString(fmt.Sprintf("import '%s' as pb;\n", importPath))
			}
		}
		sb.WriteString("\n")

		if pkg.Root {
			/*
				Op_root_type Op() {
				  return Op_root_type();
				}
			*/
			sb.WriteString("Op_root_type Op() {\n")
			sb.WriteString("  return Op_root_type();\n")
			sb.WriteString("}\n")
			sb.WriteString("\n")
			/*
				class Op_root_type {
				  Op_root_type();
				  Person_type Person() {
				    return Person_type([]);
				  }
				  //...
				}
			*/
			sb.WriteString("class Op_root_type {\n")
			sb.WriteString("  Op_root_type();\n")
			// ...
			for _, file := range pkg.Files {
				for _, typ := range file.Types {
					if typ.CollectionType != BASE {
						continue
					}
					sb.WriteString(fmt.Sprintf("  %s %s() {\n", typ.LocatorName, typ.ValueName))
					sb.WriteString(fmt.Sprintf("    return %s([]);\n", typ.LocatorName))
					sb.WriteString("  }\n")
				}
			}
			sb.WriteString("}\n")
			sb.WriteString("\n")
		}

		for _, file := range pkg.Files {
			for _, typ := range file.Types {

				/*
					class Share_type extends delta.Location {
					  Share_type(List<delta.Locator> location) : super(location);
				*/
				sb.WriteString(fmt.Sprintf("class %s extends delta.Location {\n", typ.LocatorName))
				sb.WriteString(fmt.Sprintf("  %s(List<delta.Locator> location) : super(location);\n", typ.LocatorName))

				if typ.CollectionType == LIST {
					/*
					  Share_type Index(int i) {
					    return Share_type(delta.copyAndAppendIndex(location, fixnum.Int64(i)));
					  }
					*/
					sb.WriteString(fmt.Sprintf("  %s Index(int i) {\n", typ.ValueLocatorName))
					sb.WriteString(fmt.Sprintf("    return %s(delta.copyAndAppendIndex(location, fixnum.Int64(i)));\n", typ.ValueLocatorName))
					sb.WriteString(fmt.Sprintf("  }\n"))

					/*
						delta.Op Insert(int index, pb.Item value) {
						  return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
						}
						delta.Op Insert(int index, String value) {
						  return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), delta.scalarString(value));
						}
					*/
					sb.WriteString(fmt.Sprintf("  delta.Op Insert(int index, %s value) {\n", typ.DartValueType()))
					sb.WriteString(fmt.Sprintf("    return delta.insert(delta.copyAndAppendIndex(location, fixnum.Int64(index)), %s);\n", typ.DartValueConversion("value")))
					sb.WriteString("  }\n")
					sb.WriteString("\n")
					/*
						delta.Op Move(int from, int to) {
						  return delta.moveList(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
						}
					*/
					sb.WriteString("  delta.Op Move(int from, int to) {\n")
					sb.WriteString("    return delta.moveList(delta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));\n")
					sb.WriteString("  }\n")
					sb.WriteString("\n")

				}
				if typ.CollectionType == MAP {
					/*
					  Share_type Key(int k) {
					    return Share_type(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
					  }
					*/
					sb.WriteString(fmt.Sprintf("  %s Key(%s key) {\n", typ.ValueLocatorName, DartTypesConvenience[typ.Key]))
					sb.WriteString(fmt.Sprintf("    return %s(delta.copyAndAppendKey%s(location, %s));\n", typ.ValueLocatorName, strings.Title(typ.Key), DartTypesConversion[typ.Key]("key")))
					sb.WriteString(fmt.Sprintf("  }\n"))

					/*
						delta.Op Insert(int k, String value) {
						  return delta.insert(delta.copyAndAppendKeyInt64(location, fixnum.Int64(key)), scalarString(value));
						}
					*/
					sb.WriteString(fmt.Sprintf("  delta.Op Insert(%s key, %s value) {\n", DartTypesConvenience[typ.Key], typ.DartValueType()))
					sb.WriteString(fmt.Sprintf("    return delta.insert(delta.copyAndAppendKey%s(location, %s), %s);\n", strings.Title(typ.Key), DartTypesConversion[typ.Key]("key"), typ.DartValueConversion("value")))
					sb.WriteString("  }\n")
					sb.WriteString("\n")
					/*
						delta.Op Move(int from, int to) {
						  return delta.moveMap(delta.copyAndAppendIndex(location, fixnum.Int64(from)), delta.keyInt64(fixnum.Int64(to)));
						}
					*/
					sb.WriteString(fmt.Sprintf("  delta.Op Move(%s from, %s to) {\n", DartTypesConvenience[typ.Key], DartTypesConvenience[typ.Key]))
					sb.WriteString(fmt.Sprintf("    return delta.moveMap(delta.copyAndAppendKey%s(location, %s), delta.key%s(%s));\n", strings.Title(typ.Key), DartTypesConversion[typ.Key]("from"), strings.Title(typ.Key), DartTypesConversion[typ.Key]("to")))
					sb.WriteString("  }\n")
					sb.WriteString("\n")
				}
				if typ.CollectionType == BASE && typ.ValueType == MESSAGE {
					for _, field := range typ.Fields {
						var qualifiedTypeName string
						switch field.ValueType {
						case SCALAR:
							qualifiedTypeName = fmt.Sprintf("delta.%s", field.ValueLocator)
						case MESSAGE:
							if field.ValueDartPackage == field.Message.File.Package.DartPackagePath {
								qualifiedTypeName = field.ValueLocator
							} else {
								qualifiedTypeName = fmt.Sprintf("%s.%s", field.ValueDartAlias, field.ValueLocator)
							}
						}
						/*
							delta.String_scalar Id() {
							  return delta.String_scalar(delta.copyAndAppendField(location, "id", 1));
							}
						*/
						sb.WriteString(fmt.Sprintf("  %s %s() {\n", qualifiedTypeName, field.NameTitle))
						sb.WriteString(fmt.Sprintf("    return %s(delta.copyAndAppendField(location, %q, %d));\n", qualifiedTypeName, field.Name, field.Number))
						sb.WriteString("  }\n")
					}
				}

				/*
				  delta.Op Delete() {
				    return delta.delete(location);
				  }
				*/
				sb.WriteString("  delta.Op Delete() {\n")
				sb.WriteString("    return delta.delete(location);\n")
				sb.WriteString("  }\n")
				sb.WriteString("\n")
				/*
					delta.Op Replace(pb.Company value) {
					  return delta.replace(location, value);
					}
				*/
				sb.WriteString(fmt.Sprintf("  delta.Op Replace(%s value) {\n", typ.DartCollectionType()))
				sb.WriteString(fmt.Sprintf("    return delta.replace(location, %s);\n", typ.DartCollectionConversion("value")))
				sb.WriteString("  }\n")
				sb.WriteString("\n")
				if typ.CollectionType == BASE && typ.ValueType == SCALAR && typ.Value == "string" {
					/*
						delta.Op Edit(String from, String to) {
						  return delta.edit(location, from, to)
						}
					*/
					sb.WriteString("  delta.Op Edit(String from, String to) {\n")
					sb.WriteString("    return delta.edit(location, from, to);\n")
					sb.WriteString("  }\n")
					sb.WriteString("\n")
				}

				sb.WriteString("}\n\n")

			}
		}

		if err := os.MkdirAll(dirOut, 0777); err != nil {
			return err
		}

		if err := ioutil.WriteFile(fpathOut, []byte(sb.String()), 0666); err != nil {
			return err
		}
	}

	if s.registry {
		registryFpath := filepath.Join(s.dartRoot, "registry.dart")
		var sb strings.Builder

		//import 'package:protobuf/protobuf.dart';
		sb.WriteString(fmt.Sprintf("import 'package:protobuf/protobuf.dart';\n"))
		for _, pkg := range s.packages {
			for _, file := range pkg.Files {
				importPath, err := s.dartImportPath(s.dartPkg, pkg.DartPackagePath+"/"+file.ProtoFilename+".pb.dart")
				if err != nil {
					return err
				}
				sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", importPath, pkg.DartPackageAlias))
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
		for _, pkg := range s.packages {
			for _, file := range pkg.Files {
				for _, typ := range file.Types {
					if typ.CollectionType != BASE {
						continue
					}
					sb.WriteString(fmt.Sprintf("  %s.%s(),\n", pkg.DartPackageAlias, typ.ValueName))
				}
			}
		}
		sb.WriteString(fmt.Sprintf("]);\n\n"))

		if err := ioutil.WriteFile(registryFpath, []byte(sb.String()), 0666); err != nil {
			return err
		}
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

type ValueType int

const MESSAGE ValueType = 1
const SCALAR ValueType = 2
const ENUM ValueType = 3

type CollectionType int

const BASE CollectionType = 1
const LIST CollectionType = 2
const MAP CollectionType = 3

type Package struct {
	Root                 bool // emit the root type and Op() func
	Scope                *Scope
	ProtoName            string // proto name
	ProtoDir             string
	GoDir                string
	DartDir              string
	RelDir               string
	Files                []*File
	GoPackagePath        string // from proto option tag
	GoPackageName        string // from proto option tag
	DartPackagePath      string
	DartPackageAlias     string
	DartLocatorsFilePath string
	DartImports          map[string]string
	//MessageFileLookup    map[string]*File // lookup file by message name
}

type File struct {
	ProtoFilename string // without .proto extension
	Package       *Package
	Types         []*Type
}

/*
	Person_type_int32_map
	ValueType: MESSAGE
	CollectionType: MAP
	Key: "int32"
	Value: "Person"
	ValueName: "Person"
	LocatorName: "Person_type_int32_map"
	ValueLocatorName: "Person_type"

	String_scalar
	ValueType: SCALAR
	CollectionType: BASE
	Key: ""
	Value: "string"
	ValueName: "String"
	LocatorName: "String_scalar"
	ValueLocatorName: "String_scalar"
*/
type Type struct {
	Scope            *Scope
	File             *File
	ValueType        ValueType
	CollectionType   CollectionType
	Key              string // only for CollectionType == MAP
	Value            string // name WITHOUT SCOPE PREFIX
	ValueName        string // capitalised version of Value WITH SCOPE PREFIX
	LocatorName      string
	ValueLocatorName string
	Fields           []*Field // only for ValueType == MESSAGE
	Message          *parser.Message
	Enum             *parser.Enum
}

type Field struct {
	Message           *Type
	Name              string
	NameTitle         string
	Number            int
	ValueType         ValueType
	CollectionType    CollectionType
	Key               string
	Value             string
	ValueProtoPackage string // proto package of the type of the value, only for ValueType == MESSAGE
	ValueGoPackage    string
	ValueDartPackage  string
	ValueDartAlias    string
	ValueLocator      string
}

func (t *Type) EmitGo(f *jen.File) {

	/*
		type String_scalar struct {
			location []*Locator
		}
	*/
	f.Type().Id(t.LocatorName).Struct(
		jen.Id("location").Index().Op("*").Qual(deltaPath, "Locator"),
	)
	/*
		func (b String_scalar) Location_get() []*Locator {
			return b.location
		}
	*/
	f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Location_get").Params().Index().Op("*").Qual(deltaPath, "Locator").Block(
		jen.Return(jen.Id("b").Dot("location")),
	)
	/*
		func NewString_scalar(l []*Locator) String_scalar {
			return String_scalar{location: l}
		}
	*/
	f.Func().Id("New" + t.LocatorName).Params(jen.Id("l").Index().Op("*").Qual(deltaPath, "Locator")).Id(t.LocatorName).Block(
		jen.Return(jen.Id(t.LocatorName).Values(jen.Dict{jen.Id("location"): jen.Id("l")})),
	)
	if t.CollectionType == LIST {
		/*
			func (b Person_type_list) Index(i int) Person_type {
				return NewPerson_type(
					delta.CopyAndAppendIndex(b.location, int64(i)),
				)
			}
		*/
		f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Index").Params(jen.Id("i").Int()).Id(t.ValueLocatorName).Block(
			jen.Return(jen.Id(fmt.Sprintf("New%s", t.ValueLocatorName)).Call(
				jen.Qual(deltaPath, "CopyAndAppendIndex").Call(
					jen.Id("b").Dot("location"),
					jen.Int64().Parens(jen.Id("i")),
				),
			)),
		)
		/*
			func (b Person_type) Insert(index int, value *Person) *delta.Op {
				return delta.Insert(
					delta.CopyAndAppendIndex(b.location, int64(index)),
					value,
				)
			}
		*/
		f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Insert").Params(jen.Id("index").Int(), jen.Id("value").Add(t.GoValueType())).Op("*").Qual(deltaPath, "Op").Block(
			jen.Return(jen.Qual(deltaPath, "Insert").Call(
				jen.Qual(deltaPath, "CopyAndAppendIndex").Call(
					jen.Id("b").Dot("location"),
					jen.Int64().Parens(jen.Id("index")),
				),
				t.GoValueConversion("value"),
			)),
		)
		/*
			func (b Person_type) Move(from, to int) *delta.Op {
				return delta.Move(
					delta.CopyAndAppendIndex(b.location, int64(from)),
					int64(to),
				)
			}
		*/
		f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Move").Params(jen.Id("from"), jen.Id("to").Int()).Op("*").Qual(deltaPath, "Op").Block(
			jen.Return(jen.Qual(deltaPath, "Move").Call(
				jen.Qual(deltaPath, "CopyAndAppendIndex").Call(
					jen.Id("b").Dot("location"),
					jen.Int64().Parens(jen.Id("from")),
				),
				jen.Int64().Parens(jen.Id("to")),
			)),
		)
	}
	if t.CollectionType == MAP {
		/*
			func (b Person_type_list) Key(key int) Person_type {
				return NewPerson_type(
					delta.CopyAndAppendKeyInt32(b.location, int32(key),
				)
			}
		*/
		f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Key").Params(jen.Id("key").Add(GoTypesConvenience[t.Key])).Id(t.ValueLocatorName).Block(
			jen.Return(jen.Id(fmt.Sprintf("New%s", t.ValueLocatorName)).Call(
				jen.Qual(deltaPath, fmt.Sprintf("CopyAndAppendKey%s", strings.Title(t.Key))).Call(
					jen.Id("b").Dot("location"),
					GoTypesConversion[t.Key]("key"),
				),
			)),
		)

		/*
			func (b Person_type) Move(from, to string) *delta.Op {
				return delta.Move(
					delta.CopyAndAppendKeyString(
						b.location,
						from
					),
					to,
				)
			}
		*/
		f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Move").Params(jen.Id("from"), jen.Id("to").Add(GoTypesConvenience[t.Key])).Op("*").Qual(deltaPath, "Op").Block(
			jen.Return(jen.Qual(deltaPath, "Move").Call(
				jen.Qual(deltaPath, fmt.Sprintf("CopyAndAppendKey%s", strings.Title(t.Key))).Call(
					jen.Id("b").Dot("location"),
					GoTypesConversion[t.Key]("from"),
				),
				GoTypesConversion[t.Key]("to"),
			)),
		)
		/*
			func (b Person_type) Insert(key bool, value *Person) *delta.Op {
				return delta.Move(
					delta.CopyAndAppendKeyBool(
						b.location,
						key,
					),
					value,
				)
			}
		*/
		f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Insert").Params(jen.Id("key").Add(GoTypesConvenience[t.Key]), jen.Id("value").Add(t.GoValueType())).Op("*").Qual(deltaPath, "Op").Block(
			jen.Return(jen.Qual(deltaPath, "Insert").Call(
				jen.Qual(deltaPath, fmt.Sprintf("CopyAndAppendKey%s", strings.Title(t.Key))).Call(
					jen.Id("b").Dot("location"),
					GoTypesConversion[t.Key]("key"),
				),
				t.GoValueConversion("value"),
			)),
		)

	}
	if t.CollectionType == BASE && t.ValueType == MESSAGE {
		for _, field := range t.Fields {

			//func (b Person_type) Name() delta.String_scalar {
			//	return delta.NewString_scalar(
			//		delta.CopyAndAppendField(
			//			b.location,
			//			"name",
			//			number,
			//		),
			//	)
			//}
			f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id(field.NameTitle).Params().Qual(field.ValueGoPackage, field.ValueLocator).Block(
				jen.Return(
					jen.Qual(field.ValueGoPackage, fmt.Sprintf("New%s", field.ValueLocator)).Call(
						jen.Qual(deltaPath, "CopyAndAppendField").Call(
							jen.Id("b").Dot("location"),
							jen.Lit(field.Name),
							jen.Lit(field.Number),
						),
					),
				),
			)
		}
	}
	/*
		func (b Person_type) Delete() *delta.Op {
			return delta.Delete(b.location)
		}
	*/
	f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Delete").Params().Op("*").Qual(deltaPath, "Op").Block(
		jen.Return(jen.Qual(deltaPath, "Delete").Call(jen.Id("b").Dot("location"))),
	)
	/*
		func (b Person_type) Replace(value *Person) *delta.Op {
			return delta.Replace(b.location, value)
		}
	*/
	f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Replace").Params(jen.Id("value").Add(t.GoCollectionType())).Op("*").Qual(deltaPath, "Op").Block(
		jen.Return(jen.Qual(deltaPath, "Replace").Call(jen.Id("b").Dot("location"), t.GoCollectionConversion("value"))),
	)
	if t.CollectionType == BASE && t.Value == "string" {
		/*
			func (b Person_type) Edit(from, to string) *delta.Op {
				return delta.Edit(b.location, from, to)
			}
		*/
		f.Func().Params(jen.Id("b").Id(t.LocatorName)).Id("Edit").Params(jen.Id("from"), jen.Id("to").String()).Op("*").Qual(deltaPath, "Op").Block(
			jen.Return(jen.Qual(deltaPath, "Edit").Call(jen.Id("b").Dot("location"), jen.Id("from"), jen.Id("to"))),
		)
	}
}

func (t *Type) GoValueType() jen.Code {
	if t.ValueType == SCALAR {
		return GoTypesConvenience[t.Value]
	} else if t.ValueType == ENUM {
		return jen.Id(t.ValueName)
	} else {
		return jen.Op("*").Id(t.ValueName)
	}
}

func (t *Type) GoValueConversion(name string) jen.Code {
	if t.ValueType == SCALAR {
		return GoTypesConversion[t.Value](name)
	} else {
		return jen.Id(name)
	}
}

func (t *Type) GoCollectionType() jen.Code {
	var valueType jen.Code
	if t.ValueType == SCALAR {
		if t.CollectionType == BASE {
			valueType = GoTypesConvenience[t.Value]
		} else {
			valueType = GoTypesActual[t.Value]
		}
	} else if t.ValueType == ENUM {
		return jen.Id(t.ValueName)
	} else {
		valueType = jen.Op("*").Id(t.ValueName)
	}
	switch t.CollectionType {
	case LIST:
		return jen.Index().Add(valueType)
	case MAP:
		return jen.Map(GoTypesActual[t.Key]).Add(valueType)
	default:
		// BASE
		return valueType
	}
}

func (t *Type) GoCollectionConversion(name string) jen.Code {
	if t.ValueType == SCALAR {
		if t.CollectionType == BASE {
			return GoTypesConversion[t.Value](name)
		} else {
			return jen.Id(name)
		}
	} else {
		return jen.Id(name)
	}
}

func (t *Type) DartValueType() string {
	if t.ValueType == SCALAR {
		return DartTypesConvenience[t.Value]
	} else {
		return fmt.Sprintf("pb.%s", t.ValueName)
	}
}

func (t *Type) DartValueConversion(name string) string {
	if t.ValueType == SCALAR {
		return fmt.Sprintf("delta.scalar%s(%s)", strings.Title(t.Value), DartTypesConversion[t.Value](name))
	} else {
		return name
	}
}

func (t *Type) DartCollectionType() string {
	var valueType string
	if t.ValueType == SCALAR {
		if t.CollectionType == BASE {
			valueType = DartTypesConvenience[t.Value]
		} else {
			valueType = DartTypesActual[t.Value]
		}
	} else {
		valueType = fmt.Sprintf("pb.%s", t.ValueName)
	}
	switch t.CollectionType {
	case LIST:
		return fmt.Sprintf("List<%s>", valueType)
	case MAP:
		return fmt.Sprintf("Map<%s, %s>", DartTypesActual[t.Key], valueType)
	default:
		// BASE
		return valueType
	}
}

func (t *Type) DartCollectionConversion(name string) string {
	if t.ValueType == SCALAR {
		if t.CollectionType == BASE {
			return fmt.Sprintf("delta.scalar%s(%s)", strings.Title(t.Value), DartTypesConversion[t.Value](name))
		} else {
			return name
		}
	} else {
		return name
	}
}

var ProtoKeyTypes = []string{
	"bool",
	"int32",
	"int64",
	"uint32",
	"uint64",
	"string",
}

var ProtoScalarTypes = []string{
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

var GoTypesActual = map[string]*jen.Statement{
	"double":   jen.Float64(),
	"float":    jen.Float32(),
	"int32":    jen.Int32(),
	"int64":    jen.Int64(),
	"uint32":   jen.Uint32(),
	"uint64":   jen.Uint64(),
	"sint32":   jen.Int32(),
	"sint64":   jen.Int64(),
	"fixed32":  jen.Uint32(),
	"fixed64":  jen.Uint64(),
	"sfixed32": jen.Int32(),
	"sfixed64": jen.Int64(),
	"bool":     jen.Bool(),
	"string":   jen.String(),
	"bytes":    jen.Index().Byte(),
}

var GoTypesConvenience = map[string]*jen.Statement{
	"double":   jen.Float64(),
	"float":    jen.Float64(),
	"int32":    jen.Int(),
	"int64":    jen.Int(),
	"uint32":   jen.Int(),
	"uint64":   jen.Int(),
	"sint32":   jen.Int(),
	"sint64":   jen.Int(),
	"fixed32":  jen.Int(),
	"fixed64":  jen.Int(),
	"sfixed32": jen.Int(),
	"sfixed64": jen.Int(),
	"bool":     jen.Bool(),
	"string":   jen.String(),
	"bytes":    jen.Index().Byte(),
}

var GoTypesConversion = map[string]func(string) jen.Code{
	"double":   func(s string) jen.Code { return jen.Id(s) },
	"float":    func(s string) jen.Code { return jen.Float32().Parens(jen.Id(s)) },
	"int32":    func(s string) jen.Code { return jen.Int32().Parens(jen.Id(s)) },
	"int64":    func(s string) jen.Code { return jen.Int64().Parens(jen.Id(s)) },
	"uint32":   func(s string) jen.Code { return jen.Uint32().Parens(jen.Id(s)) },
	"uint64":   func(s string) jen.Code { return jen.Uint64().Parens(jen.Id(s)) },
	"sint32":   func(s string) jen.Code { return jen.Int32().Parens(jen.Id(s)) },
	"sint64":   func(s string) jen.Code { return jen.Int64().Parens(jen.Id(s)) },
	"fixed32":  func(s string) jen.Code { return jen.Uint32().Parens(jen.Id(s)) },
	"fixed64":  func(s string) jen.Code { return jen.Uint64().Parens(jen.Id(s)) },
	"sfixed32": func(s string) jen.Code { return jen.Int32().Parens(jen.Id(s)) },
	"sfixed64": func(s string) jen.Code { return jen.Int64().Parens(jen.Id(s)) },
	"bool":     func(s string) jen.Code { return jen.Id(s) },
	"string":   func(s string) jen.Code { return jen.Id(s) },
	"bytes":    func(s string) jen.Code { return jen.Id(s) },
}

var DartTypesActual = map[string]string{
	"double":   "double",
	"float":    "double",
	"int32":    "int",
	"int64":    "fixnum.Int64",
	"uint32":   "int",
	"uint64":   "fixnum.Int64",
	"sint32":   "int",
	"sint64":   "fixnum.Int64",
	"fixed32":  "int",
	"fixed64":  "fixnum.Int64",
	"sfixed32": "int",
	"sfixed64": "fixnum.Int64",
	"bool":     "bool",
	"string":   "String",
	"bytes":    "List<int>",
}

var DartTypesConvenience = map[string]string{
	"double":   "double",
	"float":    "double",
	"int32":    "int",
	"int64":    "int",
	"uint32":   "int",
	"uint64":   "int",
	"sint32":   "int",
	"sint64":   "int",
	"fixed32":  "int",
	"fixed64":  "int",
	"sfixed32": "int",
	"sfixed64": "int",
	"bool":     "bool",
	"string":   "String",
	"bytes":    "List<int>",
}

var DartTypesConversion = map[string]func(string) string{
	"double":   func(s string) string { return s },
	"float":    func(s string) string { return s },
	"int32":    func(s string) string { return s },
	"int64":    func(s string) string { return fmt.Sprintf("fixnum.Int64(%s)", s) },
	"uint32":   func(s string) string { return s },
	"uint64":   func(s string) string { return fmt.Sprintf("fixnum.Int64(%s)", s) },
	"sint32":   func(s string) string { return s },
	"sint64":   func(s string) string { return fmt.Sprintf("fixnum.Int64(%s)", s) },
	"fixed32":  func(s string) string { return s },
	"fixed64":  func(s string) string { return fmt.Sprintf("fixnum.Int64(%s)", s) },
	"sfixed32": func(s string) string { return s },
	"sfixed64": func(s string) string { return fmt.Sprintf("fixnum.Int64(%s)", s) },
	"bool":     func(s string) string { return s },
	"string":   func(s string) string { return s },
	"bytes":    func(s string) string { return s },
}

var DartKeyFields = map[string]string{
	"bool":   "bool_1",
	"int32":  "int32",
	"int64":  "int64",
	"uint32": "uint32",
	"uint64": "uint64",
	"string": "string",
}

var DartScalarFields = map[string]string{
	"double":   "double_1",
	"float":    "float",
	"int32":    "int32",
	"int64":    "int64",
	"uint32":   "uint32",
	"uint64":   "uint64",
	"sint32":   "sint32",
	"sint64":   "sint64",
	"fixed32":  "fixed32",
	"fixed64":  "fixed64",
	"sfixed32": "sfixed32",
	"sfixed64": "sfixed64",
	"bool":     "bool_13",
	"string":   "string",
	"bytes":    "bytes",
}

const deltaPath = "github.com/dave/protod/delta"

type Scope struct {
	Parent *Scope
	Prefix string
	Types  map[string]*Type
	Scopes map[string]*Scope
}

func (s *Scope) Lookup(name string) *Type {
	if t, ok := s.Types[name]; ok {
		return t
	}
	if s.Parent == nil {
		return nil
	}
	return s.Parent.Lookup(name)
}
