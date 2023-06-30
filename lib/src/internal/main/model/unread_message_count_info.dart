// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'unread_message_count_info.g.dart';

@JsonSerializable(createToJson: false)
class UnreadMessageCountInfo {
  int all;
  int feed;
  Map<String, int> customTypes;
  int ts;

  UnreadMessageCountInfo({
    this.all = 0,
    this.feed = 0,
    this.customTypes = const {},
    this.ts = 0,
  });

  bool copyWith(UnreadMessageCountInfo others) {
    var didChange = false;

    if (all != others.all) {
      didChange = true;
      all = others.all;
    }

    if (feed != others.feed) {
      didChange = true;
      feed = others.feed;
    }

    others.customTypes.forEach((key, value) {
      final currValue = customTypes[key];
      if (currValue != value) {
        didChange = true;
        customTypes[key] = value;
      }
    });

    ts = others.ts;
    return didChange;
  }

  static UnreadMessageCountInfo fromJson(Map<String, dynamic> json) =>
      _$UnreadMessageCountInfoFromJson(json);
}
