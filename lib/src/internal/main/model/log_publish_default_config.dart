// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'log_publish_default_config.g.dart';

@JsonSerializable(createToJson: false)
class LogPublishDefaultConfig {
  final int? minStatCount; // 100
  final int? minInterval; // 10800 seconds (3 hours)
  final int? maxStatCountPerRequest; // 1000
  final int? lowerThreshold; // 10
  final int? requestDelayRange; // 180 seconds (3 minutes)

  LogPublishDefaultConfig({
    required this.minStatCount,
    required this.minInterval,
    required this.maxStatCountPerRequest,
    required this.lowerThreshold,
    required this.requestDelayRange,
  });

  static LogPublishDefaultConfig fromJson(Map<String, dynamic> json) =>
      _$LogPublishDefaultConfigFromJson(json);
}
