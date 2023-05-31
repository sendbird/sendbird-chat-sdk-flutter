// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'poll_data.g.dart';

/// Class representing data for poll.
/// A poll may or may not have a data, which is an additional field used after user's vote.
/// Currently this class only supports [text] data.
@JsonSerializable()
class PollData {
  /// Text data field.
  String text;

  PollData({this.text = ''});

  factory PollData.fromJson(Map<String, dynamic> json) =>
      _$PollDataFromJson(json);

  Map<String, dynamic> toJson() => _$PollDataToJson(this);
}
