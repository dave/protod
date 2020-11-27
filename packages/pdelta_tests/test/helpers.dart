import 'dart:io';

import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:protobuf/protobuf.dart';

String assetPath(String name) {
  if (Directory.current.path.endsWith("/test")) {
    // flutter tests run in the test dir?
    return "../assets/$name";
  } else {
    // intellij tests run in the project root
    return "assets/$name";
  }
}

Object toObject(GeneratedMessage msg) {
  if (msg == null) {
    return null;
  }
  var ob = msg.toProto3Json(typeRegistry: typeRegistry);
  return process(ob);
}

Object process(Object o) {
  if (o is Map) {
    Map out = {};
    o.forEach((key, value) {
      final child = process(value);
      if (child != null) {
        out[key] = child;
      }
    });
    if (out.length == 0) {
      return null;
    }
    return out;
  } else if (o is List) {
    List out = [];
    o.forEach((element) {
      final child = process(element);
      if (child != null) {
        out.add(child);
      }
    });
    if (out.length == 0) {
      return null;
    }
    return out;
  } else if (o is double) {
    if (o == 0.0) {
      return null;
    }
    return o;
  } else if (o is int) {
    if (o == 0) {
      return null;
    }
    return o;
  } else if (o is bool) {
    if (o == false) {
      return null;
    }
    return o;
  } else if (o is String) {
    if (o == "") {
      return null;
    }
    return o;
  }
  throw Exception("unknown type ${o.runtimeType} in process - need to add case to return null instead of empty value");
  //return o;
}
