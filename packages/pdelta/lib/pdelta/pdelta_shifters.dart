import 'package:pdelta/pdelta/pdelta.pb.dart' as pb;

// ShiftTarget determines whether we are tracking how the value moves, or how the location moves during the operation.
// For insert and delete operations, this is the same. But for move operations, when we try to shift the index of the
// value that is moved (e.g. i == fromIndex), the behaviour is different:
// target == VALUE =>    we return the new location of the value.
// target == LOCATION => we return the new location of the place the value was previously located (which might have
//                       moved forward one if the value was moved backwards in the list).
enum ShiftTarget {
  VALUE,
  LOCATION,
}

enum ShiftDirection {
  NORMAL,
  REVERSE,
}

enum PriorityType {
  DISABLED,
  WINNER,
  LOSER,
}

PriorityType reversePriority(PriorityType priority) {
  switch (priority) {
    case PriorityType.DISABLED:
      return PriorityType.DISABLED;
    case PriorityType.WINNER:
      return PriorityType.LOSER;
    case PriorityType.LOSER:
      return PriorityType.WINNER;
  }
  throw Exception("");
}

class Shift {
  final int index;
  final PriorityType priority;
  Shift(this.index, this.priority);
}

Shift Function(int) deleteShifter(int deleteIndex, ShiftDirection direction) {
  // op: delete at 1
  //         0 1 2 3
  // before: a b c d
  //  after: a c d
  // ------------------
  //             y x   = 3 -> 2
  //           y x     = 2 -> 1
  //           x       = 1*->
  //         xy        = 0 -> 0

  Shift f(int i) {
    if (direction == ShiftDirection.NORMAL) {
      if (i > deleteIndex) {
        return Shift(i - 1, PriorityType.DISABLED);
      } else if (i == deleteIndex) {
        return Shift(deleteIndex, PriorityType.DISABLED); // maybe this should panic?
      } else {
        return Shift(i, PriorityType.DISABLED);
      }
    } else {
      if (i > deleteIndex) {
        return Shift(i + 1, PriorityType.DISABLED);
      } else if (i == deleteIndex) {
        return Shift(deleteIndex + 1, PriorityType.DISABLED);
      } else {
        return Shift(i, PriorityType.DISABLED);
      }
    }
  }

  return f;
}

Shift Function(int) insertShifter(int insertIndex, PriorityType priority, ShiftDirection direction, ShiftTarget target) {
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

  Shift f(int i) {
    if (direction == ShiftDirection.NORMAL) {
      if (i > insertIndex) {
        return Shift(i + 1, PriorityType.DISABLED);
      } else if (i == insertIndex) {
        switch (priority) {
          case PriorityType.DISABLED:
          case PriorityType.WINNER:
            return Shift(insertIndex + 1, PriorityType.DISABLED);
          case PriorityType.LOSER:
            return Shift(insertIndex, PriorityType.DISABLED);
        }
      } else if (i < insertIndex) {
        return Shift(i, PriorityType.DISABLED);
      }
    } else {
      if (i > insertIndex + 1) {
        return Shift(i - 1, PriorityType.DISABLED);
      } else if (i == insertIndex + 1) {
        return Shift(insertIndex, PriorityType.WINNER);
      } else if (i == insertIndex) {
        return Shift(insertIndex, PriorityType.LOSER);
      } else if (i < insertIndex) {
        return Shift(i, PriorityType.DISABLED);
      }
    }
    throw Exception("");
  }

  return f;
}

