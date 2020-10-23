package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {
	if err := run(); err != nil {
		fmt.Printf("%+v\n", err)
		os.Exit(1)
	}
}

func run() error {
	in := *flag.String("in", "", "proto root")
	if in == "" {
		in = "/Users/dave/src/protod/delta/tests"
	}

	s := &Holder{
		Root: &Scope{Children: map[string]*Scope{}}, // Root scope is just a holder for package entities.
	}

	return nil
}

type Holder struct {
	Root     *Scope
	Packages map[string]PackageData
}

type Scope struct {
	Name     string
	Parent   *Scope
	Children map[string]*Scope
	Data     EntityData
}

type EntityData interface{}

type PackageData struct {
	Name  string
	Scope *Scope
	// ...
}
type MessageData struct {
	Name  string
	Scope *Scope
	// ...
}
type FieldData struct {
	Name  string
	Scope *Scope
	// ...
}
type EnumData struct {
	Name  string
	Scope *Scope
	// ...
}
