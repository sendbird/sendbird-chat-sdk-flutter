// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_group_channel_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicGroupChannelListQuery _$PublicGroupChannelListQueryFromJson(
    Map<String, dynamic> json) {
  return PublicGroupChannelListQuery()
    ..loading = json['loading'] as bool
    ..hasNext = json['has_next'] as bool
    ..token = json['token'] as String
    ..limit = json['limit'] as int
    ..channelUrls =
        (json['channel_urls'] as List)?.map((e) => e as String)?.toList()
    ..superChannelFilter = _$enumDecodeNullable(
        _$GroupChannelSuperChannelFilterEnumMap, json['super_channel_filter'])
    ..membershipFilter = _$enumDecodeNullable(
        _$PublicGroupChannelMembershipFilterEnumMap, json['membership_filter'])
    ..order = _$enumDecodeNullable(
        _$PublicGroupChannelListOrderEnumMap, json['order'])
    ..customTypeStartWithFilter =
        json['custom_type_start_with_filter'] as String
    ..customTypesFilter =
        (json['custom_types_filter'] as List)?.map((e) => e as String)?.toList()
    ..channelNameContainsFilter = json['channel_name_contains_filter'] as String
    ..metaDataOrderKeyFilter = json['meta_data_order_key_filter'] as String
    ..includeEmptyChannel = json['include_empty_channel'] as bool
    ..includeFrozenChannel = json['include_frozen_channel'] as bool
    ..includeMemberList = json['include_member_list'] as bool
    ..includeMetaData = json['include_meta_data'] as bool;
}

Map<String, dynamic> _$PublicGroupChannelListQueryToJson(
        PublicGroupChannelListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_urls': instance.channelUrls,
      'super_channel_filter':
          _$GroupChannelSuperChannelFilterEnumMap[instance.superChannelFilter],
      'membership_filter': _$PublicGroupChannelMembershipFilterEnumMap[
          instance.membershipFilter],
      'order': _$PublicGroupChannelListOrderEnumMap[instance.order],
      'custom_type_start_with_filter': instance.customTypeStartWithFilter,
      'custom_types_filter': instance.customTypesFilter,
      'channel_name_contains_filter': instance.channelNameContainsFilter,
      'meta_data_order_key_filter': instance.metaDataOrderKeyFilter,
      'include_empty_channel': instance.includeEmptyChannel,
      'include_frozen_channel': instance.includeFrozenChannel,
      'include_member_list': instance.includeMemberList,
      'include_meta_data': instance.includeMetaData,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GroupChannelSuperChannelFilterEnumMap = {
  GroupChannelSuperChannelFilter.all: 'all',
  GroupChannelSuperChannelFilter.superChannel: 'super',
  GroupChannelSuperChannelFilter.nonsuperChannel: 'nonsuper',
};

const _$PublicGroupChannelMembershipFilterEnumMap = {
  PublicGroupChannelMembershipFilter.all: 'all',
  PublicGroupChannelMembershipFilter.joined: 'joined',
};

const _$PublicGroupChannelListOrderEnumMap = {
  PublicGroupChannelListOrder.chronological: 'chronological',
  PublicGroupChannelListOrder.channelNameAlphabetical:
      'channel_name_alphabetical',
  PublicGroupChannelListOrder.channelMetaDataValueAlphabetical:
      'metadata_value_alphabetical',
};
