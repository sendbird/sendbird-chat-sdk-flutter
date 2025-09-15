// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/notification_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/uikit_config_info.dart';

part 'app_info.g.dart';

/// Represents information obtained from the application settings.
/// The values for this will be set after a connection has been made.
@JsonSerializable(createToJson: false)
class AppInfo {
  /// List of all premium features that application is using.
  @JsonKey(defaultValue: [])
  final List<String> premiumFeatureList;

  /// The maximum limit of file size for uploading. (MB)
  @JsonKey(
    name: 'file_upload_size_limit',
    defaultValue: 30,
  ) // Check
  final int uploadSizeLimit;

  /// List of all attributes that the application is using.
  @JsonKey(name: 'application_attributes', defaultValue: [])
  final List<String> attributesInUse;

  /// The current registered emoji version hash.
  final String emojiHash;

  /// Whether an application is using the reaction feature.
  final bool useReaction;

  /// Notification info.
  /// @since 4.0.3
  @JsonKey(name: 'notifications')
  final NotificationInfo? notificationInfo;

  @JsonKey(name: 'allow_sdk_log_ingestion')
  final bool allowSdkStatsUpload;

  @JsonKey(name: 'disable_supergroup_mack')
  final bool disableSuperGroupMack;

  /// The unread message count policy for message threading.
  /// 0(NONE), 1(INCLUDE_REPLY), 2(EXCLUDE_REPLY), 3(INCLUDE_REPLY_TO_CHANNEL)
  /// @since 4.2.27
  final int unreadCntThreadingPolicy;

  /// The last message policy for message threading.
  /// 0(NONE), 1(INCLUDE_REPLY), 2(EXCLUDE_REPLY), 3(INCLUDE_REPLY_TO_CHANNEL)
  /// @since 4.2.27
  final int lastMsgThreadingPolicy;

  /// @since 4.4.0
  @JsonKey(includeFromJson: false, includeToJson: false)
  UIKitConfigInfo? uikitConfigInfo;

  AppInfo({
    required this.premiumFeatureList,
    required this.uploadSizeLimit,
    required this.attributesInUse,
    required this.emojiHash,
    required this.useReaction,
    this.notificationInfo,
    this.allowSdkStatsUpload = true,
    this.disableSuperGroupMack = false,
    this.unreadCntThreadingPolicy = 0,
    this.lastMsgThreadingPolicy = 0,
  });

  /// Checks whether the emoji list needs to be updated.
  bool needUpdateEmoji(String prevEmojiHash) {
    final result = emojiHash != prevEmojiHash;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    final appInfo = _$AppInfoFromJson(json);
    if (json['uikit_config'] != null) {
      appInfo.uikitConfigInfo = UIKitConfigInfo.fromJson(json['uikit_config']);
    }
    return appInfo;
  }
}
