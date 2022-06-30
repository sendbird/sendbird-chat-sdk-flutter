import 'package:json_annotation/json_annotation.dart';

part 'apple_critical_alert_options.g.dart';

@JsonSerializable()
class AppleCriticalAlertOptions {
  /// The name of the file that sounds for critical alerts.
  final String? sound;

  /// The volume of the critical alert sound. The volume ranges from 0.0 to 1.0,
  /// which indicates silent and full volume, respectively.
  final double? volume;

  AppleCriticalAlertOptions({this.sound, this.volume});

  Map<String, dynamic> toJson() => _$AppleCriticalAlertOptionsToJson(this);

  factory AppleCriticalAlertOptions.fromJson(Map<String, dynamic> json) =>
      _$AppleCriticalAlertOptionsFromJson(json);
}
