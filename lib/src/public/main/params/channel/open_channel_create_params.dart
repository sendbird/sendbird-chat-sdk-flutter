// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/file_info.dart';

part 'open_channel_create_params.g.dart';

/// Represents a open channel params.
@JsonSerializable()
class OpenChannelCreateParams {
  /// The channel url of the channel.
  String? channelUrl;

  /// The name of the channel.
  String? name;

  /// The custom type of the channel.
  String? customType;

  /// The data of the channel.
  String? data;

  /// The cover image file info.
  @JsonKey(includeFromJson: false, includeToJson: false)
  FileInfo? coverImage;

  /// The operator user ids of the channel. Defaults to null.
  @JsonKey(name: 'operator_ids')
  List<String>? operatorUserIds;

  static OpenChannelCreateParams fromJson(Map<String, dynamic> json) {
    return _$OpenChannelCreateParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$OpenChannelCreateParamsToJson(this);
    if (coverImage != null && coverImage!.hasBinary) {
      json['cover_file'] = coverImage;
    } else {
      json['cover_url'] = coverImage?.fileUrl;
    }

    json.removeWhere((key, value) => value == null);
    return json;
  }
}
