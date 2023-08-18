// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restricted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestrictedUser _$RestrictedUserFromJson(Map<String, dynamic> json) =>
    RestrictedUser(
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

RestrictionInfo _$RestrictionInfoFromJson(Map<String, dynamic> json) =>
    RestrictionInfo(
      description: json['description'] as String?,
      endAt: json['endAt'] as int?,
      restrictionType: $enumDecodeNullable(
              _$RestrictionTypeEnumMap, json['restrictionType']) ??
          RestrictionType.muted,
    );

const _$RestrictionTypeEnumMap = {
  RestrictionType.muted: 'muted',
  RestrictionType.banned: 'banned',
};