Shift Function(int) moveShifter(int fromIndex, int toIndex, PriorityType priority, ShiftDirection direction, ShiftTarget target) {
  Shift f(int i) {
    if (fromIndex == toIndex || fromIndex + 1 == toIndex) {
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
      if (direction == ShiftDirection.NORMAL && target == ShiftTarget.LOCATION && i == toIndex) {
        if (fromIndex == toIndex) {
          // backward crossing: with priority WINNER the gap comes out after the stationary value
          if (priority == PriorityType.WINNER) {
            return Shift(toIndex + 1, PriorityType.DISABLED);
          }
          return Shift(toIndex, PriorityType.DISABLED);
        }
        // forward crossing: with priority LOSER the gap comes out before the stationary value
        if (priority == PriorityType.LOSER) {
          return Shift(toIndex - 1, PriorityType.DISABLED);
        }
        return Shift(toIndex, PriorityType.DISABLED);
      }
      return Shift(i, PriorityType.DISABLED);
    } else if (toIndex < fromIndex) {
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

      if (direction == ShiftDirection.NORMAL) {
        if (i > fromIndex) {
          return Shift(i, PriorityType.DISABLED);
        } else if (i == fromIndex) {
          if (target == ShiftTarget.VALUE) {
            return Shift(toIndex, PriorityType.DISABLED);
          }
          return Shift(fromIndex + 1, PriorityType.DISABLED);
        } else if (i > toIndex && i < fromIndex) {
          return Shift(i + 1, PriorityType.DISABLED);
        } else if (i == toIndex) {
          if (target == ShiftTarget.VALUE) {
            return Shift(toIndex + 1, PriorityType.DISABLED);
          }
          // when we're transforming two operations with the same to index, the one with priority ends up
          // at toIndex+1
          if (priority == PriorityType.WINNER || priority == PriorityType.DISABLED) {
            return Shift(toIndex + 1, PriorityType.DISABLED);
          } else {
            return Shift(toIndex, PriorityType.DISABLED);
          }
        } else if (i < toIndex) {
          return Shift(i, PriorityType.DISABLED);
        }
        throw Exception("");
      } else {
        if (i > fromIndex + 1) {
          return Shift(i, PriorityType.DISABLED);
        } else if (i == fromIndex + 1) {
          if (target == ShiftTarget.VALUE) {
            return Shift(i, PriorityType.DISABLED);
          }
          return Shift(fromIndex + 1, PriorityType.DISABLED);
        } else if (i < fromIndex + 1 && i > toIndex + 1) {
          return Shift(i - 1, PriorityType.DISABLED);
        } else if (i == toIndex + 1) {
          return Shift(toIndex, PriorityType.WINNER);
        } else if (i == toIndex) {
          if (target == ShiftTarget.VALUE) {
            return Shift(fromIndex, PriorityType.LOSER);
          }
          return Shift(toIndex, PriorityType.LOSER);
        } else if (i < toIndex) {
          return Shift(i, PriorityType.DISABLED);
        }
        throw Exception("");
      }
    } else if (fromIndex < toIndex) {
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

      if (direction == ShiftDirection.NORMAL) {
        if (i > toIndex) {
          return Shift(i, PriorityType.DISABLED);
        } else if (i == toIndex) {
          if (target == ShiftTarget.VALUE) {
            // the element at toIndex shifts back one when the value is removed from earlier in the
            // list, then forward one when the value is inserted in front of it: net zero. Priority is
            // a gap-ordering concept and only applies when tracking a location.
            return Shift(toIndex, PriorityType.DISABLED);
          }
          if (priority == PriorityType.WINNER || priority == PriorityType.DISABLED) {
            return Shift(toIndex, PriorityType.DISABLED);
          } else {
            return Shift(toIndex - 1, PriorityType.DISABLED);
          }
        } else if (i > fromIndex + 1 && i < toIndex) {
          return Shift(i - 1, PriorityType.DISABLED);
        } else if (i == fromIndex + 1) {
          return Shift(fromIndex, PriorityType.DISABLED);
        } else if (i == fromIndex) {
          if (target == ShiftTarget.VALUE) {
            // the target moves to toIndex, but because of the item removed from earlier in the list, the
            // index is shifted back one
            return Shift(toIndex - 1, PriorityType.DISABLED);
          }
          return Shift(fromIndex, PriorityType.DISABLED);
        } else if (i < fromIndex) {
          return Shift(i, PriorityType.DISABLED);
        }
        throw Exception("");
      } else {
        if (i > toIndex) {
          return Shift(i, PriorityType.DISABLED);
        } else if (i == toIndex) {
          return Shift(toIndex, PriorityType.WINNER);
        } else if (i == toIndex - 1) {
          if (target == ShiftTarget.VALUE) {
            return Shift(fromIndex, PriorityType.LOSER);
          }
          return Shift(toIndex, PriorityType.LOSER);
        } else if (i < toIndex - 1 && i > fromIndex) {
          return Shift(i + 1, PriorityType.DISABLED);
        } else if (i == fromIndex) {
          if (target == ShiftTarget.VALUE) {
            return Shift(fromIndex + 1, PriorityType.DISABLED);
          }
          return Shift(fromIndex, PriorityType.DISABLED);
        } else if (i < fromIndex) {
          return Shift(i, PriorityType.DISABLED);
        }
        throw Exception("");
      }
    }
    throw Exception("");
  }

  return f;
}

pb.Key Function(pb.Key) renameShifter(pb.Key fromKey, pb.Key toKey) {
  pb.Key f(pb.Key key) {
    if (fromKey == key) {
      return toKey.clone();
    }
    return key.clone();
  }

  return f;
}
