// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenChannel _$OpenChannelFromJson(Map<String, dynamic> json) => OpenChannel(
      participantCount: json['participantCount'] as int,
      operators: (json['operators'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      channelUrl: json['channelUrl'] as String,
      name: json['name'] as String? ?? '',
      coverUrl: json['coverUrl'] as String? ?? '',
      createdAt: json['createdAt'] as int?,
      data: json['data'] as String? ?? '',
      customType: json['customType'] as String? ?? '',
      isFrozen: json['freeze'] as bool? ?? false,
      isEphemeral: json['isEphemeral'] as bool? ?? false,
    );
