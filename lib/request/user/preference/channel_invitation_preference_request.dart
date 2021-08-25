import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelInvitationPreferenceSetRequest extends ApiRequest {
  @override
  final method = Method.put;

  ChannelInvitationPreferenceSetRequest(bool autoAccept, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/channel_invitation_preference';
    body = {'auto_accept': autoAccept};
  }
}

class ChannelInvitationPreferenceGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ChannelInvitationPreferenceGetRequest({String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/channel_invitation_preference';
  }

  @override
  Future<bool> response(res) async {
    return res['auto_accept'] as bool;
  }
}
