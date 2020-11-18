package main

import (
	"fmt"
	"path/filepath"
	"strings"

	"github.com/dave/jennifer/jen"
	. "github.com/dave/jennifer/jen"
	"github.com/dave/protod/packages/perr/pkg/perr"
)

func (m *Main) writeGo(protoRoot, protoPackageRoot, goPackageRoot string) error {

	for _, pkg := range m.Packages {

		if !IsSubdirectory(protoPackageRoot, filepath.Join(protoRoot, pkg.RelativeDir)) {
			continue
		}

		locatables := pkg.Scope.Locatables()
		if len(locatables) == 0 {
			continue
		}

		f := NewFilePathName(pkg.GoPackagePath, pkg.GoPackageName)

		f.ImportName(deltaPath, "pdelta")
		for _, p := range m.Packages {
			f.ImportName(p.GoPackagePath, p.GoPackageName)
		}

		if !m.IsScalars {
			f.Func().Id("Op").Params().Id("Op_root_type").Block(
				Return(Id("Op_root_type").Values()),
			)
			f.Type().Id("Op_root_type").Struct()
			for _, message := range pkg.Scope.Messages() {
				locatableTypeName := message.GoLocatableTypeName(false, false, "")
				//func (Op_root_type)Person() Person_type {
				//	return Person_type{}
				//}
				f.Func().Params(Id("Op_root_type")).Id(message.GoName()).Params().Id(locatableTypeName).Block(
					jen.Return(jen.Id(locatableTypeName).Block()),
				)
			}
		}

		for _, locatable := range locatables {
			// base locatable
			m.writeGoLocatable(f, locatable, false, false, "")

			// collection locatables (messages, scalars and enums)
			switch locatable := locatable.(type) {
			case *MessageData, *ScalarData, *EnumData:
				m.writeGoLocatable(f, locatable, true, false, "")
				for _, key := range ProtoKeyTypes {
					m.writeGoLocatable(f, locatable, false, true, key)
				}
			}
		}

		if err := f.Save(filepath.Join(goPackageRoot, pkg.RelativeDir, fmt.Sprintf("%s.op.go", pkg.Name))); err != nil {
			return perr.Wrap(err).Debug("saving go source")
		}

	}

	return nil
}

