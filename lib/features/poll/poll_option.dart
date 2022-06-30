import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/poll_vote_event.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/request/poll/poll_option_delete_request.dart';
import 'package:sendbird_sdk/request/poll/poll_option_get_request.dart';
import 'package:sendbird_sdk/request/poll/poll_option_update_request.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'poll_option.g.dart';

/// Represents a poll option that a user can vote for
@JsonSerializable()
class PollOption {
  /// ID for the poll to which this option belongs.
  final int pollId;

  /// ID for an option. This value is unique within a poll.
  final int id;

  /// Representation of this option
  final String text;

  /// Number of votes casted on the option
  int voteCount;

  /// Timestamp (milliseconds) this option was created
  final int createdAt;

  /// Timestamp (milliseconds) this option was created
  int updatedAt;

  /// List of Users who voted
  @JsonKey(name: 'partial_voter_list', defaultValue: [])
  final List<User> partialVoters;

  PollOption({
    required this.pollId,
    required this.id,
    required this.text,
    required this.voteCount,
    required this.createdAt,
    required this.updatedAt,
    required this.partialVoters,
  });

  SendbirdSdkInternal get _sdk => SendbirdSdk().getInternal();

  /// Get Poll Options
  static Future<PollOption> get({
    required String channelUrl,
    required int optionId,
    required int pollId,
    required ChannelType channelType,
  }) async {
    final sdk = SendbirdSdk().getInternal();
    return sdk.api.send(PollOptionGetRequest(
      channelType: channelType,
      channelUrl: channelUrl,
      optionId: optionId,
      pollId: pollId,
    ));
  }

  /// Update Poll Option - only text update available
  Future<Poll> update({required String text}) async {
    return _sdk.api.send(PollOptionUpdateRequest(
      optionId: id,
      pollId: pollId,
      text: text,
    ));
  }

  /// Delete Poll Option
  Future<void> delete() async {
    return _sdk.api.send(PollOptionDeleteRequest(
      optionId: id,
      pollId: pollId,
    ));
  }

  /// Applying [PollVoteEvent]
  bool applyEvent(PollVoteEvent event) {
    for (var option in event.updatedVoteCounts) {
      if (option.optionId == id && updatedAt < event.ts) {
        voteCount = option.voteCount;
        updatedAt = event.ts;
        return true;
      }
    }
    return false;
  }

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return _$PollOptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PollOptionToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = ListEquality().equals;
    return other is PollOption &&
        other.id == id &&
        other.text == text &&
        other.pollId == pollId &&
        other.voteCount == voteCount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        eq(other.partialVoters, partialVoters);
  }

  @override
  int get hashCode => hashValues(
        super.hashCode,
        pollId,
        id,
        text,
        voteCount,
        createdAt,
        updatedAt,
        partialVoters,
      );
}
