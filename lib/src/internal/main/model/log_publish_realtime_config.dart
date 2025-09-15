// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'log_publish_realtime_config.g.dart';

@JsonSerializable(createToJson: false)
class LogPublishRealtimeConfig {
  final int? minStatCount; // 1
  final int? minInterval; // 0 seconds
  final int? maxStatCountPerRequest; // 1000
  final int? lowerThreshold; // 0
  final int? requestDelayRange; // 20 seconds

  LogPublishRealtimeConfig({
    required this.minStatCount,
    required this.minInterval,
    required this.maxStatCountPerRequest,
    required this.lowerThreshold,
    required this.requestDelayRange,
  });

  static LogPublishRealtimeConfig fromJson(Map<String, dynamic> json) =>
      _$LogPublishRealtimeConfigFromJson(json);
}
