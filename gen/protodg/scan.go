package main

import (
	"fmt"
	"os"
	"path"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/dave/protod/perr"
	"github.com/yoheimuta/go-protoparser/v4"
	"github.com/yoheimuta/go-protoparser/v4/parser"
)

func (m *Main) scanner(protoRoot string, dartPkg string) func(fpath string, info os.FileInfo, err error) error {
	return func(fpath string, info os.FileInfo, err error) error {
		if !strings.HasSuffix(fpath, ".proto") {
			return nil
		}

		protoDir, protoFilename := filepath.Split(fpath)
		protoRel, err := filepath.Rel(protoRoot, protoDir)
		if err != nil {
			return perr.Wrap(err).Debug("getting relative proto root")
		}
		protoFilename = strings.TrimSuffix(protoFilename, ".proto")
		//fmt.Println(protoDir, protoFilename)

		reader, err := os.Open(fpath)
		if err != nil {
			return fmt.Errorf("failed to open %q: %w", fpath, err)
		}
		defer func() { _ = reader.Close() }()

		parsedFile, err := protoparser.Parse(reader)
		if err != nil {
			return perr.Wrap(err).Debug("failed to parse")
		}

		var dartPkgOption, goPkgOptionPath, goPkgOptionName string
		var pkg *parser.Package

		for _, v := range parsedFile.ProtoBody {
			switch v := v.(type) {
			case *parser.Package:
				pkg = v
			case *parser.Option:
				switch v.OptionName {
				case "(dart_options.dart_package)":
					var err error
					dartPkgOption, err = strconv.Unquote(v.Constant)
					if err != nil {
						return perr.Wrap(err).Debug("unquoting dart_package option")
					}
				case "go_package":
					c, err := strconv.Unquote(v.Constant)
					if err != nil {
						return perr.Wrap(err).Debug("unquoting go_package option")
					}
					parts := strings.Split(c, ";")
					goPkgOptionPath = parts[0]
					if len(parts) > 1 {
						goPkgOptionName = parts[1]
					}
				}
			case *parser.Import:
				// ???
			case *parser.Message, *parser.Enum:
				// ignore in this pass
			default:
				return fmt.Errorf("don't know what to do with %T", v)
			}
		}
		if pkg == nil {
			panic("package not found")
		}
		if goPkgOptionPath == "" {
			panic("go_package option not found")
		}
		if dartPkgOption == "" {
			panic("dart_package option not found")
		}
		//fmt.Println(goPkgPath, goPkgName, pkg.Name)

		var scope *Scope
		var data *PackageData

		if scope = m.Root.Children[pkg.Name]; scope != nil {
			data = scope.Data.(*PackageData)
		} else {
			data = &PackageData{
				Name:          pkg.Name,
				RelativeDir:   protoRel,
				GoPackagePath: goPkgOptionPath,
				GoPackageName: goPkgOptionName,
				DartPath:      path.Join(dartPkgOption, protoRel),
				Files:         map[string]*FileData{},
			}
			scope = &Scope{
				Parent:   m.Root,
				Name:     pkg.Name,
				Children: map[string]*Scope{},
			}
			data.Scope = scope
			scope.Data = data
			m.Root.Children[pkg.Name] = scope
			m.Packages[pkg.Name] = data
		}

		data.Files[protoFilename] = &FileData{Name: protoFilename, Package: data}

		hasAnnotation := func(comments []*parser.Comment) bool {
			for _, c := range comments {
				if strings.Contains(c.Raw, "[proto:data]") {
					return true
				}
			}
			return false
		}

		for _, v := range parsedFile.ProtoBody {
			switch v := v.(type) {
			case *parser.Package, *parser.Option, *parser.Import:
				// ignore in this pass
			case *parser.Message:

				// only require annotations for root messages
				if !hasAnnotation(v.Comments) {
					continue
				}

				if err := m.scanMessage(scope, v); err != nil {
					return perr.Wrap(err).Debug("scanning message")
				}
			case *parser.Enum:

				// only require annotations for root enums
				if !hasAnnotation(v.Comments) {
					continue
				}

				if err := m.scanEnum(scope, v); err != nil {
					return perr.Wrap(err).Debug("scanning enum")
				}
			default:
				return fmt.Errorf("don't know what to do with %T", v)
			}
		}

		return nil
	}
}

