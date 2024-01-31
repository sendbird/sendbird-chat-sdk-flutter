// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/base_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/c_channel_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/chunk.dart';

class ChannelChunk extends BaseChunk {
  final ChannelChunkType channelChunkType;

  ChannelChunk({
    required this.channelChunkType,
    List<Chunk>? chunks,
  }) {
    super.chunks = chunks ?? [];
  }
}
