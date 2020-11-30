// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userId: json['user_id'] as String,
    nickname: json['nickname'] as String,
    profileUrl: json['profile_url'] as String,
    isOnline: json['is_online'] as bool,
    lastSeenAt: json['last_seen_at'] as int,
    isActive: json['is_active'] as bool,
    preferredLanguages: (json['preferred_languages'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    friendDiscoveryKey: json['friend_discovery_key'] as String,
    friendName: json['friend_name'] as String,
    discoveryKeys:
        (json['discovery_keys'] as List)?.map((e) => e as String)?.toList(),
    metaData: (json['meta_data'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(k, e as String),
        ) ??
        {},
    requireAuth: json['require_auth_for_profile_image'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'profile_url': instance.profileUrl,
      'is_online': instance.isOnline,
      'last_seen_at': instance.lastSeenAt,
      'is_active': instance.isActive,
      'preferred_languages': instance.preferredLanguages,
      'friend_discovery_key': instance.friendDiscoveryKey,
      'friend_name': instance.friendName,
      'discovery_keys': instance.discoveryKeys,
      'meta_data': instance.metaData,
      'require_auth_for_profile_image': instance.requireAuth,
    };
