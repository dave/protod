# CLAUDE.md - Protod Project Guidelines

## Commands
- **Build**: `go build ./...`
- **Test Go**: `go test ./...` or `go test ./packages/pdelta_tests/pkg/pdelta_tests/...`
- **Test Dart**: `cd packages/pdelta_tests && dart test`
- **Single Test**: `go test ./packages/pdelta_tests/pkg/pdelta_tests/apply_manual_test.go -run TestApplyCases/name_of_test`
- **Generate code**: `go generate ./...`

## Code Style Guidelines
- **Formatting**: Follow Go standard formatting (`gofmt`) and Dart formatting conventions
- **Imports**: Group imports (standard library, external packages, project packages)
- **Error handling**: Return errors, don't panic; check all errors
- **Naming**: CamelCase for exported symbols, camelCase for unexported; use descriptive names
- **Types**: Use protocol buffer types; check any type conversions carefully
- **Tests**: Write comprehensive tests for all functionality, both in Go and Dart
- **Comments**: Document public APIs and complex operations

## Project Structure
- Protocol Buffer definitions (.proto) in package root folders
- Generated Go code in pkg subdirectories
- Generated Dart code in lib subdirectories
- Tests in Go and Dart should cover the same functionality