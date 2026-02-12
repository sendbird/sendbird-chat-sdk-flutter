// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) => AppInfo(
      premiumFeatureList: (json['premium_feature_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      uploadSizeLimit: (json['file_upload_size_limit'] as num?)?.toInt() ?? 30,
      attributesInUse: (json['application_attributes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      emojiHash: json['emoji_hash'] as String,
      useReaction: json['use_reaction'] as bool,
      notificationInfo: json['notifications'] == null
          ? null
          : NotificationInfo.fromJson(
              json['notifications'] as Map<String, dynamic>),
      allowSdkStatsUpload: json['allow_sdk_log_ingestion'] as bool? ?? true,
      disableSuperGroupMack: json['disable_supergroup_mack'] as bool? ?? false,
      unreadCntThreadingPolicy:
          (json['unread_cnt_threading_policy'] as num?)?.toInt() ?? 0,
      lastMsgThreadingPolicy:
          (json['last_msg_threading_policy'] as num?)?.toInt() ?? 0,
      multipleFilesMessageFileCountLimit:
          (json['multiple_file_send_max_size'] as num?)?.toInt() ??
              AppInfo.multipleFilesMessageDefaultFileCountLimit,
    );
