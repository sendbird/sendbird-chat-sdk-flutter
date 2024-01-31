// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/base_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_base_chunk.g.dart';

class CBaseChunk {
  Id id = Isar.autoIncrement;

  late List<CChunk> chunks;

  CBaseChunk();

  factory CBaseChunk.fromChunk(BaseChunk chunk) {
    return CBaseChunk()..setChunk(chunk);
  }

  void setChunk(BaseChunk chunk) {
    chunks = chunk.chunks.map((e) => CChunk.fromChunk(e)).toList();
  }

  Future<BaseChunk> toChunk(Chat chat, Isar isar) async {
    final chunk = BaseChunk();
    return setCChunk(chat, isar, chunk, this);
  }

  static BaseChunk setCChunk(
      Chat chat, Isar isar, BaseChunk chunk, CBaseChunk cChunk) {
    return chunk..chunks = cChunk.chunks.map((e) => e.toChunk()).toList();
  }
}

@embedded
class CChunk {
  late int oldestTs;
  late int latestTs;

  CChunk();

  factory CChunk.fromChunk(Chunk chunk) {
    return CChunk()
      ..oldestTs = chunk.oldestTs
      ..latestTs = chunk.latestTs;
  }

  Chunk toChunk() {
    return Chunk(
      oldestTs: oldestTs,
      latestTs: latestTs,
    );
  }
}
