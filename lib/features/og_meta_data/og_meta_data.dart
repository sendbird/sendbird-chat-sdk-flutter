import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/features/og_meta_data/og_image.dart';

part 'og_meta_data.g.dart';

/// Represents open graph information
@JsonSerializable()
class OGMetaData {
  /// Open graph title
  @JsonKey(name: 'og:title')
  final String? title;

  /// Open graph url
  @JsonKey(name: 'og:url')
  final String? url;

  /// Open graph description
  @JsonKey(name: 'og:description')
  final String? description;

  /// Open graph image
  @JsonKey(name: 'og:image')
  final OGImage? defaultImage;

  OGMetaData({
    this.title,
    this.url,
    this.description,
    this.defaultImage,
  });

  factory OGMetaData.fromJson(Map<String, dynamic> json) =>
      _$OGMetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$OGMetaDataToJson(this);
}
