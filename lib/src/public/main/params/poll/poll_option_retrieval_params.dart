// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/public/main/define/enums.dart';

/// Parameters for retrieving poll option.
/// A poll option should be
/// specified by the [pollId] of the poll that the option belongs to and [pollOptionId] of the
/// option, and the [channelUrl] of the channel that the poll specified by [pollId] belongs
/// to.
class PollOptionRetrievalParams {
  /// The ID of the poll of this option.
  int pollId;

  /// The ID of the pollOption to get.
  int pollOptionId;

  /// The channel type of the channel this poll belongs to.
  ChannelType channelType;

  /// The url of the channel this poll belongs to.
  String channelUrl;

  PollOptionRetrievalParams({
    required this.pollId,
    required this.pollOptionId,
    required this.channelType,
    required this.channelUrl,
  });
}
