// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_user.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';

part 'c_root_message.g.dart';

class CRootMessage {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String rootId;

  @Index(composite: [CompositeIndex('rootId')])
  @enumerated
  late MessageType messageType;

  @Index()
  late String channelUrl;

  @Index(composite: [CompositeIndex('channelUrl')])
  @enumerated
  late ChannelType channelType;

  String? data;
  String? customType;

  @enumerated
  late MentionType mentionType;

  late List<String> mentionedUsers; // List<CUser>
  late List<String> mentionedUserIds;
  List<CMessageMetaArray>? allMetaArrays;
  late String extendedMessage; // Map<String, dynamic>
  late int createdAt;
  late int updatedAt;

  CRootMessage();

  factory CRootMessage.fromRootMessage(RootMessage message) {
    return CRootMessage()..setRootMessage(message);
  }

  void setRootMessage(RootMessage message) {
    rootId = message.rootId;
    messageType = message.messageType;
    channelUrl = message.channelUrl;
    channelType = message.channelType;
    data = message.data;
    customType = message.customType;
    mentionType = message.mentionType;
    mentionedUsers = message.mentionedUsers.map((user) => user.userId).toList();
    mentionedUserIds = message.mentionedUserIds;
    allMetaArrays = message.allMetaArrays
        ?.map((array) => CMessageMetaArray.fromMessageMetaArray(array))
        .toList();
    extendedMessage = jsonEncode(message.extendedMessage);
    createdAt = message.createdAt;
    updatedAt = message.updatedAt;
  }

  Future<RootMessage> toRootMessage(Chat chat, Isar isar) async {
    final rootMessage = RootMessage(
      channelUrl: channelUrl,
      channelType: channelType,
    )..set(chat);
    return setCRootMessage(chat, isar, rootMessage, this);
  }

  static Future<RootMessage> setCRootMessage(
    Chat chat,
    Isar isar,
    RootMessage rootMessage,
    CRootMessage cRootMessage,
  ) async {
    rootMessage
      ..data = cRootMessage.data
      ..customType = cRootMessage.customType
      ..mentionType = cRootMessage.mentionType
      ..mentionedUserIds = cRootMessage.mentionedUserIds
      ..allMetaArrays = cRootMessage.allMetaArrays
          ?.map((cArray) => cArray.toMessageMetaArray())
          .toList()
      ..extendedMessage =
          jsonDecode(cRootMessage.extendedMessage) as Map<String, dynamic>
      ..createdAt = cRootMessage.createdAt
      ..updatedAt = cRootMessage.updatedAt;

    final List<User> tempMentionedUsers = [];
    for (final userId in cRootMessage.mentionedUsers) {
      final user = await CUser.get(chat, isar, userId);
      if (user != null) {
        tempMentionedUsers.add(user);
      }
    }
    rootMessage.mentionedUsers = tempMentionedUsers;

    return rootMessage;
  }

  static Future<void> upsert(Chat chat, Isar isar, RootMessage message) async {
    await chat.dbManager.write(() async {
      // mentionedUsers
      for (final user in message.mentionedUsers) {
        await isar.cUsers.put(CUser.fromUser(user));
      }
    });
  }
}

@embedded
class CMessageMetaArray {
  late String key;
  late List<String> value;

  CMessageMetaArray();

  factory CMessageMetaArray.fromMessageMetaArray(MessageMetaArray array) {
    return CMessageMetaArray()
      ..key = array.key
      ..value = array.value;
  }

  MessageMetaArray toMessageMetaArray() {
    return MessageMetaArray(key: key)..value = value;
  }
}
