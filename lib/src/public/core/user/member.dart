// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/restricted_user.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'member.g.dart';

/// Represents a `GroupChannel` member.
@JsonSerializable()
class Member extends User {
  /// The [Member]'s invitation state.
  @JsonKey(name: 'state', unknownEnumValue: MemberState.none)
  MemberState memberState;

  /// Whether the [Member] is blocked by the [SendbirdChat.currentUser].
  bool isBlockedByMe;

  /// Whether the [Member] is blocking the [SendbirdChat.currentUser].
  bool isBlockingMe;

  /// Whether the [Member] is muted or not.
  bool isMuted;

  /// The role of this member in the channel. Refer to [Role].
  @JsonKey(unknownEnumValue: Role.none)
  Role role;

  /// Restriction information for the current member.
  /// Only `Nonnull` if the member is muted.
  @JsonKey(includeFromJson: false, includeToJson: false)
  RestrictionInfo? restrictionInfo;

  Member({
    this.memberState = MemberState.none,
    this.isBlockedByMe = false,
    this.isBlockingMe = false,
    this.isMuted = false,
    this.role = Role.none,
    required String userId,
    required String nickname,
    String profileUrl = '',
    UserConnectionStatus connectionStatus = UserConnectionStatus.notAvailable,
    int? lastSeenAt,
    List<String>? preferredLanguages,
    String friendDiscoveryKey = '',
    String friendName = '',
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
          metaData: metaData,
          requireAuth: requireAuth,
        );

  factory Member.fromJson(Map<String, dynamic> json) {
    final member = _$MemberFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat
    member.restrictionInfo = RestrictionInfo.fromJson(json);
    return member;
  }

  factory Member.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return Member.fromJson(json)..set(chat);
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
        other.memberState == memberState;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, role, isMuted, memberState);
}
