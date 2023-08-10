import 'dart:convert';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/command.dart';
// import 'package:sendbird_sdk/request/abstract/ws_event.dart';

// Future<WsEvent?> parseEventCommand(String data) async {
//   return compute(parseEventData, data);
// }

// WsEvent? parseEventData(String data) {
//   final cmd = data.substring(0, 4);
//   final payloadData = data.substring(4);
//   final payload = jsonDecode(payloadData);
//   return WsEvent.fromJson(cmd, payload);
// }

Future<Command> parseCommand(String data) async {
  return await parseCommandData(data);
}

Command parseCommandData(String data) {
  final payloadData = data.substring(4);
  final payload = jsonDecode(payloadData);
  payload['cmd'] = data.substring(0, 4);
  final ret = Command.fromJson(payload);
  ret.payload = payload;
  return ret;
}

Future<BaseMessage?> parseMessageData(Map<String, dynamic> data) async {
  return await parseMessageFromData(data);
}

BaseMessage? parseMessageFromData(Map<String, dynamic> data) {
  return BaseMessage.msgFromJson(data, type: data['cmd']);
}

Future<BaseMessage?> parseMessage(Command? data) async {
  return await parseMessageFromCommand(data);
}

BaseMessage? parseMessageFromCommand(Command? command) {
  if (command == null) return null;
  final payload = command.payload;
  return BaseMessage.msgFromJson(payload, type: command.cmd);
}
