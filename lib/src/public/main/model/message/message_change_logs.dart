// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/public/core/message/base_message.dart';

part 'message_change_logs.g.dart';

/// The MessageChangeLogs class.
@JsonSerializable(createToJson: false)
class MessageChangeLogs {
  /// The updated messages.
  @JsonKey(defaultValue: [], name: 'updated')
  final List<BaseMessage> updatedMessages;

  /// The deleted message IDs.
  @JsonKey(fromJson: _deletedMessageIds, name: 'deleted')
  final List<int> deletedMessageIds;

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

List<int> _deletedMessageIds(List<dynamic> json) =>
    json.map((e) => e['message_id'] as int).toList();
