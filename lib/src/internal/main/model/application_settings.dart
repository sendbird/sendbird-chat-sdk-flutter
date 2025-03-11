// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'application_settings.g.dart';

@JsonSerializable(createToJson: false)
class ApplicationSettings {
  Map<String, dynamic> configs;
  bool hasMore;
  String? next;
  int? ts;

  ApplicationSettings({
    required this.configs,
    required this.hasMore,
    this.next,
    this.ts,
  });

  static ApplicationSettings fromJson(Map<String, dynamic> json) =>
      _$ApplicationSettingsFromJson(json);
}
