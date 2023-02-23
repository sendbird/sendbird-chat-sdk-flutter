import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelMarkAsReadWsRequest extends WsRequest {
  @override
  final cmd = CommandString.read;

  GroupChannelMarkAsReadWsRequest() : super();
}

class GroupChannelMarkAsReadApiRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelMarkAsReadApiRequest({
    List<String>? channelUrls,
    String? userId,
  }) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/mark_as_read_all';
    body = {
      if (channelUrls != null && channelUrls.isNotEmpty)
        'channel_urls': channelUrls,
    };
  }
}
