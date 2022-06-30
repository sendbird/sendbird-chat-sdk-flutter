import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'poll_vote_event.g.dart';

@JsonSerializable()
class PollUpdateVoteCount {
  int optionId;
  int voteCount;

  PollUpdateVoteCount({
    required this.optionId,
    required this.voteCount,
  });

  factory PollUpdateVoteCount.fromJson(Map<String, dynamic> json) =>
      _$PollUpdateVoteCountFromJson(json);

  Map<String, dynamic> toJson() => _$PollUpdateVoteCountToJson(this);
}

/// Represents Poll Update event
@JsonSerializable()
class PollVoteEvent implements BaseEvent {
  int pollId;
  List<PollUpdateVoteCount> updatedVoteCounts;
  int ts;

  PollVoteEvent({
    required this.pollId,
    required this.ts,
    required this.updatedVoteCounts,
  });

  factory PollVoteEvent.fromJson(Map<String, dynamic> json) {
    return _$PollVoteEventFromJson(json);
  }
}
