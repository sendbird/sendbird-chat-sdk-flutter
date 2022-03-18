import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/features/og_meta_data/og_interfaces.dart';

part 'og_image.g.dart';

/// Represents open graph image information
@JsonSerializable()
class OGImage implements OGDisplayable, OGMedia {
  /// Image url
  @override
  final String? url;

  /// Image secure url
  @override
  final String? secureUrl;

  /// Image type
  final String? type;

  /// Description of what's in this image
  final String? alt;

  /// Image width
  @override
  @JsonKey(defaultValue: 0)
  final int width;

  /// Image height
  @override
  @JsonKey(defaultValue: 0)
  final int height;

  OGImage({
    this.url,
    this.secureUrl,
    this.type,
    this.alt,
    this.width = 0,
    this.height = 0,
  });

  factory OGImage.fromJson(Map<String, dynamic> json) =>
      _$OGImageFromJson(json);
  Map<String, dynamic> toJson() => _$OGImageToJson(this);
}
