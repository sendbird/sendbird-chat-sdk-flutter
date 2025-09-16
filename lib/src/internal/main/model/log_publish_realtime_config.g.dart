// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_publish_realtime_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogPublishRealtimeConfig _$LogPublishRealtimeConfigFromJson(
        Map<String, dynamic> json) =>
    LogPublishRealtimeConfig(
      minStatCount: (json['min_stat_count'] as num?)?.toInt(),
      minInterval: (json['min_interval'] as num?)?.toInt(),
      maxStatCountPerRequest:
          (json['max_stat_count_per_request'] as num?)?.toInt(),
      lowerThreshold: (json['lower_threshold'] as num?)?.toInt(),
      requestDelayRange: (json['request_delay_range'] as num?)?.toInt(),
    );
