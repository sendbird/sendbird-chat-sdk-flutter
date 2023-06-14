// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'base_channel.dart';

/// BaseMessageHandler
typedef BaseMessageHandler = void Function(
  BaseMessage message,
  SendbirdException? e,
);

/// UserMessageHandler
typedef UserMessageHandler = void Function(
  UserMessage message,
  SendbirdException? e,
);

/// FileMessageHandler
typedef FileMessageHandler = void Function(
  FileMessage message,
  SendbirdException? e,
);

/// ProgressHandler
typedef ProgressHandler = void Function(
  int sentBytes,
  int totalBytes,
);

/// BaseChannelMessage
extension BaseChannelMessage on BaseChannel {
  /// Sends a user message with text.
  UserMessage sendUserMessageWithText(
    String text, {
    UserMessageHandler? handler,
  }) {
    sbLog.i(StackTrace.current, 'text: $text');

    final params = UserMessageCreateParams(message: text);
    return sendUserMessage(
      params,
      handler: handler,
    );
  }

  /// Sends a user message.
  UserMessage sendUserMessage(
    UserMessageCreateParams params, {
    UserMessageHandler? handler,
  }) {
    sbLog.i(StackTrace.current, 'message: ${params.message}');

    if (params.message.isEmpty) {
      throw InvalidParameterException();
    }

    final cmd = Command.buildUserMessage(
      channelUrl,
      params,
      const Uuid().v1(),
    );

    final pendingUserMessage =
        BaseMessage.getMessageFromJsonWithChat<UserMessage>(
      chat,
      cmd.payload,
      channelType: channelType,
      commandType: cmd.cmd,
    );

    if (chat.chatContext.currentUser == null) {
      final error = ConnectionRequiredException();
      pendingUserMessage
        ..errorCode = error.code
        ..sendingStatus = SendingStatus.failed;
      if (handler != null) handler(pendingUserMessage, error);
      return pendingUserMessage;
    }

    pendingUserMessage.sendingStatus = SendingStatus.pending;
    pendingUserMessage.sender =
        Sender.fromUser(chat.chatContext.currentUser, this);

    runZonedGuarded(() {
      chat.commandManager.sendCommand(cmd).then((result) {
        if (result == null) return;

        final message = BaseMessage.getMessageFromJsonWithChat<UserMessage>(
          chat,
          result.payload,
          commandType: result.cmd,
        );

        chat.collectionManager.onMessageSentByMe(message);
        if (handler != null) handler(message, null);
      });
    }, (e, s) {
      sbLog.e(StackTrace.current, 'e: $e');

      if (e is AckTimeoutException) {
        pendingUserMessage
          ..errorCode = e.code ?? SendbirdError.unknownError
          ..sendingStatus = SendingStatus.failed;
        if (handler != null) handler(pendingUserMessage, e);
      }
    });

    return pendingUserMessage;
  }

  /// Resends a failed user message.
  /// [message] is a failed user message.
  UserMessage resendUserMessage(
    UserMessage message, {
    UserMessageHandler? handler,
  }) {
    sbLog.i(StackTrace.current, 'message: $message');

    if (message.sendingStatus != SendingStatus.failed) {
      throw InvalidParameterException();
    }
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }
    if (!message.isResendable()) {
      throw InvalidParameterException();
    }

