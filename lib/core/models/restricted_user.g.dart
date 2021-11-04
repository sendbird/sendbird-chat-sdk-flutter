// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restricted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestrictedUser _$RestrictedUserFromJson(Map<String, dynamic> json) {
  return RestrictedUser(
    userId: json['user_id'] as String,
    nickname: json['nickname'] as String? ?? '',
    profileUrl: json['profile_url'] as String?,
    connectionStatus: boolToConnectionStatus(json['is_online'] as bool?),
    lastSeenAt: json['last_seen_at'] as int?,
    preferredLanguages: (json['preferred_languages'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    friendDiscoveryKey: json['friend_discovery_key'] as String?,
    friendName: json['friend_name'] as String?,
    discoveryKeys: (json['discovery_keys'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    metaData: (json['metadata'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e as String),
        ) ??
        {},
    requireAuth: json['require_auth_for_profile_image'] as bool? ?? false,
  )
    ..isActive = json['is_active'] as bool?
    ..sessionToken = json['session_token'] as String?;
}

Map<String, dynamic> _$RestrictedUserToJson(RestrictedUser instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'profile_url': instance.profileUrl,
      'is_online': connectionStatusToBool(instance.connectionStatus),
      'last_seen_at': instance.lastSeenAt,
      'is_active': instance.isActive,
      'preferred_languages': instance.preferredLanguages,
      'friend_discovery_key': instance.friendDiscoveryKey,
      'friend_name': instance.friendName,
      'discovery_keys': instance.discoveryKeys,
      'metadata': instance.metaData,
      'require_auth_for_profile_image': instance.requireAuth,
      'session_token': instance.sessionToken,
    };

RestrictionInfo _$RestrictionInfoFromJson(Map<String, dynamic> json) {
  return RestrictionInfo(
    description: json['description'] as String?,
    endAt: json['end_at'] as int?,
    startAt: json['start_at'] as int?,
    type: _$enumDecode(_$RestrictionTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$RestrictionInfoToJson(RestrictionInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'end_at': instance.endAt,
      'start_at': instance.startAt,
      'type': _$RestrictionTypeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$RestrictionTypeEnumMap = {
  RestrictionType.muted: 'muted',
  RestrictionType.banned: 'banned',
};
