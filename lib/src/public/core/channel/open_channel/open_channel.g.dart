// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenChannel _$OpenChannelFromJson(Map<String, dynamic> json) => OpenChannel(
      participantCount: json['participant_count'] as int,
      operators: (json['operators'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      channelUrl: json['channel_url'] as String,
      name: json['name'] as String? ?? '',
      coverUrl: json['cover_url'] as String? ?? '',
      createdAt: json['created_at'] as int?,
      data: json['data'] as String? ?? '',
      customType: json['custom_type'] as String? ?? '',
      isFrozen: json['freeze'] as bool? ?? false,
      isEphemeral: json['is_ephemeral'] as bool? ?? false,
    );

Map<String, dynamic> _$OpenChannelToJson(OpenChannel instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'name': instance.name,
      'created_at': instance.createdAt,
      'cover_url': instance.coverUrl,
      'data': instance.data,
      'custom_type': instance.customType,
      'freeze': instance.isFrozen,
      'is_ephemeral': instance.isEphemeral,
      'participant_count': instance.participantCount,
      'operators': instance.operators.map((e) => e.toJson()).toList(),
    };
