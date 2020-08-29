import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:hive/hive.dart' as hive;
import 'package:protobuf/protobuf.dart';
import 'package:protod/delta/delta.dart';
import 'package:protod/delta/delta.pb.dart';

class Store<T extends GeneratedMessage> {
  final hive.Box<Item<T>> _box;
  final StoreAdapter<T> _adapter;
  final String _type;
  final TypeRegistry _registry;
  Map<String, Item<T>> _items = {};
  final _rand = Random();

  Store(
    T empty,
    hive.Box<Item<T>> box,
    StoreAdapter<T> adapter,
    TypeRegistry registry,
  )   : this._type = empty.info_.qualifiedMessageName,
        this._box = box,
        this._adapter = adapter,
        this._registry = registry;

  Iterable<String> ids() {
    return _box.keys;
  }

  Future<void> init() async {
    if (!_adapter.connected()) {
      return;
    }
    List<Future> futures = [];
    _box.keys.forEach((id) {
      if (!_items.containsKey(id)) {
        final response = _getFromBox(id);
        if (response.future != null) {
          futures.add(response.future);
        }
      }
      if (!_items.containsKey(id)) {}
    });
    await Future.wait(futures);
  }

  Response<T> _getFromBox(String id) {
    var item = _box.get(id);
    item._sending = false;
    item._store = this;
    item.id = id;

    _items[id] = item;

    if (item.state == 0 || item.requestId != '') {
      // If a previous request was interrupted, send again and return the
      // future along with the item. It is safe to use this item and continue
      // adding operations while the future is pending.

      if (!_adapter.connected()) {
        // if the device is offline, just return the item
        return Response<T>(item, null);
      }

      print("sending $id");
      final future = item.send();
      return Response<T>(item, future);
    }

    // The item is ready, and no future is needed.
    return Response<T>(item, null);
  }

  Response<T> add(String documentId, T value) {
    var item = Item<T>()
      .._store = this
      .._sending = false
      ..id = documentId
      ..value = value
      ..state = Int64(0)
      ..requestId = ""
      ..buffer = [set(null, value)]
      ..overflow = [];

    _items[documentId] = item;
    // TODO: do we need to wait for this future to finish??
    _put(documentId, item);

    if (!_adapter.connected()) {
      return Response<T>(item, null);
    }

    final future = item.send();
    return Response<T>(item, future);
  }

  bool has(String id) => _items.containsKey(id) || _box.containsKey(id);

  Future<Item<T>> refresh(String id) async {
    final response = get(id);
    if (response.future != null) {
      // item has an uncommitted change... once that is complete, item will be refreshed.
      return await response.future;
    } else if (response.item != null) {
      // item didn't have any uncommitted changes, so we trigger a refresh:
      await response.item.send();
      return response.item;
    }
    return null;
  }

  Future<void> deleteLocal(String id) async {
    _items.remove(id);
    await _box.delete(id);
  }

  Response<T> get(String id, {bool create = false}) {
    if (_items.containsKey(id)) {
      return Response<T>(_items[id], null);
    }

    if (_box.containsKey(id)) {
      return _getFromBox(id);
    }

    if (!_adapter.connected()) {
      // Item doesn't exist yet AND the device is not connected, so return null.
      return Response<T>(null, null);
    }

    // Item doesn't exist yet, so just return the future.
    final future = _sendGet(id, create: create);
    return Response<T>(null, future);
  }

  Future<Item<T>> _sendGet(String id, {bool create = false}) async {
    final response = await _adapter.get(_type, id, create, _registry);

    var item = Item<T>()
      .._store = this
      .._sending = false
      ..id = id
      ..value = response.value
      ..state = response.state
      ..requestId = ''
      ..buffer = []
      ..overflow = [];

    _items[id] = item;
    // TODO: do we need to wait for this future to finish?
    _put(id, item);

    return item;
  }

  Future<void> _put(String id, Item<T> item) async {
    await _box.put(id, item);
  }

  String randomUnique() {
    var values = List<int>.generate(16, (i) => _rand.nextInt(255));
    return base64UrlEncode(values);
  }
}

class Item<T extends GeneratedMessage> {
  // Once a request is sent, no more operations can be added to buffer, and the
  // UI would be locked. In a system with high contention, requests may take
  // some time to process. We can avoid this by using a separate overflow buffer:
  //
  //                         A -> o
  //                             / \
  //                            /   \
  //                 buffer -> /     \
  //                          /       \
  //                         /         \
  //                   B -> o           o
  //                       / \         /
  //                      /   \       /
  //         overflow -> /     \ <- response
  //                    /       \   /
  //                   /         \ /
  //             C -> o           o <- D
  //                   \         /
  //                    \       /
  //        responsex -> \     / <- overflowx
  //                      \   /
  //                       \ /
  //                   E -> o
  //
  // The original server state is [A]. Operations are recorded in [buffer] and
  // applied to value, to arrive at [B]. When the client sends the request, we
  // switch to recording operations in [overflow]. Operations are still applied
  // to value as they are created. When the server eventually responds, value is
  // at [C], but the server state is at [D]. We can transform [response] and
  // [overflow] to get [responsex] and [overflowx]. We apply [responsex] to value
  // to get to the eventual state [E]. We replace the contents of [buffer] with
  // [overflowx], and trigger another server request.

  String id = '';
  Store<T> _store;
  bool _sending = false;
  Completer<void> _current;

  // The value of the document after the operations in buffer have been applied.
  T value;

  // The state of the document when it last received an update from the server.
  Int64 state = Int64(0);

  // The state id while an edit request is in process (or retrying). If this is
  // set, we should append operations to overflow, instead of buffer.
  String requestId = '';

  // The list of pending operations that have not yet been acknowledged by the server.
  List<Op> buffer = [];

