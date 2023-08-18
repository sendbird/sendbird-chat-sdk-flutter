// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sender _$SenderFromJson(Map<String, dynamic> json) => Sender(
      isBlockedByMe: json['isBlockedByMe'] as bool? ?? false,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role'],
              unknownValue: Role.none) ??
          Role.none,
      userId: json['userId'] as String,
      nickname: json['nickname'] as String,
      profileUrl: json['profileUrl'] as String? ?? '',
      connectionStatus: json['is_online'] == null
          ? UserConnectionStatus.notAvailable
          : boolToConnectionStatus(json['is_online'] as bool?),
      lastSeenAt: json['lastSeenAt'] as int?,
      preferredLanguages: (json['preferredLanguages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      friendDiscoveryKey: json['friendDiscoveryKey'] as String? ?? '',
      friendName: json['friendName'] as String? ?? '',
      metaData: (json['metadata'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      requireAuth: json['require_auth_for_profile_image'] as bool? ?? false,
    )..isActive = json['isActive'] as bool?;

const _$RoleEnumMap = {
  Role.none: 'none',
  Role.operator: 'operator',
};
