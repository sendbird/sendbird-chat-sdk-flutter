import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class ChannelUserMessageSendRequest extends WsRequest {
  @override
  final cmd = CommandString.userMessage;

  ChannelType channelType;
  String channelUrl;
  UserMessageParams params;

  ChannelUserMessageSendRequest({
    required this.channelType,
    required this.channelUrl,
    required this.params,
  }) : super() {
    //
    payload.addAll({
      'channel_url': channelUrl,
      'message': params.message,
      'data': params.data,
      'custom_type': params.customType
    });

    if (params.targetLanguages.isNotEmpty) {
      payload['target_langs'] = params.targetLanguages;
      payload['translations'] = {for (var e in params.targetLanguages) e: ''};
    }

    if (params.pushOption == PushNotificationDeliveryOption.suppress) {
      payload['push_option'] = params.pushOption.asString();
    }

    payload['mention_type'] = params.mentionType?.asString();
    if (params.mentionType == MentionType.users) {
      payload['mentioned_user_ids'] = params.mentionedUserIds;
    }

    payload['created_at'] = DateTime.now().millisecondsSinceEpoch;
    payload['metaarray'] = params.metaArrays?.map((e) => e.toJson()).toList();

    if (params.parentMessageId != null) {
      payload['parent_message_id'] = params.parentMessageId;
      payload['root_message_id'] = params.parentMessageId;
    }

    payload.removeWhere((key, value) => value == null);
  }

  UserMessage get pending => BaseMessage.msgFromJson<UserMessage>(
        payload,
        channelType: channelType,
        type: cmd,
      )!;
}

class ChannelUserMessageSendApiRequest extends ApiRequest {
  @override
  final method = Method.post;

  ChannelType channelType;

  ChannelUserMessageSendApiRequest({
    required UserMessageParams params,
    required this.channelType,
    required String channelUrl,
    String? senderId,
    bool markAsRead = false,
    List<String>? additionalMentionedUserIds,
  }) : super(userId: senderId) {
    url = '${channelType.urlString}/$channelUrl/messages';
    body = {
      'message_type': CommandString.userMessage,
      'user_id': senderId,
      'mark_as_read': markAsRead,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<BaseMessage> response(res) async {
    return BaseMessage.msgFromJson<UserMessage>(res, channelType: channelType)!;
  }
}
