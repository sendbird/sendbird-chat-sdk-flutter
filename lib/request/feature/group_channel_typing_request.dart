import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';

class GroupChannelTypingStartRequest extends WsRequest {
  @override
  final cmd = CommandString.typingStart;

  GroupChannelTypingStartRequest() : super();
}

class GroupChannelTypingEndRequest extends WsRequest {
  @override
  final cmd = CommandString.typingEnd;

  GroupChannelTypingEndRequest() : super();
}
