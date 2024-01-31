// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

/// The SendbirdChatOptions class for [SendbirdChat.init].
class SendbirdChatOptions {
  static const defaultUseCollectionCaching = kIsWeb ? false : true;
  static const defaultConnectionTimeout = 10;
  static const defaultWebSocketTimeout = 30;
  static const defaultFileTransferTimeout = 30;
  static const defaultTypingIndicatorThrottle = 1000;
  static const defaultUseMemberInfoInMessage = true;

  bool _useCollectionCaching = defaultUseCollectionCaching;
  int _connectionTimeout = defaultConnectionTimeout;
  int _webSocketTimeout = defaultWebSocketTimeout;
  int _fileTransferTimeout = defaultFileTransferTimeout;
  int _typingIndicatorThrottle = defaultTypingIndicatorThrottle;
  bool _useMemberInfoInMessage = defaultUseMemberInfoInMessage;

  SendbirdChatOptions({
    bool? useCollectionCaching = defaultUseCollectionCaching,
    int? connectionTimeout = defaultConnectionTimeout,
    int? webSocketTimeout = defaultWebSocketTimeout,
    int? fileTransferTimeout = defaultFileTransferTimeout,
    int? typingIndicatorThrottle = defaultTypingIndicatorThrottle,
    bool? useMemberInfoInMessage = defaultUseMemberInfoInMessage,
  }) {
    this.useCollectionCaching = useCollectionCaching;
    this.connectionTimeout = connectionTimeout;
    this.webSocketTimeout = webSocketTimeout;
    this.fileTransferTimeout = fileTransferTimeout;
    this.typingIndicatorThrottle = typingIndicatorThrottle;
    this.useMemberInfoInMessage = useMemberInfoInMessage;
  }

  bool get useCollectionCaching => _useCollectionCaching;

  /// If set `true`, the local caching for collection will be worked.
  /// The default value is `true`.
  /// @since 4.2.0
  set useCollectionCaching(value) {
    _useCollectionCaching = value;
  }

  int get connectionTimeout => _connectionTimeout;

  /// Sets the timeout for connection. If there is a timeout error
  /// frequently, set the longer timeout than default value.
  /// The default value is 10 seconds.
  set connectionTimeout(value) {
    if (value > 0) {
      _connectionTimeout = value;
    }
  }

  int get webSocketTimeout => _webSocketTimeout;

  /// Sets the websocket response timeout used in sending/receiving
  /// commands by websocket. The value should be between 5 seconds
  /// and 300 seconds (5 minutes).
  /// The default value is 30 seconds.
  set webSocketTimeout(value) {
    if (value >= 5 && value <= 300) {
      _webSocketTimeout = value;
    }
  }

  int get fileTransferTimeout => _fileTransferTimeout;

  /// Sets the timeout for file transfer. This value affects the methods
  /// that send a binary data including sending file messages, creating
  /// and updating channels. The value should be between 5 seconds
  /// and 300 seconds (5 minutes).
  /// The default value is 30 seconds.
  set fileTransferTimeout(value) {
    if (value >= 5 && value <= 300) {
      _fileTransferTimeout = value;
    }
  }

  int get typingIndicatorThrottle => _typingIndicatorThrottle;

  /// Sets a term of typing indicator throttling in group channel.
  /// After this throttling interval from typing indicator started
  /// (or ended), You can re-start (or re-end) typing indicator.
  /// If you call start (or end) again in this interval, the call will be ignored.
  /// The value should be between 1000 milliseconds and 9000 milliseconds.
  /// The default value is 1000 milliseconds.
  set typingIndicatorThrottle(value) {
    if (value >= 1000 && value <= 9000) {
      _typingIndicatorThrottle = value;
    }
  }

  bool get useMemberInfoInMessage => _useMemberInfoInMessage;

  /// If set `true`, the information of
  ///   1. [BaseMessage.sender]
  ///   2. [BaseMessage.mentionedUsers]
  /// such as nickname and profile url will be returned as the same with channel members.
  /// Otherwise, the information will be the value of the message's creation time.
  /// The default value is `true`.
  set useMemberInfoInMessage(value) {
    _useMemberInfoInMessage = value;
  }
}
