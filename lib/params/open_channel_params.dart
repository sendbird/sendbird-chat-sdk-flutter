import 'package:sendbird_sdk/core/models/file_info.dart';

/// An object consists a set of parameters to create/update open channel.
class OpenChannelParams {
  /// Channel url that a channel is to be updated.
  /// Use in creation only.
  String channelUrl;

  /// Custom type for a channel
  String customType;

  /// Custom data for a channel
  String data;

  /// Name for a channel
  String name;

  /// Object contains url or file to be uploaded
  FileInfo coverImage;

  /// List of user id who will be operator in a channel
  List<String> operatorUserIds;
}
