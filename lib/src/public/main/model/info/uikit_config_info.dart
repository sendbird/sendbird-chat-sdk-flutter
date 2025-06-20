// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'uikit_config_info.g.dart';

@JsonSerializable(createToJson: false)
class UIKitConfigInfo {
  @JsonKey(defaultValue: 0)
  final int lastUpdatedAt;

  UIKitConfigInfo({
    required this.lastUpdatedAt,
  });

  factory UIKitConfigInfo.fromJson(Map<String, dynamic> json) =>
      _$UIKitConfigInfoFromJson(json);
}
