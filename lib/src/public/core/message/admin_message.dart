// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/type_checker.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_meta_data.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info.dart';

part 'admin_message.g.dart';

/// Object representing an admin message.
@JsonSerializable()
class AdminMessage extends BaseMessage {
  AdminMessage({
    required String channelUrl,
    required ChannelType channelType,
    required int messageId,
    required String message,
    SendingStatus? sendingStatus,
    String? requestId,
    List<User> mentionedUsers = const [],
    MentionType mentionType = MentionType.users,
    int createdAt = 0,
    int updatedAt = 0,
    int? parentMessageId,
    Map<String, dynamic>? parentMessage,
    ThreadInfo? threadInfo,
    List<MessageMetaArray>? metaArrays,
    String? customType,
    int? messageSurvivalSeconds,
    bool forceUpdateLastMessage = false,
    bool isSilent = false,
    bool isOperatorMessage = false,
    String? data,
    OGMetaData? ogMetaData,
    List<Reaction>? reactions,
    bool replyToChannel = false,
    Map<String, dynamic>? extendedMessage,
  }) : super(
          isReplyToChannel: replyToChannel,
          requestId: requestId,
          messageId: messageId,
          message: message,
          sendingStatus: sendingStatus,
          channelType: channelType,
          channelUrl: channelUrl,
          mentionedUsers: mentionedUsers,
          mentionType: mentionType,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentMessageId: parentMessageId,
          parentMessage: parentMessage,
          threadInfo: threadInfo,
          allMetaArrays: metaArrays,
          customType: customType,
          messageSurvivalSeconds: messageSurvivalSeconds,
          forceUpdateLastMessage: forceUpdateLastMessage,
          isSilent: isSilent,
          isOperatorMessage: isOperatorMessage,
          data: data,
          ogMetaData: ogMetaData,
          reactions: reactions,
          extendedMessage: extendedMessage ?? {},
        );

  factory AdminMessage.fromJson(Map<String, dynamic> json) {
    return _$AdminMessageFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat
  }

  factory AdminMessage.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return AdminMessage.fromJson(json)..set(chat);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$AdminMessageToJson(this);
    json['message_type'] = MessageType.admin.name; // Check
    return json;
  }
}
