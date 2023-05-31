// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_count_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnreadCountInfo _$UnreadCountInfoFromJson(Map<String, dynamic> json) =>
    UnreadCountInfo(
      all: json['all'] as int? ?? 0,
      customTypes: (json['custom_types'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
      ts: json['ts'] as int? ?? 0,
    );
