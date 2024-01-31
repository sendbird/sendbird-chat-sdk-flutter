// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/message_changelog_info.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_message_changelog_info.g.dart';

@collection
class CMessageChangeLogInfo {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String channelUrl;

  String? lastMessageToken;
  String? lastPollToken;

  CMessageChangeLogInfo();

  factory CMessageChangeLogInfo.fromChangeLogInfo(MessageChangeLogInfo info) {
    return CMessageChangeLogInfo()
      ..channelUrl = info.channelUrl
      ..lastMessageToken = info.lastMessageToken
      ..lastPollToken = info.lastPollToken;
  }

  Future<MessageChangeLogInfo> toChangeLogInfo(Chat chat, Isar isar) async {
    return MessageChangeLogInfo(
      channelUrl: channelUrl,
      lastMessageToken: lastMessageToken,
      lastPollToken: lastPollToken,
    );
  }

  static Future<CMessageChangeLogInfo> upsert(
      Chat chat, Isar isar, MessageChangeLogInfo info) async {
    final cChangeLog = CMessageChangeLogInfo.fromChangeLogInfo(info);

    // ChangeLogInfo
    await chat.dbManager.write(() async {
      await isar.cMessageChangeLogInfos.put(cChangeLog);
    });

    return cChangeLog;
  }

  static Future<MessageChangeLogInfo?> get(
      Chat chat, Isar isar, String channelUrl) async {
    final cChangeLog = await isar.cMessageChangeLogInfos
        .where()
        .channelUrlEqualTo(channelUrl)
        .findFirst();
    return await cChangeLog?.toChangeLogInfo(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String channelUrl) async {
    await chat.dbManager.write(() async {
      await isar.cMessageChangeLogInfos.deleteByChannelUrl(channelUrl);
    });
  }
}
