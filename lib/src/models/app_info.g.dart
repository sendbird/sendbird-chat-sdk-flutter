// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) {
  return AppInfo(
    emojiHash: json['emoji_hash'] as String,
    uploadSizeLimit: json['upload_size_limit'] as int,
    premiumFeatureList: (json['premium_feature_list'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    useReaction: json['use_reaction'] as bool,
    applicationAttributes: (json['application_attributes'] as List)
        ?.map((e) => e as String)
        ?.toList(),
  );
}
