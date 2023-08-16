// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snooze_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnoozePeriod _$SnoozePeriodFromJson(Map<String, dynamic> json) => SnoozePeriod(
      isSnoozeOn: json['snooze_enabled'] as bool,
      startDate: _msToDateTime(json['snooze_start_ts']),
      endDate: _msToDateTime(json['snooze_end_ts']),
    );
