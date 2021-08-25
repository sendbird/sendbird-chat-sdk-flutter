import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelJoinRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelJoinRequest({
    required String channelUrl,
    String? accessCode,
    String? userId,
  }) : super(userId: userId) {
    url = 'group_channels/$channelUrl/join';
    body = {
      if (accessCode != null) 'access_code': accessCode,
    };
  }
}
