// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/channel_access.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_channel_access.g.dart';

@collection
class CChannelAccess {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String channelUrl;

  @Index()
  late int lastAccessedAt;

  CChannelAccess();

  factory CChannelAccess.fromChannelAccess(ChannelAccess access) {
    return CChannelAccess()
      ..channelUrl = access.channelUrl
      ..lastAccessedAt = access.lastAccessedAt;
  }

  Future<ChannelAccess> toChannelAccess(Chat chat, Isar isar) async {
    return ChannelAccess(
      channelUrl: channelUrl,
      lastAccessedAt: lastAccessedAt,
    );
  }

  static Future<CChannelAccess> upsert(
      Chat chat, Isar isar, ChannelAccess access) async {
    final cChannelAccess = CChannelAccess.fromChannelAccess(access);

    // ChannelAccess
    await chat.dbManager.write(() async {
      await isar.cChannelAccess.put(cChannelAccess);
    });

    return cChannelAccess;
  }

  static Future<ChannelAccess?> get(
      Chat chat, Isar isar, String channelUrl) async {
    final cChannelAccess = await isar.cChannelAccess
        .where()
        .channelUrlEqualTo(channelUrl)
        .findFirst();
    return await cChannelAccess?.toChannelAccess(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String channelUrl) async {
    await chat.dbManager.write(() async {
      await isar.cChannelAccess.deleteByChannelUrl(channelUrl);
    });
  }
}
