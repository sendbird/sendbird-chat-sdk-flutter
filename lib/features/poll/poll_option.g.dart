// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOption _$PollOptionFromJson(Map<String, dynamic> json) => PollOption(
      pollId: json['poll_id'] as int,
      id: json['id'] as int,
      text: json['text'] as String,
      voteCount: json['vote_count'] as int,
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
      partialVoters: (json['partial_voter_list'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PollOptionToJson(PollOption instance) =>
    <String, dynamic>{
      'poll_id': instance.pollId,
      'id': instance.id,
      'text': instance.text,
      'vote_count': instance.voteCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'partial_voter_list':
          instance.partialVoters.map((e) => e.toJson()).toList(),
    };
