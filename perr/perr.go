package perr

import (
	"fmt"
)

type ReturnTypes string

const (
	Panic  ReturnTypes = "panic"
	Error  ReturnTypes = "error"
	GoWrap ReturnTypes = "gowrap"
)

const Action = Error

func Wrap(err error, s string) error {
	switch Action {
	case Panic:
		panic(err)
	case Error:
		return err
	case GoWrap:
		return fmt.Errorf(s+": %w", err)
	}
	panic("")
}

func Wrapf(err error, s string, args ...interface{}) error {
	switch Action {
	case Panic:
		panic(err)
	case Error:
		return err
	case GoWrap:
		return fmt.Errorf(s+": %w", append(args, err))
	}
	panic("")
}
