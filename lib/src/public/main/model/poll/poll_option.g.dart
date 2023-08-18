// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOption _$PollOptionFromJson(Map<String, dynamic> json) => PollOption(
      pollId: json['pollId'] as int,
      id: json['id'] as int,
      text: json['text'] as String,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as int,
      voteCount: json['voteCount'] as int,
      updatedAt: json['updatedAt'] as int,
    );

Map<String, dynamic> _$PollOptionToJson(PollOption instance) =>
    <String, dynamic>{
      'pollId': instance.pollId,
      'id': instance.id,
      'text': instance.text,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'voteCount': instance.voteCount,
      'updatedAt': instance.updatedAt,
    };
