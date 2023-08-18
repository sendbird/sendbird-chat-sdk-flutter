// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String,
      nickname: json['nickname'] as String,
      profileUrl: json['profileUrl'] as String? ?? '',
      connectionStatus: json['is_online'] == null
          ? UserConnectionStatus.notAvailable
          : boolToConnectionStatus(json['is_online'] as bool?),
      lastSeenAt: json['lastSeenAt'] as int?,
      isActive: json['isActive'] as bool? ?? true,
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
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'profileUrl': instance.profileUrl,
      'is_online': connectionStatusToBool(instance.connectionStatus),
      'lastSeenAt': instance.lastSeenAt,
      'isActive': instance.isActive,
      'preferredLanguages': instance.preferredLanguages,
      'friendDiscoveryKey': instance.friendDiscoveryKey,
      'friendName': instance.friendName,
      'metadata': instance.metaData,
      'require_auth_for_profile_image': instance.requireAuth,
    };
