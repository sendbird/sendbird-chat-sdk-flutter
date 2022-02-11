import 'dart:isolate';
import 'dart:async';

import 'isolate_bridge_def.dart';

class IsolateSlave {
  RawReceivePort? _portReceive;
  SendPort? _portTransmit;
  SendPort _masterPort;
  int _pingCount;

  IsolateSlave(IsoactionInternalInit actionInit)
      : _masterPort = actionInit.port,
        _pingCount = 1 {
    _portReceive = RawReceivePort(_processMessage);
    _portTransmit = _portReceive?.sendPort;
    //Do not reply to UX side yet, it needs to happen
    //after the parent class has fully initialized
    //Call the replyInit() inside the constructor of parent class
    _pingCount = 1;
    Timer.periodic(Duration(seconds: 30), (_) {
      var actionPing = IsoactionInternalPing();
      actionPing.count = _pingCount++;
      sendToMaster(actionPing);
    });
  }

  void replyInit(IsoactionInternalInit actionInit) {
    actionInit.port = _portTransmit!;
    _masterPort.send(actionInit);
  }

  void sendToMaster(dynamic action) {
    _masterPort.send(action);
  }

  void sendToSlave(dynamic action) {
    _portTransmit?.send(action);
  }

  void setError(String action) {
    var actionErr = IsoactionInternalError();
    actionErr.stamp = DateTime.now();
    actionErr.exec = true;
    actionErr.action = action;
    sendToMaster(actionErr);
  }

  void _processMessage(dynamic action) {
    try {
      handleMessage(action);
    } catch (e) {
      setError('Exception Thrown:' +
          e.toString() +
          '-' +
          action.runtimeType.toString());
    }
  }

  // void cleanUp() async {
  //   throw UnimplementedError('cleanUp should be overridden');
  // }

  void handleMessage(dynamic action) async {
    throw UnimplementedError('handleMessage should be overridden');
  }
}
