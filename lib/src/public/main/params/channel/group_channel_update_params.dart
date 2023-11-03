// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

part 'group_channel_update_params.g.dart';

/// Represents a group channel update params.
@JsonSerializable()
class GroupChannelUpdateParams {
  /// The public mode of the channel.
  /// If set to `true`, then [isDistinct] must be `false`.
  bool? isPublic;

  /// The distinct mode of the channel.
  /// If [GroupChannel.isSuper] is `true`, then this must be set to `false`.
  bool? isDistinct;

  /// Whether the channel is a discoverable channel for public group channel.
  /// It is valid only when [isPublic] is set to `true`.
  /// If set to `false`, this channel will not appear in the result of [PublicGroupChannelListQuery].
  bool? isDiscoverable = true;

  /// The access code for public group channel. The access code setting is only valid for **public** [GroupChannel]s.
  /// Once the access code is set, users have to accept an invitation or join the public [GroupChannel] with the access code to be a member of the channel.
  /// Refer to [GroupChannelOperation.join] and [GroupChannelOperation.acceptInvitation].
  /// To delete the existing access code, pass an empty string as to this and call [GroupChannel.updateChannel].
  String? accessCode;

  /// The custom type of the channel.
  String? customType;

  /// The data of the channel.
  String? data;

  /// The name of the channel.
  String? name;

  /// The cover image file info.
  @JsonKey(includeFromJson: false, includeToJson: false)
  FileInfo? coverImage;

  /// The operator user ids of the channel. Defaults to null.
  @JsonKey(name: 'operator_ids')
  List<String>? operatorUserIds;

  GroupChannelUpdateParams();

  static GroupChannelUpdateParams fromJson(Map<String, dynamic> json) {
    return _$GroupChannelUpdateParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$GroupChannelUpdateParamsToJson(this);
    if (coverImage != null && coverImage!.hasBinary) {
      json['cover_file'] = coverImage;
    } else {
      json['cover_url'] = coverImage?.fileUrl;
    }
    if (json['is_public'] == false || json['is_public'] == null) {
      json.remove('is_discoverable');
    }

    // Remove Unchanged Properties
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
