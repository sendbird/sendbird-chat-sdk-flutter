// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'unread_count_info.g.dart';

@JsonSerializable(createToJson: false)
class UnreadCountInfo {
  int all;
  Map<String, int> customTypes;
  int ts;

  UnreadCountInfo({
    this.all = 0,
    this.customTypes = const {},
    this.ts = 0,
  });

  bool copyWith(UnreadCountInfo others) {
    var didChange = false;
    ts = others.ts;

    others.customTypes.forEach((key, value) {
      final currValue = customTypes[key];
      if (currValue != value) {
        didChange = true;
        customTypes[key] = value;
      }
    });

    if (all != others.all) {
      didChange = true;
      all = others.all;
    }
    return didChange;
  }

  static UnreadCountInfo fromJson(Map<String, dynamic> json) =>
      _$UnreadCountInfoFromJson(json);
}
