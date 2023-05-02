// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_message_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviousMessageListQuery _$PreviousMessageListQueryFromJson(
        Map<String, dynamic> json) =>
    PreviousMessageListQuery(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int
      ..reverse = json['reverse'] as bool
      ..messageTypeFilter =
          $enumDecode(_$MessageTypeFilterEnumMap, json['message_type_filter'])
      ..customTypesFilter = (json['custom_types_filter'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..senderIdsFilter = (json['sender_ids_filter'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..includeMetaArray = json['include_meta_array'] as bool
      ..includeReactions = json['include_reactions'] as bool
      ..includeParentMessageText = json['include_parent_message_text'] as bool?
      ..includeParentMessageInfo = json['include_parent_message_info'] as bool
      ..includeReplies = json['include_replies'] as bool?
      ..replyType = $enumDecode(_$ReplyTypeEnumMap, json['include_reply_type'])
      ..includeThreadInfo = json['include_thread_info'] as bool
      ..showSubChannelMessagesOnly =
          json['show_subchannel_messages_only'] as bool;

Map<String, dynamic> _$PreviousMessageListQueryToJson(
        PreviousMessageListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'channel_url': instance.channelUrl,
      'reverse': instance.reverse,
      'message_type_filter':
          _$MessageTypeFilterEnumMap[instance.messageTypeFilter],
      'custom_types_filter': instance.customTypesFilter,
      'sender_ids_filter': instance.senderIdsFilter,
      'include_meta_array': instance.includeMetaArray,
      'include_reactions': instance.includeReactions,
      'include_parent_message_text': instance.includeParentMessageText,
      'include_parent_message_info': instance.includeParentMessageInfo,
      'include_replies': instance.includeReplies,
      'include_reply_type': _$ReplyTypeEnumMap[instance.replyType]!,
      'include_thread_info': instance.includeThreadInfo,
      'show_subchannel_messages_only': instance.showSubChannelMessagesOnly,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$MessageTypeFilterEnumMap = {
  MessageTypeFilter.all: null,
  MessageTypeFilter.user: 'MESG',
  MessageTypeFilter.file: 'FILE',
  MessageTypeFilter.admin: 'ADMN',
};

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'NONE',
  ReplyType.all: 'ALL',
  ReplyType.only_reply_to_channel: 'ONLY_REPLY_TO_CHANNEL',
};
