import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelHideRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelHideRequest(String channelUrl,
      {bool hidePreviousMessages = false,
      bool allowAutoUnhide = true,
      String? userId})
      : super(userId: userId) {
    url = 'group_channels/$channelUrl/hide';
    body = {
      'hide_previous_messages': hidePreviousMessages,
      'allow_auto_unhide': allowAutoUnhide,
    };
  }
}

class GroupChannelUnhideRequest extends ApiRequest {
  @override
  final method = Method.delete;

  GroupChannelUnhideRequest({required String channelUrl, String? userId})
      : super(userId: userId) {
    url = 'group_channels/$channelUrl/hide';
  }
}
