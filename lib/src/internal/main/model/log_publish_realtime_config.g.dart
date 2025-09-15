// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_publish_realtime_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogPublishRealtimeConfig _$LogPublishRealtimeConfigFromJson(
        Map<String, dynamic> json) =>
    LogPublishRealtimeConfig(
      minStatCount: json['min_stat_count'] as int?,
      minInterval: json['min_interval'] as int?,
      maxStatCountPerRequest: json['max_stat_count_per_request'] as int?,
      lowerThreshold: json['lower_threshold'] as int?,
      requestDelayRange: json['request_delay_range'] as int?,
    );
