import 'package:json_annotation/json_annotation.dart';

/// Represents Scheduled Status
enum ScheduledStatus {
  pending,
  @JsonValue('in_queue')
  inQueue,
  sent,
  failed,
  canceled,
  removed,
}

const scheduledMessageListOrderEnumMap = <ScheduledMessageListOrder, String>{
  ScheduledMessageListOrder.createdAt: 'created_at',
  ScheduledMessageListOrder.scheduledAt: 'scheduled_at',
};

/// Represnts Ordering of Scheduled Message List
enum ScheduledMessageListOrder {
  @JsonValue('created_at')
  createdAt,
  @JsonValue('scheduled_at')
  scheduledAt,
}

/// Represents poll status
enum PollStatus {
  @JsonValue('open')
  open,
  @JsonValue('closed')
  closed
}

/// Represents message's reply type
enum ReplyType {
  @JsonValue('NONE')
  none,
  @JsonValue('ALL')
  all,
  @JsonValue('ONLY_REPLY_TO_CHANNEL')
  only_reply_to_channel
}

/// Represents message's sending status
enum MessageSendingStatus { none, pending, failed, succeeded, canceled }

/// Represents the type of channel
enum ChannelType { group, open }

extension ChannelTypeExtension on ChannelType {
  String get urlString {
    switch (this) {
      case ChannelType.group:
        return 'group_channels';
      case ChannelType.open:
        return 'open_channels';
    }
  }

  String get commandString {
    switch (this) {
      case ChannelType.group:
        return 'group';
      case ChannelType.open:
        return 'open';
    }
  }
}

/// Represents message's mention type
enum MentionType {
  /// Mentions with specific users
  users,

  /// Mentions for entire channel
  channel
}

/// Represents scheduled user message status
enum ScheduledUserMessageStatus { scheduled, sent, canceled, failed, pending }

/// Represents push notification delivery option
enum PushNotificationDeliveryOption { normal, suppress, force }

/// Represents meta array update mode
enum MetaArrayUpdateMode { add, remove }

/// Represents role for user in a channel
enum Role {
  /// Default member
  none,

  /// Operator
  @JsonValue('operator')
  chat_operator
}

/// Represents member state for user in a channel
enum MemberState { none, invited, joined }

/// Represents a filter for member state
enum MemberStateFilter {
  all,

  invited,

  joined,

  @JsonValue('invited_by_friend')
  invitedByFriend,

  @JsonValue('invited_by_non_friend')
  invitedByNonFriend,
}

String memberStateFilterEnumForQuery(MemberStateFilter filter) {
  switch (filter) {
    case MemberStateFilter.all:
      return 'all';
    case MemberStateFilter.invited:
      return 'invited_only';
    case MemberStateFilter.joined:
      return 'joined_only';
    case MemberStateFilter.invitedByFriend:
      return 'invited_by_friend';
    case MemberStateFilter.invitedByNonFriend:
      return 'invited_by_non_friend';
  }
}

String memberStateFilterEnumForGroupCount(MemberStateFilter filter) {
  switch (filter) {
    case MemberStateFilter.all:
      return 'all';
    case MemberStateFilter.invited:
      return 'invited';
    case MemberStateFilter.joined:
      return 'joined';
    case MemberStateFilter.invitedByFriend:
      return 'invited_by_friend';
    case MemberStateFilter.invitedByNonFriend:
      return 'invited_by_non_friend';
  }
}

/// Represents a filter for public group channel member state
enum PublicGroupChannelMembershipFilter {
  all,
  joined,
}

const messageTypeEnumMap = <MessageType, String>{
  MessageType.admin: 'ADMN',
  MessageType.file: 'FILE',
  MessageType.user: 'MESG',
};

/// Represents message type
enum MessageType {
  @JsonValue(null)
  all,
  @JsonValue('MESG')
  user,
  @JsonValue('FILE')
  file,
  @JsonValue('ADMN')
  admin
}

const messageTypeFilterEnumMap = <MessageTypeFilter, String>{
  MessageTypeFilter.admin: 'ADMN',
  MessageTypeFilter.file: 'FILE',
  MessageTypeFilter.user: 'MESG',
};

/// Represents a filter for message type
enum MessageTypeFilter {
  @JsonValue(null)
  all,
  @JsonValue('MESG')
  user,
  @JsonValue('FILE')
  file,
  @JsonValue('ADMN')
  admin
}

