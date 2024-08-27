// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/meta/channel_info.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_channel_info.g.dart';

@collection
class CChannelInfo {
  Id id = Isar.autoIncrement;

  String? lastChannelToken;
  late bool isChannelBackSyncCompleted;

  CChannelInfo();

  factory CChannelInfo.fromChannelInfo(ChannelInfo info) {
    return CChannelInfo()
      ..lastChannelToken = info.lastChannelToken
      ..isChannelBackSyncCompleted = info.isChannelBackSyncCompleted;
  }

  Future<ChannelInfo> toChannelInfo(Chat chat, Isar isar) async {
    return ChannelInfo(
      lastChannelToken: lastChannelToken,
      isChannelBackSyncCompleted: isChannelBackSyncCompleted,
    );
  }

  static Future<CChannelInfo> upsert(
      Chat chat, Isar isar, ChannelInfo info) async {
    final cChannelInfo = CChannelInfo.fromChannelInfo(info);

    // ChannelInfo
    await chat.dbManager.write(() async {
      await isar.cChannelInfos.clear();
      await isar.cChannelInfos.put(cChannelInfo);
    }, force: true);

    return cChannelInfo;
  }

  static Future<ChannelInfo?> get(Chat chat, Isar isar) async {
    final cChannelInfo = await isar.cChannelInfos.where().findFirst();
    return await cChannelInfo?.toChannelInfo(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar) async {
    await chat.dbManager.write(() async {
      await isar.cChannelInfos.clear();
    });
  }
}
