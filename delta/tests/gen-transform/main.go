package main

import (
	"fmt"

	. "github.com/dave/jennifer/jen"
)

const PATH = "github.com/dave/protod/delta"

func main() {
	f := NewFilePathName(PATH, "delta")
	// func (t *Op) transform(op *Op, priority bool) *Op {
	f.Func().Params(
		Id("t").Op("*").Qual(PATH, "Op"),
	).Id("transform").Params(
		Id("op").Op("*").Id("Op"),
		Id("priority").Bool(),
	).Op("*").Id("Op").Block(
		/*
			switch t.Type {
				case Op_Edit:
					_, transformerItem := t.Pop()
		*/
		Switch(Id("t").Dot("Type")).BlockFunc(func(g *Group) {
			for _, op := range OpTypes {
				tData := Behaviours[op]
				g.Case(Id(tData.Type)).Block(
					// _, tItem := t.Pop()
					List(Op("_"), Id("tItem")).Op(":=").Id("t").Dot("Pop").Call(),
					Switch(Id("tItem").Dot("V").Assert(Type())).BlockFunc(func(g *Group) {
						for _, tLocType := range tData.Locators {
							tLoc := Locators[tLocType]
							g.Case(Op("*").Id(tLoc.Type)).Block(
								// switch op.Type {
								//	case Op_Edit:
								Switch(Id("op").Dot("Type")).BlockFunc(func(g *Group) {
									for _, op := range OpTypes {
										opData := Behaviours[op]
										g.Case(Id(opData.Type)).Block(
											// _, opItem := op.Pop()
											List(Op("_"), Id("opItem")).Op(":=").Id("op").Dot("Pop").Call(),
											Switch(Id("opItem").Dot("V").Assert(Type())).BlockFunc(func(g *Group) {
												for _, opLocType := range opData.Locators {
													opLoc := Locators[opLocType]
													g.Case(Op("*").Id(opLoc.Type)).BlockFunc(func(g *Group) {
														if tLoc.Name == opLoc.Name {
															// return transformEditFieldEditField(t, op, priority)
															g.Return(Id(fmt.Sprintf("t%s%s%s%s", tData.Name, tLoc.Name, opData.Name, opLoc.Name)).Call(
																Id("t"),
																Id("op"),
																Id("priority"),
															))
														} else {
															g.Return(Id("tIndependent").Call(Id("t"), Id("op")))
														}
													})
												}
												g.Default().Block(Panic(Lit("invalid op")))
											}),
										)
									}
									g.Default().Block(Panic(Lit("invalid op")))
								}),
							)
						}
						g.Default().Block(Panic(Lit("invalid op")))
					}),
				)
			}
			g.Default().Block(Panic(Lit("invalid op")))
		}),
	)

	if err := f.Save("delta/transform-generated.go"); err != nil {
		panic(err)
	}
}
