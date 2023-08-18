// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';

/// The NotificationData class for [BaseMessage.notificationData].
/// @since 4.0.7
class NotificationData {
  /// templateKey
  /// @since 4.0.7
  final String templateKey;

  /// templateVariables
  /// @since 4.0.7
  final Map<String, String> templateVariables;

  /// label
  /// @since 4.0.7
  String? label;

  NotificationData({
    required this.templateKey,
    required this.templateVariables,
    this.label,
  });
}
