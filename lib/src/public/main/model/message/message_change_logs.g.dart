// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_change_logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageChangeLogs _$MessageChangeLogsFromJson(Map<String, dynamic> json) =>
    MessageChangeLogs(
      updatedMessages: json['updated'] == null
          ? []
          : toRootMessageList(json['updated'] as List),
      deletedMessageIds: toDeletedMessageIds(json['deleted'] as List),
      hasMore: json['has_more'] as bool? ?? false,
      token: json['next'] as String?,
    );
