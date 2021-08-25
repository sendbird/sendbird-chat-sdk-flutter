import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/params/file_message_params.dart';
import 'package:sendbird_sdk/params/user_message_params.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

import 'package:uuid/uuid.dart';

part 'command.g.dart';

@JsonSerializable()
class Command {
  // @JsonKey(fromJson: _toEnum)
  // CommandType cmd;
  String cmd;

  @JsonKey(name: 'ts')
  final int? timestamp;

  @JsonKey(name: 'code')
  final int? errorCode;

  @JsonKey(name: 'message')
  final String? errorMessage;

  final bool? requireAuth;

  @JsonKey(name: 'req_id')
  String? requestId;

  @JsonKey(ignore: true)
  Map<String, dynamic> payload = {};

  Command({
    required this.cmd,
    this.requestId,
    this.timestamp,
    this.requireAuth,
    this.errorCode,
    this.errorMessage,
    this.payload = const {},
  }) {
    if (payload.isNotEmpty) {
      requestId ??= Uuid().v1();
      payload['req_id'] = requestId;
      payload.removeWhere((key, value) => value == null);
    }
  }

  factory Command.fromJson(Map<String, dynamic> json) {
    return _$CommandFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommandToJson(this);

  String encode() {
    return cmd + jsonEncode(payload) + '\n';
  }

  bool get isAckRequired =>
      CommandString.isUserMessage(cmd) ||
      CommandString.isFileMessage(cmd) ||
      cmd == CommandString.enter ||
      cmd == CommandString.exit ||
      cmd == CommandString.read;

  bool get hasError => payload['error'] != null;

  bool get isSessionExpired => cmd == CommandString.sessionExpired;

  bool get isLogin => cmd == CommandString.login;

  bool get isNewMessage =>
      cmd == CommandString.userMessage ||
      cmd == CommandString.fileMessage ||
      cmd == CommandString.adminMessage ||
      cmd == CommandString.broadcastMessage;

  bool get isUpdatedMessage =>
      cmd == CommandString.userMessageUpdate ||
      cmd == CommandString.fileMessageUpdate ||
      cmd == CommandString.adminMessageUpdate;

  bool get isMemberCountChange => cmd == CommandString.memberCountChange;

  bool get isDeletedMessage => cmd == CommandString.deleteMessage;

  bool get isRead => cmd == CommandString.read;

  bool get isDelivery => cmd == CommandString.delivery;

  bool get isThread => cmd == CommandString.thread;

  bool get isReaction => cmd == CommandString.reaction;

  bool get isSystemEvent => cmd == CommandString.systemEvent;

  bool get isUserEvent => cmd == CommandString.userEvent;

  bool get isError => cmd == CommandString.error;

  // builders

  static Command buildEnterChannel(BaseChannel channel) {
    return Command(
      cmd: CommandString.enter,
      payload: {
        'channel_url': channel.channelUrl,
        'last_ts': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  static Command buildExitChannel(BaseChannel channel) {
    return Command(
      cmd: CommandString.exit,
      payload: {
        'channel_url': channel.channelUrl,
      },
    );
  }

  static Command buildUserMessage(
    String channelUrl,
    UserMessageParams params,
    String requestId,
  ) {
    final payload = <String, dynamic>{
      'channel_url': channelUrl,
      'message': params.message,
      'data': params.data,
      'custom_type': params.customType
    };

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

    return Command(
      cmd: CommandString.userMessage,
      payload: payload,
      requestId: requestId,
    );
  }

  static Command buildUpdateUserMessage(
    String channelUrl,
    int messageId,
    UserMessageParams params,
  ) {
    final payload = <String, dynamic>{
      'msg_id': messageId,
      'channel_url': channelUrl,
      'message': params.message,
      'data': params.data,
      'custom_type': params.customType,
      'mention_type': params.mentionType,
      'mentioned_user_ids': params.mentionedUserIds
    };
    payload.removeWhere((key, value) => value == null);
    return Command(cmd: CommandString.userMessageUpdate, payload: payload);
  }

  static Command buildFileMessage({
    required String channelUrl,
    required FileMessageParams params,
    required String? requestId,
    List<dynamic>? thumbnails,
    bool? requireAuth,
  }) {
    final payload = <String, dynamic>{
      'channel_url': channelUrl,
      if (requireAuth != null) 'require_auth': requireAuth,
      'url': params.uploadFile.url,
      'name': params.uploadFile.name,
      'type': params.uploadFile.mimeType,
      'size': params.uploadFile.fileSize,
      'custom': params.data,
      'custom_type': params.customType,
    };

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
    return Command(
      cmd: CommandString.fileMessage,
      payload: payload,
      requestId: requestId,
    );
  }

  static Command buildUpdateFileMessage(
      String channelUrl, int messageId, FileMessageParams params) {
    final payload = <String, dynamic>{
      'channel_url': channelUrl,
      'msg_id': messageId,
      'data': params.data,
      'custom_type': params.customType,
      'mention_type': params.mentionType,
      'mentioned_user_ids': params.mentionedUserIds
    };
    payload.removeWhere((key, value) => value == null);
    return Command(cmd: CommandString.fileMessageUpdate, payload: payload);
  }

  static Command buildUpdateMessageMetaArray(
      BaseMessage message,
      List<MessageMetaArray> metaArrays,
      MetaArrayUpdateMode updateMode,
      bool upsert) {
    if (message.messageId <= 0) {
      throw InvalidParameterError();
    }
    if (metaArrays.isEmpty) {
      throw InvalidParameterError();
    }

    String type;
    if (message is UserMessage) {
      type = CommandString.userMessageUpdate;
    } else if (message is FileMessage) {
      type = CommandString.fileMessageUpdate;
    } else {
      throw InvalidParameterError();
    }

    return Command(cmd: type, payload: {
      'channel_url': message.channelUrl,
      'msg_id': message.messageId,
      'metaarray': {
        'array': metaArrays.map((e) => e.toJson()).toList(),
        'mode': updateMode.asString(),
        'upsert': upsert
      }
    });
  }

  static Command buildPing() {
    return Command(
        cmd: CommandString.ping,
        payload: {'id': DateTime.now().millisecondsSinceEpoch});
  }

  static Command buildStartTyping(String channelUrl, int startAt) {
    return Command(
        cmd: CommandString.typingStart,
        payload: {'channel_url': channelUrl, 'time': startAt});
  }

  static Command buildEndTyping(String channelUrl, int endAt) {
    return Command(
        cmd: CommandString.typingEnd,
        payload: {'channel_url': channelUrl, 'time': endAt});
  }

  static Command buildRead(String channelUrl) {
    return Command(
      cmd: CommandString.read,
      payload: {
        'channel_url': channelUrl,
      },
    );
  }

  static Command buildMessageMACK(String channelUrl, int messageId) {
    return Command(
      cmd: CommandString.mack,
      payload: {
        'channel_url': channelUrl,
        'msg_id': messageId,
      },
    );
  }

  static Command buildLOGIUpdateSessionKey(String? token) {
    final hasCallback = SendbirdSdk()
        .getInternal()
        .eventManager
        .getHandlers<SessionEventHandler>()
        .isNotEmpty;
    return Command(
      cmd: CommandString.login,
      payload: {
        if (token != null) 'token': token,
        'expiring_session': hasCallback,
      },
    );
  }
}
