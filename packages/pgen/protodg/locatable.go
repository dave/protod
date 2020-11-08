package main

import (
	"fmt"
	"strings"

	"github.com/dave/jennifer/jen"
)

type Locatable interface {
	GoName() string
	DartAccessorName() string
	DartTypeName() string
	GoLocatableTypeName(isRepeated, isMap bool, key string) string
	DartLocatableTypeName(isRepeated, isMap bool, key string) string
	GoType() jen.Code
	DartType() string
	GoValueConversion(name string) jen.Code
	DartValueConversion(name string) string
	GoCollectionType(isRepeated, isMap bool, key string) jen.Code
	GoCollectionConversionAction(isRepeated, isMap bool, key string, name string) jen.Code
	DartCollectionType(isRepeated, isMap bool, key string) string
	DartCollectionConversionAction(isRepeated, isMap bool, key string, name string) string
}

type OneofData struct {
	Scope *Scope
	Field *MessageField
	Name  string
}

func (d *OneofData) GoName() string {
	return accessorName(d.Scope, true)
}
func (d *OneofData) DartAccessorName() string {
	return dartName(d.Scope)
}
func (d *OneofData) DartTypeName() string {
	return accessorName(d.Scope, true)
}
func (d *OneofData) GoLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "oneof", isRepeated, isMap, key)
}
func (d *OneofData) DartLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "oneof", isRepeated, isMap, key)
}
func (d *OneofData) GoType() jen.Code {
	return jen.Id(fmt.Sprintf("is%s", d.GoName()))
}
func (d *OneofData) DartType() string {
	panic("not implemented") // shouldn't use this
}
func (d *OneofData) GoValueConversion(name string) jen.Code {
	return jen.Id(name)
}
func (d *OneofData) DartValueConversion(name string) string {
	panic("not implemented") // shouldn't use this
}
func (d *OneofData) GoCollectionType(isRepeated, isMap bool, key string) jen.Code {
	panic("not implemented")
}
func (d *OneofData) GoCollectionConversionAction(isRepeated, isMap bool, key string, name string) jen.Code {
	panic("not implemented")
}
func (d *OneofData) DartCollectionType(isRepeated, isMap bool, key string) string {
	panic("not implemented")
}
func (d *OneofData) DartCollectionConversionAction(isRepeated, isMap bool, key string, name string) string {
	panic("not implemented")
}

type ScalarData struct {
	Scope *Scope
	Name  string
}

func (d *ScalarData) GoName() string {
	return accessorName(d.Scope, true)
}
func (d *ScalarData) DartAccessorName() string {
	return dartName(d.Scope)
}
func (d *ScalarData) DartTypeName() string {
	panic("not implemented") // shouldn't use this
}
func (d *ScalarData) GoLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "scalar", isRepeated, isMap, key)
}
func (d *ScalarData) DartLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "scalar", isRepeated, isMap, key)
}
func (d *ScalarData) GoType() jen.Code {
	return goScalarConversionType[d.Name]
}
func (d *ScalarData) DartType() string {
	return dartScalarConversionType[d.Name]
}
func (d *ScalarData) GoValueConversion(name string) jen.Code {
	return goScalarConversionAction[d.Name](name)
}
func (d *ScalarData) DartValueConversion(name string) string {
	return fmt.Sprintf("pdelta.scalar%s(%s)", strings.Title(d.Name), dartScalarConversionAction[d.Name](name))
}
func (d *ScalarData) GoCollectionType(isRepeated, isMap bool, key string) jen.Code {
	var code jen.Code
	if !isRepeated && !isMap {
		code = goScalarConversionType[d.Name]
	} else {
		code = goScalarActualType[d.Name]
	}
	return goCollectionCode(isRepeated, isMap, key, code)
}
func (d *ScalarData) GoCollectionConversionAction(isRepeated, isMap bool, key string, name string) jen.Code {
	if !isRepeated && !isMap {
		return goScalarConversionAction[d.Name](name)
	} else {
		return jen.Id(name)
	}
}
func (d *ScalarData) DartCollectionType(isRepeated, isMap bool, key string) string {
	if isRepeated {
		return fmt.Sprintf("List<%s>", dartScalarActualType[d.Name])
	}
	if isMap {
		return fmt.Sprintf("Map<%s, %s>", dartScalarActualType[key], dartScalarActualType[d.Name])
	}
	return dartScalarConversionType[d.Name]
}
func (d *ScalarData) DartCollectionConversionAction(isRepeated, isMap bool, key string, name string) string {
	if isRepeated || isMap {
		return name
	}
	return fmt.Sprintf("pdelta.scalar%s(%s)", strings.Title(d.Name), dartScalarConversionAction[d.Name](name))
}

