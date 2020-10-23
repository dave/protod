import 'package:protod/delta/delta.dart';
import 'package:protod/delta/delta.pb.dart' as pb;
import 'package:protod/delta/delta_reduce.dart';

// pb.Op reduceGenerated(pb.Op r, pb.Op op) {
//   switch (r.type) {
//   case pb.Op_Type.Edit:
//     final rItem = item(r);
//     if (rItem.hasField_1()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rEditFieldEditField(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rEditFieldSetField(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rEditFieldDeleteField(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else if (rItem.hasIndex()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rEditIndexEditIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rEditIndexSetIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rEditIndexDeleteIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else if (rItem.hasKey()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rEditKeyEditKey(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rEditKeySetKey(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rEditKeyDeleteKey(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rEditKeyRenameKey(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else {
//       throw Exception('invalid op');
//     }
//     break;
//   case pb.Op_Type.Set:
//     final rItem = item(r);
//     if (rItem.hasField_1()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rSetFieldEditField(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rSetFieldSetField(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rSetFieldDeleteField(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else if (rItem.hasIndex()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rSetIndexEditIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rSetIndexSetIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rSetIndexDeleteIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else if (rItem.hasKey()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rSetKeyEditKey(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rSetKeySetKey(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rSetKeyDeleteKey(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rSetKeyRenameKey(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else {
//       throw Exception('invalid op');
//     }
//     break;
//   case pb.Op_Type.Insert:
//     final rItem = item(r);
//     if (rItem.hasIndex()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rInsertIndexSetIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rInsertIndexMoveIndex(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rInsertIndexDeleteIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else {
//       throw Exception('invalid op');
//     }
//     break;
//   case pb.Op_Type.Move:
//     final rItem = item(r);
//     if (rItem.hasIndex()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rMoveIndexMoveIndex(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rMoveIndexDeleteIndex(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else {
//       throw Exception('invalid op');
//     }
//     break;
//   case pb.Op_Type.Delete:
//     final rItem = item(r);
//     if (rItem.hasField_1()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else if (rItem.hasIndex()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else if (rItem.hasKey()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else if (rItem.hasOneof()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else {
//       throw Exception('invalid op');
//     }
//     break;
//   case pb.Op_Type.Rename:
//     final rItem = item(r);
//     if (rItem.hasKey()) {
//       switch (op.type) {
//       case pb.Op_Type.Edit:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Set:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Insert:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Move:
//         final opItem = item(op);
//         if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Delete:
//         final opItem = item(op);
//         if (opItem.hasField_1()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasIndex()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else if (opItem.hasOneof()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       case pb.Op_Type.Rename:
//         final opItem = item(op);
//         if (opItem.hasKey()) {
//           return rIndependent(t, op);
//         } else {
//           throw Exception('invalid op');
//         }
//         break;
//       default:
//         throw Exception('invalid op');
//       }
//     } else {
//       throw Exception('invalid op');
//     }
//     break;
//   default:
//     throw Exception('invalid op');
//   }
// }
