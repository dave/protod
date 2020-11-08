package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"github.com/dave/protod/packages/perr/pkg/perr"
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

func run() error {

	protoRootFlag := flag.String("root", "", "proto root")
	scalarsFlag := flag.String("scalars", "", "Scalars roots in the form [go root]:[dart root] (only needed if developing the protod library)")

	var packages PackageFlags
	flag.Var(&packages, "package", "Packages in the form [proto package root]:[go root]:[dart root]")

	flag.Parse()

	protoRoot := *protoRootFlag
	var goScalars, dartScalars string
	if parts := filepath.SplitList(*scalarsFlag); len(parts) == 2 {
		goScalars, dartScalars = parts[0], parts[1]
	}

	m := &Main{
		Root:     &Scope{Children: map[string]*Scope{}}, // Root scope is just a holder for package entities.
		Packages: map[string]*PackageData{},
	}

	if err := filepath.Walk(protoRoot, m.scanner(protoRoot)); err != nil {
		return perr.Wrap(err).Debug("scanning files")
	}

	// once the naming scopes are complete, we can go back and look up the types for all fields
	if err := m.lookupTypes(); err != nil {
		return perr.Wrap(err).Debug("looking up types")
	}

	for _, pkgFlag := range packages {
		if pkgFlag.GoPath != "" {
			if err := m.writeGo(protoRoot, pkgFlag.ProtoPath, pkgFlag.GoPath); err != nil {
				return perr.Wrap(err).Debug("writing go")
			}
		}
		if pkgFlag.DartPath != "" {
			if err := m.writeDart(protoRoot, pkgFlag.ProtoPath, pkgFlag.DartPath); err != nil {
				return perr.Wrap(err).Debug("writing dart")
			}
		}
	}

	if goScalars != "" || dartScalars != "" {
		// write scalars
		scalarsMain := &Main{
			IsScalars: true,
			Root:      Scalars.Scope, // Root scope is just a holder for package entities.
			Packages:  map[string]*PackageData{"pdelta": Scalars},
		}
		if goScalars != "" {
			if err := scalarsMain.writeGo(protoRoot, filepath.Join(protoRoot, "pdelta"), goScalars); err != nil {
				return perr.Wrap(err).Debug("writing go scalars")
			}
		}
		if dartScalars != "" {
			if err := scalarsMain.writeDart(protoRoot, filepath.Join(protoRoot, "pdelta"), dartScalars); err != nil {
				return perr.Wrap(err).Debug("writing dart scalars")
			}
		}
	}

	return nil
}

type PackageFlags []struct{ ProtoPath, GoPath, DartPath string }

func (i *PackageFlags) String() string {
	return ""
}

func (i *PackageFlags) Set(value string) error {
	var p struct{ ProtoPath, GoPath, DartPath string }
	parts := filepath.SplitList(value)
	p.ProtoPath = parts[0]
	p.GoPath = parts[1]
	p.DartPath = parts[2]
	*i = append(*i, p)
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
			Name:     "pdelta",
			Children: map[string]*Scope{},
		},
		Files:         map[string]*FileData{},
		Name:          "pdelta",
		GoPackagePath: deltaPath,
		GoPackageName: "pdelta",
		DartPackage:   "pdelta",
		DartPath:      "pdelta/pdelta",
		RelativeDir:   "pdelta",
		Scalars:       true,
	}
	s.Files["pdelta"] = &FileData{Name: "pdelta", Package: s}
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

func IsSubdirectory(parent, sub string) bool {
	up := ".." + string(os.PathSeparator)

	rel, err := filepath.Rel(parent, sub)
	if err != nil {
		return false
	}
	if !strings.HasPrefix(rel, up) && rel != ".." {
		return true
	}
	return false
}
