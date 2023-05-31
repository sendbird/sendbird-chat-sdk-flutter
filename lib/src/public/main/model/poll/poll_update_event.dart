// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/handler/channel_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';

/// Class representing an event that a [Poll] has been updated.
/// This event will be passed to [GroupChannelHandler.onPollUpdated].
/// Once this event is received, the user must find cached messages
/// that contain this poll and apply changes using [Poll.applyPollUpdateEvent].
class PollUpdateEvent {
  /// Id of the updated [Poll].
  int pollId;

  /// Id of the message that contains the [Poll].
  int messageId;

  Map<String, dynamic> json;

  PollUpdateEvent({
    required this.pollId,
    required this.messageId,
    required this.json,
  });

  factory PollUpdateEvent.fromJson(Map<String, dynamic> res) {
    return PollUpdateEvent(
      pollId: res['poll']['id'],
      messageId: res['poll']['message_id'],
      json: res,
    );
  }
}
