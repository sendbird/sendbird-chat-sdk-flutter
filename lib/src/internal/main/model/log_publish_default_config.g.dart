// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_publish_default_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogPublishDefaultConfig _$LogPublishDefaultConfigFromJson(
        Map<String, dynamic> json) =>
    LogPublishDefaultConfig(
      minStatCount: (json['min_stat_count'] as num?)?.toInt(),
      minInterval: (json['min_interval'] as num?)?.toInt(),
      maxStatCountPerRequest:
          (json['max_stat_count_per_request'] as num?)?.toInt(),
      lowerThreshold: (json['lower_threshold'] as num?)?.toInt(),
      requestDelayRange: (json['request_delay_range'] as num?)?.toInt(),
    );
