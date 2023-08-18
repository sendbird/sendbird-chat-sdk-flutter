// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannel _$GroupChannelFromJson(Map<String, dynamic> json) => GroupChannel(
      channelUrl: json['channelUrl'] as String,
      lastMessage: json['lastMessage'] == null
          ? null
          : BaseMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
      isSuper: json['isSuper'] as bool? ?? false,
      isBroadcast: json['isBroadcast'] as bool? ?? false,
      isPublic: json['isPublic'] as bool? ?? false,
      isDistinct: json['isDistinct'] as bool? ?? false,
      isDiscoverable: json['isDiscoverable'] as bool? ?? false,
      isExclusive: json['isExclusive'] as bool? ?? false,
      isAccessCodeRequired: json['isAccessCodeRequired'] as bool? ?? false,
      unreadMessageCount: json['unreadMessageCount'] as int? ?? 0,
      unreadMentionCount: json['unreadMentionCount'] as int? ?? 0,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      memberCount: json['memberCount'] as int? ?? 0,
      joinedMemberCount: json['joinedMemberCount'] as int? ?? 0,
      myPushTriggerOption: $enumDecodeNullable(
              _$GroupChannelPushTriggerOptionEnumMap,
              json['push_trigger_option']) ??
          GroupChannelPushTriggerOption.defaultValue,
      isChatNotification: json['isChatNotification'] as bool? ?? false,
      myMemberState:
          $enumDecodeNullable(_$MemberStateEnumMap, json['member_state']) ??
              MemberState.none,
      myRole: $enumDecodeNullable(_$RoleEnumMap, json['myRole'],
              unknownValue: Role.none) ??
          Role.none,
      myMutedState: json['is_muted'] == null
          ? MuteState.unmuted
          : boolToMuteState(json['is_muted'] as bool?),
      myCountPreference: $enumDecodeNullable(
              _$CountPreferenceEnumMap, json['count_preference']) ??
          CountPreference.all,
      creator: json['created_by'] == null
          ? null
          : User.fromJson(json['created_by'] as Map<String, dynamic>),
      inviter: json['inviter'] == null
          ? null
          : Member.fromJson(json['inviter'] as Map<String, dynamic>),
      invitedAt: json['invitedAt'] as int? ?? 0,
      joinedAt: json['joined_ts'] as int? ?? 0,
      isHidden: json['isHidden'] as bool? ?? false,
      hiddenState: $enumDecodeNullable(
              _$GroupChannelHiddenStateEnumMap, json['hiddenState'],
              unknownValue: GroupChannelHiddenState.unhidden) ??
          GroupChannelHiddenState.unhidden,
      myLastRead: json['user_last_read'] as int? ?? 0,
      messageOffsetTimestamp: json['ts_message_offset'] as int?,
      messageSurvivalSeconds: json['messageSurvivalSeconds'] as int? ?? -1,
      pinnedMessageIds: (json['pinnedMessageIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      lastPinnedMessage: json['latest_pinned_message'] == null
          ? null
          : BaseMessage.fromJson(
              json['latest_pinned_message'] as Map<String, dynamic>),
      name: json['name'] as String? ?? '',
      coverUrl: json['coverUrl'] as String? ?? '',
      createdAt: json['createdAt'] as int?,
      data: json['data'] as String? ?? '',
      customType: json['customType'] as String? ?? '',
      isFrozen: json['freeze'] as bool? ?? false,
      isEphemeral: json['isEphemeral'] as bool? ?? false,
    );

const _$GroupChannelPushTriggerOptionEnumMap = {
  GroupChannelPushTriggerOption.defaultValue: 'default',
  GroupChannelPushTriggerOption.all: 'all',
  GroupChannelPushTriggerOption.off: 'off',
  GroupChannelPushTriggerOption.mentionOnly: 'mention_only',
};

const _$MemberStateEnumMap = {
  MemberState.none: 'none',
  MemberState.invited: 'invited',
  MemberState.joined: 'joined',
};

const _$RoleEnumMap = {
  Role.none: 'none',
  Role.operator: 'operator',
};

const _$CountPreferenceEnumMap = {
  CountPreference.all: 'all',
  CountPreference.unreadMessageCountOnly: 'unread_message_count_only',
  CountPreference.unrealMentionCountOnly: 'unread_mention_count_only',
  CountPreference.off: 'off',
};

const _$GroupChannelHiddenStateEnumMap = {
  GroupChannelHiddenState.unhidden: 'unhidden',
  GroupChannelHiddenState.allowAutoUnhide: 'allow_auto_unhide',
  GroupChannelHiddenState.preventAutoUnhide: 'prevent_auto_unhide',
};
