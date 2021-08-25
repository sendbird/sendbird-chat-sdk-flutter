import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelInvitationAcceptRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelInvitationAcceptRequest({
    required String channelUrl,
    String? accessCode,
    String? userId,
  }) : super(userId: userId) {
    url = 'group_channels/$channelUrl/accept';
    body = {
      if (accessCode != null) 'access_code': accessCode,
    };
  }
}
