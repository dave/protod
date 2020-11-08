package main

import (
	"fmt"
	"path/filepath"
	"sort"
	"strings"
)

type Scope struct {
	Parent   *Scope
	Name     string
	Children map[string]*Scope
	Data     Entity
}

type Entity interface{}

type PackageData struct {
	Scope         *Scope
	Files         map[string]*FileData
	Name          string
	RelativeDir   string
	GoPackagePath string
	GoPackageName string
	DartPackage   string
	DartPath      string
	Scalars       bool
}

func (d *PackageData) DartImportAlias() string {
	dartPath := strings.Join(strings.Split(filepath.ToSlash(d.DartPath), "/"), "_")
	return fmt.Sprintf("pkg_%s_%s", dartPath, d.Name)
}

type FileData struct {
	Name    string // without .proto extension
	Package *PackageData
}

func (d *PackageData) Imports() []*PackageData {
	pkgs := map[string]*PackageData{}
	for _, message := range d.Scope.Messages() {
		for _, field := range message.Fields {
			fieldPackage := field.TypeScope.Package()
			if fieldPackage == nil {
				continue
			}
			if fieldPackage.RelativeDir != d.RelativeDir {
				pkgs[field.TypeScope.Package().RelativeDir] = field.TypeScope.Package()
			}
		}
	}
	var imports []*PackageData
	for _, pkg := range pkgs {
		imports = append(imports, pkg)
	}
	sort.Slice(imports, func(i, j int) bool { return imports[i].RelativeDir < imports[j].RelativeDir })
	return imports
}

func (d *PackageData) AllImports() []*PackageData {
	imports := map[*PackageData]bool{}
	var scan func(*PackageData)
	scan = func(pd *PackageData) {
		if imports[pd] {
			return
		}
		imports[pd] = true
		for _, child := range pd.Imports() {
			scan(child)
		}
	}
	scan(d)
	var ordered []*PackageData
	for pd := range imports {
		ordered = append(ordered, pd)
	}
	sort.Slice(ordered, func(i, j int) bool { return ordered[i].RelativeDir < ordered[j].RelativeDir })
	return ordered
}

func (s *Scope) Walk(f func(Entity) error) error {
	var walker func(*Scope) error
	walker = func(current *Scope) error {
		if current == nil {
			return nil
		}
		if current.Data != nil {
			if err := f(current.Data); err != nil {
				return err
			}
		}
		for _, c := range current.Children {
			if err := walker(c); err != nil {
				return err
			}
		}
		return nil
	}
	return walker(s)
}

func (s *Scope) Lookup(name string) *Scope {
	var lookup func(*Scope, string) *Scope
	lookup = func(s *Scope, fragment string) *Scope {
		if found := s.Children[fragment]; found != nil {
			return found
		}
		if s.Parent != nil {
			return lookup(s.Parent, fragment)
		}
		return nil
	}
	parts := strings.Split(name, ".")
	scope := lookup(s, parts[0])
	if len(parts) > 1 {
		for i := 1; i < len(parts) && scope != nil; i++ {
			scope = scope.Children[parts[i]]
		}
	}
	return scope
}

func (s *Scope) Full() string {
	if s.Parent == nil {
		return ""
	}
	if s.Parent.Full() == "" {
		return s.Name
	}
	return s.Parent.Full() + "." + s.Name
}

func (s *Scope) Messages() []*MessageData {
	var messages []*MessageData
	if err := s.Walk(func(entity Entity) error {
		switch entity := entity.(type) {
		case *MessageData:
			messages = append(messages, entity)
		}
		return nil
	}); err != nil {
		panic(err)
	}
	sort.Slice(messages, func(i, j int) bool { return messages[i].GoName() < messages[j].GoName() })
	return messages
}

func (s *Scope) Locatables() []Locatable {
	var locatables []Locatable
	if err := s.Walk(func(entity Entity) error {
		switch entity := entity.(type) {
		case Locatable:
			locatables = append(locatables, entity)
		}
		return nil
	}); err != nil {
		panic(err)
	}
	sort.Slice(locatables, func(i, j int) bool { return locatables[i].GoName() < locatables[j].GoName() })
	return locatables
}

func (s *Scope) Ancestors() []*Scope {
	if s.Parent == nil {
		return []*Scope{s}
	}
	return append([]*Scope{s}, s.Parent.Ancestors()...)
}

func (s *Scope) Package() *PackageData {
	for _, scope := range s.Ancestors() {
		if pkg, ok := scope.Data.(*PackageData); ok {
			return pkg
		}
	}
	panic("package not found")
}
