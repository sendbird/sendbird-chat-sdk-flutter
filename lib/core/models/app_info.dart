import 'package:json_annotation/json_annotation.dart';

part 'app_info.g.dart';

/// Represents current Sendbird application information.
@JsonSerializable(createToJson: false)
class AppInfo {
  /// Latest hash value for emoji
  final String emojiHash;

  /// Uplodable file size limit (unit in bytes)
  @JsonKey(
    name: 'file_upload_size_limit',
    defaultValue: 30,
  )
  final int uploadSizeLimit;

  /// List of premium feature on current application id
  @JsonKey(defaultValue: [])
  final List<String> premiumFeatureList;

  /// True if reaction feature is enabled
  final bool useReaction;

  /// list of application attributes of current application id
  @JsonKey(defaultValue: [])
  final List<String> applicationAttributes;

  AppInfo({
    required this.emojiHash,
    required this.uploadSizeLimit,
    required this.premiumFeatureList,
    required this.useReaction,
    required this.applicationAttributes,
  });

  /// Return `true` if a given [prevEmojiHash] is outdated
  bool isEmojiUpdatedNeeded(String prevEmojiHash) {
    return emojiHash != prevEmojiHash;
  }

  factory AppInfo.fromJson(Map<String, dynamic> json) =>
      _$AppInfoFromJson(json);
}
