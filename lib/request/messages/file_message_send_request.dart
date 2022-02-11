import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/params/base_message_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class ChannelFileMessageSendWsRequest extends WsRequest {
  @override
  final cmd = CommandString.fileMessage;

  ChannelFileMessageSendWsRequest({
    required String channelUrl,
    required FileMessageParams params,
    required String? requestId,
    List<dynamic>? thumbnails,
    bool? requireAuth,
  }) : super() {
    payload.addAll({
      'channel_url': channelUrl,
      if (requireAuth != null) 'require_auth': requireAuth,
      'url': params.uploadFile.url,
      'name': params.uploadFile.name,
      'type': params.uploadFile.mimeType,
      'size': params.uploadFile.fileSize,
      'custom': params.data,
      'custom_type': params.customType,
    });

    if (params.pushOption == PushNotificationDeliveryOption.suppress) {
      payload['push_option'] = params.pushOption.asString();
    }

    payload['mention_type'] = params.mentionType?.asString();
    if (params.mentionType == MentionType.users) {
      payload['mentioned_user_ids'] = params.mentionedUserIds;
    }

    payload['thumbnails'] = thumbnails;
    payload['created_at'] = DateTime.now().millisecondsSinceEpoch;
    payload['metaarray'] = params.metaArrays?.map((e) => e.toJson()).toList();

    if (params.parentMessageId != null) {
      payload['parent_message_id'] = params.parentMessageId;
      payload['root_message_id'] = params.parentMessageId;
    }
    payload.removeWhere((key, value) => value == null);
  }
}

class ChannelFileMessageSendApiRequest extends ApiRequest {
  @override
  final method = Method.post;

  ChannelType channelType;

  ChannelFileMessageSendApiRequest({
    required this.channelType,
    required String channelUrl,
    required FileMessageParams params,
    String? senderId,
    List<dynamic>? thumbnails,
    bool markAsRead = false,
    bool? requireAuth,
    List<String>? additionalMentionedUserIds,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/messages';

    body = {
      'message_type': CommandString.fileMessage,
      'user_id': senderId ?? state.userId,
      'mark_as_read': markAsRead,
      'require_auth': requireAuth,
      'mentioned_user_ids': additionalMentionedUserIds,
      'thumbnails': thumbnails,
      'file_size': params.uploadFile.fileSize,
      'file_name': params.uploadFile.name,
      'file_type': params.uploadFile.mimeType,
      'url': params.uploadFile.url,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<FileMessage> response(res) async {
    return BaseMessage.msgFromJson<FileMessage>(res, channelType: channelType)!;
  }
}
