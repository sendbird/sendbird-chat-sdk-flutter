// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_vote_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollUpdateVoteCount _$PollUpdateVoteCountFromJson(Map<String, dynamic> json) =>
    PollUpdateVoteCount(
      optionId: json['option_id'] as int,
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$PollUpdateVoteCountToJson(
        PollUpdateVoteCount instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'vote_count': instance.voteCount,
    };

PollVoteEvent _$PollVoteEventFromJson(Map<String, dynamic> json) =>
    PollVoteEvent(
      pollId: json['poll_id'] as int,
      ts: json['ts'] as int,
      updatedVoteCounts: (json['updated_vote_counts'] as List<dynamic>)
          .map((e) => PollUpdateVoteCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PollVoteEventToJson(PollVoteEvent instance) =>
    <String, dynamic>{
      'poll_id': instance.pollId,
      'updated_vote_counts':
          instance.updatedVoteCounts.map((e) => e.toJson()).toList(),
      'ts': instance.ts,
    };
