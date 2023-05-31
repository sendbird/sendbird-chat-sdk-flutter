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
