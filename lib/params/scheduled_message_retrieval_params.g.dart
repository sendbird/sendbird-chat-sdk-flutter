// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_message_retrieval_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledMessageRetrievalParams _$ScheduledMessageRetrievalParamsFromJson(
        Map<String, dynamic> json) =>
    ScheduledMessageRetrievalParams(
      channelUrl: json['channel_url'] as String,
      scheduledMessageId: json['scheduled_message_id'] as int,
    );

Map<String, dynamic> _$ScheduledMessageRetrievalParamsToJson(
        ScheduledMessageRetrievalParams instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'scheduled_message_id': instance.scheduledMessageId,
    };