/// Represents a filter for super group channel
enum SuperChannelFilter {
  all,

  @JsonValue('exclusive_only')
  exclusiveOnly,

  @JsonValue('super')
  superChannel,

  @JsonValue('nonsuper')
  nonsuperChannel,

  @JsonValue('broadcast_only')
  broadcastOnly,
}

String groupChannelSuperFilterEnum(SuperChannelFilter filter) {
  switch (filter) {
    case SuperChannelFilter.all:
      return 'all';
    case SuperChannelFilter.exclusiveOnly:
      return 'exclusive_only';
    case SuperChannelFilter.superChannel:
      return 'super';
    case SuperChannelFilter.nonsuperChannel:
      return 'nonsuper';
    case SuperChannelFilter.broadcastOnly:
      return 'broadcast_only';
  }
}

/// Represents a filter for group channel visibilty
enum PublicChannelFilter { all, public, private }

const groupChannelPublicFilterEnumMap = <PublicChannelFilter, String>{
  PublicChannelFilter.all: 'all',
  PublicChannelFilter.public: 'public',
  PublicChannelFilter.private: 'private',
};

/// Represents a filter for unread channel
enum UnreadChannelFilter {
  all,
  @JsonValue('unread_message')
  unreadMessage
}

/// Defines reporting category
enum ReportCategory { suspicious, harassing, spam, inappropriate }

/// Represents user's mute state in a channel
enum MuteState { unmuted, muted }

enum UserConnectionStatus { online, offline, notAvailable }

/// Represents global push trigger option
enum PushTriggerOption {
  all,
  off,
  @JsonValue('mention_only')
  mentionOnly,
}

const pushTriggerOptionEnumMap = <PushTriggerOption, String>{
  PushTriggerOption.all: 'all',
  PushTriggerOption.off: 'off',
  PushTriggerOption.mentionOnly: 'mention_only',
};

/// Represents push trigger option for a group channel
enum GroupChannelPushTriggerOption {
  @JsonValue('default')
  global,
  all,
  off,
  @JsonValue('mention_only')
  mentionOnly,
}

const groupChannelPushTriggerOptionEnumMap =
    <GroupChannelPushTriggerOption, String>{
  GroupChannelPushTriggerOption.global: 'default',
  GroupChannelPushTriggerOption.all: 'all',
  GroupChannelPushTriggerOption.off: 'off',
  GroupChannelPushTriggerOption.mentionOnly: 'mention_only',
};

/// Represents user's message count filter
enum CountPreference {
  all,
  @JsonValue('unread_message_count_only')
  messageOnly,
  @JsonValue('unread_mention_count_only')
  mentionOnly,
  off
}

const countPreferenceEnumMap = <CountPreference, String>{
  CountPreference.all: 'all',
  CountPreference.messageOnly: 'unread_message_count_only',
  CountPreference.mentionOnly: 'unread_mention_count_only',
  CountPreference.off: 'off',
};

T enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  required T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source).key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

/// Represents channel's visibility state
enum GroupChannelHiddenState {
  unhidden,

  @JsonValue('allow_auto_unhide')
  allowAutoUnhide,

  @JsonValue('prevent_auto_unhide')
  preventAutoUnhide,
}

/// Represents a filter for channel's visibility state
enum ChannelHiddenStateFilter {
  all,

  @JsonValue('unhidden_only')
  unhiddenOnly,

  @JsonValue('hidden_only')
  hiddenOnly,

  @JsonValue('hidden_allow_auto_hide')
  hiddenAllowAutoUnhide,

  @JsonValue('hidden_prevent_auto_unhide')
  hiddenPreventAutoUnhide
}

/// Represents result order of group channel query
enum GroupChannelListOrder {
  chronological,

  @JsonValue('latest_last_message')
  latestLastMessage,

  @JsonValue('channel_name_alphabetical')
  channelNameAlphabetical,

  @JsonValue('metadata_value_alphabetical')
  channelMetaDataValueAlphabetical
}

const groupChannelListOrderEnumMap = <GroupChannelListOrder, String>{
  GroupChannelListOrder.chronological: 'chronological',
  GroupChannelListOrder.latestLastMessage: 'latest_last_message',
  GroupChannelListOrder.channelNameAlphabetical: 'channel_name_alphabetical',
  GroupChannelListOrder.channelMetaDataValueAlphabetical:
      'metadata_value_alphabetical',
};

/// Represents result order of public group channel query
enum PublicGroupChannelListOrder {
  chronological,

