import 'dart:isolate';
import 'dart:async';

import 'isolate_bridge_def.dart';

class IsolateMaster {
  //Major properties
  IsoBridgeStatus _status = IsoBridgeStatus.none;
  //NOTE: @Mark why list of error
  late List<IsoactionInternalError> _errors;

  //Stream processing
  late RawReceivePort _receivePortForUxIsolate;
  Isolate? _isolate;
  late SendPort _sendPortForExecIsolate;
  late DateTime _pingLastStamp;
  late int _pingCount;
  late IsolateBridgeEntryFunc _entryFunc;

  //Constructor
  IsolateMaster(IsolateBridgeEntryFunc cb) {
    _status = IsoBridgeStatus.init;
    _entryFunc = cb;
    _receivePortForUxIsolate = RawReceivePort(_processAction);
    _sendPortForExecIsolate = _receivePortForUxIsolate
        .sendPort; //Temporary assignment for early callers
    _errors = <IsoactionInternalError>[];
    _pingLastStamp = DateTime.now();
    _pingCount = 0;
    Timer.run(initialize);
  }

  void initialize() async {
    _status = IsoBridgeStatus.execwait;
    var actionInit = IsoactionInternalInit();
    actionInit.port = _receivePortForUxIsolate.sendPort;

    //Allows for single isolate operations for developer convenience
    // _entryFunc(actionInit);
    //return;

    try {
      _isolate = await Isolate.spawn(
        _entryFunc,
        actionInit,
        paused: false,
        errorsAreFatal: false,
        debugName: 'Exec',
      );
      return;
    } catch (except) {
      _setError('Exception:' + except.toString());
    }
    _status = IsoBridgeStatus.error;
  }

  FutureOr<void> shutdown() async {
    switch (_status) {
      case IsoBridgeStatus.error:
        break;
      case IsoBridgeStatus.execwait:
        break;
      case IsoBridgeStatus.running:
        break;
      default:
        return null;
    }
    if (_isolate != null) {
      //clean up isolate part
      // _sendExec.send(ShutdownAction());
      //wait to finish cleanup
      _isolate?.kill(priority: Isolate.immediate);
      _isolate = null;
    }
    _status = IsoBridgeStatus.shutdown;
  }

  void sendToMaster(dynamic action) {
    _receivePortForUxIsolate.sendPort.send(action);
  }

  void sendToSlave(dynamic action) {
    _sendPortForExecIsolate.send(action);
  }

  void _setError(String action) {
    var actionErr = IsoactionInternalError();
    actionErr.exec = false;
    actionErr.action = action;
    _errors.add(actionErr);
  }

  void _processAction(dynamic action) async {
    switch (action.runtimeType) {
      case IsoactionInternalInit:
        _sendPortForExecIsolate = (action as IsoactionInternalInit).port;
        _status = IsoBridgeStatus.running;
        didInitialize();
        return;
      case IsoactionInternalPing:
        _pingLastStamp = DateTime.now();
        _pingCount++;
        return;
      case IsoactionInternalError:
        _errors.add(action);
        //NOTE:Maybe add trigger error signal externally?
        return;
    }

    try {
      handleMessage(action);
    } catch (exception) {
      _setError('Exception:' +
          exception.toString() +
          '-' +
          action.runtimeType.toString());
    }
  }

  FutureOr<IsoBridgeStatus> waitStatus(
    int msecs, [
    IsoBridgeStatus ref = IsoBridgeStatus.none,
  ]) async {
    var current = _status;
    if (current == ref) {
      return current;
    }
    if (_errors.isNotEmpty) {
      return IsoBridgeStatus.error;
    }
    var total = 0;
    while (_status != ref) {
      await Future.delayed(Duration(milliseconds: 10));
      if (_errors.isNotEmpty) {
        return IsoBridgeStatus.error;
      }
      total += 10;
      if (total <= msecs) {
        continue;
      }
      return IsoBridgeStatus.nochange;
    }
    return _status;
  }

  //Overrideable functions
  void handleMessage(dynamic action) async {
    throw UnimplementedError();
  }

  void handleError(String action) async {}

  void didInitialize() async {}

  int pingCount() {
    return _pingCount;
  }

  DateTime pingLast() {
    return _pingLastStamp;
  }
}