func (m *Main) writeGoLocatable(f *File, locatable Locatable, isRepeated, isMap bool, key string) {
	locatableTypeName := locatable.GoLocatableTypeName(isRepeated, isMap, key)
	isBase := !isRepeated && !isMap

	/*
		type String_scalar struct {
			location []*Locator
		}
	*/
	f.Type().Id(locatableTypeName).Struct(
		jen.Id("location").Index().Op("*").Qual(deltaPath, "Locator"),
	)

	/*
		func (b String_scalar) Location_get() []*Locator {
			return b.location
		}
	*/
	f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Location_get").Params().Index().Op("*").Qual(deltaPath, "Locator").Block(
		jen.Return(jen.Id("b").Dot("location")),
	)

	/*
		func NewString_scalar(l []*Locator) String_scalar {
			return String_scalar{location: l}
		}
	*/
	f.Func().Id("New" + locatableTypeName).Params(jen.Id("l").Index().Op("*").Qual(deltaPath, "Locator")).Id(locatableTypeName).Block(
		jen.Return(jen.Id(locatableTypeName).Values(jen.Dict{jen.Id("location"): jen.Id("l")})),
	)

	if isRepeated {
		m.writeGoLocatableRepeated(f, locatable)
	}
	if isMap {
		m.writeGoLocatableMap(f, locatable, key)
	}
	if isBase {
		if scalar, ok := locatable.(*ScalarData); ok && scalar.Name == "string" {
			/*
				func (b String_scalar) Edit(from, to string) *pdelta.Op {
					return pdelta.Edit(b.location, from, to)
				}
			*/
			f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Edit").Params(jen.Id("from"), jen.Id("to").String()).Op("*").Qual(deltaPath, "Op").Block(
				jen.Return(jen.Qual(deltaPath, "Edit").Call(jen.Id("b").Dot("location"), jen.Id("from"), jen.Id("to"))),
			)
		}
	}

	/*
		func (b Person_type) Delete() *pdelta.Op {
			return pdelta.Delete(b.location)
		}
	*/
	f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Delete").Params().Op("*").Qual(deltaPath, "Op").Block(
		jen.Return(jen.Qual(deltaPath, "Delete").Call(jen.Id("b").Dot("location"))),
	)

	if _, ok := locatable.(*OneofData); !ok {
		/*
			func (b Person_type) Set(value *Person) *pdelta.Op {
				return pdelta.Set(b.location, value)
			}
		*/
		f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Set").Params(jen.Id("value").Add(locatable.GoCollectionType(isRepeated, isMap, key))).Op("*").Qual(deltaPath, "Op").Block(
			jen.Return(jen.Qual(deltaPath, "Set").Call(jen.Id("b").Dot("location"), locatable.GoCollectionConversionAction(isRepeated, isMap, key, "value"))),
		)
	}

	if isBase {
		// fields (messages and oneof's only)
		switch locatable := locatable.(type) {
		case *MessageData:
			m.writeGoFields(f, locatable, locatable.Fields)
		case *OneofData:
			m.writeGoFields(f, locatable, locatable.Field.OneofFields)
		}
	}

}
func (m *Main) writeGoLocatableRepeated(f *File, locatable Locatable) {
	locatableTypeName := locatable.GoLocatableTypeName(true, false, "")
	valueLocatableTypeName := locatable.GoLocatableTypeName(false, false, "")
	/*
		func (b Person_type_list) Index(i int) Person_type {
			return NewPerson_type(
				pdelta.CopyAndAppendIndex(b.location, int64(i)),
			)
		}
	*/
	f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Index").Params(jen.Id("i").Int()).Id(valueLocatableTypeName).Block(
		jen.Return(jen.Id(fmt.Sprintf("New%s", valueLocatableTypeName)).Call(
			jen.Qual(deltaPath, "CopyAndAppendIndex").Call(
				jen.Id("b").Dot("location"),
				jen.Int64().Parens(jen.Id("i")),
			),
		)),
	)

	/*
		func (b Person_type) Insert(index int, value *Person) *pdelta.Op {
			return pdelta.Insert(
				pdelta.CopyAndAppendIndex(b.location, int64(index)),
				value,
			)
		}
	*/
	f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Insert").Params(jen.Id("index").Int(), jen.Id("value").Add(locatable.GoType())).Op("*").Qual(deltaPath, "Op").Block(
		jen.Return(jen.Qual(deltaPath, "Insert").Call(
			jen.Qual(deltaPath, "CopyAndAppendIndex").Call(
				jen.Id("b").Dot("location"),
				jen.Int64().Parens(jen.Id("index")),
			),
			locatable.GoValueConversion("value"),
		)),
	)
	/*
		func (b Person_type) Move(from, to int) *pdelta.Op {
			return pdelta.Move(
				pdelta.CopyAndAppendIndex(b.location, int64(from)),
				int64(to),
			)
		}
	*/
	f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Move").Params(jen.Id("from"), jen.Id("to").Int()).Op("*").Qual(deltaPath, "Op").Block(
		jen.Return(jen.Qual(deltaPath, "Move").Call(
			jen.Qual(deltaPath, "CopyAndAppendIndex").Call(
				jen.Id("b").Dot("location"),
				jen.Int64().Parens(jen.Id("from")),
			),
			jen.Int64().Parens(jen.Id("to")),
		)),
	)
}
func (m *Main) writeGoLocatableMap(f *File, locatable Locatable, key string) {
	locatableTypeName := locatable.GoLocatableTypeName(false, true, key)
	valueLocatableTypeName := locatable.GoLocatableTypeName(false, false, "")
	/*
		func (b Person_type_list) Key(key int) Person_type {
			return NewPerson_type(
				pdelta.CopyAndAppendKeyInt32(b.location, int32(key),
			)
		}
	*/
	f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Key").Params(jen.Id("key").Add(goScalarConversionType[key])).Id(valueLocatableTypeName).Block(
		jen.Return(jen.Id(fmt.Sprintf("New%s", valueLocatableTypeName)).Call(
			jen.Qual(deltaPath, fmt.Sprintf("CopyAndAppendKey%s", strings.Title(key))).Call(
				jen.Id("b").Dot("location"),
				goScalarConversionAction[key]("key"),
			),
		)),
	)

	/*
		func (b Person_type) Rename(from, to string) *pdelta.Op {
			return pdelta.Rename(
				pdelta.CopyAndAppendKeyString(
					b.location,
					from
				),
				to,
			)
		}
	*/
	f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id("Rename").Params(jen.Id("from"), jen.Id("to").Add(goScalarConversionType[key])).Op("*").Qual(deltaPath, "Op").Block(
		jen.Return(jen.Qual(deltaPath, "Rename").Call(
			jen.Qual(deltaPath, fmt.Sprintf("CopyAndAppendKey%s", strings.Title(key))).Call(
				jen.Id("b").Dot("location"),
				goScalarConversionAction[key]("from"),
			),
			goScalarConversionAction[key]("to"),
		)),
	)
}

