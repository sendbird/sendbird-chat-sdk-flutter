// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'emoji.g.dart';

/// Objects representing a emoji.
@JsonSerializable(createToJson: false)
class Emoji {
  /// The key of the emoji.
  final String key;

  /// The url of the emoji.
  final String url;

  Emoji({required this.key, required this.url});

  factory Emoji.fromJson(Map<String, dynamic> json) => _$EmojiFromJson(json);
}

/// Objects representing a category of emoji.
@JsonSerializable(createToJson: false)
class EmojiCategory {
  /// The id of the emoji category.
  final int id;

  /// The name of the emoji category.
  final String name;

  /// The url of the emoji category.
  final String url;

  /// The list of emojis.
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

/// Objects representing emoji information.
@JsonSerializable(createToJson: false)
class EmojiContainer {
  /// The hash value of emoji information.
  final String emojiHash;

  /// The list of emoji categories.
  @JsonKey(defaultValue: [])
  final List<EmojiCategory> emojiCategories;

  EmojiContainer({required this.emojiHash, required this.emojiCategories});

  factory EmojiContainer.fromJson(Map<String, dynamic> json) =>
      _$EmojiContainerFromJson(json);
}
