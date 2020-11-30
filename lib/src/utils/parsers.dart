import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../message/base_message.dart';
import '../models/command.dart';

Future<Command> parseCommand(String data) async {
  return compute(parseCommandData, data);
}

Command parseCommandData(String data) {
  String cmdData = data.substring(0, 4);
  String payloadData = data.substring(4);
  Map<String, dynamic> payload = jsonDecode(payloadData);
  final cmd = Command.fromJson(payload);
  cmd.cmd = cmdData;
  cmd.payload = payload;
  return cmd;
}

Future<BaseMessage> parseMessage(Command data) async {
  return compute(parseMessageFromCommand, data);
}

BaseMessage parseMessageFromCommand(Command command) {
  final payload = command.payload;
  payload['type'] = command.cmd;
  return BaseMessage.msgFromJson(payload);
}
