// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadInfo _$ThreadInfoFromJson(Map<String, dynamic> json) {
  return ThreadInfo(
    replyCount: json['reply_count'] as int,
    mostRepliesUsers: (json['most_replies_users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    lastRepliedAt: json['last_replied_at'] as int,
    updatedAt: json['updated_at'] as int,
  );
}

Map<String, dynamic> _$ThreadInfoToJson(ThreadInfo instance) =>
    <String, dynamic>{
      'reply_count': instance.replyCount,
      'most_replies_users':
          instance.mostRepliesUsers?.map((e) => e?.toJson())?.toList(),
      'last_replied_at': instance.lastRepliedAt,
      'updated_at': instance.updatedAt,
    };
