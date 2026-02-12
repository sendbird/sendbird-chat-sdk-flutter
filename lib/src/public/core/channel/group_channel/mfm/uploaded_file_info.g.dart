// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_file_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedFileInfo _$UploadedFileInfoFromJson(Map<String, dynamic> json) =>
    UploadedFileInfo(
      url: json['url'] as String,
      name: json['name'] as String?,
      size: (json['size'] as num?)?.toInt() ?? 0,
      type: json['type'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      requireAuth: json['require_auth'] as bool? ?? false,
    );

Map<String, dynamic> _$UploadedFileInfoToJson(UploadedFileInfo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'size': instance.size,
      'type': instance.type,
      'thumbnails': instance.thumbnails?.map((e) => e.toJson()).toList(),
      'require_auth': instance.requireAuth,
    };
