//import 'dart:io';
import 'dart:isolate';
//import 'dart:async';

enum IsoBridgeStatus {
  none,
  error,
  nochange,
  init,
  execwait,
  running,
  shutdown,
}

typedef void IsolateBridgeEntryFunc(IsoactionInternalInit action);

class IsoactionInternalInit {
  SendPort port;
}

class IsoactionInternalPing {
  int count;
}

class IsoactionInternalError {
  bool exec;
  DateTime stamp;
  String action;
}
