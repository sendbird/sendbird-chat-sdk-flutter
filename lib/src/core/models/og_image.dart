import 'package:json_annotation/json_annotation.dart';
import 'og_interfaces.dart';

part 'og_image.g.dart';

/// Represents open graph image information
@JsonSerializable()
class OGImage implements OGMedia, OGDisplayable {
  /// Image url
  final String url;

  /// Image secure url
  final String secureUrl;

  /// Image type
  final String type;

  /// Description of what's in this image
  final String alt;

  /// Image width
  final int width;

  /// Image height
  final int height;

  OGImage({
    this.url,
    this.secureUrl,
    this.type,
    this.alt,
    this.width,
    this.height,
  });

  factory OGImage.fromJson(Map<String, dynamic> json) =>
      _$OGImageFromJson(json);
  Map<String, dynamic> toJson() => _$OGImageToJson(this);
}
