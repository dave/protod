import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protod/delta/delta.pb.dart';
import 'package:protod/pserver/pserver.dart';
import 'package:protod/pstore/pstore.pb.dart';

class Adapter<T extends GeneratedMessage> extends StoreAdapter<T> {
  final Future<R>
          Function<R extends GeneratedMessage, Q extends GeneratedMessage>(R, Q)
      _send;
  final bool Function() _connected;

  Adapter(this._send, this._connected);

  @override
  bool connected() => _connected();

  @override
  Future<StoreAdapterGetResponse<T>> get(
    String documentType,
    String documentId,
    bool create,
    TypeRegistry r,
  ) async {
    final request = Payload_Get_Request()
      ..documentType = documentType
      ..documentId = documentId
      ..create_3 = create;
    final response = await _send(Payload_Get_Response(), request);
    var value = r.lookup(documentType).createEmptyInstance();
    response.value.unpackInto(value);
    return StoreAdapterGetResponse<T>(response.state, value);
  }

  @override
  Future<StoreAdapterEditResponse> edit(
    String documentType,
    String documentId,
    String stateId,
    Int64 state,
    Op op,
  ) async {
    final request = Payload_Edit_Request()
      ..documentType = documentType
      ..documentId = documentId
      ..stateId = stateId
      ..state = state;
    if (op != null) {
      request.op = op;
    }
    final response = await _send(Payload_Edit_Response(), request);
    return StoreAdapterEditResponse(response.state, response.op);
  }

//  @override
//  Future<StoreAdapterAddResponse> add(
//    String documentType,
//    String documentId,
//    T value,
//  ) async {
//    final request = Payload_Add_Request()
//      ..documentType = documentType
//      ..documentId = documentId
//      ..value = Any.pack(value);
//    final response = await _send(request, Payload_Add_Response());
//    return StoreAdapterAddResponse(response.state);
//  }
}