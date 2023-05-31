// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sender _$SenderFromJson(Map<String, dynamic> json) => Sender(
      isBlockedByMe: json['is_blocked_by_me'] as bool? ?? false,
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

const _$RoleEnumMap = {
  Role.none: 'none',
  Role.operator: 'operator',
};
