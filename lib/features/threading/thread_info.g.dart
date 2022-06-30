// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadInfo _$ThreadInfoFromJson(Map<String, dynamic> json) => ThreadInfo(
      replyCount: json['reply_count'] as int? ?? 0,
      mostRepliesUsers: (json['most_replies'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lastRepliedAt: json['last_replied_at'] as int? ?? 0,
      updatedAt: json['updated_at'] as int?,
    );

Map<String, dynamic> _$ThreadInfoToJson(ThreadInfo instance) =>
    <String, dynamic>{
      'reply_count': instance.replyCount,
      'most_replies': instance.mostRepliesUsers.map((e) => e.toJson()).toList(),
      'last_replied_at': instance.lastRepliedAt,
      'updated_at': instance.updatedAt,
    };
