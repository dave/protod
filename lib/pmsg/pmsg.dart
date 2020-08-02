import 'package:protobuf/protobuf.dart';
import 'package:protod/google/protobuf/any.pb.dart';
import 'package:protod/pmsg/pmsg.pb.dart';

export 'pmsg.pb.dart';

extension Extensions on Bundle {
  void set(GeneratedMessage m) {
    this.messages[m.info_.qualifiedMessageName] = Any.pack(m);
  }

  bool has(GeneratedMessage m) {
    return this.messages.containsKey(m.info_.qualifiedMessageName);
  }

  T get<T extends GeneratedMessage>(T m) {
    if (!this.has(m)) {
      return null;
    }
    final name = m.info_.qualifiedMessageName;
    m = m.info_.createEmptyInstance();
    this.messages[name].unpackInto(m);
    return m;
  }
}
