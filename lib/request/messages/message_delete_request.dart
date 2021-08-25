import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMessageDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelMessageDeleteRequest({
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId';
  }
}

class ChannelMessageDeleteWsRequest extends WsRequest {}
