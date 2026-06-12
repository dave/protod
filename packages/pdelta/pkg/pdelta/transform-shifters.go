package pdelta

func deleteShifter(deleteIndex int64, direction ShiftDirection) func(int64) (int64, PriorityType) {

	// op: delete at 1
	//         0 1 2 3
	// before: a b c d
	//  after: a c d
	// ------------------
	//             y x   = 3 -> 2
	//           y x     = 2 -> 1
	//           x       = 1*->
	//         xy        = 0 -> 0

	return func(i int64) (int64, PriorityType) {
		if direction == NORMAL {
			switch {
			case i > deleteIndex:
				return i - 1, DISABLED
			case i == deleteIndex:
				return deleteIndex, DISABLED // maybe this should panic?
			case i < deleteIndex:
				return i, DISABLED
			}
			panic("")
		} else {
			switch {
			case i > deleteIndex:
				return i + 1, DISABLED
			case i == deleteIndex:
				return deleteIndex + 1, DISABLED
			case i < deleteIndex:
				return i, DISABLED
			}
			panic("")
		}

	}
}

//func insertValueShifter(insertIndex int64, direction ShiftDirection) func(int64) int64 {
//	// op: insert x at 1
//	//         0 1 2 3
//	// before: a b c
//	//  after: a x b c
//	// ------------------
//	//               x y = 3 -> 4
//	//             x y   = 2 -> 3
//	//           x y     = 1 -> 2
//	//         xy        = 0 -> 0
//
//	return func(i int64) int64 {
//		switch {
//		case i > insertIndex:
//			if direction == NORMAL {
//				return i + 1
//			} else {
//				return i - 1
//			}
//		case i == insertIndex:
//			if direction == NORMAL {
//				return i + 1
//			} else {
//				return i - 1
//			}
//		case i < insertIndex:
//			return i
//		}
//		panic("")
//	}
//}

func insertShifter(insertIndex int64, priority PriorityType, direction ShiftDirection, target ShiftTarget) func(int64) (int64, PriorityType) {
	// op: insert x at 1
	//         0 1 2 3
	// before: a b c
	//  after: a x b c
	// ------------------
	// target == LOCATION
	// ------------------
	//               x y = 3 -> 4
	//             x y   = 2 -> 3
	//           x y     = 1*-> 2 (priority)
	//           xy      = 1*-> 1 (!priority)
	//         xy        = 0 -> 0
	// ------------------
	// target == VALUE
	// ------------------
	//               x y = 3 -> 4
	//             x y   = 2 -> 3
	//           x y     = 1*-> 2
	//         xy        = 0 -> 0

	return func(i int64) (int64, PriorityType) {
		if direction == NORMAL {
			switch {
			case i > insertIndex:
				return i + 1, DISABLED
			case i == insertIndex:
				//if target == VALUE {
				//	return insertIndex + 1, DISABLED
				//}
				switch priority {
				case DISABLED, WINNER:
					return insertIndex + 1, DISABLED
				case LOSER:
					return insertIndex, DISABLED
				}
			case i < insertIndex:
				return i, DISABLED
			}
		} else {
			switch {
			case i > insertIndex+1:
				return i - 1, DISABLED
			case i == insertIndex+1:
				if target == VALUE {
					return insertIndex, WINNER
				}
				return insertIndex, WINNER
				//if priority == DISABLED || priority == WINNER {
				//	return insertIndex
				//} else {
				//	panic("with priority loser, we never shift to insertIndex+1, so cannot reverse")
				//}
			case i == insertIndex:
				if target == VALUE {
					// TODO: is this right?
					return insertIndex, LOSER
					//panic("in target value mode, we never shift to insertIndex, so cannot reverse")
				}
				return insertIndex, LOSER
				//if priority == DISABLED || priority == WINNER {
				//	panic("with priority disabled or winner, we never shift to insertIndex, so cannot reverse")
				//} else {
				//	return insertIndex
				//}
			case i < insertIndex:
				return i, DISABLED
			}
		}

		panic("")
	}
}

// ShiftTarget determines whether we are tracking how the value moves, or how the location moves during the operation.
// For insert and delete operations, this is the same. But for move operations, when we try to shift the index of the
// value that is moved (e.g. i == fromIndex), the behaviour is different:
// target == VALUE =>    we return the new location of the value.
// target == LOCATION => we return the new location of the place the value was previously located (which might have
//
//	moved forward one if the value was moved backwards in the list).
type ShiftTarget string

