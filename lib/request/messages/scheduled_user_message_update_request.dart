import 'package:sendbird_sdk/core/message/scheduled_user_message.dart';
import 'package:sendbird_sdk/params/scheduled_user_message_update_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledUserMessageUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelScheduledUserMessageUpdateRequest({
    required String channelUrl,
    required int scheduledMessageId,
    required ScheduledUserMessageUpdateParams params,
  }) {
    url = 'group_channels/$channelUrl/scheduled_messages/$scheduledMessageId';

    body.addAll(params.toJson());
  }

  @override
  Future<ScheduledUserMessage> response(res) async {
    return ScheduledUserMessage.fromJson(res);
  }
}
