// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) => Command(
      cmd: json['cmd'] as String,
      requestId: json['req_id'] as String?,
      timestamp: json['ts'] as int?,
      requireAuth: json['require_auth'] as bool?,
      errorCode: json['code'] as int?,
      errorMessage: json['message'] as String?,
      replyToChannel: json['reply_to_channel'] as bool? ?? false,
    );

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
      'cmd': instance.cmd,
      'ts': instance.timestamp,
      'code': instance.errorCode,
      'message': instance.errorMessage,
      'require_auth': instance.requireAuth,
      'req_id': instance.requestId,
      'reply_to_channel': instance.replyToChannel,
    };
