// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOption _$PollOptionFromJson(Map<String, dynamic> json) => PollOption(
      pollId: json['poll_id'] as int,
      id: json['id'] as int,
      text: json['text'] as String,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as int,
      voteCount: json['vote_count'] as int,
      updatedAt: json['updated_at'] as int,
    );

Map<String, dynamic> _$PollOptionToJson(PollOption instance) =>
    <String, dynamic>{
      'poll_id': instance.pollId,
      'id': instance.id,
      'text': instance.text,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'vote_count': instance.voteCount,
      'updated_at': instance.updatedAt,
    };
