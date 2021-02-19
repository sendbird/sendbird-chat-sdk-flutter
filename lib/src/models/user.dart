import 'dart:async';

import 'package:json_annotation/json_annotation.dart';

import '../models/error.dart';
import '../sdk/sendbird_sdk_api.dart';

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
    return null;
  }

  /// True if this user is online
  bool isOnline;

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

  User({
    this.userId,
    this.nickname,
    this.profileUrl,
    this.isOnline,
    this.lastSeenAt,
    this.isActive,
    this.preferredLanguages,
    this.friendDiscoveryKey,
    this.friendName,
    this.discoveryKeys,
    this.metaData,
    this.requireAuth,
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
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  void copyWith(User other) {
    nickname = other.nickname;
    profileUrl = other.profileUrl;
    isOnline = other.isOnline;
    lastSeenAt = other.lastSeenAt;
    isActive = other.isActive;
    preferredLanguages = other.preferredLanguages;
    friendDiscoveryKey = other.friendDiscoveryKey;
    friendName = other.friendName;
    discoveryKeys = other.discoveryKeys;
    metaData = other.metaData;
  }
}
