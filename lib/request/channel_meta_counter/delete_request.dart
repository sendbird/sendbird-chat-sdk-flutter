import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMetaCounterDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelMetaCounterDeleteRequest({
    required ChannelType channelType,
    required String channelUrl,
    required String key,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metacounter/$key';
  }
}

class ChannelMetaCounterDeleteAllRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelMetaCounterDeleteAllRequest({
    required ChannelType channelType,
    required String channelUrl,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metacounter';
  }
}
