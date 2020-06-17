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

func insertValueShifter(insertIndex int64) func(int64) int64 {

	// op: insert x at 1
	//         0 1 2 3
	// before: a b c
	//  after: a x b c
	// ------------------
	//               x y = 3 -> 4
	//             x y   = 2 -> 3
	//           x y     = 1 -> 2
	//         xy        = 0 -> 0

	return func(i int64) int64 {
		switch {
		case i > insertIndex:
			return i + 1
		case i == insertIndex:
			return i + 1
		case i < insertIndex:
			return i
		}
		panic("")
	}
}

func insertLocationShifter(insertIndex int64, priority, usePriority bool) func(int64) int64 {

	// op: insert x at 1
	//         0 1 2 3
	// before: a b c
	//  after: a x b c
	// ------------------
	//               x y = 3 -> 4
	//             x y   = 2 -> 3
	//           x y     = 1 -> 2 (p)
	//           xy      = 1 -> 1 (!p)
	//         xy

	return func(i int64) int64 {
		switch {
		case i > insertIndex:
			return i + 1
		case i == insertIndex:
			if !usePriority {
				panic("")
			}
			if priority {
				return i + 1
			} else {
				return i
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

func moveLocationShifter(fromIndex, toIndex int64, priority, usePriority bool) func(int64) int64 {

	return func(i int64) int64 {
		switch {
		case fromIndex == toIndex:
			return i
		case fromIndex > toIndex:
			// items in between to and from shift forward one

			// 0 1 2 3 4
			// a b c d e
			// move from 3 to 1
			// a d b c e
			//         xy 4 -> 4
			//       x y  3 -> 4
			//     x y    2 -> 3
			//   x y      1 -> 2 (p)
			//   xy       1 -> 1 (!p)
			// xy         0 -> 0

			switch {
			case i > fromIndex:
				return i
			case i == fromIndex:
				return i + 1
			case i < fromIndex && i > toIndex:
				return i + 1
			case i == toIndex:
				if !usePriority {
					panic("")
				}
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

			// 0 1 2 3 4 5
			// a B c d e f
			// move from 1 to 4
			// a c d B e f
			//           xy 5 -> 5
			//         xy   4 -> 4 (p)
			//       y x    4 -> 3 (!p)
			//     y x      3 -> 2
			//   y x        2 -> 1
			//   xy         1 -> 1
			// xy           0 -> 0

			switch {
			case i > toIndex:
				return i
			case i == toIndex:
				if !usePriority {
					panic("")
				}
				if priority {
					return i
				} else {
					return i - 1
				}
			case i < toIndex && i > fromIndex:
				return i - 1
			case i == fromIndex:
				return i
			case i < fromIndex:
				return i
			}
			panic("")
		}
		panic("")
	}
}

func moveValueShifter(fromIndex, toIndex int64) func(int64) int64 {
	return func(i int64) int64 {
		switch {
		case fromIndex == toIndex:
			return i
		case fromIndex > toIndex:
			// items in between to and from shift forward one

			// 0 1 2 3 4
			// a b c d e
			// move from 3 to 1
			// a d b c e
			//         xy 4 -> 4
			//   y   x    3 -> 1
			//     x y    2 -> 3
			//   x y      1 -> 2
			// xy         0 -> 0

			switch {
			case i > fromIndex:
				return i
			case i == fromIndex:
				return toIndex
			case i < fromIndex && i > toIndex:
				return i + 1
			case i == toIndex:
				return i + 1
			case i < toIndex:
				return i
			}
			panic("")
		case fromIndex < toIndex:

			// items in between to and from shift back one

			// 0 1 2 3 4 5
			// a B c d e f
			// move from 1 to 4
			// a c d B e f
			//           xy 5 -> 5
			//         xy   4 -> 4
			//     y x      3 -> 2
			//   y x        2 -> 1
			//   x   y      1 -> 3
			// xy           0 -> 0

			// Remember the index that the to index points to in the resultant list is toIndex-1 because it's shifted
			// backwards by the removal of the value from earlier in the list. So we decrement toIndex.
			toIndex--

			// after we decrement toIndex, we have to check again for a null move
			if fromIndex == toIndex {
				return i
			}

			switch {
			case i > toIndex:
				return i
			case i == toIndex:
				return i - 1
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
