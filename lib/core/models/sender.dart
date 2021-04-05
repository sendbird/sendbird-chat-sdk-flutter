import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/models/user.dart';

part 'sender.g.dart';

/// An object represents a sender of a message.
@JsonSerializable()
class Sender extends User {
  /// True if current user blocked this sender
  final bool isBlockedByMe;

  /// Role of this sender in the channel
  @JsonKey(unknownEnumValue: Role.none)
  Role role;

  Sender({
    this.isBlockedByMe,
    this.role,
    String userId,
    String nickname,
    String profileUrl,
    UserConnectionStatus connectionStatus,
    int lastSeenAt,
    List<String> preferredLanguages,
    String friendDiscoveryKey,
    String friendName,
    List<String> discoveryKeys,
    Map<String, String> metaData,
    bool requireAuth,
  }) : super(
          userId: userId,
          nickname: nickname,
          profileUrl: profileUrl,
          connectionStatus: connectionStatus,
          lastSeenAt: lastSeenAt,
          preferredLanguages: preferredLanguages,
          friendDiscoveryKey: friendDiscoveryKey,
          friendName: friendName,
          discoveryKeys: discoveryKeys,
          metaData: metaData,
          requireAuth: requireAuth,
        );

  factory Sender.fromUser(User user, BaseChannel channel) {
    Sender sender = Sender.fromJson(user.toJson());
    if (channel is GroupChannel) {
      sender.role = channel.myRole;
    } else if (channel is OpenChannel) {
      sender.role =
          channel.isOperator(user.userId) ? Role.chat_operator : Role.none;
    }
    return sender;
  }

  //json serialization

  factory Sender.fromJson(Map<String, dynamic> json) {
    if (json['guest_id'] != null) json['user_id'] = json['guest_id'];
    if (json['name'] != null) json['nickname'] = json['name'];
    if (json['image'] != null) json['profile_url'] = json['image'];
    return _$SenderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SenderToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    return other is Sender && other.role == role;
  }

  @override
  int get hashCode => super.hashCode;
}
