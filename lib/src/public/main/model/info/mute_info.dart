// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'mute_info.g.dart';

/// The MuteInfo class.
@JsonSerializable(createToJson: false)
class MuteInfo {
  /// IsMuted.
  final bool isMuted;

  /// Description.
  final String? description;

  /// Timestamp when the mute started (ms).
  final int? startAt;

  /// Timestamp when the mute will end (ms).
  final int? endAt;

  /// Remaining duration (ms).
  final int? remainingDuration;

  MuteInfo({
    required this.isMuted,
    this.description,
    this.startAt,
    this.endAt,
    this.remainingDuration,
  });

  static MuteInfo fromJson(Map<String, dynamic> json) =>
      _$MuteInfoFromJson(json);
}
