// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';

part 'group_channel_change_logs.g.dart';

/// The GroupChannelChangeLogs class.
@JsonSerializable(createToJson: false)
class GroupChannelChangeLogs {
  /// The updated channels.
  @JsonKey(defaultValue: [], name: 'updated')
  final List<GroupChannel> updatedChannels;

  /// The deleted channel urls.
  @JsonKey(defaultValue: [], name: 'deleted')
  final List<String> deletedChannelUrls;

  /// True if it has more changelogs.
  @JsonKey(defaultValue: false)
  final bool hasMore;

  /// [token] to get next changelogs.
  @JsonKey(name: 'next')
  final String? token;

  GroupChannelChangeLogs({
    required this.updatedChannels,
    required this.deletedChannelUrls,
    required this.hasMore,
    this.token,
  });

  static GroupChannelChangeLogs fromJsonWithChat(
      Chat chat, Map<String, dynamic> json) {
    final res = _$GroupChannelChangeLogsFromJson(json);

    for (final channel in res.updatedChannels) {
      channel.set(chat);
    }
    return res;
  }
}
