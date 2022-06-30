import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/features/poll/poll_data.dart';
import 'package:sendbird_sdk/features/poll/poll_option.dart';

part 'poll_detail.g.dart';

/// Represents a poll
@JsonSerializable()
class PollDetail {
  /// Lists of options for this current poll
  List<PollOption> options;

  /// Additional information to accompany the poll.
  ///Can be used to provide explanations for incorrect quiz answers.
  PollData? data;

  /// Whether to make the votes anonymous
  bool isAnonymous;

  /// Whether to allow user-suggested options
  bool allowUserSuggestion;

  /// Whether to allow multiple vote casting
  bool allowMultipleVotes;

  /// Unix timestamp at which the poll has closed or will close (second).
  /// If this value is -1, it means the poll is indefinitely open.
  int closeAt;

  /// Number of voters who casted a vote on the poll
  int voterCount;

  /// List of option ids which the user has voted on.
  @JsonKey(defaultValue: [])
  List<int> votedOptionIds;

  /// The status of the poll.
  /// The value is one of the following: "removed", "open", or "closed".
  String status;

  /// ID of the user who has created the poll
  String? createdBy;

  /// Unix timestamp at which the poll is created (millisecond)
  int createdAt;

  /// Unix timestamp at which the poll is updated (millisecond)
  int updatedAt;

  PollDetail({
    required this.options,
    required this.isAnonymous,
    required this.allowUserSuggestion,
    required this.allowMultipleVotes,
    required this.closeAt,
    required this.voterCount,
    this.votedOptionIds = const [],
    required this.status,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.data,
  });

  factory PollDetail.fromJson(Map<String, dynamic> json) {
    return _$PollDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PollDetailToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = ListEquality().equals;
    return other is PollDetail &&
        eq(other.options, options) &&
        other.data == data &&
        other.isAnonymous == isAnonymous &&
        other.allowUserSuggestion == allowUserSuggestion &&
        other.allowMultipleVotes == allowMultipleVotes &&
        other.closeAt == closeAt &&
        other.voterCount == voterCount &&
        eq(other.votedOptionIds, votedOptionIds) &&
        other.status == status &&
        other.createdBy == createdBy &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => hashValues(
        super.hashCode,
        options,
        isAnonymous,
        allowUserSuggestion,
        allowMultipleVotes,
        closeAt,
        voterCount,
        votedOptionIds,
        status,
        createdBy,
        createdAt,
        updatedAt,
        data,
      );
}
