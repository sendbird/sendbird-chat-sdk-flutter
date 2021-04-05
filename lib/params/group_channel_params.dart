import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/models/image_info.dart';

/// An object consists a set of parameters to create/update group channel.
class GroupChannelParams {
  /// Determine a channel is super channel or not. default is `false`
  bool isSuper = false;

  /// Determine a channel is broadcast channel or not. default is `false`
  bool isBroadcast = false;

  /// Determine a channel is public channel or not. default is `false`
  bool isPublic = false;

  /// Determine a channel is distinct or not.
  /// If `true`, the channel which has the same users is returned.
  /// default is `false`
  bool isDistinct = false;

  /// Determine a channel is ephemeral or not. default is `false`
  bool isEphemeral = false;

  /// Determine whether the public group channel is discoverable.
  /// It is only for creating or updating a public group channel.
  /// This property will be ingored if [isPublic] is `false`.
  bool isDiscoverable = true;

  /// Determine whether a channel is strict or not.
  /// If you have two valid users and this property is `true`, then
  /// the channel is created successfully with that users. If one
  /// valid user, one invalid user, and this property is `true`, you
  /// will get an error when creating channel. However, if you have
  /// one valid user, one invalid user, and this propety is `false`,
  /// you can create a channel without errors
  bool isStrict = false;

  /// A string that allows access to the public group channel.
  /// ONLY use for public group channel.
  String accessCode;

  /// An unique identification for channel. Use in creation only.
  String channelUrl;

  /// Custom type for a channel
  String customType;

  /// Custom data for a channel
  String data;

  /// Name for a channel
  String name;

  ImageInfo coverImage;

  /// List of user id who will get invited
  List<String> userIds;

  /// List of user id who are operator
  List<String> operatorUserIds;

  //TBD
  //Int messageSurvivalSeconds;

  GroupChannelParams();
  GroupChannelParams.withChannel(GroupChannel channel) {
    channelUrl = channel.channelUrl;
    isPublic = channel.isPublic;
    isDiscoverable = channel.isDiscoverable;
    isDistinct = channel.isDistinct;
  }
}
