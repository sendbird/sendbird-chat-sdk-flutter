import 'package:json_annotation/json_annotation.dart';

extension EnumTransform on List {
  T enumFromString<T>(String value) {
    return firstWhere((type) => type.toString().split('.').last == value,
        orElse: () => null);
  }
}

/// Represents message's sending status
enum MessageSendingStatus { none, pending, failed, succeeded, canceled }

/// Represents the type of channel
enum ChannelType { group, open }

extension ChannelTypeExtension on ChannelType {
  String get urlString {
    switch (this) {
      case ChannelType.group:
        return "group_channels";
      case ChannelType.open:
        return "open_channels";
      default:
        return null;
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
enum ScheduledUserMessageStatus { scheduled, sent, canceled, failed }

/// Represents push notification delivery option
enum PushNotificationDeliveryOption { normal, suppress }

/// Represents meta array update mode
enum MetaArrayUpdateMode { add, remove }

/// Represents role for user in a channel
enum Role {
  /// Default member
  none,

  /// Operator
  @JsonValue("operator")
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

String memberStateFilterToString(MemberStateFilter filter) {
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
    default:
      return 'all';
  }
}

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
enum GroupChannelSuperChannelFilter {
  all,
  @JsonValue('super')
  superChannel,
  @JsonValue('nonsuper')
  nonsuperChannel,
}

enum GroupChannelPublicChannelFilter { all, public, private }

const groupChannelSuperFilterEnumMap = <GroupChannelSuperChannelFilter, String>{
  GroupChannelSuperChannelFilter.all: 'all',
  GroupChannelSuperChannelFilter.superChannel: 'super',
  GroupChannelSuperChannelFilter.nonsuperChannel: 'nonsuper',
};

const groupChannelPublicFilterEnumMap =
    <GroupChannelPublicChannelFilter, String>{
  GroupChannelPublicChannelFilter.all: 'all',
  GroupChannelPublicChannelFilter.public: 'public',
  GroupChannelPublicChannelFilter.private: 'private',
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
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

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

  /// only support in my group channel
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
  if (fields == null || fields.isEmpty) {
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
enum LogLevel { none, debug, info, warning, error }

/// Represents sdk's connection status
enum ConnectionState { connecting, open, closed }

/// Represents push registration status
enum PushTokenRegistrationStatus { success, pending, error }

/// Represents push token type
enum PushTokenType { none, gcm, apns }

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

String stringFromUnreadItemKey(UnreadItemKey key) {
  if (key == UnreadItemKey.nonSuperGroupChannelUnreadMessageCount)
    return 'non_super_group_channel_unread_message_count';
  if (key == UnreadItemKey.superGroupChannelUnreadMessageCount)
    return 'super_group_channel_unread_message_count';
  if (key == UnreadItemKey.groupChannelUnreadMessageCount)
    return 'group_channel_unread_message_count';
  if (key == UnreadItemKey.nonSuperGroupChannelUnreadMentionCount)
    return 'non_super_group_channel_unread_mention_count';
  if (key == UnreadItemKey.superGroupChannelUnreadMentionCount)
    return 'super_group_channel_unread_mention_count';
  if (key == UnreadItemKey.groupChannelUnreadMentionCount)
    return 'group_channel_unread_mention_count';
  if (key == UnreadItemKey.nonSuperGroupChannelInvitationCount)
    return 'non_super_group_channel_invitation_count';
  if (key == UnreadItemKey.superGroupChannelInvitationCount)
    return 'super_group_channel_invitation_count';
  if (key == UnreadItemKey.groupChannelInvitationCount)
    return 'group_channel_invitation_count';
  return '';
}

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
}

// const channelEventEnumMap = <ChannelEventCategory, int>{
//   ChannelEventCategory.none: 0,
//   ChannelEventCategory.join: 10000,
//   ChannelEventCategory.leave: 10001,
//   ChannelEventCategory.updateOperators: 10002,
//   ChannelEventCategory.invite: 10020,
//   ChannelEventCategory.declineInvite: 10022,
//   ChannelEventCategory.enter: 10102,
//   ChannelEventCategory.exit: 10103,
//   ChannelEventCategory.unmute: 10200,
//   ChannelEventCategory.mute: 10201,
//   ChannelEventCategory.unban: 10600,
//   ChannelEventCategory.ban: 10601,
//   ChannelEventCategory.unfrozen: 10700,
//   ChannelEventCategory.frozen: 10701,
//   ChannelEventCategory.typingStart: 10900,
//   ChannelEventCategory.typingEnd: 10901,
//   ChannelEventCategory.propChanged: 11000,
//   ChannelEventCategory.deleted: 12000,
//   ChannelEventCategory.metaDataChanged: 11100,
//   ChannelEventCategory.metaCounterChanged: 11200,
//   ChannelEventCategory.hidden: 13000,
//   ChannelEventCategory.unhidden: 13001,
// };

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
    case 13000:
      return ChannelEventCategory.hidden;
    case 13001:
      return ChannelEventCategory.unhidden;
    default:
      return ChannelEventCategory.none;
  }
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

Map<String, bool> paramsFromChannelIncludeOption(
    List<ChannelQueryIncludeOption> options) {
  final params = Map<String, bool>();
  options.forEach((element) {
    if (element == ChannelQueryIncludeOption.emptyChannel)
      params['show_empty'] = true;
    else if (element == ChannelQueryIncludeOption.memberList)
      params['show_member'] = true;
    else if (element == ChannelQueryIncludeOption.frozenChannel)
      params['show_frozen'] = true;
    else if (element == ChannelQueryIncludeOption.readReceipt)
      params['show_read_receipt'] = true;
    else if (element == ChannelQueryIncludeOption.deliveryReceipt)
      params['show_delivery_receipt'] = true;
    else if (element == ChannelQueryIncludeOption.metaData)
      params['show_metadata'] = true;
  });
  return params;
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
  cancelled,
}
