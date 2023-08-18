// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadStatus _$ReadStatusFromJson(Map<String, dynamic> json) => ReadStatus(
      userId: userToUserId(json['user'] as Map<String, dynamic>?),
      timestamp: json['ts'] as int? ?? 0,
      channelUrl: json['channelUrl'] as String,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channelType']),
    );

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
};
