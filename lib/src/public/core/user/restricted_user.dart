// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'restricted_user.g.dart';

/// Represents a restricted [User].
@JsonSerializable(createToJson: false)
class RestrictedUser extends User {
  /// [RestrictionInfo] of the current user.
  RestrictionInfo? get restrictionInfo => _restrictionInfo;
  RestrictionInfo? _restrictionInfo;

  RestrictedUser({
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

  factory RestrictedUser.fromJson(Map<String, dynamic> json) {
    final user = _$RestrictedUserFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat
    user._restrictionInfo = RestrictionInfo.fromJson(json);
    return user;
  }

  factory RestrictedUser.fromJsonWithChat(
      Chat chat, Map<String, dynamic> json) {
    return RestrictedUser.fromJson(json)..set(chat);
  }
}

/// Represents an detailed information of a [RestrictedUser] or [Member]'s restriction.
@JsonSerializable(createToJson: false)
class RestrictionInfo {
  /// Description of the restriction.
  String? description;

  /// End time of the restriction.
  int? endAt;

  /// [RestrictionType] of the current user.
  RestrictionType restrictionType;

  RestrictionInfo({
    this.description,
    this.endAt,
    this.restrictionType = RestrictionType.muted,
  });

  factory RestrictionInfo.fromJson(Map<String, dynamic> json) {
    json['end_at'] = json['end_at'] ?? json['muted_end_at'];
    json['description'] = json['description'] ?? json['muted_description'];
    if (json['type'] == null) json['type'] = 'muted';
    return _$RestrictionInfoFromJson(json);
  }
}