const VALUE ShiftTarget = "value"
const LOCATION ShiftTarget = "location"

type ShiftDirection string

const NORMAL ShiftDirection = "normal"
const REVERSE ShiftDirection = "reverse"

type PriorityType string

const DISABLED PriorityType = "disabled"
const WINNER PriorityType = "winner"
const LOSER PriorityType = "loser"

func reversePriority(priority PriorityType) PriorityType {
	switch priority {
	case DISABLED:
		return DISABLED
	case WINNER:
		return LOSER
	case LOSER:
		return WINNER
	}
	panic("")
}

func moveShifter(fromIndex, toIndex int64, priority PriorityType, direction ShiftDirection, target ShiftTarget) func(int64) (int64, PriorityType) {
	return func(i int64) (int64, PriorityType) {
		fromIndex, toIndex := fromIndex, toIndex // make copies so we can modify without affecting subsequent calls
		switch {

		case fromIndex == toIndex || fromIndex+1 == toIndex:
			//
			// ===================================================
			//                     null move
			// ---------------------------------------------------
			//  the list is unchanged, so almost all indexes are
			//  unchanged. However, during reduce a null move
			//  produced by rebasing op2 backwards across op1 still
			//  carries gap ordering information: a location (gap)
			//  index at toIndex crossed the stationary value, so
			//  with priority it must come out on the other side of
			//  it. With priority DISABLED the shift is identity.
			// ===================================================
			if direction == NORMAL && target == LOCATION && i == toIndex {
				if fromIndex == toIndex {
					// backward crossing: with priority WINNER the gap comes out after the stationary value
					if priority == WINNER {
						return toIndex + 1, DISABLED
					}
					return toIndex, DISABLED
				}
				// forward crossing: with priority LOSER the gap comes out before the stationary value
				if priority == LOSER {
					return toIndex - 1, DISABLED
				}
				return toIndex, DISABLED
			}
			return i, DISABLED

		case toIndex < fromIndex:
			// ==================================================
			//               value moves backwards
			// ==================================================
			// so, items in between to and from shift forward one
			// ==================================================

			// 0 1 2 3 4
			// a b c D e
			// move from 3 to 1
			// a D b c e
			// ------------------
			// target == LOCATION
			// ------------------
			//         xy 4 -> 4
			//       x y  3*-> 4
			//     x y    2 -> 3
			//   x y      1*-> 2 (priority)
			//   xy       1*-> 1 (!priority)
			// xy         0 -> 0
			// -----------------
			// target == VALUE
			// -----------------
			//         xy 4 -> 4
			//   y   x    3*-> 1
			//     x y    2 -> 3
			//   x y      1*-> 2
			// xy         0 -> 0

			if direction == NORMAL {
				switch {
				case i > fromIndex:
					return i, DISABLED
				case i == fromIndex:
					if target == VALUE {
						return toIndex, DISABLED
					}
					return fromIndex + 1, DISABLED
				case i > toIndex && i < fromIndex:
					return i + 1, DISABLED
				case i == toIndex:
					if target == VALUE {
						return toIndex + 1, DISABLED
					}
					// when we're transforming two operations with the same to index, the one with priority ends up
					// at toIndex+1
					if priority == WINNER || priority == DISABLED {
						return toIndex + 1, DISABLED
					} else {
						return toIndex, DISABLED
					}
				case i < toIndex:
					return i, DISABLED
				}
				panic("")
			} else {
				switch {
				case i > fromIndex+1:
					return i, DISABLED
				case i == fromIndex+1:
					if target == VALUE {
						return i, DISABLED
					}
					// TODO: is this right?
					return fromIndex + 1, DISABLED
					//panic("in location target mode, both fromIndex and fromIndex+1 are both shifted to fromIndex+1, so can't reverse")
				case i < fromIndex+1 && i > toIndex+1:
					return i - 1, DISABLED
				case i == toIndex+1:
					if target == VALUE {
						return toIndex, WINNER
					}
					return toIndex, WINNER
					//if priority == WINNER || priority == DISABLED {
					//	return toIndex
					//} else {
					//	panic("in non-priority mode we never shift to toIndex+1, so cannot reverse")
					//}
				case i == toIndex:
					if target == VALUE {
						return fromIndex, LOSER
					}
					return toIndex, LOSER
					//if priority == WINNER || priority == DISABLED {
					//	panic("in priority mode we never shift to toIndex, so cannot reverse")
					//} else {
					//	return toIndex
					//}
				case i < toIndex:
					return i, DISABLED
				}
				panic("")
			}
		case fromIndex < toIndex:
			// ===================================================
			//               value moves forwards
			// ===================================================
			// so, items in between to and from shift backward one
			// ===================================================

			// 0 1 2 3 4 5
			// a B c d e f
			// move from 1 to 4
			// a c d B e f
			// -------------------
			// target == LOCATION
			// -------------------
			//           xy 5 -> 5
			//         xy   4* -> 4 (priority)
			//       y x    4* -> 3 (!priority)
			//     y x      3 -> 2
			//   y x        2 -> 1
			//   xy         1* -> 1
			// xy           0 -> 0
			// -------------------
			// target == VALUE
			// -------------------
			//           xy 5 -> 5
			//         xy   4* -> 4
			//     y x      3 -> 2
			//   y x        2 -> 1
			//   x   y      1* -> 3
			// xy           0 -> 0

			if direction == NORMAL {

				switch {
				case i > toIndex:
					return i, DISABLED
				case i == toIndex:
					if target == VALUE {
						// the element at toIndex shifts back one when the value is removed from earlier in the
						// list, then forward one when the value is inserted in front of it: net zero. Priority is
						// a gap-ordering concept and only applies when tracking a location.
						return toIndex, DISABLED
					}
					if priority == WINNER || priority == DISABLED {
						return toIndex, DISABLED
					} else {
						return toIndex - 1, DISABLED
					}
				case i > fromIndex+1 && i < toIndex:
					return i - 1, DISABLED
				case i == fromIndex+1:
					return fromIndex, DISABLED
				case i == fromIndex:
					if target == VALUE {
						// the target moves to toIndex, but because of the item removed from earlier in the list, the
						// index is shifted back one
						return toIndex - 1, DISABLED
					}
					return fromIndex, DISABLED
				case i < fromIndex:
					return i, DISABLED
				}
				panic("")

			} else {
				switch {
				case i > toIndex:
					return i, DISABLED
				case i == toIndex:
					if target == VALUE {
						return toIndex, WINNER
					}
					return toIndex, WINNER
					//if priority == WINNER || priority == DISABLED {
					//	return toIndex
					//} else {
					//	panic("in non-priority mode we never shift to toIndex, so cannot reverse")
					//}
				case i == toIndex-1:
					if target == VALUE {
						return fromIndex, LOSER
					}
					return toIndex, LOSER
					//if priority == WINNER || priority == DISABLED {
					//	panic("in priority mode we never shift to toIndex-1, so cannot reverse")
					//} else {
					//	return toIndex
					//}
				case i < toIndex-1 && i > fromIndex:
					return i + 1, DISABLED
				case i == fromIndex:
					if target == VALUE {
						return fromIndex + 1, DISABLED
					}
					// TODO: is this right?
					return fromIndex, DISABLED
					//panic("in location target mode, both fromIndex and fromIndex+1 are both shifted to fromIndex, so can't reverse")
				case i < fromIndex:
					return i, DISABLED
				}
				panic("")

			}
		}
		panic("")
	}
}

