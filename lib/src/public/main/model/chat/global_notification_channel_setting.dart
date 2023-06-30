// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

/// Class to obtain the global notification channel setting.
/// @since 4.0.3
class GlobalNotificationChannelSetting {
  /// The setting map received from the [SendbirdChat.getGlobalNotificationChannelSetting].
  /// @since 4.0.3
  final Map<String, dynamic> setting;

  GlobalNotificationChannelSetting({
    required this.setting,
  });
}
