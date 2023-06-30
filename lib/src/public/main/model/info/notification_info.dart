// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

part 'notification_info.g.dart';

/// Represents information about Notifications.
/// @since 4.0.3
@JsonSerializable(createToJson: false)
class NotificationInfo {
  /// Whether notification is enabled
  /// @since 4.0.3
  @JsonKey(name: 'enabled')
  final bool isEnabled;

  /// List of feed channels for [SendbirdChat.currentUser], channel_key : channel_url
  /// @since 4.0.3
  final Map<String, String> feedChannels;

  /// Updated at for the global notification settings
  /// @since 4.0.3
  final int settingsUpdatedAt;

  /// Token for the notification template list
  /// @since 4.0.3
  final String? templateListToken;

  NotificationInfo({
    required this.isEnabled,
    required this.feedChannels,
    required this.settingsUpdatedAt,
    this.templateListToken,
  });

  static NotificationInfo fromJson(Map<String, dynamic> json) =>
      _$NotificationInfoFromJson(json);
}
