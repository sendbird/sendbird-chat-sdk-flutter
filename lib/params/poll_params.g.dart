// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollParams _$PollParamsFromJson(Map<String, dynamic> json) => PollParams(
      title: json['title'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    )
      ..data = json['data'] == null
          ? null
          : PollData.fromJson(json['data'] as Map<String, dynamic>)
      ..isAnonymous = json['is_anonymous'] as bool
      ..allowUserSuggestion = json['allow_user_suggestion'] as bool
      ..allowMutipleVotes = json['allow_mutiple_votes'] as bool
      ..closeAt = json['close_at'] as int;

Map<String, dynamic> _$PollParamsToJson(PollParams instance) =>
    <String, dynamic>{
      'title': instance.title,
      'options': instance.options,
      'data': instance.data?.toJson(),
      'is_anonymous': instance.isAnonymous,
      'allow_user_suggestion': instance.allowUserSuggestion,
      'allow_mutiple_votes': instance.allowMutipleVotes,
      'close_at': instance.closeAt,
    };
