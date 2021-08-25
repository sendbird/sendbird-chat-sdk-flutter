import 'package:sendbird_sdk/core/message/scheduled_user_message.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledMessageSendRequest extends ApiRequest {
  @override
  final method = Method.post;

  GroupChannelScheduledMessageSendRequest({
    required String channelUrl,
    required ScheduledUserMessageParams params,
    bool markAsRead = false,
    String? userId,
  }) : super(userId: userId) {
    url = 'group_channels/$channelUrl/scheduled_messages';
    body = {
      'user_id': userId,
      'mark_as_read': markAsRead,
    };
    body.addAll(params.toJson());
  }

  @override
  Future<ScheduledUserMessage> response(res) async {
    return ScheduledUserMessage.fromJson(res);
  }
}
