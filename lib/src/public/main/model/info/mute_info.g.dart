// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuteInfo _$MuteInfoFromJson(Map<String, dynamic> json) => MuteInfo(
      isMuted: json['is_muted'] as bool,
      description: json['description'] as String?,
      startAt: json['start_at'] as int?,
      endAt: json['end_at'] as int?,
      remainingDuration: json['remaining_duration'] as int?,
    );
