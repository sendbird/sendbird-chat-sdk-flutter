import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/restricted_user.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/utils/json_from_parser.dart';

part 'member.g.dart';

/// Represents a member of a channel.
@JsonSerializable()
class Member extends User {
  /// The state for invitation. The values of the property are `invited` and `joined`.
  /// The `invited` means that the user doesn't accept the invitation yet and the
  /// `joined` means that the user accepted the invitation manually or automatically
  @JsonKey(defaultValue: MemberState.none, unknownEnumValue: MemberState.none)
  MemberState state;

  /// True if current user has blocked this member, otherwise false
  @JsonKey(defaultValue: false)
  bool isBlockedByMe;

  /// True if this member has blocked current user, otherwise false
  @JsonKey(defaultValue: false)
  bool isBlockingMe;

  /// Muted state of this member in the channel
  @JsonKey(defaultValue: false)
  bool isMuted;

  /// Role of this member in the channel
  @JsonKey(defaultValue: Role.none, unknownEnumValue: Role.none)
  Role role;

  /// Restriction information
  @JsonKey(ignore: true)
  RestrictionInfo? restrictionInfo;

  Member({
    this.state = MemberState.none,
    this.isBlockedByMe = false,
    this.isBlockingMe = false,
    this.isMuted = false,
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

  // json serialization

  factory Member.fromJson(Map<String, dynamic> json) {
    final member = _$MemberFromJson(json);
    member.restrictionInfo = RestrictionInfo.fromJson(json);
    return member;
  }

  @override
  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    return other is Member &&
        other.role == role &&
        other.isMuted == isMuted &&
        other.state == state;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, role, isMuted, state);
}
