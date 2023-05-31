// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconnect_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReconnectConfiguration _$ReconnectConfigurationFromJson(
        Map<String, dynamic> json) =>
    ReconnectConfiguration(
      interval: (json['interval'] as num).toDouble(),
      maxInterval: (json['max_interval'] as num).toDouble(),
      multiplier: json['mul'] as int,
      maximumRetryCount: json['retry_cnt'] as int,
    );

Map<String, dynamic> _$ReconnectConfigurationToJson(
        ReconnectConfiguration instance) =>
    <String, dynamic>{
      'interval': instance.interval,
      'max_interval': instance.maxInterval,
      'mul': instance.multiplier,
      'retry_cnt': instance.maximumRetryCount,
    };
