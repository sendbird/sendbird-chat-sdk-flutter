import 'dart:convert';
import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:uuid/uuid.dart';

abstract class WsRequest {
  String cmd = '';
  Map<String, dynamic> payload = {};
  String? requestId;

  WsRequest({this.requestId}) {
    payload['req_id'] = requestId ?? Uuid().v1();
  }

  String get encoded => cmd + jsonEncode(payload) + '\n';

  bool get isAckRequired =>
      CommandString.isUserMessage(cmd) ||
      CommandString.isFileMessage(cmd) ||
      cmd == CommandString.enter ||
      cmd == CommandString.exit ||
      cmd == CommandString.read;
}

// abstract class WsEvent {
//   String cmd = '';
//   Map<String, dynamic> payload = {};
//   String? requestId;
//   Command? data;

//   // @JsonKey(name: 'ts')
//   // final int? timestamp;

//   // @JsonKey(name: 'code')
//   // final int? errorCode;

//   // @JsonKey(name: 'message')
//   // final String? errorMessage;

//   // final bool? requireAuth;

//   WsEvent({this.requestId});

//   Future<dynamic> handleEvent(SendbirdSdkInternal sdk);

//   static WsEvent? fromJson(String cmd, Map<String, dynamic> json) {
//     if (cmd == CommandString.userMessage || cmd == CommandString.fileMessage) {
//       return NewMessageEvent.fromJson(json);
//     } else if (cmd == CommandString.userMessageUpdate ||
//         cmd == CommandString.fileMessageUpdate) {
//       return UpdateMessageEvent.fromJson(json);
//     }

//     ///...

//     return null;
//   }
// }
