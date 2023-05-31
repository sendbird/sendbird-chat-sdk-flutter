// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/user/user_meta_data/user_meta_data_create_request.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/user/user_meta_data/user_meta_data_delete_request.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/user/user_meta_data/user_meta_data_update_request.dart';
import 'package:sendbird_chat/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/define/exceptions.dart';

part 'user.g.dart';

/// Represents a user.
@JsonSerializable()
class User {
  /// The ID of the user.
  String userId;

  /// The nickname of the user.
  String nickname;

  /// The profile image URL.
  String profileUrl;

  /// The profile image URL with auth
  String get secureProfileUrl {
    if (requireAuth && chat.chatContext.eKey != null && profileUrl.isNotEmpty) {
      // https://github.com/flutter/flutter/issues/25107
      return '$profileUrl?auth=${chat.chatContext.eKey}';
    }
    return '';
  }

  /// The user connection status type.
  @JsonKey(
    name: 'is_online',
    fromJson: boolToConnectionStatus,
    toJson: connectionStatusToBool,
  )
  UserConnectionStatus connectionStatus;

  /// The time this [User] has been last seen at. Zero if this [User] is online.
  int? lastSeenAt;

  /// Whether the user is active.
  bool? isActive;

  /// The preferred languages of the user.
  List<String>? preferredLanguages;

  /// Represents friend discovery key.
  String friendDiscoveryKey;

  /// The friend name.
  String friendName;

  /// All meta data of the user.
  @JsonKey(name: 'metadata')
  Map<String, String> metaData;

  @JsonKey(name: 'require_auth_for_profile_image')
  bool requireAuth;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Chat chat;

  User({
    required this.userId,
    required this.nickname,
    this.profileUrl = '',
    this.connectionStatus = UserConnectionStatus.notAvailable,
    this.lastSeenAt,
    this.isActive = true,
    this.preferredLanguages,
    this.friendDiscoveryKey = '',
    this.friendName = '',
    this.metaData = const {},
    this.requireAuth = false,
  });

  void set(Chat chat) {
    this.chat = chat;
  }

  /// createMetaData
  Future<Map<String, String>> createMetaData(
      Map<String, String> metaDataMap) async {
    sbLog.i(StackTrace.current, 'metaDataMap: $metaDataMap');

    if (metaDataMap.isEmpty) {
      throw InvalidParameterException();
    }

    final result =
        await chat.apiClient.send(UserMetaDataCreateRequest(chat, metaDataMap));
    final map = Map<String, String>.from(result);
    metaData.addAll(map);
    return map;
  }

  /// updateMetaData
  Future<Map<String, String>> updateMetaData(
      Map<String, String> metaDataMap) async {
    sbLog.i(StackTrace.current, 'metaDataMap: $metaDataMap');

    if (metaDataMap.isEmpty) {
      throw InvalidParameterException();
    }

    final result = await chat.apiClient
        .send(UserMetaDataUpdateRequest(chat, metaDataMap, upsert: true));
    final map = Map<String, String>.from(result);
    metaData.addAll(map);
    return map;
  }

  /// deleteMetaData
  Future<void> deleteMetaData(String key) async {
    sbLog.i(StackTrace.current, 'key: $key');

    if (key.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(UserMetaDataDeleteRequest(chat, key));
    metaData.remove(key);
  }

  /// deleteAllMetaData
  Future<void> deleteAllMetaData() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(UserMetaDataDeleteAllRequest(chat));
    metaData.removeWhere((key, value) => true);
  }

  /// isCurrentUser
  bool get isCurrentUser => userId == chat.chatContext.currentUser?.userId;

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['guest_id'] != null) json['user_id'] = json['guest_id'];
    if (json['is_online'] != null) {
      bool isOnline = json['is_online'];
      json['connection_status'] = isOnline ? 'online' : 'offline';
    }
    return _$UserFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat
  }

  factory User.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return User.fromJson(json)..set(chat);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = const ListEquality().equals;
    final mapEq = const MapEquality().equals;
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
    preferredLanguages = other.preferredLanguages;
    isActive = other.isActive;
    metaData = other.metaData;
    friendDiscoveryKey = other.friendDiscoveryKey;
    friendName = other.friendName;
  }
}
