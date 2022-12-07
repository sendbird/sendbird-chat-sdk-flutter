import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'poll_vote_event.g.dart';

@JsonSerializable()
class UpdatedVoteCount {
  int pollOptionId;
  int voteCount;

  UpdatedVoteCount({
    required this.pollOptionId,
    required this.voteCount,
  });

  factory UpdatedVoteCount.fromJson(Map<String, dynamic> json) =>
      _$UpdatedVoteCountFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedVoteCountToJson(this);
}

/// Represents Poll Update event
class PollVoteEvent implements BaseEvent {
  int pollId;
  int messageId;
  Map<String, dynamic> json;

  PollVoteEvent({
    required this.pollId,
    required this.messageId,
    required this.json,
  });

  factory PollVoteEvent.fromJson(Map<String, dynamic> res) {
    return PollVoteEvent(
      pollId: res['poll_id'],
      messageId: res['message_id'],
      json: res,
    );
  }
}
