// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_create_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollCreateParams _$PollCreateParamsFromJson(Map<String, dynamic> json) =>
    PollCreateParams(
      title: json['title'] as String,
      optionTexts:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] == null
          ? null
          : PollData.fromJson(json['data'] as Map<String, dynamic>),
      allowUserSuggestion: json['allowUserSuggestion'] as bool?,
      allowMultipleVotes: json['allowMultipleVotes'] as bool?,
      closeAt: json['closeAt'] as int? ?? -1,
    );

Map<String, dynamic> _$PollCreateParamsToJson(PollCreateParams instance) =>
    <String, dynamic>{
      'title': instance.title,
      'options': instance.optionTexts,
      'data': instance.data,
      'allowUserSuggestion': instance.allowUserSuggestion,
      'allowMultipleVotes': instance.allowMultipleVotes,
      'closeAt': instance.closeAt,
    };