type EnumData struct {
	Scope  *Scope
	Name   string
	Fields []*EnumField
}

type EnumField struct {
	Enum   *EnumData
	Name   string
	Number int
}

func (d *EnumData) GoName() string {
	return accessorName(d.Scope, true)
}
func (d *EnumData) DartAccessorName() string {
	return dartName(d.Scope)
}
func (d *EnumData) DartTypeName() string {
	return accessorName(d.Scope, true)
}
func (d *EnumData) GoLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "enum", isRepeated, isMap, key)
}
func (d *EnumData) DartLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "enum", isRepeated, isMap, key)
}
func (d *EnumData) GoType() jen.Code {
	return jen.Id(d.GoName())
}
func (d *EnumData) DartType() string {
	return fmt.Sprintf("pb.%s", d.DartTypeName())
}
func (d *EnumData) GoValueConversion(name string) jen.Code {
	return jen.Id(name)
}
func (d *EnumData) DartValueConversion(name string) string {
	return fmt.Sprintf("pdelta.scalarEnum(%s)", name)
}
func (d *EnumData) GoCollectionType(isRepeated, isMap bool, key string) jen.Code {
	return goCollectionCode(isRepeated, isMap, key, jen.Id(d.GoName()))
}
func (d *EnumData) GoCollectionConversionAction(isRepeated, isMap bool, key string, name string) jen.Code {
	return jen.Id(name)
}
func (d *EnumData) DartCollectionType(isRepeated, isMap bool, key string) string {
	if isRepeated {
		return fmt.Sprintf("List<%s>", fmt.Sprintf("pb.%s", d.DartTypeName()))
	}
	if isMap {
		return fmt.Sprintf("Map<%s, %s>", dartScalarActualType[key], fmt.Sprintf("pb.%s", d.DartTypeName()))
	}
	return fmt.Sprintf("pb.%s", d.DartTypeName())
}
func (d *EnumData) DartCollectionConversionAction(isRepeated, isMap bool, key string, name string) string {
	if isRepeated || isMap {
		return name
	}
	return fmt.Sprintf("pdelta.scalarEnum(%s)", name)
}

type MessageData struct {
	Scope  *Scope
	Name   string
	Fields []*MessageField
}

func (d *MessageData) GoName() string {
	return accessorName(d.Scope, true)
}
func (d *MessageData) DartAccessorName() string {
	return dartName(d.Scope)
}
func (d *MessageData) DartTypeName() string {
	return accessorName(d.Scope, true)
}
func (d *MessageData) GoLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "type", isRepeated, isMap, key)
}
func (d *MessageData) DartLocatableTypeName(isRepeated, isMap bool, key string) string {
	return locatableTypeName(d.Scope, "type", isRepeated, isMap, key)
}
func (d *MessageData) GoType() jen.Code {
	return jen.Op("*").Id(d.GoName())
}
func (d *MessageData) DartType() string {
	return fmt.Sprintf("pb.%s", d.DartTypeName())
}
func (d *MessageData) GoValueConversion(name string) jen.Code {
	return jen.Id(name)
}
func (d *MessageData) DartValueConversion(name string) string {
	return name
}
func (d *MessageData) GoCollectionType(isRepeated, isMap bool, key string) jen.Code {
	return goCollectionCode(isRepeated, isMap, key, jen.Op("*").Id(d.GoName()))
}
func (d *MessageData) GoCollectionConversionAction(isRepeated, isMap bool, key string, name string) jen.Code {
	return jen.Id(name)
}
func (d *MessageData) DartCollectionType(isRepeated, isMap bool, key string) string {
	if isRepeated {
		return fmt.Sprintf("List<%s>", fmt.Sprintf("pb.%s", d.DartTypeName()))
	}
	if isMap {
		return fmt.Sprintf("Map<%s, %s>", dartScalarActualType[key], fmt.Sprintf("pb.%s", d.DartTypeName()))
	}
	return fmt.Sprintf("pb.%s", d.DartTypeName())
}
func (d *MessageData) DartCollectionConversionAction(isRepeated, isMap bool, key string, name string) string {
	return name
}

