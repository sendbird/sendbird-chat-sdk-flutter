// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/handler/channel_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';

/// Class representing an event that one or more vote has been casted on a poll option.
/// The affected poll may be in multiple channels.
/// This event will be passed to [GroupChannelHandler.onPollVoted].
/// Once this event is received, the user must find cached messages
/// that contain this poll and apply changes using [Poll.applyPollVoteEvent].
class PollVoteEvent {
  /// Id of the voted [Poll].
  int pollId;

  /// Id of the message that contains the [Poll].
  int messageId;

  Map<String, dynamic> json;

  PollVoteEvent({
    required this.pollId,
    required this.messageId,
    required this.json,
  });

  factory PollVoteEvent.fromJson(Map<String, dynamic> res) {
    return PollVoteEvent(
      pollId: res['poll_id'],
      messageId: res['message_id'],
      json: res,
    );
  }
}
