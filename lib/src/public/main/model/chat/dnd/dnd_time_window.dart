// Copyright (c) 2026 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'dnd_time_window.g.dart';

/// Represents a time window for do-not-disturb.
/// @since 4.10.0
@JsonSerializable()
class DndTimeWindow {
  /// The starting hour (0~23).
  final int startHour;

  /// The starting minute (0~59).
  final int startMin;

  /// The ending hour (0~23).
  final int endHour;

  /// The ending minute (0~59).
  final int endMin;

  DndTimeWindow({
    required this.startHour,
    required this.startMin,
    required this.endHour,
    required this.endMin,
  });

  factory DndTimeWindow.fromJson(Map<String, dynamic> json) =>
      _$DndTimeWindowFromJson(json);

  Map<String, dynamic> toJson() => _$DndTimeWindowToJson(this);
}
