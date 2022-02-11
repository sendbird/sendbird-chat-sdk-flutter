import 'dart:isolate';

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
  late SendPort port;
}

class IsoactionInternalPing {
  late int count;
}

class IsoactionInternalError {
  late bool exec;
  late DateTime stamp;
  late String action;
}
