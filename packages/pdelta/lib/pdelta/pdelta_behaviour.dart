import 'package:pdelta/pdelta/pdelta.dart';
import 'package:pdelta/pdelta/pdelta.pb.dart' as pb;
import 'package:pdelta/pdelta/pdelta_shifters.dart';

enum OpType {
  EDIT,
  SET,
  INSERT,
  MOVE,
  DELETE,
  RENAME,
}

const OpTypes = [
  OpType.EDIT,
  OpType.SET,
  OpType.INSERT,
  OpType.MOVE,
  OpType.DELETE,
  OpType.RENAME,
];

enum LocatorType {
  FIELD,
  INDEX,
  KEY,
  ONEOF,
}

const LocatorTypes = [
  LocatorType.FIELD,
  LocatorType.INDEX,
  LocatorType.KEY,
  LocatorType.ONEOF,
];

class OpBehaviour {
  final OpType opType;
  final LocatorType locatorType;
  final bool itemIsDeleted;
  final bool valueIsDeleted;
  final bool valueIsLocation;
  final Shift Function(int) Function(pb.Op, PriorityType, ShiftDirection, ShiftTarget) indexShifter;
  final pb.Key Function(pb.Key) Function(pb.Op, pb.Op) keyShifter;

  OpBehaviour({
    this.opType,
    this.locatorType,
    this.itemIsDeleted,
    this.valueIsDeleted,
    this.valueIsLocation,
    this.indexShifter,
    this.keyShifter,
  });

  ShiftTarget get shiftTarget => opType == OpType.INSERT ? ShiftTarget.LOCATION : ShiftTarget.VALUE;
}

final Map<OpType, Map<LocatorType, OpBehaviour>> Behaviours = {
  OpType.EDIT: {
    LocatorType.FIELD: OpBehaviour(
      opType: OpType.EDIT,
      locatorType: LocatorType.FIELD,
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
    LocatorType.INDEX: OpBehaviour(
      opType: OpType.EDIT,
      locatorType: LocatorType.INDEX,
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
    LocatorType.KEY: OpBehaviour(
      opType: OpType.EDIT,
      locatorType: LocatorType.KEY,
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
  },
  OpType.SET: {
    LocatorType.FIELD: OpBehaviour(
      opType: OpType.SET,
      locatorType: LocatorType.FIELD,
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
    LocatorType.INDEX: OpBehaviour(
      opType: OpType.SET,
      locatorType: LocatorType.INDEX,
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
    LocatorType.KEY: OpBehaviour(
      opType: OpType.SET,
      locatorType: LocatorType.KEY,
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
  },
  OpType.INSERT: {
    LocatorType.INDEX: OpBehaviour(
      opType: OpType.INSERT,
      locatorType: LocatorType.INDEX,
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexShifter: (pb.Op t, PriorityType priority, ShiftDirection direction, ShiftTarget target) {
        return insertShifter(item(t).index.toInt(), priority, direction, target);
      },
      keyShifter: null,
    ),
  },
  OpType.MOVE: {
    LocatorType.INDEX: OpBehaviour(
      opType: OpType.MOVE,
      locatorType: LocatorType.INDEX,
      valueIsLocation: true,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexShifter: (pb.Op t, PriorityType priority, ShiftDirection direction, ShiftTarget target) {
        return moveShifter(item(t).index.toInt(), t.index.toInt(), priority, direction, target);
      },
      keyShifter: null,
    ),
  },
  OpType.RENAME: {
    LocatorType.KEY: OpBehaviour(
      opType: OpType.RENAME,
      locatorType: LocatorType.KEY,
      valueIsLocation: true,
      itemIsDeleted: false,
      valueIsDeleted: true,
      indexShifter: null,
      keyShifter: (pb.Op t, pb.Op op) {
        return renameShifter(item(t).key, t.key);
      },
    ),
  },
  OpType.DELETE: {
    LocatorType.FIELD: OpBehaviour(
      opType: OpType.DELETE,
      locatorType: LocatorType.FIELD,
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
    LocatorType.INDEX: OpBehaviour(
      opType: OpType.DELETE,
      locatorType: LocatorType.INDEX,
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexShifter: (pb.Op t, PriorityType priority, ShiftDirection direction, ShiftTarget target) {
        return deleteShifter(item(t).index.toInt(), direction);
      },
      keyShifter: null,
    ),
    LocatorType.KEY: OpBehaviour(
      opType: OpType.DELETE,
      locatorType: LocatorType.KEY,
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
    LocatorType.ONEOF: OpBehaviour(
      opType: OpType.DELETE,
      locatorType: LocatorType.ONEOF,
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexShifter: null,
      keyShifter: null,
    ),
  },
};

OpBehaviour getBehaviour(pb.Op op) {
  OpType opType;
  LocatorType locatorType;
  switch (op.type) {
    case pb.Op_Type.Edit:
      opType = OpType.EDIT;
      break;
    case pb.Op_Type.Set:
      opType = OpType.SET;
      break;
    case pb.Op_Type.Insert:
      opType = OpType.INSERT;
      break;
    case pb.Op_Type.Move:
      opType = OpType.MOVE;
      break;
    case pb.Op_Type.Rename:
      opType = OpType.RENAME;
      break;
    case pb.Op_Type.Delete:
      opType = OpType.DELETE;
      break;
    default:
      throw Exception("invalid op");
  }
  final itm = item(op);
  if (itm.hasField_1()) {
    locatorType = LocatorType.FIELD;
  } else if (itm.hasIndex()) {
    locatorType = LocatorType.INDEX;
  } else if (itm.hasKey()) {
    locatorType = LocatorType.KEY;
  } else if (itm.hasOneof()) {
    locatorType = LocatorType.ONEOF;
  } else {
    throw Exception("invalid op");
  }
  return Behaviours[opType][locatorType];
}