func locatableTypeName(s *Scope, typ string, isRepeated, isMap bool, key string) string {
	// foo.Bar.Baz => Bar_Baz_type

	var suffix string

	if isMap {
		suffix = "_" + key + "_map"
	} else if isRepeated {
		suffix = "_list"
	} else {
		suffix = "_" + typ
	}

	return accessorName(s, true) + suffix
}

func accessorName(s *Scope, capitalise bool) string {
	// foo.Bar.Baz => Bar_Baz
	// so: Op().Bar_Baz()...

	var name string

	scopes := s.Ancestors()

	for _, scope := range scopes {

		if scope.Data == nil {
			// ignore root scope
			continue
		}

		if _, ok := scope.Data.(*PackageData); ok {
			// ignore package scope
			continue
		}

		if name != "" {
			name = "_" + name
		}

		if capitalise {
			name = strings.Title(scope.Name) + name
		} else {
			name = strings.ToLower(scope.Name[0:1]) + scope.Name[1:] + name
		}

	}
	return name
}

func dartName(s *Scope) string {
	n := accessorName(s, false)
	if dartKeywords[n] {
		n += "_"
	}
	return n
}

var dartScalarActualType = map[string]string{
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

var goScalarActualType = map[string]*jen.Statement{
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

var goScalarConversionType = map[string]*jen.Statement{
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

var dartScalarConversionType = map[string]string{
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

var goScalarConversionAction = map[string]func(string) jen.Code{
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

var dartScalarConversionAction = map[string]func(string) string{
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

func goCollectionCode(isRepeated, isMap bool, key string, code jen.Code) jen.Code {
	if isRepeated {
		return jen.Index().Add(code)
	}
	if isMap {
		return jen.Map(goScalarActualType[key]).Add(code)
	}
	return code
}

var dartKeywords = map[string]bool{
	// Reserved Words: These are main keywords in dart and they are:
	"assert": true, "break": true, "case": true, "catch": true, "class": true, "const": true, "continue": true, "default": true, "do": true, "else": true, "enum": true, "extends": true, "false": true, "final": true, "finally": true, "for": true, "if": true, "in": true, "is": true, "new": true, "null": true, "rethrow": true, "return": true, "super": true, "switch": true, "this": true, "throw": true, "true": true, "try": true, "var": true, "void": true, "while": true, "with": true,

	// Contextual Keywords: These Keywords have meaning only in specific places. They’re valid identifiers everywhere. Contextual Keywords are:
	//"async": true, "hide": true, "on": true, "show": true, "sync": true,

	// Keywords for Asynchrony Support: These are newer, limited reserved words related to the asynchrony support. And these keywords are:
	"await": true, "yield": true,

	// Built-in Identifier Words: These are used to simplify the task of porting JavaScript code to Dart, these keywords are valid identifiers in most places, but they can’t be used as class or type names, or as import prefixes. These words are:
	//"abstract": true, "as": true, "covariant": true, "deferred": true, "dynamic": true, "export": true, "extension": true, "external": true, "factory": true, "function": true, "get": true, "implements": true, "import": true, "interface": true, "library": true, "mixin": true, "operator": true, "part": true, "set": true, "static": true, "typedef": true,
}