  // List of pending operations that were created after request sent
  List<Op> overflow = [];

  Future<void> op(Op op) async {
    // Add to buffer / overflow
    if (requestId == '') {
      buffer.add(op);
    } else {
      overflow.add(op);
    }

    // Apply to value
    apply(op, value);

    // Persist the item
    // TODO: do we need to wait for this future to finish?
    _store._put(id, this);

    // Trigger the server request
    await send();
  }

  Future<void> refresh() async {
    await send();
  }

  Future<Item<T>> send() async {
    if (_sending) {
      Future<Item<T>> f() async {
        await _current.future;
        return this;
      }

      return f();
    }
    if (!_store._adapter.connected()) {
      // if the device is not connected, return immediately without error.
      return this;
    }
    _sending = true;
    _current = Completer<void>();
    try {
      await _sendEdit();
    } catch (e) {
      _current.completeError(e);
      return this;
    } finally {
      _sending = false;
    }
    _current.complete();
    return this;
  }

  Future<void> _sendEdit() async {
    // Only create a new request id if we don't have one already.
    if (requestId == '') {
      requestId = _store.randomUnique();
    }

    // Persist the item before sending the request. If the request never returns,
    // we should use the same request ID on subsequent attempts, even after app
    // shutdown / restart.
    // TODO: do we need to wait for this future to finish?
    _store._put(id, this);

    final response = await _store._adapter.edit(
      _store._type,
      id,
      requestId,
      state,
      compound(buffer),
    );

    if (overflow.length == 0) {
      // Reset state
      state = response.state;

      // Apply response
      apply(response.op, value);

      // Reset buffer and request
      buffer = [];
      requestId = '';
    } else {
      // Reset state
      state = response.state;

      // Transform operations
      final responsex = transform(compound(overflow), response.op, false);
      final overflowx = transform(response.op, compound(overflow), true);

      // Apply responsex
      apply(responsex, value);

      // Replace buffer with overflowx
      buffer = [];
      if (overflowx != null) {
        buffer = [overflowx];
      }

      // reset the request and overflow
      overflow = [];
      requestId = '';
    }

    // Persist the item
    // TODO: do we need to wait for this future to finish?
    _store._put(id, this);

    // If buffer has an operation, send again.
    if (buffer.length > 0) {
      if (!_store._adapter.connected()) {
        // if the device isn't connected, don't start sending.
        return;
      }
      await _sendEdit();
    }
  }
}

class Response<T extends GeneratedMessage> {
  final Item<T> item;
  final Future<Item<T>> future;
  Response(this.item, this.future);
}

class ItemAdapter<T extends GeneratedMessage>
    extends hive.TypeAdapter<Item<T>> {
  @override
  final int typeId;

  final TypeRegistry _types;

  ItemAdapter(this.typeId, this._types);

  @override
  Item<T> read(hive.BinaryReader reader) {
    final documentType = reader.readString(); // 0
    final valueBytes = reader.readByteList(); // 1
    final state = Int64(reader.readInt()); // 2
    final request = reader.readString(); // 3
    final bufferBytesList = reader.readList(); // 4
    final overflowBytesList = reader.readList(); // 5

    // unmarshal value
    T value;
    if (documentType != '') {
      final builderInfo = _types.lookup(documentType);
      if (builderInfo == null) {
        throw Exception("can't find type $documentType");
      }
      value = builderInfo.createEmptyInstance();
      unpackIntoHelper(valueBytes, value, 'type.googleapis.com/$documentType');
    }

    // unmarshal buffer
    final buffer = bufferBytesList
        .map((e) => e == null ? null : (Op()..mergeFromBuffer(e)))
        .toList();

    // unmarshal overflow
    final overflow = overflowBytesList
        .map((e) => e == null ? null : (Op()..mergeFromBuffer(e)))
        .toList();

    return Item<T>()
      ..value = value
      ..state = state
      ..buffer = buffer
      ..requestId = request
      ..overflow = overflow;
  }

  @override
  void write(hive.BinaryWriter writer, Item<T> item) {
    final documentType = item.value?.info_?.qualifiedMessageName ?? '';
    final valueBytes = item.value?.writeToBuffer() ?? List<int>();
    final state = item.state?.toInt() ?? 0;
    final request = item.requestId ?? '';
    final buffer = item.buffer?.map((e) => e?.writeToBuffer())?.toList() ??
        List<List<int>>();
    final overflow = item.overflow?.map((e) => e?.writeToBuffer())?.toList() ??
        List<List<int>>();

    writer.writeString(documentType); // 0
    writer.writeByteList(valueBytes); // 1
    writer.writeInt(state); // 2
    writer.writeString(request); // 3
    writer.writeList(buffer); // 4
    writer.writeList(overflow); // 5
  }
}

abstract class StoreAdapter<T extends GeneratedMessage> {
  bool connected();
  Future<StoreAdapterGetResponse<T>> get(
    String documentType,
    String documentId,
    bool create,
    TypeRegistry r,
  );
//  Future<StoreAdapterAddResponse> add(
//    String documentType,
//    String documentId,
//    T value,
//  );
  Future<StoreAdapterEditResponse> edit(
    String documentType,
    String documentId,
    String stateId,
    Int64 state,
    Op op,
  );
}

class StoreAdapterGetResponse<T extends GeneratedMessage> {
  final Int64 state;
  final T value;
  StoreAdapterGetResponse(this.state, this.value);
}

class StoreAdapterEditResponse {
  final Int64 state;
  final Op op;
  StoreAdapterEditResponse(this.state, this.op);
}

//class StoreAdapterAddResponse {
//  final Int64 state;
//  StoreAdapterAddResponse(this.state);
//}
