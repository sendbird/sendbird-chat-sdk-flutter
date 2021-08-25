import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';

class OpenChannelExitRequest extends WsRequest {
  @override
  final cmd = CommandString.exit;

  OpenChannelExitRequest(String channelUrl) : super() {
    payload = {'channel_url': channelUrl};
  }
}
