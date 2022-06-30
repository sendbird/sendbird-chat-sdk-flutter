// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SBError _$SBErrorFromJson(Map<String, dynamic> json) => SBError(
      message: json['message'] as String?,
      code: json['code'] as int? ?? 1,
    );

Map<String, dynamic> _$SBErrorToJson(SBError instance) => <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
