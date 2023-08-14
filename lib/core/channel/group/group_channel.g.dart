// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannel _$GroupChannelFromJson(Map<String, dynamic> json) => GroupChannel(
      lastMessage: json['last_message'] == null
          ? null
          : BaseMessage.fromJson(json['last_message'] as Map<String, dynamic>),
      isSuper: json['is_super'] as bool? ?? false,
      isStrict: json['is_strict'] as bool? ?? false,
      isBroadcast: json['is_broadcast'] as bool? ?? false,
      isPublic: json['is_public'] as bool? ?? false,
      isDistinct: json['is_distinct'] as bool? ?? false,
      isDiscoverable: json['is_discoverable'] as bool? ?? false,
      isExclusive: json['is_exclusive'] as bool? ?? false,
      accessCodeRequired: json['is_access_code_required'] as bool? ?? false,
      unreadMessageCount: json['unread_message_count'] as int? ?? 0,
      unreadMentionCount: json['unread_mention_count'] as int? ?? 0,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      memberCount: json['member_count'] as int? ?? 0,
      joinedMemberCount: json['joined_member_count'] as int? ?? 0,
      joinedAt: json['joined_ts'] as int? ?? 0,
      myPushTriggerOption: $enumDecodeNullable(
              _$GroupChannelPushTriggerOptionEnumMap,
              json['push_trigger_option']) ??
          GroupChannelPushTriggerOption.global,
      myMemberState:
          $enumDecodeNullable(_$MemberStateEnumMap, json['member_state']) ??
              MemberState.none,
      myRole: $enumDecodeNullable(_$RoleEnumMap, json['my_role'],
              unknownValue: Role.none) ??
          Role.none,
      myMutedState: json['is_muted'] == null
          ? MuteState.unmuted
          : booltoMuteState(json['is_muted'] as bool?),
      myCountPreference: $enumDecodeNullable(
              _$CountPreferenceEnumMap, json['count_preference']) ??
          CountPreference.all,
      invitedAt: json['invited_at'] as int? ?? 0,
      inviter: json['inviter'] == null
          ? null
          : Member.fromJson(json['inviter'] as Map<String, dynamic>),
      isHidden: json['is_hidden'] as bool? ?? false,
      hiddenState: $enumDecodeNullable(
              _$GroupChannelHiddenStateEnumMap, json['hidden_state'],
              unknownValue: GroupChannelHiddenState.unhidden) ??
          GroupChannelHiddenState.unhidden,
      myLastRead: json['user_last_read'] as int? ?? 0,
      messageOffsetTimestamp: json['ts_message_offset'] as int?,
      messageSurvivalSeconds: json['message_survival_seconds'] as int? ?? -1,
      channelUrl: json['channel_url'] as String,
      name: json['name'] as String?,
      coverUrl: json['cover_url'] as String?,
      creator: json['created_by'] == null
          ? null
          : User.fromJson(json['created_by'] as Map<String, dynamic>),
      createdAt: json['created_at'] as int?,
      data: json['data'] as String?,
      customType: json['custom_type'] as String?,
      isFrozen: json['freeze'] as bool? ?? false,
      isEphemeral: json['is_ephemeral'] as bool? ?? false,
      lastPinnedMessage: json['latest_pinned_message'] == null
          ? null
          : BaseMessage.fromJson(
              json['latest_pinned_message'] as Map<String, dynamic>),
      pinnedMessagesUpdatedAt: json['pinned_messages_updated_at'] as int? ?? 0,
    )..pinnedMessageIds = (json['pinned_message_ids'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList();

Map<String, dynamic> _$GroupChannelToJson(GroupChannel instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'name': instance.name,
      'cover_url': instance.coverUrl,
      'created_by': instance.creator?.toJson(),
      'created_at': instance.createdAt,
      'data': instance.data,
      'custom_type': instance.customType,
      'freeze': instance.isFrozen,
      'is_ephemeral': instance.isEphemeral,
      'pinned_message_ids': instance.pinnedMessageIds,
      'last_message': instance.lastMessage?.toJson(),
      'is_super': instance.isSuper,
      'is_strict': instance.isStrict,
      'is_broadcast': instance.isBroadcast,
      'is_public': instance.isPublic,
      'is_distinct': instance.isDistinct,
      'is_discoverable': instance.isDiscoverable,
      'is_exclusive': instance.isExclusive,
      'is_access_code_required': instance.accessCodeRequired,
      'unread_message_count': instance.unreadMessageCount,
      'unread_mention_count': instance.unreadMentionCount,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'member_count': instance.memberCount,
      'joined_member_count': instance.joinedMemberCount,
      'push_trigger_option':
          _$GroupChannelPushTriggerOptionEnumMap[instance.myPushTriggerOption]!,
      'member_state': _$MemberStateEnumMap[instance.myMemberState]!,
      'my_role': _$RoleEnumMap[instance.myRole]!,
      'is_muted': _$MuteStateEnumMap[instance.myMutedState]!,
      'count_preference': _$CountPreferenceEnumMap[instance.myCountPreference]!,
      'inviter': instance.inviter?.toJson(),
      'invited_at': instance.invitedAt,
      'joined_ts': instance.joinedAt,
      'is_hidden': instance.isHidden,
      'hidden_state': _$GroupChannelHiddenStateEnumMap[instance.hiddenState]!,
      'user_last_read': instance.myLastRead,
      'ts_message_offset': instance.messageOffsetTimestamp,
      'message_survival_seconds': instance.messageSurvivalSeconds,
      'latest_pinned_message': instance.lastPinnedMessage?.toJson(),
      'pinned_messages_updated_at': instance.pinnedMessagesUpdatedAt,
    };

const _$GroupChannelPushTriggerOptionEnumMap = {
  GroupChannelPushTriggerOption.global: 'default',
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
  Role.chat_operator: 'operator',
};

const _$CountPreferenceEnumMap = {
  CountPreference.all: 'all',
  CountPreference.messageOnly: 'unread_message_count_only',
  CountPreference.mentionOnly: 'unread_mention_count_only',
  CountPreference.off: 'off',
};

const _$GroupChannelHiddenStateEnumMap = {
  GroupChannelHiddenState.unhidden: 'unhidden',
  GroupChannelHiddenState.allowAutoUnhide: 'allow_auto_unhide',
  GroupChannelHiddenState.preventAutoUnhide: 'prevent_auto_unhide',
};

const _$MuteStateEnumMap = {
  MuteState.unmuted: 'unmuted',
  MuteState.muted: 'muted',
};
