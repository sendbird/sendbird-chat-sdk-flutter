// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_root_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/notification_data.dart';

part 'c_notification_message.g.dart';

@collection
class CNotificationMessage extends CRootMessage {
  late String notificationId;

  @enumerated
  late NotificationMessageStatus messageStatus;

  CNotificationData? notificationData;

  CNotificationMessage();

  factory CNotificationMessage.fromNotificationMessage(
      NotificationMessage message) {
    return CNotificationMessage()
      // RootMessage
      ..setRootMessage(message)
      // NotificationMessage
      ..notificationId = message.notificationId
      ..messageStatus = message.messageStatus
      ..notificationData = message.notificationData != null
          ? CNotificationData.fromNotificationData(message.notificationData!)
          : null;
  }

  Future<NotificationMessage> toNotificationMessage(
      Chat chat, Isar isar) async {
    final notificationMessage = NotificationMessage(
      // RootMessage
      channelUrl: channelUrl,
      channelType: channelType,
      // NotificationMessage
      notificationId: notificationId,
      messageStatus: messageStatus,
    )..set(chat);
    return await CRootMessage.setCRootMessage(
        chat, isar, notificationMessage, this) as NotificationMessage
      // NotificationMessage
      ..notificationData = notificationData?.toNotificationData();
  }

  static Future<CNotificationMessage> upsert(
      Chat chat, Isar isar, NotificationMessage message) async {
    message.channelType = ChannelType.feed;

    final cNotificationMessage =
        CNotificationMessage.fromNotificationMessage(message);

    // RootMessage
    await CRootMessage.upsert(chat, isar, message);

    // NotificationMessage
    await chat.dbManager.write(() async {
      await isar.cNotificationMessages.put(cNotificationMessage);
    });

    // ChannelMessage
    await CChannelMessage.upsert(chat, isar, message);

    return cNotificationMessage;
  }

  static Future<NotificationMessage?> get(
      Chat chat, Isar isar, String rootId) async {
    final cNotificationMessage = await isar.cNotificationMessages
        .where()
        .rootIdEqualTo(rootId)
        .findFirst();
    return await cNotificationMessage?.toNotificationMessage(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String rootId) async {
    // NotificationMessage
    await chat.dbManager.write(() async {
      await isar.cNotificationMessages.deleteByRootId(rootId);
    });

    // ChannelMessage
    await CChannelMessage.delete(chat, isar, rootId);
  }
}

@embedded
class CNotificationData {
  late String templateKey;
  late String templateVariables; // Map<String, dynamic>
  String? label;
  List<String>? tags;

  CNotificationData();

  factory CNotificationData.fromNotificationData(NotificationData data) {
    return CNotificationData()
      ..templateKey = data.templateKey
      ..templateVariables = jsonEncode(data.templateVariables)
      ..label = data.label
      ..tags = data.tags;
  }

  NotificationData toNotificationData() {
    return NotificationData(
      templateKey: templateKey,
      templateVariables: jsonDecode(templateVariables) as Map<String, dynamic>,
    )
      ..label = label
      ..tags = tags ?? [];
  }
}
