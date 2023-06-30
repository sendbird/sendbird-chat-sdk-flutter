// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';

part 'feed_channel_change_logs.g.dart';

/// The FeedChannelChangeLogs class.
@JsonSerializable(createToJson: false)
class FeedChannelChangeLogs {
  /// The updated channels.
  @JsonKey(defaultValue: [], name: 'updated')
  @FeedChannelConverter()
  final List<FeedChannel> updatedChannels;

  /// The deleted channel urls.
  @JsonKey(defaultValue: [], name: 'deleted')
  final List<String> deletedChannelUrls;

  /// True if it has more changelogs.
  @JsonKey(defaultValue: false)
  final bool hasMore;

  /// [token] to get next changelogs.
  @JsonKey(name: 'next')
  final String? token;

  FeedChannelChangeLogs({
    required this.updatedChannels,
    required this.deletedChannelUrls,
    required this.hasMore,
    this.token,
  });

  static FeedChannelChangeLogs fromJsonWithChat(
      Chat chat, Map<String, dynamic> json) {
    final res = _$FeedChannelChangeLogsFromJson(json);

    for (final channel in res.updatedChannels) {
      channel.set(chat);
    }
    return res;
  }
}
