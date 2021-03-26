import 'dart:async';

import 'package:json_annotation/json_annotation.dart';

import '../models/error.dart';
import '../../constant/enums.dart';
import '../../sdk/sendbird_sdk_api.dart';

part 'user.g.dart';

/// An object represents user
@JsonSerializable()
class User {
  /// User ID. This has to be unique
  String userId;

  /// User nickname
  String nickname;

  /// Profile image url
  String profileUrl;

  /// Profile image url with auth
  String get secureProfileUrl {
    final sdk = SendbirdSdk().getInternal();
    if (requireAuth &&
        sdk.sessionManager.getEKey() != null &&
        profileUrl != null) {
      //https://github.com/flutter/flutter/issues/25107
      return '$profileUrl?auth=${sdk.sessionManager.getEKey()}';
    }
    return null;
  }

  /// This user's connection status
  @JsonKey(unknownEnumValue: UserConnectionStatus.notAvailable)
  UserConnectionStatus connectionStatus;

  /// The lastest time when the user became offline
  int lastSeenAt;

  /// True if this user is activated. This property is changed by the
  /// [Platform API](https://docs.sendbird.com/platform#user_3_update_a_user)
  bool isActive;

  /// User's preferred language. Used for translating messages.
  List<String> preferredLanguages;

  String friendDiscoveryKey;

  String friendName;

  List<String> discoveryKeys;

  @JsonKey(defaultValue: {})
  Map<String, String> metaData;

  @JsonKey(name: "require_auth_for_profile_image")
  bool requireAuth;

  String sessionToken;

  User({
    this.userId,
    this.nickname,
    this.profileUrl,
    this.connectionStatus,
    this.lastSeenAt,
    this.isActive,
    this.preferredLanguages,
    this.friendDiscoveryKey,
    this.friendName,
    this.discoveryKeys,
    this.metaData,
    this.requireAuth,
    this.sessionToken,
  });

  Future<Map<String, String>> createMetaData(
    Map<String, String> metaDataMap,
  ) async {
    if (metaDataMap == null || metaDataMap.isEmpty) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    final result = await sdk.api.createUserMetaData(metaData: metaDataMap);
    final map = Map<String, String>.from(result);
    metaData.addAll(map);
    return map;
  }

  Future<Map<String, String>> updateMetaData(
      Map<String, String> metaDataMap) async {
    if (metaDataMap == null || metaDataMap.isEmpty) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    final result = await sdk.api.updateUserMetaData(
      metaData: metaDataMap,
      upsert: true,
    );
    final map = Map<String, String>.from(result);
    metaData.addAll(map);
    return map;
  }

  Future<void> deleteMetaData(String key) async {
    if (key == null || key == '') {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    await sdk.api.deleteUserMetaData(key);
    metaData.remove(key);
  }

  Future<void> deleteAllMetaData() async {
    final sdk = SendbirdSdk().getInternal();
    await sdk.api.deleteAllUserMetaData();
    metaData.removeWhere((key, value) => true);
  }

  bool get isCurrentUser => userId == SendbirdSdk().getCurrentUser()?.userId;

  /// json serialization
  factory User.fromJson(Map<String, dynamic> json) {
    if (json['guest_id'] != null) json['user_id'] = json['guest_id'];
    if (json['session_tokens'] != null &&
        (json['session_tokens'] as List).length > 0) {
      final tokens = List<Map>.from(json['session_tokens'] as List);
      json['session_token'] = tokens?.first['session_token'];
    }
    if (json['is_online'] != null) {
      bool isOnline = json['is_online'];
      json['connection_status'] = isOnline ? 'online' : 'offline';
    }
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  void copyWith(User other) {
    nickname = other.nickname;
    profileUrl = other.profileUrl;
    connectionStatus = other.connectionStatus;
    lastSeenAt = other.lastSeenAt;
    isActive = other.isActive;
    preferredLanguages = other.preferredLanguages;
    friendDiscoveryKey = other.friendDiscoveryKey;
    friendName = other.friendName;
    discoveryKeys = other.discoveryKeys;
    metaData = other.metaData;
  }
}
