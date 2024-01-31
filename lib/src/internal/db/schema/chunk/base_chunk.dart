// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/chunk.dart';

class BaseChunk {
  List<Chunk> chunks;

  BaseChunk({
    List<Chunk>? chunks,
  }) : chunks = chunks ?? [];
}
