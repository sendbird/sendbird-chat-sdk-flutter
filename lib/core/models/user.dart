import 'dart:async';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/request/user_meta_data/create_request.dart';
import 'package:sendbird_sdk/request/user_meta_data/delete_request.dart';
import 'package:sendbird_sdk/request/user_meta_data/update_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/utils/json_from_parser.dart';

part 'user.g.dart';

/// An object represents user
@JsonSerializable()
class User {
  /// User ID. This has to be unique
  String userId;

  /// User nickname
  @JsonKey(defaultValue: '')
  String nickname;

  /// Profile image url
  String? profileUrl;

  /// Profile image url with auth
  String? get secureProfileUrl {
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
  @JsonKey(
    name: 'is_online',
    fromJson: boolToConnectionStatus,
    toJson: connectionStatusToBool,
  )
  UserConnectionStatus connectionStatus;

  /// The lastest time when the user became offline
  int? lastSeenAt;

  /// True if this user is activated. This property is changed by the
  /// [Platform API](https://docs.sendbird.com/platform#user_3_update_a_user)
  bool? isActive;

  /// User's preferred language. Used for translating messages.
  List<String>? preferredLanguages;

  String? friendDiscoveryKey;

  String? friendName;

  List<String>? discoveryKeys;

  @JsonKey(defaultValue: {}, name: 'metadata')
  Map<String, String> metaData;

  @JsonKey(defaultValue: false, name: 'require_auth_for_profile_image')
  bool requireAuth;

  String? sessionToken;

  User({
    required this.userId,
    required this.nickname,
    this.profileUrl,
    this.connectionStatus = UserConnectionStatus.notAvailable,
    this.lastSeenAt,
    this.isActive = true,
    this.preferredLanguages,
    this.friendDiscoveryKey,
    this.friendName,
    this.discoveryKeys,
    this.metaData = const {},
    this.requireAuth = false,
    this.sessionToken,
  });

  Future<Map<String, String>> createMetaData(
      Map<String, String> metaDataMap) async {
    if (metaDataMap.isEmpty) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    final result = await sdk.api.send(UserMetaDataCreateRequest(metaDataMap));
    final map = Map<String, String>.from(result);
    metaData.addAll(map);
    return map;
  }

  Future<Map<String, String>> updateMetaData(
      Map<String, String> metaDataMap) async {
    if (metaDataMap.isEmpty) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    final result = await sdk.api
        .send(UserMetaDataUpdateRequest(metaDataMap, upsert: true));
    final map = Map<String, String>.from(result);
    metaData.addAll(map);
    return map;
  }

  Future<void> deleteMetaData(String key) async {
    if (key.isEmpty) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    await sdk.api.send(UserMetaDataDeleteRequest(key));
    metaData.remove(key);
  }

  Future<void> deleteAllMetaData() async {
    final sdk = SendbirdSdk().getInternal();
    await sdk.api.send(UserMetaDataDeleteAllRequest());
    metaData.removeWhere((key, value) => true);
  }

  bool get isCurrentUser => userId == SendbirdSdk().currentUser?.userId;

  // json serialization

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['guest_id'] != null) json['user_id'] = json['guest_id'];
    if (json['session_tokens'] != null &&
        (json['session_tokens'] as List).isNotEmpty) {
      final tokens = List<Map>.from(json['session_tokens'] as List);
      json['session_token'] = tokens.first['session_token'];
    }
    if (json['is_online'] != null) {
      bool isOnline = json['is_online'];
      json['connection_status'] = isOnline ? 'online' : 'offline';
    }
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = ListEquality().equals;
    final mapEq = MapEquality().equals;
    return other is User &&
        other.userId == userId &&
        other.nickname == nickname &&
        other.profileUrl == profileUrl &&
        other.connectionStatus == connectionStatus &&
        other.lastSeenAt == lastSeenAt &&
        eq(other.preferredLanguages, preferredLanguages) &&
        other.isActive == isActive &&
        mapEq(other.metaData, metaData) &&
        other.requireAuth == requireAuth;
  }

  @override
  int get hashCode => Object.hash(
        userId,
        nickname,
        profileUrl,
        connectionStatus,
        metaData,
      );

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
