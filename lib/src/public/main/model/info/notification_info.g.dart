// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationInfo _$NotificationInfoFromJson(Map<String, dynamic> json) =>
    NotificationInfo(
      isEnabled: json['enabled'] as bool,
      feedChannels: Map<String, String>.from(json['feedChannels'] as Map),
      settingsUpdatedAt: json['settingsUpdatedAt'] as int,
      templateListToken: json['templateListToken'] as String?,
    );
