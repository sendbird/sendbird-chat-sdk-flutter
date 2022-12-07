import 'package:sendbird_sdk/core/message/scheduled_file_message.dart';
import 'package:sendbird_sdk/params/scheduled_file_message_update_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledFileMessageUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelScheduledFileMessageUpdateRequest({
    required String channelUrl,
    required int scheduledMessageId,
    required ScheduledFileMessageUpdateParams params,
  }) {
    url = 'group_channels/$channelUrl/scheduled_messages/$scheduledMessageId';

    body.addAll(params.toJson());
  }

  @override
  Future<ScheduledFileMessage> response(res) async {
    return ScheduledFileMessage.fromJson(res);
  }
}
