import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class MessageMetaArrayAddRequest extends WsRequest {
  MessageMetaArrayAddRequest({
    required BaseMessage message,
    required List<MessageMetaArray> metaArrays,
  }) : super() {
    if (message is UserMessage) {
      cmd = CommandString.userMessageUpdate;
    } else if (message is FileMessage) {
      cmd = CommandString.fileMessageUpdate;
    } else {
      throw InvalidParameterError();
    }

    payload.addAll({
      'channel_url': message.channelUrl,
      'msg_id': message.messageId,
      'metaarray': {
        'array': metaArrays.map((e) => e.toJson()).toList(),
        'mode': MetaArrayUpdateMode.add.asString(),
        'upsert': true
      },
    });
  }
}

class MessageMetaArrayKeyDeleteRequest extends WsRequest {
  MessageMetaArrayKeyDeleteRequest({
    required BaseMessage message,
    required List<MessageMetaArray> metaArrays,
  }) : super() {
    if (message is UserMessage) {
      cmd = CommandString.userMessageUpdate;
    } else if (message is FileMessage) {
      cmd = CommandString.fileMessageUpdate;
    } else {
      throw InvalidParameterError();
    }

    payload.addAll({
      'channel_url': message.channelUrl,
      'msg_id': message.messageId,
      'metaarray': {
        'array': metaArrays.map((e) => e.toJson()).toList(),
        'mode': MetaArrayUpdateMode.remove.asString(),
        'upsert': false
      },
    });
  }
}

class MessageMetaArrayRemoveRequest extends WsRequest {
  MessageMetaArrayRemoveRequest({
    required BaseMessage message,
    required List<MessageMetaArray> metaArrays,
  }) : super() {
    if (message is UserMessage) {
      cmd = CommandString.userMessageUpdate;
    } else if (message is FileMessage) {
      cmd = CommandString.fileMessageUpdate;
    } else {
      throw InvalidParameterError();
    }

    payload.addAll({
      'channel_url': message.channelUrl,
      'msg_id': message.messageId,
      'metaarray': {
        'array': metaArrays.map((e) => e.toJson()).toList(),
        'mode': MetaArrayUpdateMode.remove.asString(),
        'upsert': true
      },
    });
  }
}
