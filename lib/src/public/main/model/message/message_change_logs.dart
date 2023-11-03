// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';

part 'message_change_logs.g.dart';

/// The MessageChangeLogs class.
@JsonSerializable(createToJson: false)
class MessageChangeLogs {
  /// The updated messages.
  /// [BaseMessage] for [BaseChannel], [NotificationMessage] for [FeedChannel].
  @JsonKey(fromJson: toRootMessageList, defaultValue: [], name: 'updated')
  final List<RootMessage> updatedMessages;

  /// The deleted message IDs.
  /// [int] for [BaseMessage], [String] for [NotificationMessage].
  @JsonKey(fromJson: toDeletedMessageIds, name: 'deleted')
  final List<dynamic> deletedMessageIds;

  /// True if it has more changelogs.
  @JsonKey(defaultValue: false)
  final bool hasMore;

  /// [token] to get next changelogs.
  @JsonKey(name: 'next')
  final String? token;

  MessageChangeLogs({
    required this.updatedMessages,
    required this.deletedMessageIds,
    required this.hasMore,
    this.token,
  });

  static MessageChangeLogs fromJson(Map<String, dynamic> json) =>
      _$MessageChangeLogsFromJson(json);
}
