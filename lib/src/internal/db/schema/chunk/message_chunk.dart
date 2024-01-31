// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:math';

import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/base_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/chunk.dart';

class MessageChunk extends BaseChunk {
  final String channelUrl;

  MessageChunk({
    required this.channelUrl,
    List<Chunk>? chunks,
  }) {
    super.chunks = chunks ?? [];
  }

  void add(Chunk chunk) {
    chunks.add(chunk);
  }

  void addNewChunk(Chunk newChunk) {
    if (chunks.isNotEmpty) {
      for (int i = chunks.length - 1; i >= 0; i--) {
        final chunk = chunks.elementAt(i);
        if ((newChunk.oldestTs >= chunk.oldestTs &&
                newChunk.oldestTs <= chunk.latestTs) ||
            (newChunk.latestTs >= chunk.oldestTs &&
                newChunk.latestTs <= chunk.latestTs)) {
          newChunk.oldestTs = min(newChunk.oldestTs, chunk.oldestTs);
          newChunk.latestTs = max(newChunk.latestTs, chunk.latestTs);
          chunks.remove(chunk); // Check
        }
      }
    }
    chunks.add(newChunk);
  }

  bool isInCurrentChunk({
    required int oldestTs,
    required int latestTs,
    required int? lastSyncedTimeStamp,
  }) {
    bool result = false;

    if (lastSyncedTimeStamp != null) {
      for (final chunk in chunks) {
        if (lastSyncedTimeStamp >= chunk.oldestTs &&
            lastSyncedTimeStamp <= chunk.latestTs) {
          if (oldestTs >= chunk.oldestTs &&
              oldestTs <= chunk.latestTs &&
              latestTs >= chunk.oldestTs &&
              latestTs <= chunk.latestTs) {
            result = true;
          }
          break;
        }
      }
    } else {
      for (final chunk in chunks) {
        if (oldestTs >= chunk.oldestTs &&
            oldestTs <= chunk.latestTs &&
            latestTs >= chunk.oldestTs &&
            latestTs <= chunk.latestTs) {
          result = true;
          break;
        }
      }
    }
    return result;
  }

  Chunk? getChunk(int ts) {
    Chunk? resultChunk;
    for (final chunk in chunks) {
      if (ts >= chunk.oldestTs && ts <= chunk.latestTs) {
        resultChunk = chunk;
        break;
      }
    }
    return resultChunk;
  }

  void removeChunk(Chunk chunk) {
    chunks.removeWhere(
        (c) => (chunk.oldestTs == c.oldestTs && chunk.latestTs == c.latestTs));
  }
}
