import 'package:sendbird_sdk/core/message/scheduled_file_message.dart';
import 'package:sendbird_sdk/params/scheduled_file_message_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledFileMessageSendRequest extends ApiRequest {
  @override
  final method = Method.post;

  GroupChannelScheduledFileMessageSendRequest({
    required String channelUrl,
    required ScheduledFileMessageParams params,
  }) : super() {
    if (userId == null) {
      throw InvalidParameterError;
    }
    url = 'group_channels/$channelUrl/scheduled_messages';
    body = {
      'user_id': userId,
      'message_type': 'FILE',
    };
    body.addAll(params.toJson());
    body.remove('file');
  }

  @override
  Future<ScheduledFileMessage> response(res) async {
    return ScheduledFileMessage.fromJson(res);
  }
}
