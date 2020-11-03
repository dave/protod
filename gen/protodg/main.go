package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"sort"

	"github.com/dave/protod/perr"
)

func main() {
	if err := run(); err != nil {
		fmt.Printf("%+v\n", err)
		os.Exit(1)
	}
}

type Main struct {
	Root      *Scope
	Packages  map[string]*PackageData
	IsScalars bool
}

var Scalars = getScalarsPackage()

const DEBUG = false

func run() error {

	protoRootFlag := flag.String("proto-root", "", "proto input root")
	goRootFlag := flag.String("go-root", "", "go output root")
	goPkgFlag := flag.String("go-pkg", "", "go output package path")
	dartRootFlag := flag.String("dart-root", "", "dart output root")
	dartPkgFlag := flag.String("dart-pkg", "", "dart output package fragment (package name and path to root)")
	goScalarsFlag := flag.String("go-scalars", "", "go output root for scalars (only needed if developing the protod library)")
	dartScalarsFlag := flag.String("dart-scalars", "", "dart output root for scalars (only needed if developing the protod library)")

	flag.Parse()

	protoRoot := *protoRootFlag
	goRoot := *goRootFlag
	goPkg := *goPkgFlag
	dartRoot := *dartRootFlag
	dartPkg := *dartPkgFlag
	goScalars := *goScalarsFlag
	dartScalars := *dartScalarsFlag

	if DEBUG && protoRoot == "" {
		protoRoot = "/Users/dave/src/protod/delta"
	}
	if DEBUG && goRoot == "" {
		goRoot = "/Users/dave/src/protod/delta"
		goPkg = "github.com/dave/protod/delta"
	}
	if DEBUG && dartRoot == "" {
		dartRoot = "/Users/dave/src/protod/test/pb"
		dartPkg = "protod/test/pb"
	}
	if DEBUG && goScalars == "" {
		goScalars = "/Users/dave/src/protod/delta"
	}
	if DEBUG && dartScalars == "" {
		dartScalars = "/Users/dave/src/protod/lib/delta"
	}

	m := &Main{
		Root:     &Scope{Children: map[string]*Scope{}}, // Root scope is just a holder for package entities.
		Packages: map[string]*PackageData{},
	}

	// parse all the .proto files in all the directories and populate the naming scopes
	if err := filepath.Walk(protoRoot, m.scanner(protoRoot, dartPkg)); err != nil {
		return perr.Wrap(err).Debug("scanning files")
	}

	// once the naming scopes are complete, we can go back and look up the types for all fields
	if err := m.lookupTypes(); err != nil {
		return perr.Wrap(err).Debug("looking up types")
	}

	if goRoot != "" {
		if err := m.writeGo(goRoot, goPkg); err != nil {
			return perr.Wrap(err).Debug("writing go")
		}
	}

	if dartRoot != "" {
		if err := m.writeDart(dartRoot, dartPkg); err != nil {
			return perr.Wrap(err).Debug("writing dart")
		}
	}

	if goScalars != "" || dartScalars != "" {
		// write scalars
		scalarsMain := &Main{
			IsScalars: true,
			Root:      Scalars.Scope, // Root scope is just a holder for package entities.
			Packages:  map[string]*PackageData{"delta": Scalars},
		}
		if goScalars != "" {
			if err := scalarsMain.writeGo(goScalars, deltaPath); err != nil {
				return perr.Wrap(err).Debug("writing go scalars")
			}
		}
		if dartScalars != "" {
			if err := scalarsMain.writeDart(dartScalars, "protod/delta"); err != nil {
				return perr.Wrap(err).Debug("writing dart scalars")
			}
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

var protoScalarTypes = []string{
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

func getScalarsPackage() *PackageData {
	// create a special scalars package and scope, so scalar fields can point to a suitable locatable for type details
	s := &PackageData{
		Scope: &Scope{
			Parent:   &Scope{Children: map[string]*Scope{}},
			Name:     "delta",
			Children: map[string]*Scope{},
		},
		Files:         map[string]*FileData{},
		Name:          "delta",
		GoPackagePath: deltaPath,
		GoPackageName: "delta",
		DartPath:      "protod/delta",
		RelativeDir:   "/",
	}
	s.Files["delta"] = &FileData{Name: "delta", Package: s}
	s.Scope.Data = s
	for _, scalarType := range protoScalarTypes {
		scalarData := &ScalarData{
			Name: scalarType,
		}
		scalarScope := &Scope{
			Parent:   s.Scope,
			Name:     scalarType,
			Children: map[string]*Scope{},
		}
		scalarData.Scope = scalarScope
		scalarScope.Data = scalarData
		s.Scope.Children[scalarType] = scalarScope
	}
	return s
}

func (m *Main) PackagesSorted() []*PackageData {
	var out []*PackageData
	for _, pkg := range m.Packages {
		out = append(out, pkg)
	}
	sort.Slice(out, func(i, j int) bool { return out[i].DartImportAlias() < out[j].DartImportAlias() })
	return out
}