//func moveLocationShifter(fromIndex, toIndex int64, priority, usePriority bool, direction ShiftDirection) func(int64) int64 {
//
//	if priority && direction == REVERSE {
//		panic("with direction == REVERSE, should never use priority")
//	}
//
//	return func(i int64) int64 {
//		fromIndex, toIndex := fromIndex, toIndex // make copies so we can modify without affecting subsequent calls
//		switch {
//		case fromIndex == toIndex:
//			return i
//		case toIndex < fromIndex:
//			// items in between to and from shift forward one
//
//			// 0 1 2 3 4
//			// a b c d e
//			// move from 3 to 1
//			// a d b c e
//			//         xy 4 -> 4
//			//       x y  3 -> 4
//			//     x y    2 -> 3
//			//   x y      1 -> 2 (p)
//			//   xy       1 -> 1 (!p)
//			// xy         0 -> 0
//
//			switch {
//			case i > fromIndex:
//				return i
//			case i == fromIndex:
//				if direction == NORMAL {
//					return i + 1
//				} else {
//					return i - 1
//				}
//			case i < fromIndex && i > toIndex:
//				if direction == NORMAL {
//					return i + 1
//				} else {
//					return i - 1
//				}
//			case i == toIndex:
//				if !usePriority || direction == REVERSE {
//					// in reverse or !usePriority modes, shifting the location of the toIndex is impossible
//					panic("")
//				}
//				if priority {
//					return i + 1
//				} else {
//					return i
//				}
//			case i < toIndex:
//				return i
//			}
//			panic("")
//		case fromIndex < toIndex:
//
//			// items in between to and from shift back one
//
//			// 0 1 2 3 4 5
//			// a B c d e f
//			// move from 1 to 4
//			// a c d B e f
//			//           xy 5 -> 5
//			//         xy   4 -> 4 (p)
//			//       y x    4 -> 3 (!p)
//			//     y x      3 -> 2
//			//   y x        2 -> 1
//			//   xy         1 -> 1
//			// xy           0 -> 0
//
//			// TODO: comments to explain why we don't do toIndex-- in here too.
//
//			switch {
//			case i > toIndex:
//				return i
//			case i == toIndex:
//				if !usePriority {
//					panic("")
//				}
//				if priority {
//					return i
//				} else {
//					return i - 1
//				}
//			case i < toIndex && i > fromIndex:
//				return i - 1
//			case i == fromIndex:
//				if direction == NORMAL {
//					return i
//				} else {
//					return i + 1
//				}
//			case i < fromIndex:
//				return i
//			}
//			panic("")
//		}
//		panic("")
//	}
//}
//
//func moveValueShifter(fromIndex, toIndex int64, direction ShiftDirection) func(int64) int64 {
//	return func(i int64) int64 {
//		fromIndex, toIndex := fromIndex, toIndex // make copies so we can modify without affecting subsequent calls
//		switch {
//		case fromIndex == toIndex:
//			return i
//		case fromIndex > toIndex:
//			// items in between to and from shift forward one
//
//			// 0 1 2 3 4
//			// a b c d e
//			// move from 3 to 1
//			// a d b c e
//			//         xy 4 -> 4
//			//   y   x    3 -> 1
//			//     x y    2 -> 3
//			//   x y      1 -> 2
//			// xy         0 -> 0
//
//			switch {
//			case i > fromIndex:
//				return i
//			case i == fromIndex:
//				if direction == NORMAL {
//					return toIndex
//				} else {
//					return i - 1
//				}
//			case i < fromIndex && i > toIndex:
//				if direction == NORMAL {
//					return i + 1
//				} else {
//					return i - 1
//				}
//			case i == toIndex:
//				if direction == NORMAL {
//					return i + 1
//				} else {
//					return fromIndex
//				}
//			case i < toIndex:
//				return i
//			}
//			panic("")
//		case fromIndex < toIndex:
//
//			// items in between to and from shift back one
//
//			// 0 1 2 3 4 5
//			// a B c d e f
//			// move from 1 to 4
//			// a c d B e f
//			//           xy 5 -> 5
//			//         xy   4 -> 4
//			//     y x      3 -> 2
//			//   y x        2 -> 1
//			//   x   y      1 -> 3
//			// xy           0 -> 0
//
//			// Remember the index that the to index points to in the resultant list is toIndex-1 because it's shifted
//			// backwards by the removal of the value from earlier in the list. So we decrement toIndex.
//			toIndex--
//
//			// after we decrement toIndex, we have to check again for a null move
//			if fromIndex == toIndex {
//				return i
//			}
//
//			switch {
//			case i > toIndex:
//				return i
//			case i == toIndex:
//				if direction == NORMAL {
//					return i - 1
//				} else {
//					return fromIndex
//				}
//			case i < toIndex && i > fromIndex:
//				if direction == NORMAL {
//					return i - 1
//				} else {
//					return i + 1
//				}
//			case i == fromIndex:
//				if direction == NORMAL {
//					return toIndex
//				} else {
//					return i + 1
//				}
//			case i < fromIndex:
//				return i
//			}
//			panic("")
//		}
//		panic("")
//	}
//}