  @JsonValue('channel_name_alphabetical')
  channelNameAlphabetical,

  @JsonValue('metadata_value_alphabetical')
  channelMetaDataValueAlphabetical
}

const publicGroupChannelListOrderEnumMap =
    <PublicGroupChannelListOrder, String>{
  PublicGroupChannelListOrder.chronological: 'chronological',
  PublicGroupChannelListOrder.channelNameAlphabetical:
      'channel_name_alphabetical',
  PublicGroupChannelListOrder.channelMetaDataValueAlphabetical:
      'metadata_value_alphabetical',
};

/// Defines query operational type
enum GroupChannelListQueryType { and, or }

/// Represents group channel search field
enum GroupChannelListQuerySearchField {
  @JsonValue('member_nick_name')
  memberNickname,
  @JsonValue('channel_name')
  channelName
}

const groupChannelListQuerySearchFieldEnumMap =
    <GroupChannelListQuerySearchField, String>{
  GroupChannelListQuerySearchField.memberNickname: 'member_nick_name',
  GroupChannelListQuerySearchField.channelName: 'channel_name',
};

List<String> stringFromSearchFields(
    List<GroupChannelListQuerySearchField> fields) {
  if (fields.isEmpty) {
    return [];
  }

  final result = <String>[];
  fields.forEach((element) {
    if (element == GroupChannelListQuerySearchField.memberNickname) {
      result.add('member_nick_name');
    } else {
      result.add('channel_name');
    }
  });
  return result;
}

/// Represents a filter for user list query
enum UserListQueryType { blocked, participants, muted, banned, filtered }

/// Represents result order for message search
enum MessageSearchQueryOrder { score, timestamp }

const messageSearchQueryOrderEnumMap = <MessageSearchQueryOrder, String>{
  MessageSearchQueryOrder.score: 'score',
  MessageSearchQueryOrder.timestamp: 'ts',
};

/// Defines levels of logging level
enum LogLevel {
  none,
  info,
  warning,
  error,
  verbose,
}

/// Represents sdk's connection status
enum ConnectionState { connecting, open, closed }

/// Represents push registration status
enum PushTokenRegistrationStatus { success, pending, error }

/// Represents push token type
enum PushTokenType { none, hms, fcm, apns }

String? pushTokenToString(PushTokenType type) {
  switch (type) {
    case PushTokenType.apns:
      return 'apns';
    case PushTokenType.fcm:
      return 'gcm';
    case PushTokenType.hms:
      return 'huawei';
    default:
      return null;
  }
}

/// Represents unread item key filter
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
  groupChannelInvitationCount
}

const unreadItemKeyEnumMap = <UnreadItemKey, String>{
  UnreadItemKey.nonSuperGroupChannelUnreadMessageCount:
      'non_super_group_channel_unread_message_count',
  UnreadItemKey.superGroupChannelUnreadMessageCount:
      'super_group_channel_unread_message_count',
  UnreadItemKey.groupChannelUnreadMessageCount:
      'group_channel_unread_message_count',
  UnreadItemKey.nonSuperGroupChannelUnreadMentionCount:
      'non_super_group_channel_unread_mention_count',
  UnreadItemKey.superGroupChannelUnreadMentionCount:
      'super_group_channel_unread_mention_count',
  UnreadItemKey.groupChannelUnreadMentionCount:
      'group_channel_unread_mention_count',
  UnreadItemKey.nonSuperGroupChannelInvitationCount:
      'non_super_group_channel_invitation_count',
  UnreadItemKey.superGroupChannelInvitationCount:
      'super_group_channel_invitation_count',
  UnreadItemKey.groupChannelInvitationCount: 'group_channel_invitation_count',
};

/// Represents user event that comes from socket
enum UserEventCategory { none, unblock, block, friendDiscoveryReady }

UserEventCategory userEventValueOf(int value) {
  switch (value) {
    case 20000:
      return UserEventCategory.unblock;
    case 20001:
      return UserEventCategory.block;
    case 20900:
      return UserEventCategory.friendDiscoveryReady;
    default:
      return UserEventCategory.none;
  }
}

/// Represents meta counter operation mode
enum MetaCounterMode { set, increase, decrease }

