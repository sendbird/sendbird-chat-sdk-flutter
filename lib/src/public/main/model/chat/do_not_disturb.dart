// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'do_not_disturb.g.dart';

/// The DoNotDisturb class.
@JsonSerializable(createToJson: false)
class DoNotDisturb {
  /// Flag for the option is on or off.
  @JsonKey(name: 'do_not_disturb')
  final bool isDoNotDisturbOn;

  /// The option starting hour (0~23).
  final int? startHour;

  /// The option starting minute (0~59).
  final int? startMin;

  /// The option ending hour (0~23).
  final int? endHour;

  /// The option ending minute (0~59).
  final int? endMin;

  /// Timezone.
  final String? timezone;

  DoNotDisturb({
    required this.isDoNotDisturbOn,
    this.startHour,
    this.startMin,
    this.endHour,
    this.endMin,
    this.timezone,
  });

  static DoNotDisturb fromJson(Map<String, dynamic> json) =>
      _$DoNotDisturbFromJson(json);
}
