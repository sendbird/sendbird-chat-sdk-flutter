// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SBError _$SBErrorFromJson(Map<String, dynamic> json) {
  return SBError(
    message: json['message'] as String?,
    code: json['code'] as int?,
  );
}

Map<String, dynamic> _$SBErrorToJson(SBError instance) => <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
