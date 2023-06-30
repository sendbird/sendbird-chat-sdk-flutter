// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/feed_channel/feed_channel_refresh_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';

/// Represents a feed channel.
/// @since 4.0.3
class FeedChannel extends BaseChannel {
  /// The unique channel URL.
  /// @since 4.0.3
  @override
  String get channelUrl => groupChannel.channelUrl;
  @override
  set channelUrl(value) => groupChannel.channelUrl = value;

  /// The topic or name of the channel.
  /// @since 4.0.3
  @override
  String get name => groupChannel.name;
  @override
  set name(value) => groupChannel.name = value;

  /// The creation time of the channel.
  /// @since 4.0.3
  @override
  int? get createdAt => groupChannel.createdAt;
  @override
  set createdAt(value) => groupChannel.createdAt = value;

  /// Member list for this channel.
  /// @since 4.0.3
  List<Member> get members => groupChannel.members;

  /// The total member count for this channel.
  /// @since 4.0.3
  int get memberCount => groupChannel.memberCount;

  /// My member state.
  /// @since 4.0.3
  MemberState get myMemberState => groupChannel.myMemberState;

  /// Current user's last read receipt timestamp in channel.
  /// @since 4.0.3
  int get myLastRead => groupChannel.myLastRead;

  /// The last message of the channel.
  /// @since 4.0.3
  BaseMessage? get lastMessage => groupChannel.lastMessage;

  /// The unread message count for this channel for the current [User].
  /// @since 4.0.3
  int get unreadMessageCount => groupChannel.unreadMessageCount;

  GroupChannel groupChannel;
  int _lastMarkAsReadTimestamp;

  FeedChannel({
    required this.groupChannel,
  })  : _lastMarkAsReadTimestamp = 0,
        super(
          channelUrl: groupChannel.channelUrl,
          name: groupChannel.name,
          coverUrl: groupChannel.coverUrl,
          createdAt: groupChannel.createdAt,
          data: groupChannel.data,
          customType: groupChannel.customType,
          isFrozen: groupChannel.isFrozen,
          isEphemeral: groupChannel.isEphemeral,
          fromCache: false,
          dirty: false,
        );

  static Future<FeedChannel> getChannel(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    final channel = chat.channelCache.find<FeedChannel>(channelKey: channelUrl);
    if (channel != null && !channel.dirty) {
      channel.fromCache = true;
      return channel;
    }
    return await FeedChannel.refresh(channelUrl, chat: chat);
  }

  /// Refreshes all the data of this channel.
  /// @since 4.0.3
  static Future<FeedChannel> refresh(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    return await chat.apiClient.send<FeedChannel>(
      FeedChannelRefreshRequest(
        chat,
        channelUrl,
        options: [
          ChannelListQueryIncludeOption.includeMember,
          ChannelListQueryIncludeOption.includeMetadata,
          ChannelListQueryIncludeOption.includeReadReceipt,
          ChannelListQueryIncludeOption.includeDeliveryReceipt,
        ],
        passive: false,
      ),
    );
  }

  /// Sends mark as read to this channel.
  /// @since 4.0.3
  Future<void> markAsRead() async {
    sbLog.i(StackTrace.current);

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastMarkAsReadTimestamp <= 1000) {
      throw MarkAsReadRateLimitExceededException();
    }

    _lastMarkAsReadTimestamp = now;
    final cmd = Command.buildRead(channelUrl);
    await chat.commandManager.sendCommand(cmd);
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    return other is FeedChannel && other.groupChannel == groupChannel;
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        groupChannel.hashCode,
      );

  @override
  void copyWith(dynamic other) {
    super.copyWith(other);
    if (other is FeedChannel) {
      groupChannel = other.groupChannel;
    }
  }
}
