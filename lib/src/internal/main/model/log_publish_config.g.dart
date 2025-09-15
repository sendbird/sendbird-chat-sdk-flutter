// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_publish_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogPublishConfig _$LogPublishConfigFromJson(Map<String, dynamic> json) =>
    LogPublishConfig(
      defaultConfig: json['default'] == null
          ? null
          : LogPublishDefaultConfig.fromJson(
              json['default'] as Map<String, dynamic>),
      realtimeConfig: json['realtime'] == null
          ? null
          : LogPublishRealtimeConfig.fromJson(
              json['realtime'] as Map<String, dynamic>),
    );
