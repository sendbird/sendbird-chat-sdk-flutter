// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuteInfo _$MuteInfoFromJson(Map<String, dynamic> json) => MuteInfo(
      isMuted: json['is_muted'] as bool,
      description: json['description'] as String?,
      startAt: (json['start_at'] as num?)?.toInt(),
      endAt: (json['end_at'] as num?)?.toInt(),
      remainingDuration: (json['remaining_duration'] as num?)?.toInt(),
    );
