package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"path"
	"path/filepath"
	"strings"

	"github.com/dave/protod/packages/perr/pkg/perr"
)

func (m *Main) writeDart(protoRoot, protoPackageRoot, dartPackageRoot string) error {
	for _, pkg := range m.Packages {

		if !IsSubdirectory(protoPackageRoot, filepath.Join(protoRoot, pkg.RelativeDir)) {
			continue
		}

		locatables := pkg.Scope.Locatables()
		if len(locatables) == 0 {
			continue
		}

		sb := &strings.Builder{}
		sb.WriteString("import 'package:pdelta/pdelta/pdelta.dart' as pdelta;\n")
		sb.WriteString("import 'package:pdelta/pdelta/pdelta.pb.dart' as pdelta;\n")
		sb.WriteString("import 'package:fixnum/fixnum.dart' as fixnum;\n")

		for _, importedPackage := range pkg.Imports() {
			importPath, err := dartImportPath(pkg.DartPath, importedPackage.DartPath)
			if err != nil {
				return err
			}
			sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", path.Join(importPath, fmt.Sprintf("%s.op.dart", importedPackage.Name)), importedPackage.DartImportAlias()))
		}

		if !pkg.Scalars {
			for _, file := range pkg.Files {
				importPath, err := dartImportPath(pkg.DartPath, pkg.DartPath)
				if err != nil {
					return err
				}
				sb.WriteString(fmt.Sprintf("import '%s' as pb;\n", path.Join(importPath, fmt.Sprintf("%s.pb.dart", file.Name))))
			}
		}
		sb.WriteString("\n")

		if !m.IsScalars {
			/*
				Op_root_type get op {
				  return Op_root_type();
				}
			*/
			sb.WriteString("Op_root_type get op {\n")
			sb.WriteString("  return Op_root_type();\n")
			sb.WriteString("}\n")
			sb.WriteString("\n")
			/*
				class Op_root_type {
				  Op_root_type();
				  Person_type get person {
				    return Person_type([]);
				  }
				  //...
				}
			*/
			sb.WriteString("class Op_root_type {\n")
			sb.WriteString("  Op_root_type();\n")
			// ...
			for _, locatable := range locatables {
				switch locatable.(type) {
				case *MessageData, *OneofData:
					sb.WriteString(fmt.Sprintf("  %s get %s {\n", locatable.DartLocatableTypeName(false, false, ""), locatable.DartAccessorName()))
					sb.WriteString(fmt.Sprintf("    return %s([]);\n", locatable.DartLocatableTypeName(false, false, "")))
					sb.WriteString("  }\n")
				}
			}
			sb.WriteString("}\n")
			sb.WriteString("\n")
		}

		for _, locatable := range locatables {
			// base locatable
			m.writeDartLocatable(sb, locatable, false, false, "")

			// collection locatables (messages, scalars and enums)
			switch locatable := locatable.(type) {
			case *MessageData, *ScalarData, *EnumData:
				m.writeDartLocatable(sb, locatable, true, false, "")
				for _, key := range ProtoKeyTypes {
					m.writeDartLocatable(sb, locatable, false, true, key)
				}
			}
		}

		outDir := filepath.Join(dartPackageRoot, pkg.RelativeDir)
		outPath := filepath.Join(outDir, fmt.Sprintf("%s.op.dart", pkg.Name))

		if err := os.MkdirAll(outDir, 0777); err != nil {
			return err
		}

		if err := ioutil.WriteFile(outPath, []byte(sb.String()), 0666); err != nil {
			return err
		}
	}

	if !m.IsScalars {

		for _, pkg := range m.Packages {

			if !IsSubdirectory(protoPackageRoot, filepath.Join(protoRoot, pkg.RelativeDir)) {
				continue
			}

			if len(pkg.Scope.Locatables()) == 0 {
				continue
			}

			registryFpath := filepath.Join(dartPackageRoot, pkg.RelativeDir, "registry.dart")
			var sb strings.Builder

			//import 'package:protobuf/protobuf.dart';
			sb.WriteString(fmt.Sprintf("import 'package:protobuf/protobuf.dart' as protobuf;\n"))
			for _, pkg := range pkg.AllImports() {
				if pkg.Scalars {
					continue
				}
				if len(pkg.Scope.Locatables()) == 0 {
					continue
				}

				importPath, err := dartImportPath(dartPackageRoot, pkg.DartPath)
				if err != nil {
					return err
				}
				for _, file := range pkg.Files {
					sb.WriteString(fmt.Sprintf("import '%s' as %s;\n", path.Join(importPath, fmt.Sprintf("%s.pb.dart", file.Name)), pkg.DartImportAlias()))
				}
			}
			sb.WriteString("\n")

			/*
				final types = TypeRegistry([
				  storepb_foopb_foo.Foo(),
				  storepb_share.Share(),
				]);
			*/
			sb.WriteString(fmt.Sprintf("final types = protobuf.TypeRegistry([\n"))
			for _, pkg := range pkg.AllImports() {
				for _, msg := range pkg.Scope.Messages() {
					sb.WriteString(fmt.Sprintf("  %s.%s(),\n", pkg.DartImportAlias(), msg.DartTypeName()))
				}
			}
			sb.WriteString(fmt.Sprintf("]);\n\n"))

			if err := ioutil.WriteFile(registryFpath, []byte(sb.String()), 0666); err != nil {
				return err
			}

		}

	}

	return nil
}

