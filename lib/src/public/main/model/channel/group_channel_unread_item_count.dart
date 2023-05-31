// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

part 'group_channel_unread_item_count.g.dart';

/// The GroupChannelUnreadItemCount class for [SendbirdChat.getUnreadItemCount].
@JsonSerializable(createToJson: false)
class GroupChannelUnreadItemCount {
  /// Count of invitation of all group channels.
  final int? groupChannelInvitationCount;

  /// Count of unread mention in all of group channels.
  final int? groupChannelUnreadMentionCount;

  /// Count of unread message in all of group channels.
  final int? groupChannelUnreadMessageCount;

  /// Count of invitation of all non super group channels.
  final int? nonSuperGroupChannelInvitationCount;

  /// Count of unread mention in all of non super group channels.
  final int? nonSuperGroupChannelUnreadMentionCount;

  /// Count of unread message in all of non super group channels.
  final int? nonSuperGroupChannelUnreadMessageCount;

  /// Count of invitation of all super group channels.
  final int? superGroupChannelInvitationCount;

  /// count of unread mention in all of super group channels.
  final int? superGroupChannelUnreadMentionCount;

  /// Count of unread message in all of non super group channels.
  final int? superGroupChannelUnreadMessageCount;

  GroupChannelUnreadItemCount({
    this.groupChannelInvitationCount,
    this.groupChannelUnreadMentionCount,
    this.groupChannelUnreadMessageCount,
    this.superGroupChannelInvitationCount,
    this.superGroupChannelUnreadMentionCount,
    this.superGroupChannelUnreadMessageCount,
    this.nonSuperGroupChannelInvitationCount,
    this.nonSuperGroupChannelUnreadMentionCount,
    this.nonSuperGroupChannelUnreadMessageCount,
  });

  static GroupChannelUnreadItemCount fromJson(Map<String, dynamic> json) =>
      _$GroupChannelUnreadItemCountFromJson(json);
}
