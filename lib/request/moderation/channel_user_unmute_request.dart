import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelUserUnmuteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelUserUnmuteRequest({
    required String targetId,
    required ChannelType channelType,
    required String channelUrl,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/mute/$targetId';
  }
}
