// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map<String, dynamic> json) => Reaction(
      key: json['key'] as String,
      userIds: (json['user_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      updatedAt: json['updated_at'] as int,
    );

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'key': instance.key,
      'user_ids': instance.userIds,
      'updated_at': instance.updatedAt,
    };
