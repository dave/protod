import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protod/delta/delta.pb.dart';
import 'package:protod/google/protobuf/any.pb.dart';
import 'package:protod/pserver/pserver.dart';
import 'package:protod/pstore/pstore.pb.dart';

class Adapter<T extends GeneratedMessage> extends StoreAdapter<T> {
  final Future<U>
      Function<T extends GeneratedMessage, U extends GeneratedMessage>(
    T,
    U,
  ) _send;

  Adapter(this._send);

  @override
  Future<StoreAdapterGetResponse<T>> get(
    String documentType,
    String documentId,
    TypeRegistry r,
  ) async {
    final request = Payload_Get_Request()
      ..documentType = documentType
      ..documentId = documentId;
    final response = await _send(request, Payload_Get_Response());
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
      ..state = state
      ..op = op;
    final response = await _send(request, Payload_Edit_Response());
    return StoreAdapterEditResponse(response.state, response.op);
  }

  @override
  Future<void> add(
    String documentType,
    String documentId,
    T value,
  ) async {
    final request = Payload_Add_Request()
      ..documentType = documentType
      ..documentId = documentId
      ..value = Any.pack(value);
    await _send(request, null);
    return;
  }
}
