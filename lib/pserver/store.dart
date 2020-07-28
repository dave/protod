import 'dart:convert';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:hive/hive.dart' as hive;
import 'package:protobuf/protobuf.dart';
import 'package:protod/delta/delta.dart';
import 'package:protod/delta/delta.pb.dart';
import 'package:protod/pserver/data.pb.dart';

class Store<T extends GeneratedMessage> {
  final hive.Box<Item<T>> _box;
  final StoreAdapter<T> _adapter;
  Map<String, Item<T>> _items;
  final _rand = Random();

  Store(hive.Box<Item<T>> box, StoreAdapter<T> adapter)
      : this._box = box,
        this._adapter = adapter;

  Iterable<String> ids() {
    return _box.keys;
  }

  Item<T> add(String id, T value) {
    if (_items.containsKey(id) || _box.containsKey(id)) {
      throw Exception('document already exists');
    }

    var item = Item()
      .._store = this
      .._sending = false
      .._documentId = id
      ..value = value
      ..state = Int64(0)
      ..requestId = ''
      ..buffer = []
      ..overflow = [];

    _items[id] = item;
    _put(id, item);

    item.sendAdd();

    return item;
  }

  Future<Item<T>> get(String id) async {
    if (_items.containsKey(id)) {
      return _items[id];
    }

    if (_box.containsKey(id)) {
      var item = _box.get(id);
      item._sending = false;
      item._store = this;
      item._documentId = id;

      _items[id] = item;

      if (item.state == 0) {
        // If the server hasn't confirmed the document was added, send again.
        item.sendAdd();
      } else if (item.requestId != '') {
        // If a previous edit request was interrupted, send again.
        item.sendEdit();
      }

      return item;
    }

    final response = await _adapter.get(id);

    var item = Item()
      .._store = this
      .._sending = false
      .._documentId = id
      ..value = response.value
      ..state = response.state
      ..requestId = ''
      ..buffer = []
      ..overflow = [];

    _items[id] = item;
    _put(id, item);

    return item;
  }

  void _put(String id, Item<T> item) {
    _box.put(id, item);
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

  Store<T> _store;
  bool _sending = false;
  String _documentId = '';

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

  op(Op op) {
    // Add to buffer / overflow
    if (requestId == '') {
      buffer.add(op);
    } else {
      overflow.add(op);
    }

    // Apply to value
    apply(op, value);

    // Persist the item
    _store._put(_documentId, this);

    // Trigger the server request, if not already sending
    if (!_sending) {
      if (state == 0) {
        sendAdd();
      } else {
        sendEdit();
      }
    }
  }

  sendAdd() async {
    try {
      if (_sending) {
        // We shouldn't ever be trying to run this function concurrently, and to
        // do so would potentially corrupt data. TODO: make sure this never happens.
        throw Exception('already sending');
      }
      _sending = true;

      await _store._adapter.add(_documentId, value);
    } finally {
      // reset the sending flag even on an exception
      _sending = false;
    }

    state = Int64(1);

    // Persist the item
    _store._put(_documentId, this);

    // If operations have been added to the buffer, send them.
    if (buffer.length > 0) {
      sendEdit();
    }
  }

  sendEdit() async {
    try {
      if (_sending) {
        // We shouldn't ever be trying to run this function concurrently, and to
        // do so would potentially corrupt data. TODO: make sure this never happens.
        throw Exception('already sending');
      }
      _sending = true;

      if (state == 0) {
        throw Exception('value not added yet');
      }

      // Only create a new request id if we don't have one already.
      if (requestId == '') {
        requestId = _store.randomUnique();
      }

      // Persist the item before sending the request. If the request never returns,
      // we should use the same request ID on subsequent attempts, even after app
      // shutdown / restart.
      _store._put(_documentId, this);

      final response = await _store._adapter.edit(
        Payload_Request()
          ..id = requestId
          ..document = _documentId
          ..state = state
          ..op = compound(buffer),
      );

      if (overflow == null || overflow.length == 0) {
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
    } finally {
      // reset the sending flag even on an exception
      _sending = false;
    }

    // Persist the item
    _store._put(_documentId, this);

    // If buffer has an operation, send again.
    if (buffer.length > 0) {
      sendEdit();
    }
  }
}

abstract class StoreAdapter<T extends GeneratedMessage> {
  Future<GetResponse<T>> get(String id);
  Future<void> add(String id, T value);
  Future<Payload_Response> edit(Payload_Request payload);
}

class GetResponse<T extends GeneratedMessage> {
  final Int64 state;
  final T value;
  GetResponse(this.state, this.value);
}

class ItemAdapter<T extends GeneratedMessage>
    extends hive.TypeAdapter<Item<T>> {
  @override
  final int typeId;

  final TypeRegistry _types;

  ItemAdapter(this.typeId, this._types);

  @override
  Item<T> read(hive.BinaryReader reader) {
    final valueType = reader.readString(); // 0
    final valueBytes = reader.readByteList(); // 1
    final state = Int64(reader.readInt()); // 2
    final request = reader.readString(); // 3
    final bufferBytesList = reader.readList(); // 4
    final overflowBytesList = reader.readList(); // 5

    // unmarshal value
    T value;
    if (valueType != '') {
      final builderInfo = _types.lookup(valueType);
      if (builderInfo == null) {
        throw Exception("can't find type $valueType");
      }
      value = builderInfo.createEmptyInstance();
      unpackIntoHelper(valueBytes, value, 'type.googleapis.com/$valueType');
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
    final valueType = item.value?.info_?.qualifiedMessageName ?? '';
    final valueBytes = item.value?.writeToBuffer() ?? List<int>();
    final state = item.state?.toInt() ?? 0;
    final request = item.requestId ?? '';
    final buffer = item.buffer?.map((e) => e?.writeToBuffer())?.toList() ??
        List<List<int>>();
    final overflow = item.overflow?.map((e) => e?.writeToBuffer())?.toList() ??
        List<List<int>>();

    writer.writeString(valueType); // 0
    writer.writeByteList(valueBytes); // 1
    writer.writeInt(state); // 2
    writer.writeString(request); // 3
    writer.writeList(buffer); // 4
    writer.writeList(overflow); // 5
  }
}
