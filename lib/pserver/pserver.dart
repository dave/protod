import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:hive/hive.dart' as hive;
import 'package:protobuf/protobuf.dart';
import 'package:protod/delta/delta.dart';
import 'package:protod/delta/delta.pb.dart';

class Store<T extends GeneratedMessage> {
  hive.Box<Item<T>> _box;
  hive.Box<bool> _dirty;
  final StoreAdapter<T> _adapter;
  final bool Function() _offline;
  final String _type;
  final TypeRegistry _registry;
  Map<String, Item<T>> _items = {};
  final _rand = Random();

  Store(
    T empty,
    StoreAdapter<T> adapter,
    bool Function() offline,
    TypeRegistry registry,
  )   : this._type = empty.info_.qualifiedMessageName,
        this._adapter = adapter,
        this._offline = offline,
        this._registry = registry;

  Iterable<String> ids() {
    return _box.keys;
  }

  Iterable<String> dirty() {
    // This box makes it possible to track the documents that require an update
    // without opening and parsing them all. Opening and parsing a document may
    // be an expensive process for systems with many large documents.
    return _dirty.keys;
  }

  Future<void> init() async {
    _box = await hive.Hive.openBox(this._type);
    _dirty = await hive.Hive.openBox("${this._type}:dirty");
  }

  Future<void> update() async {
    List<Future> futures = [];
    _dirty.keys.forEach((id) {
      final response = get(id, update: true);
      if (response.future != null) {
        futures.add(response.future);
      }
    });
    await Future.wait(futures);
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

    _persist(documentId, item);

    if (_offline()) {
      // if the adapter is offline, just return the item
      return Response<T>(item, null);
    }

    final future = item.send();
    return Response<T>(item, future);
  }

  bool has(String id) => _items.containsKey(id) || _box.containsKey(id);
  bool open(String id) => _items.containsKey(id);

  Future<Item<T>> refresh(String id) async {
    final response = get(id, refresh: true);
    if (response.future != null) {
      return await response.future;
    }
    if (response.item != null) {
      return response.item;
    }
    return null;
  }

  Future<void> delete(String id) async {
    _items.remove(id);
    _box.delete(id);
    _dirty.delete(id);
  }

  Response<T> get(
    String id, {
    bool create = false, // create the document if it doesn't exist
    bool update = false, // update the document if it's dirty
    bool refresh = false, // update the document even if it's not dirty
  }) {
    if (_box.containsKey(id)) {
      if (!_items.containsKey(id)) {
        _items[id] = _box.get(id);
        _items[id]._sending = false;
        _items[id]._store = this;
        _items[id].id = id;
      }

      if (refresh || (update && _items[id].dirty())) {
        // If required, send the refresh / update and return the future along
        // with the item. It is safe to use this item and continue adding
        // operations while the future is pending.
        final future = _items[id].send();
        return Response<T>(_items[id], future);
      }

      return Response<T>(_items[id], null);
    }

    Future<Item<T>> send(String id, {bool create = false}) async {
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

      _persist(id, item);

      return item;
    }

    // Item doesn't exist yet, so just return the future.
    final future = send(id, create: create);
    return Response<T>(null, future);
  }

  void _persist(String id, Item<T> item) {
    // put is async but we don't need to await, as per https://pub.dev/packages/hive
    _box.put(id, item);
    if (item.dirty()) {
      _dirty.put(id, true);
    } else {
      _dirty.delete(id);
    }
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
    _store._persist(id, this);

    // Trigger the server request
    await send();
  }

  bool dirty() {
    return state == Int64(0) ||
        requestId != "" ||
        buffer.length > 0 ||
        overflow.length > 0;
  }

  Future<void> refresh() async {
    await send();
  }

  Future<Item<T>> send() async {
    if (_sending) {
      // if this item is already sending, instead of starting a duplicate request we
      // return a future that waits for the _current Completer.
      Future<Item<T>> f() async {
        await _current.future;
        return this;
      }

      return f();
    }
    _sending = true;
    _current = Completer<void>();
    try {
      await _sendEdit();
    } catch (e) {
      _current.completeError(e);
      throw e;
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
    _store._persist(id, this);

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
    _store._persist(id, this);

    // If buffer has an operation, send again.
    if (buffer.length > 0) {
      if (_store._offline()) {
        // if the adapter is offline, don't send.
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
  Future<StoreAdapterGetResponse<T>> get(
    String documentType,
    String documentId,
    bool create,
    TypeRegistry r,
  );
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
