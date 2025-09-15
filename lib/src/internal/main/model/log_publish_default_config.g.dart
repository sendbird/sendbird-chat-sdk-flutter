// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_publish_default_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogPublishDefaultConfig _$LogPublishDefaultConfigFromJson(
        Map<String, dynamic> json) =>
    LogPublishDefaultConfig(
      minStatCount: json['min_stat_count'] as int?,
      minInterval: json['min_interval'] as int?,
      maxStatCountPerRequest: json['max_stat_count_per_request'] as int?,
      lowerThreshold: json['lower_threshold'] as int?,
      requestDelayRange: json['request_delay_range'] as int?,
    );
