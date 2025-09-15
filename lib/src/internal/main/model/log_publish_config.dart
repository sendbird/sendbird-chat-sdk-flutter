// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/log_publish_default_config.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/log_publish_realtime_config.dart';

part 'log_publish_config.g.dart';

@JsonSerializable(createToJson: false)
class LogPublishConfig {
  @JsonKey(name: 'default')
  final LogPublishDefaultConfig? defaultConfig;

  @JsonKey(name: 'realtime')
  final LogPublishRealtimeConfig? realtimeConfig;

  LogPublishConfig({
    required this.defaultConfig,
    required this.realtimeConfig,
  });

  static LogPublishConfig fromJson(Map<String, dynamic> json) =>
      _$LogPublishConfigFromJson(json);
}
