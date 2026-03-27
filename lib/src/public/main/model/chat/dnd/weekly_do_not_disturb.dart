// Copyright (c) 2026 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/dnd/dnd_schedule.dart';

part 'weekly_do_not_disturb.g.dart';

/// Represents the weekly do-not-disturb settings for the current user.
/// @since 4.10.0
@JsonSerializable(createToJson: false)
class WeeklyDoNotDisturb {
  /// The list of do-not-disturb schedules for each day of the week.
  final List<DndSchedule>? dndSchedules;

  /// The timezone for the schedules.
  final String? timezone;

  WeeklyDoNotDisturb({
    this.dndSchedules,
    this.timezone,
  });

  static WeeklyDoNotDisturb fromJson(Map<String, dynamic> json) =>
      _$WeeklyDoNotDisturbFromJson(json);
}
