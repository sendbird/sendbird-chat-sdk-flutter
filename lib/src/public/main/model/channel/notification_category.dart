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

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is NotificationCategory &&
        other.id == id &&
        other.customType == customType &&
        other.name == name &&
        other.isDefault == isDefault;
  }

  @override
  int get hashCode => Object.hash(
        id,
        customType,
        name,
        isDefault,
      );
}
