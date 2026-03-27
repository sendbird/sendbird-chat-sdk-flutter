// Copyright (c) 2026 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/dnd/dnd_time_window.dart';

part 'dnd_schedule.g.dart';

/// Represents a do-not-disturb schedule for a specific day of the week.
/// @since 4.10.0
@JsonSerializable()
class DndSchedule {
  /// The day of the week for this schedule.
  final DayOfWeek dayOfWeek;

  /// The list of time windows during which do-not-disturb is active.
  @JsonKey(name: 'time_windows')
  final List<DndTimeWindow> dndTimeWindows;

  DndSchedule({
    required this.dayOfWeek,
    required this.dndTimeWindows,
  });

  /// Creates a list of [DndSchedule] for weekdays (Monday through Friday)
  /// with the given [dndTimeWindows].
  static List<DndSchedule> weekdays({
    required List<DndTimeWindow> dndTimeWindows,
  }) {
    return [
      DndSchedule(
        dayOfWeek: DayOfWeek.monday,
        dndTimeWindows: dndTimeWindows,
      ),
      DndSchedule(
        dayOfWeek: DayOfWeek.tuesday,
        dndTimeWindows: dndTimeWindows,
      ),
      DndSchedule(
        dayOfWeek: DayOfWeek.wednesday,
        dndTimeWindows: dndTimeWindows,
      ),
      DndSchedule(
        dayOfWeek: DayOfWeek.thursday,
        dndTimeWindows: dndTimeWindows,
      ),
      DndSchedule(
        dayOfWeek: DayOfWeek.friday,
        dndTimeWindows: dndTimeWindows,
      ),
    ];
  }

  /// Creates a list of [DndSchedule] for weekends (Saturday and Sunday)
  /// with the given [dndTimeWindows].
  static List<DndSchedule> weekends({
    required List<DndTimeWindow> dndTimeWindows,
  }) {
    return [
      DndSchedule(
        dayOfWeek: DayOfWeek.saturday,
        dndTimeWindows: dndTimeWindows,
      ),
      DndSchedule(
        dayOfWeek: DayOfWeek.sunday,
        dndTimeWindows: dndTimeWindows,
      ),
    ];
  }

  /// Creates a list of [DndSchedule] covering the full day (00:00–23:59)
  /// for each day specified in [dayOfWeeks].
  static List<DndSchedule> fullday({
    required List<DayOfWeek> dayOfWeeks,
  }) {
    final List<DndSchedule> dndSchedules = [];
    for (DayOfWeek dayOfWeek in dayOfWeeks) {
      dndSchedules.add(
        DndSchedule(
          dayOfWeek: dayOfWeek,
          dndTimeWindows: [
            DndTimeWindow(startHour: 0, startMin: 0, endHour: 23, endMin: 59),
          ],
        ),
      );
    }
    return dndSchedules;
  }

  factory DndSchedule.fromJson(Map<String, dynamic> json) =>
      _$DndScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DndScheduleToJson(this);
}
