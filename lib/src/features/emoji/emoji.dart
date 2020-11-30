import 'package:json_annotation/json_annotation.dart';

part 'emoji.g.dart';

/// An object represents emoji information
@JsonSerializable(createToJson: false)
class Emoji {
  /// Emoji key
  final String key;

  /// Emoji url address
  final String url;

  Emoji({this.key, this.url});

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
  final List<Emoji> emojis;

  EmojiCategory({this.id, this.name, this.url, this.emojis});

  factory EmojiCategory.fromJson(Map<String, dynamic> json) =>
      _$EmojiCategoryFromJson(json);
}

/// An object represents emoji container information
@JsonSerializable(createToJson: false)
class EmojiContainer {
  /// A hash value for emoji container
  final String emojiHash;

  /// List of emoji category in this container
  final List<EmojiCategory> emojiCategories;

  EmojiContainer({this.emojiHash, this.emojiCategories});

  factory EmojiContainer.fromJson(Map<String, dynamic> json) =>
      _$EmojiContainerFromJson(json);
}
