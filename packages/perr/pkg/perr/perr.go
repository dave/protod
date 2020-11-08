// App Engine retired their serverless memcached product, so that any version of the Go runtine after 1.11 cannot use
// it. The replacement memcached product needs a server running permanently (e.g. doesn't scale back to zero), which
// means at least $50/month of costs. Protod is designed to be deployed to a low cost zero-scaling app engine
// environment, so $50/month is unacceptable. Thus, we are stuck at Go 1.11 which means we can't use the Go 1.13 error
// wrapping extensions.
package perr

import (
	"fmt"
	"path/filepath"
	"runtime"
	"sort"
	"strings"
)

// Flags
var (
	// Busy means the OT server is busy and the client can retry the operation many times until it succeeds.
	Busy = NewFlag("busy")

	// Retry means the client can retry the operation, but only a few times (not related to the OT busy).
	Retry = NewFlag("retry")

	// Stop means this is a connection issue, and the client should go offline after retrying
	Stop = NewFlag("stop")

	// Auth means an authentication error so the client should react accordingly.
	Auth = NewFlag("auth")

	// Expired means some credentials have expired, so the client should react accordingly
	Expired = NewFlag("expired")

	// NotFound is a 404 or path not found
	NotFound = NewFlag("not found")
)

type err struct {
	inner   error
	message string
	debug   string
	file    string
	line    int
	flags   map[FlagType]bool
}

// New creates a new empty error
func New() *err {
	// must add this extra function so that runtime.Caller(2) always resolves to the right place.
	return newErr()
}

func newErr() *err {
	e := &err{flags: map[FlagType]bool{}}
	_, file, line, ok := runtime.Caller(2)
	if ok {
		e.file = file
		e.line = line
	}
	return e
}

// Message creates a new error with a user readable message
func Message(message string) *err {
	return newErr().Message(message)
}

// Messagef creates a new error with a user readable message
func Messagef(format string, args ...interface{}) *err {
	return newErr().Messagef(format, args...)
}

// Debug creates a new error with a debug string
func Debug(message string) *err {
	return newErr().Debug(message)
}

// Debugf creates a new error with a debug string
func Debugf(format string, args ...interface{}) *err {
	return newErr().Debugf(format, args...)
}

// Wrap creates a new error by wrapping an existing error.
func Wrap(inner error) *err {
	return newErr().Wrap(inner)
}

// Flag creates a new error and adds flag(s).
func Flag(flags ...FlagType) *err {
	return newErr().Flag(flags...)
}

// Message adds a human-readable message to the error
func (e *err) Message(message string) *err {
	e.message = message
	return e
}

// Messagef adds a human-readable message to the error
func (e *err) Messagef(format string, args ...interface{}) *err {
	e.message = fmt.Sprintf(format, args...)
	return e
}

// Debug adds a debug string to the error
func (e *err) Debug(message string) *err {
	e.debug = message
	return e
}

// Debugf adds a debug string to the error
func (e *err) Debugf(format string, args ...interface{}) *err {
	e.debug = fmt.Sprintf(format, args...)
	return e
}

// Wrap wraps an existing error.
func (e *err) Wrap(inner error) *err {
	e.inner = inner
	return e
}

// Flag adds flag(s) to the error.
func (e *err) Flag(flags ...FlagType) *err {
	for _, flag := range flags {
		e.flags[flag] = true
	}
	return e
}

// IsMessage returns true if there is a user readable message set.
func IsMessage(e error) bool {
	i, ok := e.(interface{ ErrorMessage() string })
	return ok && i.ErrorMessage() != ""
}

// IsDebug returns true if there is a debug string set.
func IsDebug(e error) bool {
	i, ok := e.(interface{ ErrorDebug() string })
	return ok && i.ErrorDebug() != ""
}

// Has returns true if flag is set.
func Has(flag FlagType) func(error) bool {
	return func(e error) bool {
		i, ok := e.(interface{ ErrorFlag(FlagType) bool })
		return ok && i.ErrorFlag(flag)
	}
}

func (e err) ErrorMessage() string {
	return e.message
}

func (e err) ErrorDebug() string {
	return e.debug
}

func (e err) ErrorFlag(flag FlagType) bool {
	return e.flags[flag]
}

func (e err) ErrorStack() (string, int) {
	return e.file, e.line
}

func (e err) Unwrap() error {
	return e.inner
}

func (e err) Cause() error {
	return e.inner
}

func (e err) FlagsList() []string {
	var flags []string
	for f := range e.flags {
		flags = append(flags, f.FlagDescription())
	}
	sort.Strings(flags)
	return flags
}

func (e err) Error() string {
	var out string

	if len(e.flags) > 0 {
		flags := e.FlagsList()
		if len(flags) == 1 {
			out = flags[0]
		} else {
			out = "[" + strings.Join(flags, ", ") + "]"
		}
		out += " error"
	}

	if e.message != "" {
		if out != "" {
			out += " - " + e.message
		} else {
			out += e.message
		}
	}

	if e.debug != "" {
		if out != "" {
			out += " [" + e.debug + "]"
		} else {
			out += e.debug
		}
	}

	if e.inner != nil {
		if out != "" {
			out += fmt.Sprintf(": %v", e.inner)
		} else {
			out += fmt.Sprintf("%v", e.inner)
		}
	}

	return out
}

func FirstMessage(err error) string {
	for err != nil {
		if IsMessage(err) {
			return err.(interface{ ErrorMessage() string }).ErrorMessage()
		}
		unwrapper, ok := err.(interface {
			Unwrap() error
		})
		if !ok {
			break
		}
		err = unwrapper.Unwrap()
	}
	return ""
}

func AnyFlag(err error, flag FlagType) bool {
	return Any(err, Has(flag))
}

func Any(err error, f func(error) bool) bool {
	for err != nil {
		if f(err) {
			return true
		}
		unwrapper, ok := err.(interface {
			Unwrap() error
		})
		if !ok {
			break
		}
		err = unwrapper.Unwrap()
	}
	return false
}

func Stack(err error) string {
	var out string
	for err != nil {
		if out != "" {
			out += "\n"
		}
		stack, ok := err.(interface {
			ErrorStack() (string, int)
		})
		if ok {
			fpath, line := stack.ErrorStack()
			_, fname := filepath.Split(fpath)
			out += fmt.Sprintf("%-10s - %-4s", fname, fmt.Sprint(line))
			debug, ok := err.(interface {
				ErrorDebug() string
			})
			if ok {
				out += fmt.Sprintf(" - %s", debug.ErrorDebug())
			} else {
				out += fmt.Sprintf(" - %s", err.Error())
			}
			flagsLister, ok := err.(interface {
				FlagsList() []string
			})
			if ok {
				flags := flagsLister.FlagsList()
				if len(flags) > 0 {
					out += " [" + strings.Join(flags, ", ") + "]"
				}
			}
		} else {
			out += fmt.Sprintf("%-10s - %-4s - %s", "n/a", "n/a", err.Error())
		}
		unwrapper, ok := err.(interface {
			Unwrap() error
		})
		if !ok {
			break
		}
		err = unwrapper.Unwrap()
	}
	return out
}

type FlagType interface {
	FlagDescription() string
}

func NewFlag(description string) FlagType {
	return &flag{description}
}

type flag struct {
	description string
}

func (f *flag) FlagDescription() string {
	return f.description
}
