// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_data.dart';

part 'poll_update_params.g.dart';

/// Parameters for updating poll operations. All members are optional.
@JsonSerializable()
class PollUpdateParams {
  /// Title of the poll.
  String? title;

  /// An additional json data to accompany the poll.
  PollData? data;

  /// Whether to allow user-suggested options
  bool? allowUserSuggestion;

  /// Whether to allow multiple vote casting
  bool? allowMultipleVotes;

  /// Unix timestamp at which the poll has closed or will close (second)
  int closeAt = -1;

  PollUpdateParams({
    this.title,
    this.data,
    this.allowUserSuggestion,
    this.allowMultipleVotes,
    this.closeAt = -1,
  });

  static PollUpdateParams fromJson(Map<String, dynamic> json) {
    return _$PollUpdateParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PollUpdateParamsToJson(this);
  }
}
