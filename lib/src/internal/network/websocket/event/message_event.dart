// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

import 'base_event.dart';

part 'message_event.g.dart';

@JsonSerializable(createToJson: false)
class MessageEvent extends BaseEvent {
  @JsonKey(name: 'req_id')
  String? requestId;

  @JsonKey(name: 'msg_id')
  final int messageId;

  final int? previousMessageId;

  final bool forceUpdateLastMessage;

  final bool silent;

  final String channelUrl;

  @JsonKey(unknownEnumValue: ChannelType.group)
  final ChannelType channelType;

  @JsonKey(unknownEnumValue: MentionType.users)
  final MentionType? mentionType;

  @JsonKey(name: 'user')
  final Sender? sender;

  final List<User>? mentionedUsers;

  final List<Thumbnail>? thumbnails;

  final Map<String, dynamic>? oldValues;

  MessageEvent({
    required this.messageId,
    required this.channelType,
    required this.channelUrl,
    this.previousMessageId,
    this.forceUpdateLastMessage = false,
    this.silent = false,
    this.sender,
    this.requestId,
    this.mentionType,
    this.mentionedUsers,
    this.thumbnails,
    this.oldValues,
  });

  factory MessageEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageEventFromJson(json);

  MentionType? hasChangedMentionType() {
    if (oldValues == null || oldValues?['mention_type'] == null) {
      return null;
    }
    final oldMentionType =
        MentionType.values.byName(oldValues?['mention_type']);

    return oldMentionType != mentionType ? mentionType : null;
  }

  bool previousMentionedContains(User user) {
    if (oldValues == null || oldValues?['mentioned_user_ids'] == null) {
      return false;
    }
    List<String> previous = oldValues?['mentioned_user_ids'];
    return previous.contains(user.userId);
  }

  bool mentionedContains(User user) {
    return mentionedUsers?.firstWhere((e) => e.userId == user.userId) != null;
  }
}
