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
    checkUnsupportedAction();

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
    int? resendMessageId,
  }) {
    sbLog.i(StackTrace.current, 'message: ${params.message}');
    checkUnsupportedAction();

    if (params.message.isEmpty) {
      throw InvalidParameterException();
    }

    final cmd = Command.buildUserMessage(
      channelUrl,
      params,
      const Uuid().v1(),
    );

    final pendingUserMessage =
        RootMessage.getMessageFromJsonWithChat<UserMessage>(
      chat,
      cmd.payload,
      channelType: channelType,
      commandType: cmd.cmd,
    ) as UserMessage;

    if (this is GroupChannel) {
      pendingUserMessage.messageId =
          resendMessageId ?? DateTime.now().millisecondsSinceEpoch;

      for (final messageCollection
          in chat.collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channelUrl) {
          if (resendMessageId != null) {
            chat.collectionManager.sendEventsToMessageCollection(
              messageCollection: messageCollection,
              baseChannel: this,
              eventSource: CollectionEventSource.localMessageResendStarted,
              sendingStatus: SendingStatus.pending,
              updatedMessages: [pendingUserMessage],
            );
          } else {
            chat.collectionManager.sendEventsToMessageCollection(
              messageCollection: messageCollection,
              baseChannel: this,
              eventSource: CollectionEventSource.localMessagePendingCreated,
              sendingStatus: SendingStatus.pending,
              addedMessages: [pendingUserMessage],
            );
          }
          break;
        }
      }
    }

    if (chat.chatContext.currentUser == null) {
      final error = ConnectionRequiredException();
      pendingUserMessage
        ..errorCode = error.code
        ..sendingStatus = SendingStatus.failed;

      if (this is GroupChannel) {
        for (final messageCollection
            in chat.collectionManager.baseMessageCollections) {
          if (messageCollection.baseChannel.channelUrl == channelUrl) {
            chat.collectionManager.sendEventsToMessageCollection(
              messageCollection: messageCollection,
              baseChannel: this,
              eventSource: CollectionEventSource.localMessageFailed,
              sendingStatus: SendingStatus.failed,
              updatedMessages: [pendingUserMessage],
            );
            break;
          }
        }
      }

      if (handler != null) {
        handler(pendingUserMessage, error);
      }
      return pendingUserMessage;
    }

    pendingUserMessage.sendingStatus = SendingStatus.pending;
    pendingUserMessage.sender =
        Sender.fromUser(chat.chatContext.currentUser, this);
    pendingUserMessage.messageCreateParams = params;

    runZonedGuarded(() {
      chat.commandManager.sendCommand(cmd).then((result) async {
        if (result == null) {
          return;
        }

        if (this is GroupChannel) {
          for (final messageCollection
              in chat.collectionManager.baseMessageCollections) {
            if (messageCollection.baseChannel.channelUrl == channelUrl) {
              await chat.collectionManager.sendEventsToMessageCollection(
                messageCollection: messageCollection,
                baseChannel: this,
                eventSource: CollectionEventSource.localMessagePendingCreated,
                sendingStatus: SendingStatus.succeeded,
                deletedMessageIds: [pendingUserMessage.rootId],
              );
              break;
            }
          }
        }

        final message = RootMessage.getMessageFromJsonWithChat<UserMessage>(
          chat,
          result.payload,
          commandType: result.cmd,
        ) as UserMessage;

        chat.collectionManager.onMessageSentByMe(message);
        if (handler != null) {
          handler(message, null);
        }
      });
    }, (e, s) {
      sbLog.e(StackTrace.current, 'e: $e');

      if (e is SendbirdException) {
        pendingUserMessage
          ..errorCode = e.code ?? SendbirdError.unknownError
          ..sendingStatus = SendingStatus.failed;

        if (this is GroupChannel) {
          for (final messageCollection
              in chat.collectionManager.baseMessageCollections) {
            if (messageCollection.baseChannel.channelUrl == channelUrl) {
              chat.collectionManager.sendEventsToMessageCollection(
                messageCollection: messageCollection,
                baseChannel: this,
                eventSource: CollectionEventSource.localMessageFailed,
                sendingStatus: SendingStatus.failed,
                updatedMessages: [pendingUserMessage],
              );
              break;
            }
          }
        }

        if (handler != null) {
          handler(pendingUserMessage, e);
        }
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
    sbLog.i(StackTrace.current, 'message.requestId: ${message.requestId}');
    checkUnsupportedAction();

    if (message.sendingStatus != SendingStatus.failed) {
      throw InvalidParameterException();
    }
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }
    if (!message.isResendable()) {
      throw InvalidParameterException();
    }

    final params = message.messageCreateParams ??
        UserMessageCreateParams.withMessage(message);
    return sendUserMessage(
      params,
      handler: handler,
      resendMessageId: message.messageId,
    );
  }

  /// Updates a `UserMessage` that was previously sent in the channel.
  Future<UserMessage> updateUserMessage(
      int messageId, UserMessageUpdateParams params) async {
    sbLog.i(StackTrace.current, 'message: ${params.message}');
    checkUnsupportedAction();

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
      final message = RootMessage.getMessageFromJsonWithChat<UserMessage>(
        chat,
        result.payload,
        commandType: cmd.cmd,
      ) as UserMessage;
      return message;
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Sends a file with given file information.
  FileMessage sendFileMessage(
    FileMessageCreateParams params, {
    FileMessageHandler? handler,
    ProgressHandler? progressHandler,
    int? resendMessageId,
  }) {
    sbLog.i(StackTrace.current,
        'params.uploadFile.name: ${params.fileInfo.fileName}');
    checkUnsupportedAction();

    if (params.fileInfo.hasSource == false) {
      throw InvalidParameterException();
    }

    final pendingFileMessage =
        FileMessage.fromParams(params: params, channel: this)..set(chat);

    pendingFileMessage.sendingStatus = SendingStatus.pending;
    pendingFileMessage.sender =
        Sender.fromUser(chat.chatContext.currentUser, this);
    pendingFileMessage.messageCreateParams = params;

    if (this is GroupChannel) {
      pendingFileMessage.messageId =
          resendMessageId ?? DateTime.now().millisecondsSinceEpoch;

      for (final messageCollection
          in chat.collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channelUrl) {
          if (resendMessageId != null) {
            chat.collectionManager.sendEventsToMessageCollection(
              messageCollection: messageCollection,
              baseChannel: this,
              eventSource: CollectionEventSource.localMessageResendStarted,
              sendingStatus: SendingStatus.pending,
              updatedMessages: [pendingFileMessage],
            );
          } else {
            chat.collectionManager.sendEventsToMessageCollection(
              messageCollection: messageCollection,
              baseChannel: this,
              eventSource: CollectionEventSource.localMessagePendingCreated,
              sendingStatus: SendingStatus.pending,
              addedMessages: [pendingFileMessage],
            );
          }
          break;
        }
      }
    }

    bool isCanceled = false;
    runZonedGuarded(() async {
      final queue = chat.getMessageQueue(channelUrl);
      final task = AsyncSimpleTask(
        () async {
          UploadResponse? uploadResponse;

          if (params.fileInfo.hasBinary) {
            uploadResponse = await chat.apiClient
                .send<UploadResponse>(ChannelFileUploadRequest(chat,
                    channelUrl: channelUrl,
                    requestId: pendingFileMessage.requestId!,
                    params: params,
                    progressHandler: progressHandler))
                .timeout(
              Duration(seconds: chat.chatContext.options.fileTransferTimeout),
              onTimeout: () {
                pendingFileMessage.sendingStatus = SendingStatus.failed;

                if (this is GroupChannel) {
                  for (final messageCollection
                      in chat.collectionManager.baseMessageCollections) {
                    if (messageCollection.baseChannel.channelUrl ==
                        channelUrl) {
                      chat.collectionManager.sendEventsToMessageCollection(
                        messageCollection: messageCollection,
                        baseChannel: this,
                        eventSource: CollectionEventSource.localMessageFailed,
                        sendingStatus: SendingStatus.failed,
                        updatedMessages: [pendingFileMessage],
                      );
                      break;
                    }
                  }
                }

                if (handler != null) {
                  handler(
                    pendingFileMessage,
                    SendbirdException(code: SendbirdError.fileUploadTimeout),
                  );
                }
                throw SendbirdException(code: SendbirdError.fileUploadTimeout);
              },
            );
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

          final messageBeforeSent =
              RootMessage.getMessageFromJsonWithChat<FileMessage>(
            chat,
            cmd.payload,
            channelType: channelType,
            commandType: cmd.cmd,
          ) as FileMessage
                ..messageId = pendingFileMessage.messageId;

          if (chat.chatContext.currentUser == null) {
            final error = ConnectionRequiredException();
            messageBeforeSent
              ..errorCode = error.code
              ..sendingStatus = SendingStatus.failed;

            if (this is GroupChannel) {
              for (final messageCollection
                  in chat.collectionManager.baseMessageCollections) {
                if (messageCollection.baseChannel.channelUrl == channelUrl) {
                  chat.collectionManager.sendEventsToMessageCollection(
                    messageCollection: messageCollection,
                    baseChannel: this,
                    eventSource: CollectionEventSource.localMessageFailed,
                    sendingStatus: SendingStatus.failed,
                    updatedMessages: [messageBeforeSent],
                  );
                  break;
                }
              }
            }

            if (handler != null) {
              handler(messageBeforeSent, error);
            }
            return messageBeforeSent;
          }

          if (chat.connectionManager.isConnected()) {
            chat.commandManager.sendCommand(cmd).then((result) async {
              if (result == null) return;

              if (this is GroupChannel) {
                for (final messageCollection
                    in chat.collectionManager.baseMessageCollections) {
                  if (messageCollection.baseChannel.channelUrl == channelUrl) {
                    await chat.collectionManager.sendEventsToMessageCollection(
                      messageCollection: messageCollection,
                      baseChannel: this,
                      eventSource:
                          CollectionEventSource.localMessagePendingCreated,
                      sendingStatus: SendingStatus.succeeded,
                      deletedMessageIds: [messageBeforeSent.rootId],
                    );
                    break;
                  }
                }
              }

              final message =
                  RootMessage.getMessageFromJsonWithChat<FileMessage>(
                chat,
                result.payload,
                channelType: channelType,
                commandType: result.cmd,
              ) as FileMessage;

              chat.collectionManager.onMessageSentByMe(message);
              if (handler != null) {
                handler(message, null);
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

            if (this is GroupChannel) {
              for (final messageCollection
                  in chat.collectionManager.baseMessageCollections) {
                if (messageCollection.baseChannel.channelUrl == channelUrl) {
                  await chat.collectionManager.sendEventsToMessageCollection(
                    messageCollection: messageCollection,
                    baseChannel: this,
                    eventSource:
                        CollectionEventSource.localMessagePendingCreated,
                    sendingStatus: SendingStatus.succeeded,
                    deletedMessageIds: [messageBeforeSent.rootId],
                  );
                  break;
                }
              }
            }

            chat.collectionManager.onMessageSentByMe(message);
            if (handler != null) {
              handler(message, null);
            }
          }
        },
        onCancel: () {
          isCanceled = true;
          pendingFileMessage.sendingStatus = SendingStatus.canceled;

          if (this is GroupChannel) {
            for (final messageCollection
                in chat.collectionManager.baseMessageCollections) {
              if (messageCollection.baseChannel.channelUrl == channelUrl) {
                chat.collectionManager.sendEventsToMessageCollection(
                  messageCollection: messageCollection,
                  baseChannel: this,
                  eventSource: CollectionEventSource.localMessageCanceled,
                  sendingStatus: SendingStatus.canceled,
                  deletedMessageIds: [pendingFileMessage.rootId],
                );
                break;
              }
            }
          }

          if (handler != null) {
            handler(pendingFileMessage, OperationCanceledException());
          }
        },
      );

      queue.enqueue(task);

      chat.setUploadTask(pendingFileMessage.requestId!, task);
      chat.setMessageQueue(channelUrl, queue);
    }, (e, s) {
      sbLog.e(StackTrace.current, 'e: $e');
      if (isCanceled) return;

      if (e is SendbirdException) {
        pendingFileMessage
          ..errorCode = e.code ?? SendbirdError.unknownError
          ..sendingStatus = SendingStatus.failed;

        if (this is GroupChannel) {
          for (final messageCollection
              in chat.collectionManager.baseMessageCollections) {
            if (messageCollection.baseChannel.channelUrl == channelUrl) {
              chat.collectionManager.sendEventsToMessageCollection(
                messageCollection: messageCollection,
                baseChannel: this,
                eventSource: CollectionEventSource.localMessageFailed,
                sendingStatus: SendingStatus.failed,
                updatedMessages: [pendingFileMessage],
              );
              break;
            }
          }
        }

        if (handler != null) {
          handler(pendingFileMessage, e);
        }
      }
    });

    return pendingFileMessage;
  }

  /// Cancels an ongoing `FileMessage` upload.
  bool cancelFileMessageUpload(String requestId) {
    sbLog.i(StackTrace.current, 'requestId: $requestId');
    checkUnsupportedAction();

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
  /// [fileMessage] Failed fileMessage.
  /// [file] File to resend. If there is a fileUrl or a fileBytes in fileMessage, this will be ignored.
  FileMessage resendFileMessage(
    FileMessage message, {
    File? file,
    FileMessageHandler? handler,
    ProgressHandler? progressHandler,
  }) {
    sbLog.i(StackTrace.current, 'message.requestId: ${message.requestId}');
    checkUnsupportedAction();

    if (message.sendingStatus != SendingStatus.failed) {
      throw InvalidParameterException();
    }
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }
    if (!message.isResendable()) {
      throw InvalidParameterException();
    }

    if (message.messageCreateParams != null) {
      if (message.messageCreateParams?.fileInfo.fileUrl == null &&
          message.messageCreateParams?.fileInfo.fileBytes == null &&
          file != null) {
        message.messageCreateParams?.fileInfo.file = file;
      }
    }

    final params = message.messageCreateParams ??
        FileMessageCreateParams.withMessage(message);
    return sendFileMessage(
      params,
      progressHandler: progressHandler,
      handler: handler,
      resendMessageId: message.messageId,
    );
  }

  /// Updates a `FileMessage` that was previously sent in the channel.
  /// Note that the file itself cannot be changed; only the fields stored within the message can be modified.
  Future<FileMessage> updateFileMessage(
    int messageId,
    FileMessageUpdateParams params,
  ) async {
    sbLog.i(StackTrace.current);
    checkUnsupportedAction();

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
      final message = RootMessage.getMessageFromJsonWithChat<FileMessage>(
        chat,
        result.payload,
        commandType: cmd.cmd,
      ) as FileMessage;
      return message;
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Deletes a message.
  Future<void> deleteMessage(int messageId) async {
    sbLog.i(StackTrace.current, 'messageId: $messageId');
    checkUnsupportedAction();

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
    checkUnsupportedAction();

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
    checkUnsupportedAction();

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    // Do not copy [extendedMessage] in message.
    message.extendedMessage.clear();

    if (message is UserMessage) {
      final params = UserMessageCreateParams.withMessage(message);
      if (params.pollId != null) {
        throw InvalidParameterException();
      }
      return targetChannel.sendUserMessage(
        params,
        handler: handler,
      );
    } else if (message is FileMessage) {
      final params = FileMessageCreateParams.withMessage(message);
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
  Future<List<RootMessage>> getMessagesByTimestamp(
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

    final res = await chat.apiClient
        .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
      chat,
      channelType: channelType,
      channelUrl: channelUrl,
      params: params.toJson(),
      timestamp: timestamp,
    ));
    return res.messages;
  }

  /// Retrieves previous or next messages based on the message ID in a specific channel.
  ///
  /// The [messageId] to be the reference point for messages to retrieve.
  Future<List<RootMessage>> getMessagesByMessageId(
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

    final res = await chat.apiClient.send<ChannelMessagesGetResponse>(
      ChannelMessagesGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        messageId: messageId,
      ),
    );
    return res.messages;
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
        timestamp: timestamp ?? SendbirdChat.maxInt,
      ),
    );
  }
}
