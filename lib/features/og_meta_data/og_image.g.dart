// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'og_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OGImage _$OGImageFromJson(Map<String, dynamic> json) {
  return OGImage(
    url: json['url'] as String?,
    secureUrl: json['secure_url'] as String?,
    type: json['type'] as String?,
    alt: json['alt'] as String?,
    width: json['width'] as int? ?? 0,
    height: json['height'] as int? ?? 0,
  );
}

Map<String, dynamic> _$OGImageToJson(OGImage instance) => <String, dynamic>{
      'url': instance.url,
      'secure_url': instance.secureUrl,
      'type': instance.type,
      'alt': instance.alt,
      'width': instance.width,
      'height': instance.height,
    };
