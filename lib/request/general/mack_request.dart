import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';

class MACKRequest extends WsRequest {
  @override
  final cmd = CommandString.mack;

  MACKRequest(String channelUrl, int messageId) : super() {
    payload = {
      'channel_url': channelUrl,
      'msg_id': messageId,
    };
  }
}
