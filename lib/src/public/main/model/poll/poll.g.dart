// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
      closeAt: json['closeAt'] as int,
      status: $enumDecode(_$PollStatusEnumMap, json['status']),
      messageId: json['messageId'] as int?,
      data: json['data'] == null
          ? null
          : PollData.fromJson(json['data'] as Map<String, dynamic>),
      voterCount: json['voterCount'] as int? ?? -1,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => PollOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdBy: json['createdBy'] as String?,
      allowUserSuggestion: json['allowUserSuggestion'] as bool? ?? false,
      allowMultipleVotes: json['allowMultipleVotes'] as bool? ?? false,
      votedPollOptionIds: (json['votedPollOptionIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'closeAt': instance.closeAt,
      'status': _$PollStatusEnumMap[instance.status]!,
      'messageId': instance.messageId,
      'data': instance.data,
      'voterCount': instance.voterCount,
      'options': instance.options,
      'createdBy': instance.createdBy,
      'allowUserSuggestion': instance.allowUserSuggestion,
      'allowMultipleVotes': instance.allowMultipleVotes,
      'votedPollOptionIds': instance.votedPollOptionIds,
    };

const _$PollStatusEnumMap = {
  PollStatus.open: 'open',
  PollStatus.closed: 'closed',
};
