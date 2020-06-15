package delta

import "github.com/golang/protobuf/proto"

func deleteShifter(deleteIndex int64) func(int64) int64 {
	return func(i int64) int64 {
		switch {
		case i > deleteIndex:
			return i - 1
		case i == deleteIndex:
			return i
		case i < deleteIndex:
			return i
		}
		panic("")
	}
}

func insertShifter(insertIndex int64, priority, applyPriority bool) func(int64) int64 {

	// TODO: I don't think we ever need to apply priority in this function - remove?

	return func(i int64) int64 {
		switch {
		case i > insertIndex:
			return i + 1
		case i == insertIndex:
			// only apply priority for two inserts (all other ops should be shifted if equal)
			if applyPriority {
				if priority {
					return i + 1
				} else {
					return i
				}
			} else {
				return i + 1
			}
		case i < insertIndex:
			return i
		}
		panic("")
	}
}

func renameShifter(fromKey, toKey *Key) func(*Key) *Key {
	return func(key *Key) *Key {
		if proto.Equal(fromKey, key) {
			return proto.Clone(toKey).(*Key)
		}
		return proto.Clone(key).(*Key)
	}
}

func moveShifter(fromIndex, toIndex int64, priority bool) func(int64) int64 {
	return func(i int64) int64 {
		switch {
		case fromIndex == toIndex:
			return i
		case fromIndex > toIndex:
			// items in between to and from shift forward one
			switch {
			case i > fromIndex:
				return i
			case i == fromIndex:
				return toIndex
			case i < fromIndex && i > toIndex:
				return i + 1
			case i == toIndex:
				if priority {
					return i + 1
				} else {
					return i
				}
			case i < toIndex:
				return i
			}
			panic("")
		case fromIndex < toIndex:
			// items in between to and from shift back one
			switch {
			case i > toIndex:
				return i
			case i == toIndex:
				if priority {
					return i
				} else {
					return i - 1
				}
			case i < toIndex && i > fromIndex:
				return i - 1
			case i == fromIndex:
				return toIndex
			case i < fromIndex:
				return i
			}
			panic("")
		}
		panic("")
	}
}
