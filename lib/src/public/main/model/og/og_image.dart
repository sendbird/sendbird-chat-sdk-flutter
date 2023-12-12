// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_meta_data.dart';

part 'og_image.g.dart';

abstract class OGMedia {
  final String? url = '';
  final String? secureUrl = '';
}

abstract class OGDisplayable {
  final int width = 0;
  final int height = 0;
}

/// Represents a Open Graph Image of [OGMetaData].
/// For Specifications, see [https://ogp.me/](https://ogp.me/).
@JsonSerializable()
class OGImage implements OGDisplayable, OGMedia {
  /// An image URL which represents the object within the Open Graph.
  @override
  final String? url;

  /// An alternate url to use if the webpage requires HTTPS.
  @override
  final String? secureUrl;

  /// A MIME type for this image.
  final String? type;

  /// A description of what is in the image (not a caption).
  final String? alt;

  /// The number of pixels wide.
  @override
  final int width;

  /// The number of pixels high.
  @override
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
