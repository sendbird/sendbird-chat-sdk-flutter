import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';

class OpenChannelEnterRequest extends WsRequest {
  @override
  final cmd = CommandString.enter;

  OpenChannelEnterRequest(String channelUrl) : super() {
    payload = {
      'channel_url': channelUrl,
      'last_ts': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
