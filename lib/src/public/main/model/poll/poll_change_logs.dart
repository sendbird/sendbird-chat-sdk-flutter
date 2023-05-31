// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/public/main/model/poll/poll.dart';

part 'poll_change_logs.g.dart';

/// The PollChangeLogs class.
@JsonSerializable(createToJson: false)
class PollChangeLogs {
  /// The updated polls.
  @JsonKey(defaultValue: [], name: 'updated')
  List<Poll>? updatedPolls;

  /// The deleted poll IDs.
  @JsonKey(name: 'deleted')
  List<double>? deletedPollIds;

  /// hasMore
  @JsonKey(defaultValue: false)
  final bool hasMore;

  /// [token] to get next changelogs.
  @JsonKey(name: 'next')
  String? token;

  static PollChangeLogs fromJson(Map<String, dynamic> json) =>
      _$PollChangeLogsFromJson(json);

  PollChangeLogs({
    this.updatedPolls,
    this.deletedPollIds,
    required this.hasMore,
    this.token,
  });
}
