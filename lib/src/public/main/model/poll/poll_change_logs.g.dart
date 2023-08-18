// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_change_logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollChangeLogs _$PollChangeLogsFromJson(Map<String, dynamic> json) =>
    PollChangeLogs(
      updatedPolls: (json['updated'] as List<dynamic>?)
              ?.map((e) => Poll.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      deletedPollIds: (json['deleted'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      hasMore: json['hasMore'] as bool? ?? false,
      token: json['next'] as String?,
    );
