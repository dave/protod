import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protod/delta/delta.pb.dart';
import 'package:protod/pserver/pserver.dart';
import 'package:protod/pstore/pstore.pb.dart';

// T: The data type
// R: response message type
// Q: request message type

class Adapter<T extends GeneratedMessage> extends StoreAdapter<T> {
  final Future<R>
      Function<R extends GeneratedMessage, Q extends GeneratedMessage>(
    R response,
    Q request,
  ) _send;

  Adapter(this._send);

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
    var value = r.lookup(documentType).createEmptyInstance() as T;
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
}
