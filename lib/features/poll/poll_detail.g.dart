// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollDetail _$PollDetailFromJson(Map<String, dynamic> json) => PollDetail(
      options: (json['options'] as List<dynamic>)
          .map((e) => PollOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAnonymous: json['is_anonymous'] as bool,
      allowUserSuggestion: json['allow_user_suggestion'] as bool,
      allowMultipleVotes: json['allow_multiple_votes'] as bool,
      closeAt: json['close_at'] as int,
      voterCount: json['voter_count'] as int,
      votedOptionIds: (json['voted_option_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      status: json['status'] as String,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
      data: json['data'] == null
          ? null
          : PollData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PollDetailToJson(PollDetail instance) =>
    <String, dynamic>{
      'options': instance.options.map((e) => e.toJson()).toList(),
      'data': instance.data?.toJson(),
      'is_anonymous': instance.isAnonymous,
      'allow_user_suggestion': instance.allowUserSuggestion,
      'allow_multiple_votes': instance.allowMultipleVotes,
      'close_at': instance.closeAt,
      'voter_count': instance.voterCount,
      'voted_option_ids': instance.votedOptionIds,
      'status': instance.status,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
