// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_vote_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatedVoteCount _$UpdatedVoteCountFromJson(Map<String, dynamic> json) =>
    UpdatedVoteCount(
      pollOptionId: json['poll_option_id'] as int,
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$UpdatedVoteCountToJson(UpdatedVoteCount instance) =>
    <String, dynamic>{
      'poll_option_id': instance.pollOptionId,
      'vote_count': instance.voteCount,
    };
