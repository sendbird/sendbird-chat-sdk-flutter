// @interface SBDOGImage : NSObject <SBDOGMedia, SBDOGDisplayableMedia>

// /// An image url
// @property (nonatomic, copy, readonly, nullable) NSString *url;

// /// An alternate url to use if the webpage requires HTTPS
// @property (nonatomic, copy, readonly, nullable) NSString *secureURL;

// /// A MIME type for this image
// @property (nonatomic, copy, readonly, nullable) NSString *type;

// /// A description of what is in the image (not a caption). If the page specifies an og:image it should specify this property
// @property (nonatomic, copy, readonly, nullable) NSString *alt;

// /// The number of pixels wide
// @property (atomic, assign, readonly) NSInteger width;

// /// The number of pixels high
// @property (atomic, assign, readonly) NSInteger height;

// @end

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
