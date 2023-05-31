// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';

/// The ThreadedMessages class.
class ThreadedMessages {
  /// Parent message of this thread.
  BaseMessage parentMessage;

  /// Retrieves the threaded replies in the thread
  List<BaseMessage> threadMessages;

  ThreadedMessages({
    required this.parentMessage,
    required this.threadMessages,
  });
}