/// Represents channel event that comes from socket
enum ChannelEventCategory {
  none,
  join,
  leave,
  updateOperators,
  invite,
  declineInvite,
  enter,
  exit,
  mute,
  unmute,
  ban,
  unban,
  frozen,
  unfrozen,
  typingStart,
  typingEnd,
  propChanged,
  deleted,
  metaDataChanged,
  metaCounterChanged,
  hidden,
  unhidden,
  pinnedMessage
}

ChannelEventCategory channelEventValueOf(int value) {
  switch (value) {
    case 0:
      return ChannelEventCategory.none;
    case 10000:
      return ChannelEventCategory.join;
    case 10001:
      return ChannelEventCategory.leave;
    case 10002:
      return ChannelEventCategory.updateOperators;
    case 10020:
      return ChannelEventCategory.invite;
    case 10022:
      return ChannelEventCategory.declineInvite;
    case 10102:
      return ChannelEventCategory.enter;
    case 10103:
      return ChannelEventCategory.exit;
    case 10201:
      return ChannelEventCategory.mute;
    case 10200:
      return ChannelEventCategory.unmute;
    case 10601:
      return ChannelEventCategory.ban;
    case 10600:
      return ChannelEventCategory.unban;
    case 10701:
      return ChannelEventCategory.frozen;
    case 10700:
      return ChannelEventCategory.unfrozen;
    case 10900:
      return ChannelEventCategory.typingStart;
    case 10901:
      return ChannelEventCategory.typingEnd;
    case 11000:
      return ChannelEventCategory.propChanged;
    case 12000:
      return ChannelEventCategory.deleted;
    case 11100:
      return ChannelEventCategory.metaDataChanged;
    case 11200:
      return ChannelEventCategory.metaCounterChanged;
    case 11300:
      return ChannelEventCategory.pinnedMessage;
    case 13000:
      return ChannelEventCategory.hidden;
    case 13001:
      return ChannelEventCategory.unhidden;
    default:
      return ChannelEventCategory.none;
  }
}

enum MessageQueryIncludeOption {
  metaArray,
  reactions,
  replies,
  parentMessageText,
  threadInfo,
}

/// Represents option to filter channel
enum ChannelQueryIncludeOption {
  emptyChannel,
  memberList,
  frozenChannel,
  readReceipt,
  deliveryReceipt,
  metaData,
}

extension IncludeOptionList on List<ChannelQueryIncludeOption> {
  Map<String, bool> toJson() {
    final hasEmpty = contains(ChannelQueryIncludeOption.emptyChannel);
    final hasMember = contains(ChannelQueryIncludeOption.memberList);
    final hasFrozen = contains(ChannelQueryIncludeOption.frozenChannel);
    final hasRead = contains(ChannelQueryIncludeOption.readReceipt);
    final hasDelivery = contains(ChannelQueryIncludeOption.deliveryReceipt);
    final hasMeta = contains(ChannelQueryIncludeOption.metaData);

    return {
      if (hasEmpty) 'show_empty': true,
      if (hasMember) 'show_member': true,
      if (hasFrozen) 'show_frozen': true,
      if (hasRead) 'show_read_receipt': true,
      if (hasDelivery) 'show_delivery_receipt': true,
      if (hasMeta) 'show_metadata': true,
    };
  }
}

/// Represents reaction's operation event
enum ReactionEventAction {
  @JsonValue('ADD')
  add,
  @JsonValue('DELETE')
  delete,
}

/// Represents sdk's connection event
enum ConnectionEventType {
  started,
  succeeded,
  failed,
  canceled,
}

enum OperatorFilter {
  all,
  operator,
  nonOperator,
}

const operatorFilterEnumMap = <OperatorFilter, String>{
  OperatorFilter.all: 'all',
  OperatorFilter.operator: 'operator',
  OperatorFilter.nonOperator: 'nonoperator',
};

enum MutedMemberFilter {
  all,
  muted,
  unmuted,
}

const mutedMemberFilterEnumMap = <MutedMemberFilter, String>{
  MutedMemberFilter.all: 'all',
  MutedMemberFilter.muted: 'muted',
  MutedMemberFilter.unmuted: 'unmuted',
};

enum MemberListOrder {
  nicknameAlphabetical,
  operatorThenMemberNicknameAlphabetical,
}

const memberListOrderEnumMap = <MemberListOrder, String>{
  MemberListOrder.nicknameAlphabetical: 'member_nickname_alphabetical',
  MemberListOrder.operatorThenMemberNicknameAlphabetical:
      'operator_then_member_alphabetical',
};

enum RestrictionType {
  muted,
  banned,
}
