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

typedef IsolateBridgeEntryFunc = void Function(IsoactionInternalInit action);

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
