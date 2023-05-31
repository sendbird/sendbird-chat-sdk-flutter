// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'apple_critical_alert_options.g.dart';

/// A class that can be used to send apple's critical alert.
@JsonSerializable()
class AppleCriticalAlertOptions {
  static const defaultName = 'default';
  static const defaultVolume = 1.0;

  /// The name of the critical alert sound.
  final String? name;

  /// The volume of the critical alert sound.
  /// The volume ranges from 0.0 to 1.0,
  /// which indicates silent and full volume, respectively.
  final double? volume;

  AppleCriticalAlertOptions({
    this.name = AppleCriticalAlertOptions.defaultName,
    this.volume = AppleCriticalAlertOptions.defaultVolume,
  });

  Map<String, dynamic> toJson() => _$AppleCriticalAlertOptionsToJson(this);

  factory AppleCriticalAlertOptions.fromJson(Map<String, dynamic> json) =>
      _$AppleCriticalAlertOptionsFromJson(json);
}