func (m *Main) writeGoFields(f *File, locatable Locatable, fields []*MessageField) {

	locatableTypeName := locatable.GoLocatableTypeName(false, false, "")

	var parent *MessageData
	switch locatable := locatable.(type) {
	case *MessageData:
		parent = locatable
	case *OneofData:
		parent = locatable.Scope.Parent.Data.(*MessageData)
	default:
		panic(fmt.Sprintf("invalid locatable %T in writeGoFields", locatable))
	}
	typeUrl := fmt.Sprintf("%s.%s", parent.Scope.Package().Name, parent.Name)

	for _, field := range fields {
		//func (b Person_type) Name() pdelta.String_scalar {
		//	return pdelta.NewString_scalar(
		//		pdelta.CopyAndAppendField(
		//			b.location,
		//			"type_url",
		//			"name",
		//			number,
		//		),
		//	)
		//}
		f.Func().Params(jen.Id("b").Id(locatableTypeName)).Id(field.GoName()).Params().Qual(field.GoTypePackagePath(), field.GoTypeLocatableName()).Block(
			jen.Return(
				jen.Qual(field.GoTypePackagePath(), fmt.Sprintf("New%s", field.GoTypeLocatableName())).CallFunc(func(g *jen.Group) {
					if field.Oneof {
						// CopyAndAppendOneof(b.location, "name", &Field{TypeUrl: "foo.Bar", Name: "n1", Number:"1"})
						g.Qual(deltaPath, "CopyAndAppendOneof").CallFunc(func(g *jen.Group) {
							g.Id("b").Dot("location")
							g.Lit(field.Name)
							for _, oneofField := range field.OneofFields {
								g.Op("&").Qual(deltaPath, "Field").Values(jen.Dict{
									jen.Id("TypeUrl"): jen.Lit(typeUrl),
									jen.Id("Name"):    jen.Lit(oneofField.Name),
									jen.Id("Number"):  jen.Lit(oneofField.Number),
								})
							}
						})
					} else {
						g.Qual(deltaPath, "CopyAndAppendField").Call(
							jen.Id("b").Dot("location"),
							jen.Lit(typeUrl),
							jen.Lit(field.Name),
							jen.Lit(field.Number),
						)
					}
				}),
			),
		)
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

const deltaPath = "github.com/dave/protod/packages/pdelta/pkg/pdelta"
