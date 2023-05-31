// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
      closeAt: json['close_at'] as int,
      status: $enumDecode(_$PollStatusEnumMap, json['status']),
      messageId: json['message_id'] as int?,
      data: json['data'] == null
          ? null
          : PollData.fromJson(json['data'] as Map<String, dynamic>),
      voterCount: json['voter_count'] as int? ?? -1,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => PollOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdBy: json['created_by'] as String?,
      allowUserSuggestion: json['allow_user_suggestion'] as bool? ?? false,
      allowMultipleVotes: json['allow_multiple_votes'] as bool? ?? false,
      votedPollOptionIds: (json['voted_poll_option_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'close_at': instance.closeAt,
      'status': _$PollStatusEnumMap[instance.status]!,
      'message_id': instance.messageId,
      'data': instance.data?.toJson(),
      'voter_count': instance.voterCount,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'created_by': instance.createdBy,
      'allow_user_suggestion': instance.allowUserSuggestion,
      'allow_multiple_votes': instance.allowMultipleVotes,
      'voted_poll_option_ids': instance.votedPollOptionIds,
    };

const _$PollStatusEnumMap = {
  PollStatus.open: 'open',
  PollStatus.closed: 'closed',
};
