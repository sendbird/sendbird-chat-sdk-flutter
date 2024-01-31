// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_base_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_root_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_sender.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/admin_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'c_admin_message.g.dart';

@collection
class CAdminMessage extends CBaseMessage {
  CAdminMessage();

  factory CAdminMessage.fromAdminMessage(AdminMessage message) {
    return CAdminMessage()
      // BaseMessage
      ..setBaseMessage(message);
  }

  Future<AdminMessage> toAdminMessage(Chat chat, Isar isar) async {
    final adminMessage = AdminMessage(
      // RootMessage
      channelUrl: channelUrl,
      channelType: channelType,
      // BaseMessage
      messageId: messageId,
      message: message,
    )..set(chat);
    return await CBaseMessage.setCBaseMessage(chat, isar, adminMessage, this)
        as AdminMessage;
  }

  static Future<CAdminMessage> upsert(
      Chat chat, Isar isar, AdminMessage message) async {
    final cAdminMessage = CAdminMessage.fromAdminMessage(message);

    // RootMessage
    await CRootMessage.upsert(chat, isar, message);

    // BaseMessage
    await CBaseMessage.upsert(chat, isar, message);

    // AdminMessage
    await chat.dbManager.write(() async {
      await isar.cAdminMessages.put(cAdminMessage);
    });

    // ChannelMessage
    await CChannelMessage.upsert(chat, isar, message);

    return cAdminMessage;
  }

  static Future<AdminMessage?> get(Chat chat, Isar isar, String rootId) async {
    final cAdminMessage =
        await isar.cAdminMessages.where().rootIdEqualTo(rootId).findFirst();
    return await cAdminMessage?.toAdminMessage(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String rootId) async {
    // AdminMessage
    await chat.dbManager.write(() async {
      await isar.cAdminMessages.deleteByRootId(rootId);
    });

    // ChannelMessage
    await CChannelMessage.delete(chat, isar, rootId);
  }
}
