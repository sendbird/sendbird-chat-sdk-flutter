// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_data.dart';

part 'poll_create_params.g.dart';

/// Parameters for creating poll and updating poll operations. For poll creation, [title] and
/// [optionTexts] are required and all other members are optional. For poll update, all members are
/// optional.
@JsonSerializable()
class PollCreateParams {
  /// Title of the poll.
  String title;

  /// Options for this poll.
  @JsonKey(name: 'options')
  List<String> optionTexts;

  /// An additional text to accompany the poll.
  PollData? data;

  /// Whether to allow user-suggested options
  bool? allowUserSuggestion;

  /// Whether to allow multiple vote casting
  bool? allowMultipleVotes;

  /// Unix timestamp at which the poll has closed or will close (second)
  int closeAt = -1;

  PollCreateParams({
    required this.title,
    required this.optionTexts,
    this.data,
    this.allowUserSuggestion,
    this.allowMultipleVotes,
    this.closeAt = -1, // Default value
  });

  static PollCreateParams fromJson(Map<String, dynamic> json) {
    return _$PollCreateParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$PollCreateParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
