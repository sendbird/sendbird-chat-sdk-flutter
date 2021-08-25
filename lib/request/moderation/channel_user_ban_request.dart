import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelUserBanRequest extends ApiRequest {
  @override
  final method = Method.post;

  ChannelUserBanRequest({
    required String targetId,
    required ChannelType channelType,
    required String channelUrl,
    String? description,
    int seconds = -1,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/ban';
    body = {
      'user_id': targetId,
      'seconds': seconds,
      if (description != null) 'description': description,
    };
  }
}
