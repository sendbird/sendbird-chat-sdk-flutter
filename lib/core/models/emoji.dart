import 'package:json_annotation/json_annotation.dart';

part 'emoji.g.dart';

/// An object represents emoji information
@JsonSerializable(createToJson: false)
class Emoji {
  /// Emoji key
  final String key;

  /// Emoji url address
  final String url;

  Emoji({required this.key, required this.url});

  factory Emoji.fromJson(Map<String, dynamic> json) => _$EmojiFromJson(json);
}

/// An object represents emoji category information
@JsonSerializable(createToJson: false)
class EmojiCategory {
  /// Emoji category id
  final int id;

  /// Emoji category name
  final String name;

  /// Emoji categori url address
  final String url;

  /// List of Emoji in this category
  @JsonKey(defaultValue: [])
  final List<Emoji> emojis;

  EmojiCategory({
    required this.id,
    required this.name,
    required this.url,
    required this.emojis,
  });

  factory EmojiCategory.fromJson(Map<String, dynamic> json) =>
      _$EmojiCategoryFromJson(json);
}

/// An object represents emoji container information
@JsonSerializable(createToJson: false)
class EmojiContainer {
  /// A hash value for emoji container
  final String emojiHash;

  /// List of emoji category in this container
  @JsonKey(defaultValue: [])
  final List<EmojiCategory> emojiCategories;

  EmojiContainer({required this.emojiHash, required this.emojiCategories});

  factory EmojiContainer.fromJson(Map<String, dynamic> json) =>
      _$EmojiContainerFromJson(json);
}
