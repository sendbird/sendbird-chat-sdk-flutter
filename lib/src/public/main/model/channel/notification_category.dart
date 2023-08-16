// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

/// NotificationCategory
/// @since 4.0.6
class NotificationCategory {
  /// id
  /// @since 4.0.6
  final int id;

  /// customType
  /// @since 4.0.6
  final String customType;

  /// name
  /// @since 4.0.6
  final String name;

  /// isDefault
  /// @since 4.0.6
  final bool isDefault;

  NotificationCategory({
    required this.id,
    required this.customType,
    required this.name,
    required this.isDefault,
  });
}
