// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'og_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OGMetaData _$OGMetaDataFromJson(Map<String, dynamic> json) => OGMetaData(
      title: json['og:title'] as String?,
      url: json['og:url'] as String?,
      description: json['og:description'] as String?,
      defaultImage: json['og:image'] == null
          ? null
          : OGImage.fromJson(json['og:image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OGMetaDataToJson(OGMetaData instance) =>
    <String, dynamic>{
      'og:title': instance.title,
      'og:url': instance.url,
      'og:description': instance.description,
      'og:image': instance.defaultImage?.toJson(),
    };
