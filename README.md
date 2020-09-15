# Protocol Buffer Deltas

Operational Transformations for protocol buffers data in Dart and Go. 

See [groupshare](https://github.com/dave/groupshare) for reference implementation.

# Project layout

### delta

Lowest level package just concerned with applying and transforming operations.

### pserver

Server helper functions for implementations using Google Firestore as the persistence database.

### pstore

Uses pserver and introduces higher level abstractions for executing edit operations, refreshing snapshots etc.

### pmsg 

Convenience objects for client / server communication.

### perr

Error types allowing client to react to various types of server side error.

