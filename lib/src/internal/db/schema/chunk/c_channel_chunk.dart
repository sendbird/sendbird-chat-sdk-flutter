// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/c_base_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/channel_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_channel_chunk.g.dart';

enum ChannelChunkType {
  chronologicalGroupChannelChunk,
}

@collection
class CChannelChunk extends CBaseChunk {
  @Index(unique: true, replace: true)
  @enumerated
  late ChannelChunkType channelChunkType;

  CChannelChunk();

  factory CChannelChunk.fromChannelChunk(ChannelChunk chunk) {
    return CChannelChunk()
      ..channelChunkType = chunk.channelChunkType
      ..setChunk(chunk);
  }

  Future<ChannelChunk> toChannelChunk(Chat chat, Isar isar) async {
    final chunk = ChannelChunk(channelChunkType: channelChunkType);
    return CBaseChunk.setCChunk(chat, isar, chunk, this) as ChannelChunk;
  }

  static Future<CChannelChunk> upsert(
      Chat chat, Isar isar, ChannelChunk chunk) async {
    final cChannelChunk = CChannelChunk.fromChannelChunk(chunk);

    // ChannelChunk
    await chat.dbManager.write(() async {
      await isar.cChannelChunks.put(cChannelChunk);
    });

    return cChannelChunk;
  }

  static Future<ChannelChunk?> get(
      Chat chat, Isar isar, ChannelChunkType channelChunkType) async {
    final cChannelChunk = await isar.cChannelChunks
        .where()
        .channelChunkTypeEqualTo(channelChunkType)
        .findFirst();
    return await cChannelChunk?.toChannelChunk(chat, isar);
  }

  static Future<void> delete(
      Chat chat, Isar isar, ChannelChunkType channelChunkType) async {
    await chat.dbManager.write(() async {
      await isar.cChannelChunks.deleteByChannelChunkType(channelChunkType);
    });
  }
}