    final params =
        UserMessageCreateParams.withMessage(message, deepCopy: false);
    return sendUserMessage(
      params,
      handler: handler,
    );
  }

  /// Updates a `UserMessage` that was previously sent in the channel.
  Future<UserMessage> updateUserMessage(
      int messageId, UserMessageUpdateParams params) async {
    sbLog.i(StackTrace.current, 'message: ${params.message}');

    if (messageId <= 0) {
      throw InvalidParameterException();
    }

    final cmd = Command.buildUpdateUserMessage(
      channelUrl,
      messageId,
      params,
    );

    final result = await chat.commandManager.sendCommand(cmd);
    if (result != null) {
      final baseMessage = BaseMessage.getMessageFromJsonWithChat<UserMessage>(
        chat,
        result.payload,
        commandType: cmd.cmd,
      );
      return baseMessage;
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Sends a file with given file information.
  FileMessage sendFileMessage(
    FileMessageCreateParams params, {
    FileMessageHandler? handler,
    ProgressHandler? progressHandler,
  }) {
    sbLog.i(StackTrace.current,
        'params.uploadFile.name: ${params.fileInfo.fileName}');

    if (params.fileInfo.hasSource == false) {
      throw InvalidParameterException();
    }

    final pendingFileMessage =
        FileMessage.fromParams(params: params, channel: this)..set(chat);
    pendingFileMessage.sendingStatus = SendingStatus.pending;
    pendingFileMessage.sender =
        Sender.fromUser(chat.chatContext.currentUser, this);

    final queue = chat.getMessageQueue(channelUrl);
    final task = AsyncSimpleTask(
      () async {
        UploadResponse? uploadResponse;

        if (params.fileInfo.hasBinary) {
          try {
            uploadResponse = await chat.apiClient
                .send<UploadResponse>(ChannelFileUploadRequest(chat,
                    channelUrl: channelUrl,
                    requestId: pendingFileMessage.requestId!,
                    params: params,
                    progressHandler: progressHandler))
                .timeout(
              Duration(seconds: chat.chatContext.options.fileTransferTimeout),
              onTimeout: () {
                if (handler != null) {
                  handler(
                    pendingFileMessage..sendingStatus = SendingStatus.failed,
                    SendbirdException(
                      message: 'Upload timeout',
                      code: SendbirdError.fileUploadTimeout,
                    ),
                  );
                }
                throw SendbirdException(code: SendbirdError.fileUploadTimeout);
              },
            );
          } catch (e) {
            sbLog.e(StackTrace.current, 'e: $e');
            rethrow;
          }
        }

        String? fileUrl = uploadResponse?.url;
        int? fileSize = uploadResponse?.fileSize;
        if (fileUrl != null) params.fileInfo.fileUrl = fileUrl;
        if (fileSize != null) params.fileInfo.fileSize = fileSize;

        final cmd = Command.buildFileMessage(
          channelUrl: channelUrl,
          params: params,
          requestId: pendingFileMessage.requestId,
          requireAuth: uploadResponse?.requireAuth,
          thumbnails: uploadResponse?.thumbnails,
        );

        final message = BaseMessage.getMessageFromJsonWithChat<FileMessage>(
          chat,
          cmd.payload,
          channelType: channelType,
          commandType: cmd.cmd,
        );

        if (chat.chatContext.currentUser == null) {
          final error = ConnectionRequiredException();
          message
            ..errorCode = error.code
            ..sendingStatus = SendingStatus.failed;
          if (handler != null) handler(message, error);
          return message;
        }

        if (chat.connectionManager.isConnected()) {
          runZonedGuarded(() {
            chat.commandManager.sendCommand(cmd).then((result) {
              if (result == null) return;

              final message =
                  BaseMessage.getMessageFromJsonWithChat<FileMessage>(
                chat,
                result.payload,
                commandType: result.cmd,
              );

              chat.collectionManager.onMessageSentByMe(message);
              if (handler != null) handler(message, null);
            });
          }, (e, s) {
            sbLog.e(StackTrace.current, 'e: $e');

            if (e is AckTimeoutException) {
              pendingFileMessage
                ..errorCode = e.code ?? SendbirdError.unknownError
                ..sendingStatus = SendingStatus.failed;
              if (handler != null) handler(pendingFileMessage, e);
            }
          });
        } else {
          final request = ChannelFileMessageSendRequest(
            chat,
            channelType: channelType,
            channelUrl: channelUrl,
            params: params,
            thumbnails: uploadResponse?.thumbnails,
            requireAuth: uploadResponse?.requireAuth,
          );
          final message = await chat.apiClient.send<FileMessage>(request);

          chat.collectionManager.onMessageSentByMe(message);
          if (handler != null) handler(message, null);
        }
      },
      onCancel: () {
        if (handler != null) {
          handler(pendingFileMessage, OperationCanceledException());
        }
      },
    );

    queue.enqueue(task);

    chat.setUploadTask(pendingFileMessage.requestId!, task);
    chat.setMessageQueue(channelUrl, queue);

    return pendingFileMessage;
  }

  /// Cancels an ongoing `FileMessage` upload.
  bool cancelFileMessageUpload(String requestId) {
    sbLog.i(StackTrace.current, 'requestId: $requestId');

    if (requestId.isEmpty) {
      throw InvalidParameterException();
    }

    final task = chat.getUploadTask(requestId);
    if (task == null) {
      return false;
    }

    final queue = chat.getMessageQueue(channelUrl);
    chat.apiClient.cancelUploadingFile(requestId);
    return queue.cancel(task.hashCode);
  }

  /// Resends a file with given file information.
  FileMessage resendFileMessage(
    FileMessage message, {
    required FileMessageCreateParams params,
    FileMessageHandler? handler,
    ProgressHandler? progressHandler,
  }) {
    sbLog.i(StackTrace.current,
        'params.uploadFile.name: ${params.fileInfo.fileName}');

    if (message.sendingStatus != SendingStatus.failed) {
      throw InvalidParameterException();
    }
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }
    if (!message.isResendable()) {
      throw InvalidParameterException();
    }

    return sendFileMessage(
      params,
      progressHandler: progressHandler,
      handler: handler,
    );
  }

  /// Updates a `FileMessage` that was previously sent in the channel.
  /// Note that the file itself cannot be changed; only the fields stored within the message can be modified.
  Future<FileMessage> updateFileMessage(
    int messageId,
    FileMessageUpdateParams params,
  ) async {
    sbLog.i(StackTrace.current);

    if (messageId <= 0) {
      throw InvalidParameterException();
    }

    final cmd = Command.buildUpdateFileMessage(
      channelUrl,
      messageId,
      params,
    );

    final result = await chat.commandManager.sendCommand(cmd);
    if (result != null) {
      final baseMessage = BaseMessage.getMessageFromJsonWithChat<FileMessage>(
        chat,
        result.payload,
        commandType: cmd.cmd,
      );
      return baseMessage;
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Deletes a message.
  Future<void> deleteMessage(int messageId) async {
    sbLog.i(StackTrace.current, 'messageId: $messageId');

    if (messageId <= 0) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(ChannelMessageDeleteRequest(
      chat,
      channelType: channelType,
      channelUrl: channelUrl,
      messageId: messageId,
    ));
  }

  /// Translates a user message.
  Future<UserMessage> translateUserMessage(
    UserMessage message,
    List<String> targetLanguages,
  ) async {
    sbLog.i(StackTrace.current, 'message: ${message.message}');

    if (message.messageId <= 0) {
      throw InvalidParameterException();
    }
    if (targetLanguages.isEmpty) {
      throw InvalidParameterException();
    }

    return await chat.apiClient.send<UserMessage>(
      ChannelMessageTranslateRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        messageId: message.messageId,
        targetLanguages: targetLanguages,
      ),
    );
  }

  /// Copies a message from this channel to the target channel.
  BaseMessage copyMessage(
    BaseMessage message,
    BaseChannel targetChannel, {
    BaseMessageHandler? handler,
  }) {
    sbLog.i(StackTrace.current, 'message: ${message.message}');

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    // Do not copy [extendedMessage] in message.
    message.extendedMessage.clear();

    if (message is UserMessage) {
      final params =
          UserMessageCreateParams.withMessage(message, deepCopy: false);
      if (params.pollId != null) {
        throw InvalidParameterException();
      }
      return targetChannel.sendUserMessage(
        params,
        handler: handler,
      );
    } else if (message is FileMessage) {
      final params =
          FileMessageCreateParams.withMessage(message, deepCopy: false);
      return targetChannel.sendFileMessage(
        params,
        handler: handler,
      );
    } else {
      throw InvalidParameterException();
    }
  }

  /// Retrieves previous or next messages based on the timestamp in a specific channel.
  ///
  /// The [timestamp] to be the reference point for messages to retrieve, in Unix milliseconds format.
  Future<List<BaseMessage>> getMessagesByTimestamp(
    int timestamp,
    MessageListParams params,
  ) async {
    sbLog.i(StackTrace.current, 'timestamp: $timestamp');

    if (timestamp <= 0) {
      throw InvalidParameterException();
    }

    if (channelType == ChannelType.group) {
      params.showSubChannelMessagesOnly = false;
    }

    return await chat.apiClient
        .send<List<BaseMessage>>(ChannelMessagesGetRequest(
      chat,
      channelType: channelType,
      channelUrl: channelUrl,
      params: params.toJson(),
      timestamp: timestamp,
    ));
  }

  /// Retrieves previous or next messages based on the message ID in a specific channel.
  ///
  /// The [messageId] to be the reference point for messages to retrieve.
  Future<List<BaseMessage>> getMessagesByMessageId(
    int messageId,
    MessageListParams params,
  ) async {
    sbLog.i(StackTrace.current, 'messageId: $messageId');

    if (messageId <= 0) {
      throw InvalidParameterException();
    }

    if (channelType == ChannelType.group) {
      params.showSubChannelMessagesOnly = false;
    }

    return await chat.apiClient.send<List<BaseMessage>>(
      ChannelMessagesGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        messageId: messageId,
      ),
    );
  }

  /// Requests message change logs after given token or timestamp
  ///
  /// The [token] to be the reference point for the changelogs to retrieve.
  /// If the token is null, the result will be passed from the beginning.
  /// The [timestamp] to load change logs.
  /// Change logs after this timestamp will be returned.
  Future<MessageChangeLogs> getMessageChangeLogs(
    MessageChangeLogParams params, {
    int? timestamp,
    String? token,
  }) async {
    sbLog.i(StackTrace.current, 'timestamp: $timestamp');

    return await chat.apiClient.send(
      ChannelMessageChangeLogGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        params: params,
        token: token,
        timestamp: timestamp ?? IntMax.max,
      ),
    );
  }
}
