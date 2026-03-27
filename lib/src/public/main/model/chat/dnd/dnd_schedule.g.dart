// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dnd_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DndSchedule _$DndScheduleFromJson(Map<String, dynamic> json) => DndSchedule(
      dayOfWeek: $enumDecode(_$DayOfWeekEnumMap, json['day_of_week']),
      dndTimeWindows: (json['time_windows'] as List<dynamic>)
          .map((e) => DndTimeWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DndScheduleToJson(DndSchedule instance) =>
    <String, dynamic>{
      'day_of_week': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
      'time_windows': instance.dndTimeWindows.map((e) => e.toJson()).toList(),
    };

const _$DayOfWeekEnumMap = {
  DayOfWeek.sunday: 'sunday',
  DayOfWeek.monday: 'monday',
  DayOfWeek.tuesday: 'tuesday',
  DayOfWeek.wednesday: 'wednesday',
  DayOfWeek.thursday: 'thursday',
  DayOfWeek.friday: 'friday',
  DayOfWeek.saturday: 'saturday',
};
