// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// Parameters for retrieving poll operations.
/// For poll retrieval, [pollId], [channelType] and [channelUrl]
/// are required and all other members are optional.
class PollRetrievalParams {
  /// The ID of the poll retrieved from server.
  int pollId;

  /// The channel type of the channel containing the poll.
  ChannelType channelType;

  /// The url of the channel containing the poll.
  String channelUrl;

  PollRetrievalParams({
    required this.pollId,
    required this.channelType,
    required this.channelUrl,
  });
}
