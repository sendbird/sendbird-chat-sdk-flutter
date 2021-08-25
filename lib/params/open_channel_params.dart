import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/models/file_info.dart';

part 'open_channel_params.g.dart';

/// An object consists a set of parameters to create/update open channel.
@JsonSerializable()
class OpenChannelParams {
  /// Channel url that a channel is to be updated.
  /// Use in creation only.
  String? channelUrl;

  /// Custom type for a channel
  String? customType;

  /// Custom data for a channel
  String? data;

  /// Name for a channel
  String? name;

  /// Object contains url or file to be uploaded
  @JsonKey(ignore: true)
  FileInfo? coverImage;

  /// List of user id who will be operator in a channel
  @JsonKey(name: 'operator_ids')
  List<String>? operatorUserIds;

  Map<String, dynamic> toJson() {
    final json = _$OpenChannelParamsToJson(this);
    if (coverImage != null && coverImage!.hasBinary) {
      json['cover_file'] = coverImage;
    } else {
      json['cover_url'] = coverImage?.url;
    }

    json.removeWhere((key, value) => value == null);
    return json;
  }
}
