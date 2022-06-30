// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_channel_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenChannelListQuery _$OpenChannelListQueryFromJson(
        Map<String, dynamic> json) =>
    OpenChannelListQuery()
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int
      ..channelUrl = json['channel_url'] as String?
      ..channelName = json['channel_name'] as String?
      ..customType = json['custom_type'] as String?
      ..includeFrozenChannel = json['include_frozen_channel'] as bool
      ..includeMetaData = json['include_meta_data'] as bool;

Map<String, dynamic> _$OpenChannelListQueryToJson(
        OpenChannelListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_url': instance.channelUrl,
      'channel_name': instance.channelName,
      'custom_type': instance.customType,
      'include_frozen_channel': instance.includeFrozenChannel,
      'include_meta_data': instance.includeMetaData,
    };
