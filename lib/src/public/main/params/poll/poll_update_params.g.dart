// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollUpdateParams _$PollUpdateParamsFromJson(Map<String, dynamic> json) =>
    PollUpdateParams(
      title: json['title'] as String?,
      data: json['data'] == null
          ? null
          : PollData.fromJson(json['data'] as Map<String, dynamic>),
      allowUserSuggestion: json['allowUserSuggestion'] as bool?,
      allowMultipleVotes: json['allowMultipleVotes'] as bool?,
      closeAt: json['closeAt'] as int? ?? -1,
    );

Map<String, dynamic> _$PollUpdateParamsToJson(PollUpdateParams instance) =>
    <String, dynamic>{
      'title': instance.title,
      'data': instance.data,
      'allowUserSuggestion': instance.allowUserSuggestion,
      'allowMultipleVotes': instance.allowMultipleVotes,
      'closeAt': instance.closeAt,
    };
