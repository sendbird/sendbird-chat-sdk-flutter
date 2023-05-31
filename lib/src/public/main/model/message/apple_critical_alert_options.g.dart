// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_critical_alert_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppleCriticalAlertOptions _$AppleCriticalAlertOptionsFromJson(
        Map<String, dynamic> json) =>
    AppleCriticalAlertOptions(
      name: json['name'] as String? ?? AppleCriticalAlertOptions.defaultName,
      volume: (json['volume'] as num?)?.toDouble() ??
          AppleCriticalAlertOptions.defaultVolume,
    );

Map<String, dynamic> _$AppleCriticalAlertOptionsToJson(
        AppleCriticalAlertOptions instance) =>
    <String, dynamic>{
      'name': instance.name,
      'volume': instance.volume,
    };
