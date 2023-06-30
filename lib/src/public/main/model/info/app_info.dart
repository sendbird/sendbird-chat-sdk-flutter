// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/notification_info.dart';

part 'app_info.g.dart';

/// Represents information obtained from the application settings.
/// The values for this will be set after a connection has been made.
@JsonSerializable(createToJson: false)
class AppInfo {
  /// List of all premium features that application is using.
  @JsonKey(defaultValue: [])
  final List<String> premiumFeatureList;

  /// The maximum limit of file size for uploading.
  @JsonKey(defaultValue: 30 * 1024 * 1024) // Check
  final int uploadSizeLimit;

  /// List of all attributes that the application is using.
  @JsonKey(defaultValue: [])
  final List<String> attributesInUse;

  /// The current registered emoji version hash.
  final String emojiHash;

  /// Whether an application is using the reaction feature.
  final bool useReaction;

  /// Notification info.
  /// @since 4.0.3
  @JsonKey(name: 'notifications')
  final NotificationInfo? notificationInfo;

  AppInfo({
    required this.premiumFeatureList,
    required this.uploadSizeLimit,
    required this.attributesInUse,
    required this.emojiHash,
    required this.useReaction,
    this.notificationInfo,
  });

  /// Checks whether the emoji list needs to be updated.
  bool needUpdateEmoji(String prevEmojiHash) {
    final result = emojiHash != prevEmojiHash;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  factory AppInfo.fromJson(Map<String, dynamic> json) =>
      _$AppInfoFromJson(json);
}
