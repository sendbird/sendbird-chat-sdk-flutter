// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emoji _$EmojiFromJson(Map<String, dynamic> json) {
  return Emoji(
    key: json['key'] as String,
    url: json['url'] as String,
  );
}

EmojiCategory _$EmojiCategoryFromJson(Map<String, dynamic> json) {
  return EmojiCategory(
    id: json['id'] as int,
    name: json['name'] as String,
    url: json['url'] as String,
    emojis: (json['emojis'] as List)
        ?.map(
            (e) => e == null ? null : Emoji.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

EmojiContainer _$EmojiContainerFromJson(Map<String, dynamic> json) {
  return EmojiContainer(
    emojiHash: json['emoji_hash'] as String,
    emojiCategories: (json['emoji_categories'] as List)
        ?.map((e) => e == null
            ? null
            : EmojiCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
