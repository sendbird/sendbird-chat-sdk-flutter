// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOption _$PollOptionFromJson(Map<String, dynamic> json) => PollOption(
      pollId: (json['poll_id'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      createdBy: json['created_by'] as String?,
      createdAt: (json['created_at'] as num).toInt(),
      voteCount: (json['vote_count'] as num).toInt(),
      updatedAt: (json['updated_at'] as num).toInt(),
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
