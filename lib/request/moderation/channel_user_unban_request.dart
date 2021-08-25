import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelUserUnbanRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelUserUnbanRequest({
    required ChannelType channelType,
    required String channelUrl,
    required String targetId,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/ban/$targetId';
  }
}
