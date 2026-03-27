// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_do_not_disturb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyDoNotDisturb _$WeeklyDoNotDisturbFromJson(Map<String, dynamic> json) =>
    WeeklyDoNotDisturb(
      dndSchedules: (json['dnd_schedules'] as List<dynamic>?)
          ?.map((e) => DndSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      timezone: json['timezone'] as String?,
    );
