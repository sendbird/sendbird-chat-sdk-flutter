// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emoji _$EmojiFromJson(Map<String, dynamic> json) => Emoji(
      key: json['key'] as String,
      url: json['url'] as String,
    );

EmojiCategory _$EmojiCategoryFromJson(Map<String, dynamic> json) =>
    EmojiCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      emojis: (json['emojis'] as List<dynamic>?)
              ?.map((e) => Emoji.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

EmojiContainer _$EmojiContainerFromJson(Map<String, dynamic> json) =>
    EmojiContainer(
      emojiHash: json['emoji_hash'] as String,
      emojiCategories: (json['emoji_categories'] as List<dynamic>?)
              ?.map((e) => EmojiCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
