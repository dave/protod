import 'package:protod/delta.dart';
import 'package:protod/delta.pb.dart' as pb;
import 'package:protod/delta_shifters.dart';

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
}

const LocatorTypes = [
  LocatorType.FIELD,
  LocatorType.INDEX,
  LocatorType.KEY,
];

class OpBehaviour {
  final bool itemIsDeleted;
  final bool valueIsDeleted;
  final bool valueIsLocation;
  final int Function(int) Function(pb.Op, pb.Op) indexValueShifter;
  final int Function(int) Function(pb.Op, pb.Op) indexLocationShifter;
  final pb.Key Function(pb.Key) Function(pb.Op, pb.Op) keyShifter;
  OpBehaviour({
    this.itemIsDeleted,
    this.valueIsDeleted,
    this.valueIsLocation,
    this.indexValueShifter,
    this.indexLocationShifter,
    this.keyShifter,
  });
}

final Map<OpType, Map<LocatorType, OpBehaviour>> Behaviours = {
  OpType.EDIT: {
    LocatorType.FIELD: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: null,
    ),
    LocatorType.INDEX: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: null,
    ),
    LocatorType.KEY: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: null,
    ),
  },
  OpType.SET: {
    LocatorType.FIELD: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: null,
    ),
    LocatorType.INDEX: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: null,
    ),
    LocatorType.KEY: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: null,
    ),
  },
  OpType.INSERT: {
    LocatorType.INDEX: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexValueShifter: (pb.Op t, pb.Op op) {
        return insertValueShifter(item(t).index.toInt());
      },
      indexLocationShifter: (pb.Op t, pb.Op op) {
        return insertLocationShifter(item(t).index.toInt(), false, false);
      },
      keyShifter: null,
    ),
  },
  OpType.MOVE: {
    LocatorType.INDEX: OpBehaviour(
      valueIsLocation: true,
      itemIsDeleted: false,
      valueIsDeleted: false,
      indexValueShifter: (pb.Op t, pb.Op op) {
        return moveValueShifter(item(t).index.toInt(), t.index.toInt());
      },
      indexLocationShifter: (pb.Op t, pb.Op op) {
        return moveLocationShifter(
            item(t).index.toInt(), t.index.toInt(), false, false);
      },
      keyShifter: null,
    ),
  },
  OpType.RENAME: {
    LocatorType.KEY: OpBehaviour(
      valueIsLocation: true,
      itemIsDeleted: false,
      valueIsDeleted: true,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: (pb.Op t, pb.Op op) {
        return renameShifter(item(t).key, op.key);
      },
    ),
  },
  OpType.DELETE: {
    LocatorType.FIELD: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexValueShifter: null,
      indexLocationShifter: null,
      keyShifter: null,
    ),
    LocatorType.INDEX: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: true,
      valueIsDeleted: false,
      indexValueShifter: (pb.Op t, pb.Op op) {
        return deleteShifter(item(t).index.toInt());
      },
      indexLocationShifter: (pb.Op t, pb.Op op) {
        return deleteShifter(item(t).index.toInt());
      },
      keyShifter: null,
    ),
    LocatorType.KEY: OpBehaviour(
      valueIsLocation: false,
      itemIsDeleted: false,
      valueIsDeleted: true,
      indexValueShifter: null,
      indexLocationShifter: null,
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
  } else {
    throw Exception("invalid op");
  }
  return Behaviours[opType][locatorType];
}