func (m *Main) writeDartLocatable(sb *strings.Builder, locatable Locatable, isRepeated, isMap bool, key string) {
	locatableTypeName := locatable.DartLocatableTypeName(isRepeated, isMap, key)
	isBase := !isRepeated && !isMap
	/*
		class Share_type extends pdelta.Location {
		  Share_type(List<pdelta.Locator> location) : super(location);
	*/
	sb.WriteString(fmt.Sprintf("class %s extends pdelta.Location {\n", locatableTypeName))
	sb.WriteString(fmt.Sprintf("  %s(List<pdelta.Locator> location) : super(location);\n", locatableTypeName))

	if isRepeated {
		m.writeDartLocatableRepeated(sb, locatable)
	}
	if isMap {
		m.writeDartLocatableMap(sb, locatable, key)
	}
	if isBase {
		if scalar, ok := locatable.(*ScalarData); ok && scalar.Name == "string" {
			/*
				pdelta.Op edit(String from, String to) {
				  return pdelta.edit(location, from, to)
				}
			*/
			sb.WriteString("  pdelta.Op edit(String from, String to) {\n")
			sb.WriteString("    return pdelta.edit(location, from, to);\n")
			sb.WriteString("  }\n")
			sb.WriteString("\n")
		}
	}

	if isBase {
		// fields (messages and oneof's only)
		switch locatable := locatable.(type) {
		case *MessageData:
			m.writeDartFields(sb, locatable, locatable.Fields)
		case *OneofData:
			m.writeDartFields(sb, locatable, locatable.Field.OneofFields)
		}
	}

	/*
	  pdelta.Op delete() {
	    return pdelta.delete(location);
	  }
	*/
	sb.WriteString("  pdelta.Op delete() {\n")
	sb.WriteString("    return pdelta.delete(location);\n")
	sb.WriteString("  }\n")
	sb.WriteString("\n")

	if _, ok := locatable.(*OneofData); !ok {
		/*
			pdelta.Op set(pb.Company value) {
			  return pdelta.set(location, value);
			}
		*/
		sb.WriteString(fmt.Sprintf("  pdelta.Op set(%s value) {\n", locatable.DartCollectionType(isRepeated, isMap, key)))
		sb.WriteString(fmt.Sprintf("    return pdelta.set(location, %s);\n", locatable.DartCollectionConversionAction(isRepeated, isMap, key, "value")))
		sb.WriteString("  }\n")
		sb.WriteString("\n")
	}

	sb.WriteString("}\n\n")

}

func (m *Main) writeDartFields(sb *strings.Builder, locatable Locatable, fields []*MessageField) {
	for _, field := range fields {
		/*
			pdelta.String_scalar get id {
			  return pdelta.String_scalar(pdelta.copyAndAppendField(location, "id", 1));
			}
		*/
		sb.WriteString(fmt.Sprintf("  %s get %s {\n", field.DartTypeQualifiedName(field.Repeated, field.Map, field.Key), field.DartName()))
		switch field.TypeLocatable.(type) {
		case *OneofData:
			var fields string
			for i, oneofField := range field.OneofFields {
				if i > 0 {
					fields += ", "
				}
				fields += fmt.Sprintf("pdelta.Field()..name=%q..number=%d", oneofField.Name, oneofField.Number)
			}
			sb.WriteString(fmt.Sprintf("    return %s(pdelta.copyAndAppendOneof(location, %q, [%s]));\n", field.DartTypeQualifiedName(field.Repeated, field.Map, field.Key), field.Name, fields))
		default:
			sb.WriteString(fmt.Sprintf("    return %s(pdelta.copyAndAppendField(location, %q, %d));\n", field.DartTypeQualifiedName(field.Repeated, field.Map, field.Key), field.Name, field.Number))
		}
		sb.WriteString("  }\n")
	}
}

