import 'package:json_annotation/json_annotation.dart';
// import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';

abstract class WsEvent {
  String cmd = '';
  Map<String, dynamic> payload = {};
  String? requestId;
  // Command? data;

  // @JsonKey(name: 'ts')
  // final int? timestamp;

  // @JsonKey(name: 'code')
  // final int? errorCode;

  // @JsonKey(name: 'message')
  // final String? errorMessage;

  // final bool? requireAuth;

  @JsonKey(fromJson: channelEventValueOf, name: 'cat')
  //NOTE: https://github.com/dart-lang/sdk/issues/33698
  final ChannelEventCategory? category;

  WsEvent({
    this.requestId,
    this.payload = const {},
    this.category,
  });

  Future<dynamic> handleEvent(SendbirdSdkInternal sdk);

  // static WsEvent? fromJson(String cmd, Map<String, dynamic> json) {
  //   if (cmd == CommandString.userMessage || cmd == CommandString.fileMessage) {
  //     return MessageNewEvent.fromJson(json);
  //   } else if (cmd == CommandString.userMessageUpdate ||
  //       cmd == CommandString.fileMessageUpdate) {
  //     return MessageUpdateEvent.fromJson(json);
  //   } else if (cmd == CommandString.systemEvent) {}

  //   ///...

  //   return null;
  // }
}
