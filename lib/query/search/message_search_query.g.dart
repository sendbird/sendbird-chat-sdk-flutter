// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_search_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageSearchQuery _$MessageSearchQueryFromJson(Map<String, dynamic> json) =>
    MessageSearchQuery(
      keyword: json['keyword'] as String,
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int
      ..channelUrl = json['channel_url'] as String?
      ..channelCustomType = json['channel_custom_type'] as String?
      ..reverse = json['reverse'] as bool
      ..exactMatch = json['exact_match'] as bool
      ..messageTimestampFrom = json['message_timestamp_from'] as int?
      ..messageTimestampTo = json['message_timestamp_to'] as int?
      ..beforeIndex = json['before_index'] as String?
      ..afterIndex = json['after_index'] as String?
      ..targetUserIds = (json['target_user_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..advancedQuery = json['advanced_query'] as bool
      ..targetFields = (json['target_fields'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..order = $enumDecode(_$MessageSearchQueryOrderEnumMap, json['order']);

Map<String, dynamic> _$MessageSearchQueryToJson(MessageSearchQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'keyword': instance.keyword,
      'channel_url': instance.channelUrl,
      'channel_custom_type': instance.channelCustomType,
      'reverse': instance.reverse,
      'exact_match': instance.exactMatch,
      'message_timestamp_from': instance.messageTimestampFrom,
      'message_timestamp_to': instance.messageTimestampTo,
      'before_index': instance.beforeIndex,
      'after_index': instance.afterIndex,
      'target_user_ids': instance.targetUserIds,
      'advanced_query': instance.advancedQuery,
      'target_fields': instance.targetFields,
      'order': _$MessageSearchQueryOrderEnumMap[instance.order]!,
    };

const _$MessageSearchQueryOrderEnumMap = {
  MessageSearchQueryOrder.score: 'score',
  MessageSearchQueryOrder.timestamp: 'timestamp',
};
