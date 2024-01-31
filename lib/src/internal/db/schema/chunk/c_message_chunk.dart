// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/c_base_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/message_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_message_chunk.g.dart';

@collection
class CMessageChunk extends CBaseChunk {
  @Index(unique: true, replace: true)
  late String channelUrl;

  CMessageChunk();

  factory CMessageChunk.fromMessageChunk(MessageChunk chunk) {
    return CMessageChunk()
      ..channelUrl = chunk.channelUrl
      ..setChunk(chunk);
  }

  Future<MessageChunk> toMessageChunk(Chat chat, Isar isar) async {
    final chunk = MessageChunk(channelUrl: channelUrl);
    return CBaseChunk.setCChunk(chat, isar, chunk, this) as MessageChunk;
  }

  static Future<CMessageChunk> upsert(
      Chat chat, Isar isar, MessageChunk chunk) async {
    final cMessageChunk = CMessageChunk.fromMessageChunk(chunk);

    // MessageChunk
    await chat.dbManager.write(() async {
      await isar.cMessageChunks.put(cMessageChunk);
    });

    return cMessageChunk;
  }

  static Future<MessageChunk?> get(
      Chat chat, Isar isar, String channelUrl) async {
    final cMessageChunk = await isar.cMessageChunks
        .where()
        .channelUrlEqualTo(channelUrl)
        .findFirst();
    return await cMessageChunk?.toMessageChunk(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String channelUrl) async {
    await chat.dbManager.write(() async {
      await isar.cMessageChunks.deleteByChannelUrl(channelUrl);
    });
  }
}
