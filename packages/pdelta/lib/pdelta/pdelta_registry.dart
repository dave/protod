// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:protobuf/protobuf.dart';

/// A TypeRegistry is used to resolve Any messages in the proto3 JSON conversion.
///
/// You must provide a TypeRegistry containing all message types used in
/// Any message fields, or the JSON conversion will fail because data
/// in Any message fields is unrecognizable. You don't need to supply a
/// TypeRegistry if you don't use Any message fields.
class TypeRegistry {
  final Map<String, BuilderInfo> _mapping = {};

  TypeRegistry();

  void add(Iterable<GeneratedMessage> types) {
    _mapping.addEntries(types.map((message) => MapEntry(message.info_.qualifiedMessageName, message.info_)));
  }

  BuilderInfo lookup(String qualifiedName) {
    return _mapping[qualifiedName];
  }
}
