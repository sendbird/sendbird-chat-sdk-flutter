// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';

/// MyConnectionState
enum MyConnectionState {
  connecting,
  open,
  closed,
}

/// ReplyType
enum ReplyType {
  @JsonValue('none')
  none,
  @JsonValue('all')
  all,
  @JsonValue('only_reply_to_channel')
  onlyReplyToChannel,
}

/// MessageSendingStatus
enum SendingStatus {
  none,
  pending,
  failed,
  succeeded,
  canceled,
}

/// ChannelType
enum ChannelType {
  group,
  open,

  /// @since 4.0.3
  feed,
}

/// MentionType
enum MentionType {
  users,
  channel,
}

/// PushNotificationDeliveryOption
enum PushNotificationDeliveryOption {
  normal,
  suppress,
  force,
}

/// Role
enum Role {
  none,
  operator,
}

/// MemberState
enum MemberState {
  none,
  invited,
  joined,
}

/// MyMemberStateFilter
enum MyMemberStateFilter {
  all,
  invited,
  joined,
  @JsonValue('invited_by_friend')
  invitedByFriend,
  @JsonValue('invited_by_non_friend')
  invitedByNonFriend,
}

/// MembershipFilter
enum MembershipFilter {
  all,
  joined,
}

/// MessageTypeFilter
enum MessageTypeFilter {
  @JsonValue('')
  all,
  @JsonValue('MESG')
  user,
  @JsonValue('FILE')
  file,
  @JsonValue('ADMN')
  admin
}

/// SuperChannelFilter
enum SuperChannelFilter {
  all,
  @JsonValue('exclusive_only')
  exclusiveChannelOnly,
  @JsonValue('super')
  superChannelOnly,
  @JsonValue('nonsuper')
  nonsuperChannelOnly,
  @JsonValue('broadcast_only')
  broadcastChannelOnly,
}

/// PublicChannelFilter
enum PublicChannelFilter {
  all,
  public,
  private,
}

/// UnreadChannelFilter
enum UnreadChannelFilter {
  all,
  @JsonValue('unread_message')
  unreadMessage,
}

/// ReportCategory
enum ReportCategory {
  suspicious,
  harassing,
  spam,
  inappropriate,
}

/// MuteState
enum MuteState {
  unmuted,
  muted,
}

/// PushTriggerOption
enum PushTriggerOption {
  all,
  off,
  @JsonValue('mention_only')
  mentionOnly,
}

/// GroupChannelPushTriggerOption
enum GroupChannelPushTriggerOption {
  @JsonValue('default')
  defaultValue,
  all,
  off,
  @JsonValue('mention_only')
  mentionOnly,
}

/// CountPreference
enum CountPreference {
  all,
  @JsonValue('unread_message_count_only')
  unreadMessageCountOnly,
  @JsonValue('unread_mention_count_only')
  unrealMentionCountOnly,
  off,
}

/// GroupChannelHiddenState
enum GroupChannelHiddenState {
  unhidden,
  @JsonValue('allow_auto_unhide')
  allowAutoUnhide,
  @JsonValue('prevent_auto_unhide')
  preventAutoUnhide,
}

/// HiddenChannelFilter
enum HiddenChannelFilter {
  all,
  @JsonValue('unhidden_only')
  unhidden,
  @JsonValue('hidden_only')
  hidden,
  @JsonValue('hidden_allow_auto_hide')
  hiddenAllowAutoUnhide,
  @JsonValue('hidden_prevent_auto_unhide')
  hiddenPreventAutoUnhide,
}

/// GroupChannelListQueryOrder
/// [chronological] query returns the result as by event time descending order.
/// [latestLastMessage] query returns the result as by event time descending order.
/// [channelNameAlphabetical] query returns the result as by channel name alphabetical order.
enum GroupChannelListQueryOrder {
  chronological,
  @JsonValue('latest_last_message')
  latestLastMessage,
  @JsonValue('channel_name_alphabetical')
  channelNameAlphabetical,
  @JsonValue('metadata_value_alphabetical')
  metadataValueAlphabetical,
}

/// GroupChannelListQueryType
enum GroupChannelListQueryType {
  and,
  or,
}

/// GroupChannelListQuerySearchField
enum GroupChannelListQuerySearchField {
  @JsonValue('member_nick_name')
  memberNickname,
  @JsonValue('channel_name')
  channelName,
}

/// The order in which the query result will be based on.
/// [score] query returns the result as by their matching score.
/// [timestamp] query returns the result as by [BaseMessage]'s timestamp.
/// @since 4.0.13
enum MessageSearchQueryOrder {
  score,
  timestamp,
}

/// PushTokenRegistrationStatus
enum PushTokenRegistrationStatus {
  success,
  pending,
  error,
}

/// PushTokenType
enum PushTokenType {
  fcm,
  apns,
  hms,
}

/// UnreadItemKey
enum UnreadItemKey {
  @JsonValue('non_super_group_channel_unread_message_count')
  nonSuperGroupChannelUnreadMessageCount,
  @JsonValue('super_group_channel_unread_message_count')
  superGroupChannelUnreadMessageCount,
  @JsonValue('group_channel_unread_message_count')
  groupChannelUnreadMessageCount,
  @JsonValue('non_super_group_channel_unread_mention_count')
  nonSuperGroupChannelUnreadMentionCount,
  @JsonValue('super_group_channel_unread_mention_count')
  superGroupChannelUnreadMentionCount,
  @JsonValue('group_channel_unread_mention_count')
  groupChannelUnreadMentionCount,
  @JsonValue('non_super_group_channel_invitation_count')
  nonSuperGroupChannelInvitationCount,
  @JsonValue('super_group_channel_invitation_count')
  superGroupChannelInvitationCount,
  @JsonValue('group_channel_invitation_count')
  groupChannelInvitationCount,
}

/// ReactionEventAction
enum ReactionEventAction {
  @JsonValue('ADD')
  add,
  @JsonValue('DELETE')
  delete,
}

/// OperatorFilter
enum OperatorFilter {
  all,
  operator,
  nonOperator,
}

/// MutedMemberFilter
enum MutedMemberFilter {
  all,
  muted,
  unmuted,
}

/// MemberListOrder
enum MemberListOrder {
  nicknameAlphabetical,
  operatorThenMemberNicknameAlphabetical,
}

/// UserConnectionStatus
enum UserConnectionStatus {
  online,
  offline,
  notAvailable,
}

/// ScheduledStatus
enum ScheduledStatus {
  pending,
  @JsonValue('in_queue')
  inQueue,
  sent,
  failed,
  canceled,
  removed,
}

/// ScheduledMessageListQueryOrder
enum ScheduledMessageListQueryOrder {
  @JsonValue('created_at')
  createdAt,
  @JsonValue('scheduled_at')
  scheduledAt,
}

/// PollStatus
enum PollStatus {
  @JsonValue('open')
  open,
  @JsonValue('closed')
  closed,
}

/// RestrictionType
enum RestrictionType {
  muted,
  banned,
}

/// LogLevel
enum LogLevel {
  none,
  error,
  warning,
  info,
}
