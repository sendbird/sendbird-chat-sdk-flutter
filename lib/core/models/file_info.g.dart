// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) => FileInfo(
      name: json['name'] as String?,
      url: json['url'] as String?,
      mimeType: json['type'] as String?,
      fileSize: json['size'] as int?,
    );

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'type': instance.mimeType,
      'size': instance.fileSize,
    };
