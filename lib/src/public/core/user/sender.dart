// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'sender.g.dart';

/// Represents a sender.
@JsonSerializable(createToJson: false)
class Sender extends User {
  /// Whether this sender is blocked by [SendbirdChat.currentUser].
  bool isBlockedByMe;

  /// The [Role] of this sender in the current channel.
  /// If the sender's role status changes after the field value allocation,
  /// the value returned by this method may not reflect the latest role.
  @JsonKey(unknownEnumValue: Role.none)
  Role role;

  Sender({
    this.isBlockedByMe = false,
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

  static Sender? fromUser(User? user, BaseChannel channel) {
    if (user == null) return null;
    final sender = Sender.fromJsonWithChat(channel.chat, user.toJson());
    if (channel is GroupChannel) {
      sender.role = channel.myRole;
    } else if (channel is OpenChannel) {
      sender.role = channel.isOperator(user.userId) ? Role.operator : Role.none;
    }
    return sender;
  }

  factory Sender.fromJson(Map<String, dynamic> json) {
    if (json['guest_id'] != null) json['user_id'] = json['guest_id'];
    if (json['name'] != null) json['nickname'] = json['name'];
    if (json['image'] != null) json['profile_url'] = json['image'];
    return _$SenderFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat
  }

  factory Sender.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return Sender.fromJson(json)..set(chat);
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    return other is Sender && other.role == role;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, role);
}
