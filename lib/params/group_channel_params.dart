import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/models/file_info.dart';

part 'group_channel_params.g.dart';

/// An object consists a set of parameters to create/update group channel.
@JsonSerializable()
class GroupChannelParams {
  /// Determine a channel is super channel or not. default is `false`
  bool? isSuper;

  /// Determine a channel is broadcast channel or not. default is `false`
  bool? isBroadcast;

  /// Determine a channel is public channel or not. default is `false`
  bool? isPublic;

  /// Determine a channel is distinct or not.
  /// If `true`, the channel which has the same users is returned.
  /// default is `false`
  bool? isDistinct;

  /// Determine a channel is ephemeral or not. default is `false`
  bool? isEphemeral;

  /// Determine whether the public group channel is discoverable.
  /// It is only for creating or updating a public group channel.
  /// This property will be ingored if [isPublic] is `false`.
  bool? isDiscoverable = true;

  /// Determine whether a channel is strict or not.
  /// If you have two valid users and this property is `true`, then
  /// the channel is created successfully with that users. If one
  /// valid user, one invalid user, and this property is `true`, you
  /// will get an error when creating channel. However, if you have
  /// one valid user, one invalid user, and this propety is `false`,
  /// you can create a channel without errors
  /// default is `false`
  bool? isStrict;

  /// A string that allows access to the public group channel.
  /// ONLY use for public group channel.
  String? accessCode;

  /// An unique identification for channel. Use in creation only.
  String? channelUrl;

  /// Custom type for a channel
  String? customType;

  /// Custom data for a channel
  String? data;

  /// Name for a channel
  String? name;

  @JsonKey(ignore: true)
  FileInfo? coverImage;

  /// List of user id who will get invited
  List<String>? userIds;

  /// List of user id who are operator
  @JsonKey(name: 'operator_ids')
  List<String>? operatorUserIds;

  /// Determines whether the channel is exclusive or not
  bool? isExclusive;

  //TBD
  //Int messageSurvivalSeconds;

  ///Constructor for [GroupChannelParams]
  ///
  /// Should set `isUpdate` to **false** if creating new Group Channel (*default is `false`*)
  /// Should set `isUpdate` to **true** if updating existing group channel
  GroupChannelParams({bool isUpdate = false}) {
    if (!isUpdate) {
      isSuper = false;
      isBroadcast = false;
      isPublic = false;
      isDistinct = false;
      isEphemeral = false;
      isStrict = false;
      isExclusive = false;
    }
  }

  GroupChannelParams.withChannel(GroupChannel channel) {
    isSuper = channel.isSuper;
    isBroadcast = channel.isBroadcast;
    isEphemeral = channel.isEphemeral;
    isDiscoverable = channel.isDiscoverable;
    isStrict = channel.isStrict;
    channelUrl = channel.channelUrl;
    isPublic = channel.isPublic;
    isDiscoverable = channel.isDiscoverable;
    isDistinct = channel.isDistinct;
    isExclusive = channel.isExclusive;
  }

  Map<String, dynamic> toJson() {
    final json = _$GroupChannelParamsToJson(this);
    if (coverImage != null && coverImage!.hasBinary) {
      json['cover_file'] = coverImage;
    } else {
      json['cover_url'] = coverImage?.url;
    }
    if (json['is_public'] == false || json['is_public'] == null) {
      json.remove('is_discoverable');
    }

    //Remove UnChanged Properties
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
