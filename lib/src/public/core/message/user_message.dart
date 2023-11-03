// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/type_checker.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/scheduled_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_meta_data.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/user_message_create_params.dart';

part 'user_message.g.dart';

/// Object representing a user message.
@JsonSerializable()
class UserMessage extends BaseMessage {
  /// The translated messages (key-value map) for the language codes in key.
  /// The messages that have been sent with translation option will have this map.
  /// (refer to [BaseChannelMessage.sendUserMessage])
  @JsonKey(defaultValue: {})
  final Map<String, String> translations;

  /// The list of target translation languages with the language codes.
  /// The messages that have been sent or scheduled with translation option will have this list.
  /// (refer to [BaseChannelMessage.sendUserMessage])
  final List<String>? translationTargetLanguages;

  /// The poll that belongs to this message object.
  Poll? poll;

  /// [UserMessageCreateParams] object that used for sending this message.
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserMessageCreateParams? messageCreateParams;

  UserMessage({
    required this.translations,
    required int messageId,
    required String message,
    required String channelUrl,
    required ChannelType channelType,
    Sender? sender,
    SendingStatus? sendingStatus,
    String? requestId,
    List<User> mentionedUsers = const [],
    MentionType? mentionType,
    List<String>? requestedMentionUserIds,
    int createdAt = 0,
    int updatedAt = 0,
    int? parentMessageId,
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
    Map<String, dynamic>? parentMessage,
    bool replyToChannel = false,
    this.poll,
    this.translationTargetLanguages,
  }) : super(
          isReplyToChannel: replyToChannel,
          requestId: requestId,
          messageId: messageId,
          message: message,
          sendingStatus: sendingStatus,
          sender: sender,
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
        );

  factory UserMessage.fromJson(Map<String, dynamic> json) {
    final userMessage = _$UserMessageFromJson(json);

    if (json['scheduled_message_id'] != null) {
      userMessage.scheduledInfo = ScheduledInfo.fromJson(json);
    }
    return userMessage..set(SendbirdChat().chat); // Set the singleton chat
  }

  factory UserMessage.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return UserMessage.fromJson(json)..set(chat);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$UserMessageToJson(this);
    json['message_type'] = MessageType.user.name; // Check
    return json;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = const MapEquality().equals;
    return other is UserMessage && eq(translations, other.translations);
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        translations,
      );
}
