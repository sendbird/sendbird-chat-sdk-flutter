// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_voter_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollVoterListQuery _$PollVoterListQueryFromJson(Map<String, dynamic> json) =>
    PollVoterListQuery(
      params: PollVoterListQueryParams.fromJson(
          json['params'] as Map<String, dynamic>),
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int;

Map<String, dynamic> _$PollVoterListQueryToJson(PollVoterListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'params': instance.params.toJson(),
    };
