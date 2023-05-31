// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) => FileInfo(
      fileUrl: json['url'] as String?,
      fileName: json['name'] as String?,
      mimeType: json['type'] as String?,
      fileSize: json['size'] as int?,
    );

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'url': instance.fileUrl,
      'name': instance.fileName,
      'type': instance.mimeType,
      'size': instance.fileSize,
    };