func (m *Main) scanMessage(parent *Scope, message *parser.Message) error {
	name := message.MessageName
	scope := &Scope{
		Parent:   parent,
		Name:     name,
		Children: map[string]*Scope{},
	}
	data := &MessageData{
		Name: name,
	}
	scope.Data = data
	data.Scope = scope
	parent.Children[name] = scope

	for _, v := range message.MessageBody {
		switch v := v.(type) {
		case *parser.Message:
			if err := m.scanMessage(scope, v); err != nil {
				return perr.Wrap(err).Debug("scanning message")
			}
		case *parser.Enum:
			if err := m.scanEnum(scope, v); err != nil {
				return perr.Wrap(err).Debug("scanning enum")
			}
		case *parser.Field:
			number, err := strconv.Atoi(v.FieldNumber)
			if err != nil {
				return perr.Wrap(err).Debug("parsing field number")
			}
			field := &MessageField{
				Message:  data,
				Name:     v.FieldName,
				Number:   number,
				TypeName: v.Type,
				Repeated: v.IsRepeated,
			}
			data.Fields = append(data.Fields, field)
		case *parser.MapField:
			number, err := strconv.Atoi(v.FieldNumber)
			if err != nil {
				return perr.Wrap(err).Debug("parsing field number")
			}
			field := &MessageField{
				Message:  data,
				Name:     v.MapName,
				Number:   number,
				TypeName: v.Type,
				Key:      v.KeyType,
				Map:      true,
			}
			data.Fields = append(data.Fields, field)
		case *parser.Oneof:
			oneOfParentField := &MessageField{
				Message: data,
				Name:    v.OneofName,
				Oneof:   true,
			}
			data.Fields = append(data.Fields, oneOfParentField)

			name := v.OneofName
			oneOfScope := &Scope{
				Parent:   scope,
				Name:     name,
				Children: map[string]*Scope{},
			}
			oneOfData := &OneofData{
				Name:  name,
				Field: oneOfParentField,
			}
			oneOfScope.Data = oneOfData
			oneOfData.Scope = oneOfScope
			scope.Children[name] = oneOfScope

			oneOfParentField.TypeScope = oneOfScope
			oneOfParentField.TypeLocatable = oneOfData

			for _, field := range v.OneofFields {
				number, err := strconv.Atoi(field.FieldNumber)
				if err != nil {
					return perr.Wrap(err).Debug("parsing field number")
				}
				field := &MessageField{
					Message:     data,
					Name:        field.FieldName,
					Number:      number,
					TypeName:    field.Type,
					OneofParent: oneOfParentField,
				}
				oneOfParentField.OneofFields = append(oneOfParentField.OneofFields, field)
			}
		default:
			return fmt.Errorf("don't know what to do with %T", v)
		}
	}
	return nil
}

func (m *Main) scanEnum(parent *Scope, enum *parser.Enum) error {
	name := enum.EnumName
	scope := &Scope{
		Parent:   parent,
		Name:     name,
		Children: map[string]*Scope{},
	}
	data := &EnumData{
		Name: name,
	}
	scope.Data = data
	data.Scope = scope
	parent.Children[name] = scope

	for _, v := range enum.EnumBody {
		switch v := v.(type) {
		case *parser.EnumField:
			number, err := strconv.Atoi(v.Number)
			if err != nil {
				return perr.Wrap(err).Debug("parsing enum number")
			}
			field := &EnumField{
				Enum:   data,
				Name:   v.Ident,
				Number: number,
			}
			data.Fields = append(data.Fields, field)
		default:
			return fmt.Errorf("don't know what to do with %T", v)
		}
	}

	return nil
}
