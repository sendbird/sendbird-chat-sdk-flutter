import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/utils/json_from_parser.dart';

part 'sender.g.dart';

/// An object represents a sender of a message.
@JsonSerializable()
class Sender extends User {
  /// True if current user blocked this sender
  @JsonKey(defaultValue: false)
  final bool isBlockedByMe;

  /// Role of this sender in the channel
  @JsonKey(defaultValue: Role.none, unknownEnumValue: Role.none)
  Role role;

  Sender({
    this.isBlockedByMe = false,
    this.role = Role.none,
    required String userId,
    required String nickname,
    String? profileUrl,
    UserConnectionStatus connectionStatus = UserConnectionStatus.notAvailable,
    int? lastSeenAt,
    List<String>? preferredLanguages,
    String? friendDiscoveryKey,
    String? friendName,
    List<String>? discoveryKeys,
    Map<String, String> metaData = const {},
    bool requireAuth = false,
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

  static Sender? fromUser(User? user, BaseChannel channel) {
    if (user == null) return null;
    final sender = Sender.fromJson(user.toJson());
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

  @override
  Map<String, dynamic> toJson() => _$SenderToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    return other is Sender && other.role == role;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, role);
}
