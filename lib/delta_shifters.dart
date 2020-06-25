import 'package:protod/delta.pb.dart' as pb;

int Function(int) deleteShifter(int deleteIndex) {
  int f(int i) {
    if (i > deleteIndex) {
      return i - 1;
    } else if (i == deleteIndex) {
      return i;
    } else if (i < deleteIndex) {
      return i;
    }
  }

  return f;
}

int Function(int) insertValueShifter(int insertIndex) {
  // op: insert x at 1
  //         0 1 2 3
  // before: a b c
  //  after: a x b c
  // ------------------
  //               x y = 3 -> 4
  //             x y   = 2 -> 3
  //           x y     = 1 -> 2
  //         xy        = 0 -> 0

  int f(int i) {
    if (i > insertIndex) {
      return i + 1;
    } else if (i == insertIndex) {
      return i + 1;
    } else if (i < insertIndex) {
      return i;
    }
  }

  return f;
}

int Function(int) insertLocationShifter(
  int insertIndex,
  bool priority,
  bool usePriority,
) {
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

  int f(int i) {
    if (i > insertIndex) {
      return i + 1;
    } else if (i == insertIndex) {
      if (!usePriority) {
        throw Exception("priority disabled");
      }
      if (priority) {
        return i + 1;
      } else {
        return i;
      }
    } else if (i < insertIndex) {
      return i;
    }
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

int Function(int) moveLocationShifter(
  int fromIndex,
  int toIndex,
  bool priority,
  bool usePriority,
) {
  int f(int i) {
    if (fromIndex == toIndex) {
      return i;
    } else if (fromIndex > toIndex) {
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

      if (i > fromIndex) {
        return i;
      } else if (i == fromIndex) {
        return i + 1;
      } else if (i < fromIndex && i > toIndex) {
        return i + 1;
      } else if (i == toIndex) {
        if (!usePriority) {
          throw Exception("priority disabled");
        }
        if (priority) {
          return i + 1;
        } else {
          return i;
        }
      } else if (i < toIndex) {
        return i;
      }
    } else if (fromIndex < toIndex) {
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

      // TODO: comments to explain why we don't do toIndex-- in here too.

      if (i > toIndex) {
        return i;
      } else if (i == toIndex) {
        if (!usePriority) {
          throw Exception("priority disabled");
        }
        if (priority) {
          return i;
        } else {
          return i - 1;
        }
      } else if (i < toIndex && i > fromIndex) {
        return i - 1;
      } else if (i == fromIndex) {
        return i;
      } else if (i < fromIndex) {
        return i;
      }
    }
  }

  return f;
}

int Function(int) moveValueShifter(int fromIndex, int toIndex) {
  int f(int i) {
    if (fromIndex == toIndex) {
      return i;
    } else if (fromIndex > toIndex) {
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

      if (i > fromIndex) {
        return i;
      } else if (i == fromIndex) {
        return toIndex;
      } else if (i < fromIndex && i > toIndex) {
        return i + 1;
      } else if (i == toIndex) {
        return i + 1;
      } else if (i < toIndex) {
        return i;
      }
    } else if (fromIndex < toIndex) {
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
      toIndex--;

      // after we decrement toIndex, we have to check again for a null move
      if (fromIndex == toIndex) {
        return i;
      }

      if (i > toIndex) {
        return i;
      } else if (i == toIndex) {
        return i - 1;
      } else if (i < toIndex && i > fromIndex) {
        return i - 1;
      } else if (i == fromIndex) {
        return toIndex;
      } else if (i < fromIndex) {
        return i;
      }
    }
  }

  return f;
}
