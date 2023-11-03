// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_image.dart';

part 'og_meta_data.g.dart';

/// Represents a OGMetaData of a url.
/// For Specifications, see [https://ogp.me/](https://ogp.me/).
/// Currently we only support images.
@JsonSerializable()
class OGMetaData {
  /// The title of the object as it should appear within the graph. ex: "The Rock".
  @JsonKey(name: 'og:title')
  final String? title;

  /// The canonical URL of the object that can be used as its permanent ID in the graph.
  /// ex: "http://www.imdb.com/title/tt0117500/"
  @JsonKey(name: 'og:url')
  final String? url;

  /// A one to two sentence description of the object.
  /// ex: "Sean Connery found fame and fortune
  /// as the suave, sophisticated British agent, James Bond."
  @JsonKey(name: 'og:description')
  final String? description;

  /// An [ogImage] object that contains information about the image that this Open Graph
  /// points to.
  @JsonKey(name: 'og:image')
  final OGImage? ogImage;

  OGMetaData({
    this.title,
    this.url,
    this.description,
    this.ogImage,
  });

  factory OGMetaData.fromJson(Map<String, dynamic> json) =>
      _$OGMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$OGMetaDataToJson(this);
}