func (f *MessageField) DartTypeQualifiedName(isRepeated, isMap bool, key string) string {
	if f.TypeScope.Package().DartPath == f.Message.Scope.Package().DartPath {
		return f.TypeLocatable.DartLocatableTypeName(isRepeated, isMap, key)
	}
	return fmt.Sprintf("%s.%s", f.TypeScope.Package().DartImportAlias(), f.TypeLocatable.DartLocatableTypeName(isRepeated, isMap, key))
}

func (f *MessageField) DartName() string {
	s := strings.ToLower(f.Name[0:1]) + f.Name[1:]
	switch s {
	case "edit", "insert", "delete", "move", "set", "rename":
		s += "_"
	}
	if dartKeywords[s] {
		s += "_"
	}
	return s
}

func (m *Main) writeDartLocatableMap(sb *strings.Builder, locatable Locatable, key string) {
	valueLocatableTypeName := locatable.DartLocatableTypeName(false, false, "")

	/*
	  Share_type key(int k) {
	    return Share_type(pdelta.copyAndAppendKeyInt64(location, fixnum.Int64(key)));
	  }
	*/
	sb.WriteString(fmt.Sprintf("  %s key(%s key) {\n", valueLocatableTypeName, dartScalarConversionType[key]))
	sb.WriteString(fmt.Sprintf("    return %s(pdelta.copyAndAppendKey%s(location, %s));\n", valueLocatableTypeName, strings.Title(key), dartScalarConversionAction[key]("key")))
	sb.WriteString(fmt.Sprintf("  }\n"))

	/*
		pdelta.Op rename(int from, int to) {
		  return pdelta.rename(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), pdelta.keyInt64(fixnum.Int64(to)));
		}
	*/
	sb.WriteString(fmt.Sprintf("  pdelta.Op rename(%s from, %s to) {\n", dartScalarConversionType[key], dartScalarConversionType[key]))
	sb.WriteString(fmt.Sprintf("    return pdelta.rename(pdelta.copyAndAppendKey%s(location, %s), pdelta.key%s(%s));\n", strings.Title(key), dartScalarConversionAction[key]("from"), strings.Title(key), dartScalarConversionAction[key]("to")))
	sb.WriteString("  }\n")
	sb.WriteString("\n")

}

func (m *Main) writeDartLocatableRepeated(sb *strings.Builder, locatable Locatable) {
	valueLocatableTypeName := locatable.DartLocatableTypeName(false, false, "")
	/*
	  Share_type index(int i) {
	    return Share_type(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));
	  }
	*/
	sb.WriteString(fmt.Sprintf("  %s index(int i) {\n", valueLocatableTypeName))
	sb.WriteString(fmt.Sprintf("    return %s(pdelta.copyAndAppendIndex(location, fixnum.Int64(i)));\n", valueLocatableTypeName))
	sb.WriteString(fmt.Sprintf("  }\n"))

	/*
		pdelta.Op insert(int index, pb.Item value) {
		  return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), value);
		}
		pdelta.Op insert(int index, String value) {
		  return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), pdelta.scalarString(value));
		}
	*/
	sb.WriteString(fmt.Sprintf("  pdelta.Op insert(int index, %s value) {\n", locatable.DartType()))
	sb.WriteString(fmt.Sprintf("    return pdelta.insert(pdelta.copyAndAppendIndex(location, fixnum.Int64(index)), %s);\n", locatable.DartValueConversion("value")))
	sb.WriteString("  }\n")
	sb.WriteString("\n")

	/*
		pdelta.Op move(int from, int to) {
		  return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));
		}
	*/
	sb.WriteString("  pdelta.Op move(int from, int to) {\n")
	sb.WriteString("    return pdelta.move(pdelta.copyAndAppendIndex(location, fixnum.Int64(from)), fixnum.Int64(to));\n")
	sb.WriteString("  }\n")
	sb.WriteString("\n")

}

func dartImportPath(currentPath, importedPath string) (string, error) {
	if isTestPackage(importedPath) {
		// if imported package is in the test package, we must refer to it with a relative path
		relPath, err := filepath.Rel(currentPath, importedPath)
		if err != nil {
			return "", perr.Wrap(err).Debug("getting relative path")
		}
		return relPath, nil
	}
	return fmt.Sprintf("package:%s", importedPath), nil

}

func isTestPackage(dartPath string) bool {
	parts := strings.Split(dartPath, "/")
	return len(parts) > 1 && parts[1] == "test"
}
