// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      memberState: $enumDecodeNullable(_$MemberStateEnumMap, json['state'],
              unknownValue: MemberState.none) ??
          MemberState.none,
      isBlockedByMe: json['is_blocked_by_me'] as bool? ?? false,
      isBlockingMe: json['is_blocking_me'] as bool? ?? false,
      isMuted: json['is_muted'] as bool? ?? false,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role'],
              unknownValue: Role.none) ??
          Role.none,
      userId: json['user_id'] as String,
      nickname: json['nickname'] as String,
      profileUrl: json['profile_url'] as String? ?? '',
      connectionStatus: json['is_online'] == null
          ? UserConnectionStatus.notAvailable
          : boolToConnectionStatus(json['is_online'] as bool?),
      lastSeenAt: json['last_seen_at'] as int?,
      preferredLanguages: (json['preferred_languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      friendDiscoveryKey: json['friend_discovery_key'] as String? ?? '',
      friendName: json['friend_name'] as String? ?? '',
      metaData: (json['metadata'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      requireAuth: json['require_auth_for_profile_image'] as bool? ?? false,
    )..isActive = json['is_active'] as bool?;

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'profile_url': instance.profileUrl,
      'is_online': connectionStatusToBool(instance.connectionStatus),
      'last_seen_at': instance.lastSeenAt,
      'is_active': instance.isActive,
      'preferred_languages': instance.preferredLanguages,
      'friend_discovery_key': instance.friendDiscoveryKey,
      'friend_name': instance.friendName,
      'metadata': instance.metaData,
      'require_auth_for_profile_image': instance.requireAuth,
      'state': _$MemberStateEnumMap[instance.memberState]!,
      'is_blocked_by_me': instance.isBlockedByMe,
      'is_blocking_me': instance.isBlockingMe,
      'is_muted': instance.isMuted,
      'role': _$RoleEnumMap[instance.role]!,
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
