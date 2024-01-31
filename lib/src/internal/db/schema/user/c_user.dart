// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'c_user.g.dart';

@collection
class CUser {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String userId;

  late String nickname;
  late String profileUrl;

  @enumerated
  late UserConnectionStatus connectionStatus;

  int? lastSeenAt;
  bool? isActive;
  List<String>? preferredLanguages;
  late String friendDiscoveryKey;
  late String friendName;
  late String metaData; // Map<String, String>

  // Internal
  late bool requireAuth;

  CUser();

  factory CUser.fromUser(User user) {
    return CUser()..setUser(user);
  }

  void setUser(User user) {
    userId = user.userId;
    nickname = user.nickname;
    profileUrl = user.profileUrl;
    connectionStatus = user.connectionStatus;
    lastSeenAt = user.lastSeenAt;
    isActive = user.isActive;
    preferredLanguages = user.preferredLanguages;
    friendDiscoveryKey = user.friendDiscoveryKey;
    friendName = user.friendName;
    metaData = jsonEncode(user.metaData);
    requireAuth = user.requireAuth;
  }

  Future<User> toUser(Chat chat, Isar isar) async {
    final user = User(
      userId: userId,
      nickname: nickname,
    )..set(chat);
    return setCUser(user, this);
  }

  static User setCUser(User user, CUser cUser) {
    return user
      ..userId = cUser.userId
      ..nickname = cUser.nickname
      ..profileUrl = cUser.profileUrl
      ..connectionStatus = cUser.connectionStatus
      ..lastSeenAt = cUser.lastSeenAt
      ..isActive = cUser.isActive
      ..preferredLanguages = cUser.preferredLanguages
      ..friendDiscoveryKey = cUser.friendDiscoveryKey
      ..friendName = cUser.friendName
      ..metaData = (jsonDecode(cUser.metaData) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString()))
      ..requireAuth = cUser.requireAuth;
  }

  static Future<CUser> upsert(Chat chat, Isar isar, User user) async {
    final cUser = CUser.fromUser(user);

    // User
    await chat.dbManager.write(() async {
      await isar.cUsers.put(cUser);
    });

    return cUser;
  }

  static Future<User?> get(Chat chat, Isar isar, String userId) async {
    final cUser = await isar.cUsers.where().userIdEqualTo(userId).findFirst();
    return await cUser?.toUser(chat, isar);
  }

  static Future<CUser?> getCUser(Chat chat, Isar isar, String userId) async {
    final cUser = await isar.cUsers.where().userIdEqualTo(userId).findFirst();
    return cUser;
  }

  static Future<void> delete(Chat chat, Isar isar, String userId) async {
    await chat.dbManager.write(() async {
      await isar.cUsers.deleteByUserId(userId);
    });
  }
}
