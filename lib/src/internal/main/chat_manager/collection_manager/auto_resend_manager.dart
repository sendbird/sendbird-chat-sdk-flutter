// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';

class AutoResendManager {
  AutoResendManager._();

  static final AutoResendManager _instance = AutoResendManager._();

  factory AutoResendManager() => _instance;

  static const int _delayForRateLimit = 200; // Check
  bool _isAutoResending = false;
  bool _stopAutoResending = false;

  void startAutoResend(Chat chat) async {
    if (!chat.chatContext.options.useAutoResend) {
      sbLog.i(StackTrace.current, 'Returned because of useAutoResend == false');
      return;
    }

    if (_isAutoResending) {
      sbLog.i(
          StackTrace.current, 'Returned because of _isAutoResending == true');
      return;
    }

    sbLog.i(StackTrace.current, 'Started');
    _isAutoResending = true;

    try {
      for (final collection in chat.collectionManager.baseMessageCollections) {
        if (collection is MessageCollection) {
          if (collection.channel.isFrozen) {
            sbLog.i(StackTrace.current,
                'Skipped because of collection.channel.isFrozen == true');
            continue;
          }

          final failedMessages = await collection.getFailedMessages();

          for (final failedMessage in failedMessages) {
            if (failedMessage.isAutoResendable()) {
              // Resend a message
              Completer completer = Completer();
              SendbirdException? exception;
              if (failedMessage is UserMessage) {
                collection.channel.resendUserMessage(
                  failedMessage,
                  handler: (UserMessage message, SendbirdException? e) {
                    exception = e;
                    completer.complete();
                  },
                );
              } else if (failedMessage is FileMessage) {
                collection.channel.resendFileMessage(
                  failedMessage,
                  handler: (FileMessage message, SendbirdException? e) {
                    exception = e;
                    completer.complete();
                  },
                );
              } else {
                // Defensive code
                completer.complete();
              }
              await completer.future;

              if (exception != null) {
                sbLog.i(
                    StackTrace.current, 'Stopped because of exception != null');
                break;
              }

              if (_stopAutoResending) break;

              // Delay to avoid the rate limit
              await Future.delayed(
                  const Duration(milliseconds: _delayForRateLimit));
            }

            if (_stopAutoResending) break;
          }
        }

        if (_stopAutoResending) break;
      }
    } catch (e) {
      sbLog.e(StackTrace.current, e.toString());
    }

    _stopAutoResending = false;
    _isAutoResending = false;
    sbLog.i(StackTrace.current, 'Stopped');
  }

  void stopAutoResend() {
    if (_isAutoResending) {
      sbLog.i(StackTrace.current);
      _stopAutoResending = true;
    }
  }
}
