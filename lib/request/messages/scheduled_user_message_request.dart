import 'package:sendbird_sdk/core/message/scheduled_user_message.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledUserMessageSendRequest extends ApiRequest {
  @override
  final method = Method.post;

  GroupChannelScheduledUserMessageSendRequest({
    required String channelUrl,
    required ScheduledUserMessageParams params,
  }) {
    if (userId == null) {
      throw InvalidParameterError;
    }
    url = 'group_channels/$channelUrl/scheduled_messages';
    body = {
      'user_id': userId,
      'message_type': 'MESG',
    };
    body.addAll(params.toJson());
  }

  @override
  Future<ScheduledUserMessage> response(res) async {
    return ScheduledUserMessage.fromJson(res);
  }
}
