// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restricted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestrictedUser _$RestrictedUserFromJson(Map<String, dynamic> json) =>
    RestrictedUser(
      userId: json['user_id'] as String,
      nickname: json['nickname'] as String,
      profileUrl: json['profile_url'] as String? ?? '',
      connectionStatus: json['is_online'] == null
          ? UserConnectionStatus.notAvailable
          : boolToConnectionStatus(json['is_online'] as bool?),
      lastSeenAt: (json['last_seen_at'] as num?)?.toInt(),
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

RestrictionInfo _$RestrictionInfoFromJson(Map<String, dynamic> json) =>
    RestrictionInfo(
      description: json['description'] as String?,
      endAt: (json['end_at'] as num?)?.toInt(),
      restrictionType: $enumDecodeNullable(
              _$RestrictionTypeEnumMap, json['restriction_type']) ??
          RestrictionType.muted,
    );

const _$RestrictionTypeEnumMap = {
  RestrictionType.muted: 'muted',
  RestrictionType.banned: 'banned',
};
