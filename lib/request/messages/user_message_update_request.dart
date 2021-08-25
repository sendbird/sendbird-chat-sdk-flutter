import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/params/user_message_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelUserMessageUpdateRequest extends WsRequest {
  @override
  final cmd = CommandString.userMessageUpdate;

  ChannelUserMessageUpdateRequest({
    required String channelUrl,
    required int messageId,
    required UserMessageParams params,
  }) : super() {
    payload = {
      'msg_id': messageId,
      'channel_url': channelUrl,
      'message': params.message,
      'data': params.data,
      'custom_type': params.customType,
      'mention_type': params.mentionType,
      'mentioned_user_ids': params.mentionedUserIds
    };
    payload.removeWhere((key, value) => value == null);
  }
}

class ChannelUserMessageUpdateApiRequest extends ApiRequest {
  @override
  final method = Method.put;

  ChannelUserMessageUpdateApiRequest({
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    required UserMessageParams params,
    String? senderId,
    List<String>? additionalMentionedUserIds,
  }) : super(userId: senderId) {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId';

    body = {
      'message_type': CommandString.userMessage,
      'user_id': senderId ?? state.userId,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }
}
