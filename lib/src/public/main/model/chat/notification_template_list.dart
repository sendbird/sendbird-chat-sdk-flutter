// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

/// The notification template list received from the [SendbirdChat.getNotificationTemplateListByToken].
/// @since 4.0.3
class NotificationTemplateList {
  /// The notification template list.
  /// @since 4.0.3
  final Map<String, dynamic> templateList;

  /// Returned true if it has more template list.
  /// @since 4.0.3
  final bool hasMore;

  /// Returned token to get next template list.
  /// @since 4.0.3
  final String? token;

  NotificationTemplateList({
    required this.templateList,
    required this.hasMore,
    required this.token,
  });
}
