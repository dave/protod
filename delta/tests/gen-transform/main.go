package main

import (
	"fmt"
	"io/ioutil"
	"strings"

	. "github.com/dave/jennifer/jen"
)

const PATH = "github.com/dave/protod/delta"

func main() {
	genGo()
	genDart()
}

func genDart() {
	var sb strings.Builder

	////pb.Op _transform(pb.Op t, pb.Op op, bool priority) {
	////  switch (t.type) {
	////  case pb.Op_Type.Edit:
	////    final tItem = item(t);
	////    if (tItem.hasField_1()) {
	////      switch (op.type) {
	////        case pb.Op_Type.Edit:
	//        final opItem = item(op);
	//        if (opItem.hasField_1()) {
	//          return tEditFieldEditField(t, op, priority);
	//        } else if (opItem.hasIndex()) {
	//          return tIndependent(t, op);
	//        } // ...
	//        break;
	//        // ...
	//      }
	////    } else if (tItem.hasIndex()) {} // ...
	////    break;
	////  }
	////}

	sb.WriteString("import 'package:protod/delta.dart';\n")
	sb.WriteString("import 'package:protod/delta.pb.dart' as pb;\n")
	sb.WriteString("\n")

	sb.WriteString("pb.Op transformGenerated(pb.Op t, pb.Op op, bool priority) {\n")
	sb.WriteString("  switch (t.type) {\n")
	for _, op := range OpTypes {
		tData := Behaviours[op]
		sb.WriteString(fmt.Sprintf("  case pb.Op_Type.%s:\n", tData.Name))
		sb.WriteString("    final tItem = item(t);\n")
		for i, tLocType := range tData.Locators {
			tLoc := Locators[tLocType]
			var elseString = ""
			if i > 0 {
				elseString = "} else "
			}
			sb.WriteString(fmt.Sprintf("    %sif (tItem.%s()) {\n", elseString, tLoc.Dart))
			sb.WriteString("      switch (op.type) {\n")
			for _, op := range OpTypes {
				opData := Behaviours[op]
				sb.WriteString(fmt.Sprintf("      case pb.Op_Type.%s:\n", opData.Name))
				sb.WriteString("        final opItem = item(op);\n")
				for i, opLocType := range opData.Locators {
					opLoc := Locators[opLocType]
					//opLoc.Type
					var elseString = ""
					if i > 0 {
						elseString = "} else "
					}
					sb.WriteString(fmt.Sprintf("        %sif (opItem.%s()) {\n", elseString, opLoc.Dart))
					if tLoc.Name == opLoc.Name {
						sb.WriteString(fmt.Sprintf("          return t%s%s%s%s(t, op, priority);\n", tData.Name, tLoc.Name, opData.Name, opLoc.Name))
					} else {
						sb.WriteString("          return tIndependent(t, op);\n")
					}
				}
				sb.WriteString("        } else {\n")
				sb.WriteString("          throw Exception('invalid op');\n")
				sb.WriteString("        }\n")
				sb.WriteString("        break;\n")
			}
			sb.WriteString("      default:\n")
			sb.WriteString("        throw Exception('invalid op');\n")
			sb.WriteString("      }\n")
		}
		sb.WriteString("    } else {\n")
		sb.WriteString("      throw Exception('invalid op');\n")
		sb.WriteString("    }\n")
		sb.WriteString("    break;\n")
	}
	sb.WriteString("  default:\n")
	sb.WriteString("    throw Exception('invalid op');\n")
	sb.WriteString("  }\n")
	sb.WriteString("}\n")
	if err := ioutil.WriteFile("lib/delta_transform_generated.dart", []byte(sb.String()), 0666); err != nil {
		panic(err)
	}

}

func genGo() {
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
