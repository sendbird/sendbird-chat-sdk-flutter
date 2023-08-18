// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) => AppInfo(
      premiumFeatureList: (json['premiumFeatureList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      uploadSizeLimit: json['file_upload_size_limit'] as int? ?? 30,
      attributesInUse: (json['application_attributes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      emojiHash: json['emojiHash'] as String,
      useReaction: json['useReaction'] as bool,
      notificationInfo: json['notifications'] == null
          ? null
          : NotificationInfo.fromJson(
              json['notifications'] as Map<String, dynamic>),
      allowSdkStatsUpload: json['allow_sdk_log_ingestion'] as bool? ?? true,
    );
