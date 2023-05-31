// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';

part 'app_info.g.dart';

/// Represents information obtained from the application settings.
/// The values for this will be set after a connection has been made.
@JsonSerializable(createToJson: false)
class AppInfo {
  /// The current registered emoji version hash.
  final String emojiHash;

  /// The maximum limit of file size for uploading.
  @JsonKey(defaultValue: 30 * 1024 * 1024) // Check
  final int uploadSizeLimit;

  /// List of all premium features that application is using.
  @JsonKey(defaultValue: [])
  final List<String> premiumFeatureList;

  /// Whether an application is using the reaction feature.
  final bool useReaction;

  /// List of all attributes that the application is using.
  @JsonKey(defaultValue: [])
  final List<String> attributesInUse;

  AppInfo({
    required this.emojiHash,
    required this.uploadSizeLimit,
    required this.premiumFeatureList,
    required this.useReaction,
    required this.attributesInUse,
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
