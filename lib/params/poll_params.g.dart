// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollCreateParams _$PollCreateParamsFromJson(Map<String, dynamic> json) =>
    PollCreateParams(
      title: json['title'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] == null
          ? null
          : PollData.fromJson(json['data'] as Map<String, dynamic>),
      allowUserSuggestion: json['allow_user_suggestion'] as bool?,
      allowMutipleVotes: json['allow_mutiple_votes'] as bool?,
      closeAt: json['close_at'] as int? ?? -1,
    );

Map<String, dynamic> _$PollCreateParamsToJson(PollCreateParams instance) =>
    <String, dynamic>{
      'title': instance.title,
      'options': instance.options,
      'data': instance.data?.toJson(),
      'allow_user_suggestion': instance.allowUserSuggestion,
      'allow_mutiple_votes': instance.allowMutipleVotes,
      'close_at': instance.closeAt,
    };
