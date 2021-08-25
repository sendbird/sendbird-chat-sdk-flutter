import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelFileMessageUpdateRequest extends WsRequest {
  @override
  final cmd = CommandString.fileMessageUpdate;

  ChannelFileMessageUpdateRequest({
    required String channelUrl,
    required int messageId,
    required FileMessageParams params,
  }) : super() {
    payload.addAll({
      'channel_url': channelUrl,
      'msg_id': messageId,
      'data': params.data,
      'custom_type': params.customType,
      'mention_type': params.mentionType,
      'mentioned_user_ids': params.mentionedUserIds
    });
    payload.removeWhere((key, value) => value == null);
  }
}

class ChannelFileMessageUpdateApiRequest extends ApiRequest {}
