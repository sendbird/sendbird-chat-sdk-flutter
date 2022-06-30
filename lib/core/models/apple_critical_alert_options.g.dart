// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_critical_alert_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppleCriticalAlertOptions _$AppleCriticalAlertOptionsFromJson(
        Map<String, dynamic> json) =>
    AppleCriticalAlertOptions(
      sound: json['sound'] as String?,
      volume: (json['volume'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AppleCriticalAlertOptionsToJson(
        AppleCriticalAlertOptions instance) =>
    <String, dynamic>{
      'sound': instance.sound,
      'volume': instance.volume,
    };
