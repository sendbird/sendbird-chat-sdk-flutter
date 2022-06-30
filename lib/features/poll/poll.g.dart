// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      details: json['details'] == null
          ? null
          : PollDetail.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'details': instance.details?.toJson(),
    };
