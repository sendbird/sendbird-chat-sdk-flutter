// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command_type.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/file_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/file_message_update_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/user_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/user_message_update_params.dart';
import 'package:uuid/uuid.dart';

part 'command.g.dart';

@JsonSerializable(createToJson: false)
class Command {
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

  // Retrieve whether the option includes reply to channel The Default value is `false`
  bool replyToChannel;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> payload = {};

  Command({
    required this.cmd,
    this.requestId,
    this.timestamp,
    this.requireAuth,
    this.errorCode,
    this.errorMessage,
    this.replyToChannel = false,
    this.payload = const {},
  }) {
    if (payload.isNotEmpty) {
      requestId ??= const Uuid().v1();
      payload['req_id'] = requestId;
      replyToChannel = payload['reply_to_channel'] ?? replyToChannel;
      payload.removeWhere((key, value) => value == null);
    }
  }

  factory Command.fromJson(Map<String, dynamic> json) {
    return _$CommandFromJson(json);
  }

  String encode() {
    return '$cmd${jsonEncode(payload)}\n';
  }

  bool get isAckRequired =>
      CommandString.isUserMessage(cmd) ||
      CommandString.isFileMessage(cmd) ||
      cmd == CommandString.enter ||
      cmd == CommandString.exit ||
      cmd == CommandString.read ||
      cmd == CommandString.pollVoted;

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

  bool get isMemberCountChanged => cmd == CommandString.memberCountChanged;

  bool get isMessageDeleted => cmd == CommandString.messageDeleted;

  bool get isRead => cmd == CommandString.read;

  bool get isDelivery => cmd == CommandString.delivery;

  bool get isThread => cmd == CommandString.thread;

  bool get isReaction => cmd == CommandString.reaction;

  bool get isSystemEvent => cmd == CommandString.systemEvent;

  bool get isUserEvent => cmd == CommandString.userEvent;

  bool get isError => cmd == CommandString.error;

  bool get isPollVoted => cmd == CommandString.pollVoted;

  bool get isPollUpdated => cmd == CommandString.pollUpdated;

  // Builders

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
    UserMessageCreateParams params,
    String requestId,
  ) {
    final payload = <String, dynamic>{
      'channel_url': channelUrl,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };

    payload.addAll(params.toJson());

    return Command(
      cmd: CommandString.userMessage,
      payload: payload,
      requestId: requestId,
    );
  }

  static Command buildUpdateUserMessage(
    String channelUrl,
    int messageId,
    UserMessageUpdateParams params,
  ) {
    final payload = <String, dynamic>{
      'msg_id': messageId,
      'channel_url': channelUrl,
      'message': params.message,
      'data': params.data,
      'custom_type': params.customType,
      'mention_type': params.mentionType?.asString(),
      if (params.mentionType == MentionType.users)
        'mentioned_user_ids': params.mentionedUserIds,
    };
    payload.removeWhere((key, value) => value == null);
    return Command(cmd: CommandString.userMessageUpdate, payload: payload);
  }

  static Command buildFileMessage({
    required String channelUrl,
    required FileMessageCreateParams params,
    required String? requestId,
    List<dynamic>? thumbnails,
    bool? requireAuth,
  }) {
    final payload = <String, dynamic>{
      'channel_url': channelUrl,
      'require_auth': requireAuth,
    };

    payload.addAll(params.toJson());

    payload['thumbnails'] = thumbnails;
    payload['created_at'] = DateTime.now().millisecondsSinceEpoch;

    payload.removeWhere((key, value) => value == null);
    return Command(
      cmd: CommandString.fileMessage,
      payload: payload,
      requestId: requestId,
    );
  }

  static Command buildUpdateFileMessage(
      String channelUrl, int messageId, FileMessageUpdateParams params) {
    final payload = <String, dynamic>{
      'channel_url': channelUrl,
      'msg_id': messageId,
      'data': params.data,
      'custom_type': params.customType,
      'mention_type': params.mentionType?.asString(),
      if (params.mentionType == MentionType.users)
        'mentioned_user_ids': params.mentionedUserIds,
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
      throw InvalidParameterException();
    }
    if (metaArrays.isEmpty) {
      throw InvalidParameterException();
    }

    String type;
    if (message is UserMessage) {
      type = CommandString.userMessageUpdate;
    } else if (message is FileMessage) {
      type = CommandString.fileMessageUpdate;
    } else {
      throw InvalidParameterException();
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

  static Command buildLOGIUpdateSessionKey(bool hasCallback, String? token) {
    return Command(
      cmd: CommandString.login,
      payload: {
        if (token != null) 'token': token,
        'expiring_session': hasCallback,
      },
    );
  }

  static Command buildVotePoll({
    required ChannelType channelType,
    required String channelUrl,
    required int pollId,
    required List<int> pollOptionIds,
  }) {
    if (channelType == ChannelType.open) {
      throw InvalidParameterException();
    }

    final payload = <String, dynamic>{
      'channel_url': channelUrl,
      'channel_type': channelType.commandString,
      'poll_id': pollId,
      'option_ids': pollOptionIds,
    };

    return Command(
      cmd: CommandString.pollVoted,
      payload: payload,
    );
  }
}
