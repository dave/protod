import 'dart:io';

import 'package:pdelta/pdelta/pdelta.dart';
import 'package:pdelta/pdelta/pdelta_reduce.dart';
import 'package:pdelta_tests/pdelta_tests/pdelta_tests.op.dart';
import 'package:pdelta_tests/pdelta_tests/tests.pb.dart';
import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart' hide isNull;

String assetPath(String name) {
  if (Directory.current.path.endsWith("/test")) {
    // flutter tests run in the test dir?
    return "../assets/$name";
  } else {
    // intellij tests run in the project root
    return "assets/$name";
  }
}

// runReduceCase mirrors the Go runReduceCase in reduce_manual_test.go: the reduced op is validated by applying it
// to the data and comparing with the result of applying the original op, rather than by comparing the op
// structures directly.
void runReduceCase(ReduceTestCase info) {
  final data1 = info.data.clone();
  final data2 = info.data.clone();
  final data3 = info.data.clone();
  final opMerged = reduce(info.op);
  apply(info.op, data1);
  if (!isNull(opMerged)) {
    apply(opMerged, data2);
  }
  if (info.hasReduced() && !isNull(info.reduced)) {
    apply(info.reduced, data3);
  }
  expect(toObject(data3), toObject(data1), reason: "${info.name}: result of applying op does not match expected");
  expect(toObject(data2), toObject(data1), reason: "${info.name}: result of applying reduced op does not match");
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
