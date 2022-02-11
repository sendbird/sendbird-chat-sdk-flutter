part of 'base_channel.dart';

/// Set of functionality related to message
extension Messages on BaseChannel {
  /// Sends [UserMessage] on this channel with [text].
  ///
  /// It returns [UserMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
  UserMessage sendUserMessageWithText(
    String text, {
    OnUserMessageCallback? onCompleted,
  }) {
    final params = UserMessageParams(message: text);
    return sendUserMessage(
      params,
      onCompleted: onCompleted,
    );
  }

  /// Sends [UserMessage] on this channel with [params].
  ///
  /// It returns [UserMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
  UserMessage sendUserMessage(
    UserMessageParams params, {
    OnUserMessageCallback? onCompleted,
  }) {
    if (params.message.isEmpty) {
      throw InvalidParameterError();
    }

    // final req = ChannelUserMessageSendRequest(
    //   channelType: channelType,
    //   channelUrl: channelUrl,
    //   params: params,
    // );

    // final pending = req.pending;

    // if (!_sdk.state.hasActiveUser) {
    //   final error = ConnectionRequiredError();
    //   pending
    //     ..errorCode = error.code
    //     ..sendingStatus = MessageSendingStatus.failed;
    //   if (onCompleted != null) onCompleted(pending, error);
    //   return pending;
    // }

    // pending.sendingStatus = MessageSendingStatus.pending;
    // pending.sender = Sender.fromUser(_sdk.state.currentUser, this);

    // _sdk.cmdManager.send(req).then((result) {
    //   if (result == null) return;
    //   final msg = BaseMessage.msgFromJson<UserMessage>(
    //     result.payload,
    //     type: result.cmd,
    //   );
    //   if (onCompleted != null && msg != null) onCompleted(msg, null);
    // }).catchError((e) {
    //   // pending.errorCode = e?.code ?? ErrorCode.unknownError;
    //   pending
    //     ..errorCode = e.code
    //     ..sendingStatus = MessageSendingStatus.failed;
    //   if (onCompleted != null) onCompleted(pending, e);
    // });

    final cmd = Command.buildUserMessage(
      channelUrl,
      params,
      Uuid().v1(),
    );
    final pending = BaseMessage.msgFromJson<UserMessage>(
      cmd.payload,
      channelType: channelType,
      type: cmd.cmd,
    )!; //UserMessage.fromJson(cmd.payload);

    if (!_sdk.state.hasActiveUser) {
      final error = ConnectionRequiredError();
      pending
        ..errorCode = error.code
        ..sendingStatus = MessageSendingStatus.failed;
      if (onCompleted != null) onCompleted(pending, error);
      return pending;
    }

    pending.sendingStatus = MessageSendingStatus.pending;
    pending.sender = Sender.fromUser(_sdk.state.currentUser, this);

    _sdk.cmdManager.sendCommand(cmd).then((result) {
      if (result == null) return;
      final msg = BaseMessage.msgFromJson<UserMessage>(
        result.payload,
        type: result.cmd,
      );
      if (onCompleted != null && msg != null) onCompleted(msg, null);
    }).catchError((e) {
      pending
        ..errorCode = e?.code ?? ErrorCode.unknownError
        ..sendingStatus = MessageSendingStatus.failed;
      if (onCompleted != null) onCompleted(pending, e);
    });

    return pending;
  }

  /// Resends failed [UserMessage] on this channel with [message].
  ///
  /// It returns [UserMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
  UserMessage resendUserMessage(
    UserMessage message, {
    OnUserMessageCallback? onCompleted,
  }) {
    if (message.sendingStatus != MessageSendingStatus.failed) {
      throw InvalidParameterError();
    }
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }
    if (!message.isResendable()) {
      throw InvalidParameterError();
    }

    final params = UserMessageParams.withMessage(message, deepCopy: false);
    return sendUserMessage(
      params,
      onCompleted: onCompleted,
    );
  }

  /// Updates [UserMessage] on this channel with [messageId] and [params].
  Future<UserMessage> updateUserMessage(
      int messageId, UserMessageParams params) async {
    if (messageId <= 0) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateUserMessage(
      channelUrl,
      messageId,
      params,
    );

    try {
      final res = await _sdk.cmdManager.sendCommand(cmd);
      if (res != null) {
        return BaseMessage.msgFromJson<UserMessage>(
          res.payload,
          type: cmd.cmd,
        )!; //mark!
      } else {
        logger.e('failed to update user message');
        throw WebSocketError();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Sends [FileMessage] on this channel with [params].
  ///
  /// It returns [FileMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
  FileMessage sendFileMessage(
    FileMessageParams params, {
    OnFileMessageCallback? onCompleted,
    OnUploadProgressCallback? progress,
  }) {
    if (!params.uploadFile.hasSource) {
      throw InvalidParameterError();
    }

    UploadResponse? upload;
    int? fileSize;
    String? url;

    final pending = FileMessage.fromParams(params: params, channel: this);
    pending.sendingStatus = MessageSendingStatus.pending;
    pending.sender = Sender.fromUser(_sdk.state.currentUser, this);

    final queue = _sdk.getMsgQueue(channelUrl);
    final task = AsyncSimpleTask(
      () async {
        if (params.uploadFile.hasBinary) {
          try {
            upload = await _sdk.api
                .send<UploadResponse>(ChannelFileUploadRequest(
                    channelUrl: channelUrl,
                    requestId: pending.requestId!,
                    params: params,
                    onProgress: progress))
                .timeout(
              Duration(seconds: _sdk.options.fileTransferTimeout),
              onTimeout: () {
                logger.e('upload timeout');
                if (onCompleted != null) {
                  onCompleted(
                    pending..sendingStatus = MessageSendingStatus.failed,
                    SBError(
                      message: 'upload timeout',
                      code: ErrorCode.fileUploadTimeout,
                    ),
                  );
                }
                //
                throw SBError(code: ErrorCode.fileUploadTimeout);
              },
            );
            if (upload == null) {
              throw SBError(code: ErrorCode.fileUploadTimeout);
            }
            fileSize = upload?.fileSize;
            url = upload?.url;
          } catch (e) {
            rethrow;
          }
        }

        if (fileSize != null) params.uploadFile.fileSize = fileSize;
        if (url != null) params.uploadFile.url = url;

        final cmd = Command.buildFileMessage(
          channelUrl: channelUrl,
          params: params,
          requestId: pending.requestId,
          requireAuth: upload?.requireAuth,
          thumbnails: upload?.thumbnails,
        );

        final msgFromPayload = BaseMessage.msgFromJson<FileMessage>(
          cmd.payload,
          channelType: channelType,
          type: cmd.cmd,
        )!;

        if (!_sdk.state.hasActiveUser) {
          final error = ConnectionRequiredError();
          msgFromPayload
            ..errorCode = error.code
            ..sendingStatus = MessageSendingStatus.failed;
          if (onCompleted != null) onCompleted(msgFromPayload, error);
          return msgFromPayload;
        }
        if (_sdk.webSocket == null || _sdk.webSocket?.isConnected() == false) {
          final request = ChannelFileMessageSendApiRequest(
            channelType: channelType,
            channelUrl: channelUrl,
            params: params,
            thumbnails: upload?.thumbnails,
            requireAuth: upload?.requireAuth,
          );
          final msg = await _sdk.api.send<FileMessage>(request);
          if (onCompleted != null) onCompleted(msg, null);
        } else {
          _sdk.cmdManager.sendCommand(cmd).then((result) {
            if (result == null) return;
            final msg = BaseMessage.msgFromJson<FileMessage>(
              result.payload,
              type: result.cmd,
            );
            if (onCompleted != null && msg != null) onCompleted(msg, null);
          }).catchError((e) {
            pending
              ..errorCode = e?.code ?? ErrorCode.unknownError
              ..sendingStatus = MessageSendingStatus.failed;
            if (onCompleted != null) onCompleted(pending, e);
          });
        }
      },
      onCancel: () {
        if (onCompleted != null) onCompleted(pending, OperationCancelError());
      },
    );

    queue.enqueue(task);

    _sdk.setUploadTask(pending.requestId!, task);
    _sdk.setMsgQueue(channelUrl, queue);

    return pending;
  }

  bool cancelUploadingFileMessage(String requestId) {
    if (requestId.isEmpty) {
      throw InvalidParameterError();
    }
    final task = _sdk.getUploadTask(requestId);
    if (task == null) {
      throw NotFoundError();
    }

    final queue = _sdk.getMsgQueue(channelUrl);
    _sdk.api.cancelUploadingFile(requestId);
    return queue.cancel(task.hashCode);
  }

  /// Resends failed [FileMessage] on this channel with [message].
  ///
  /// It returns [FileMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
  FileMessage resendFileMessage(
    FileMessage message, {
    required FileMessageParams params,
    OnFileMessageCallback? onCompleted,
    OnUploadProgressCallback? progress,
  }) {
    if (message.sendingStatus != MessageSendingStatus.failed) {
      throw InvalidParameterError();
    }
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }
    if (!message.isResendable()) {
      throw InvalidParameterError();
    }

    return sendFileMessage(
      params,
      progress: progress,
      onCompleted: onCompleted,
    );
  }

  /// Updates [FileMessage] on this channel with [messageId] and [params].
  Future<FileMessage> updateFileMessage(
      int messageId, FileMessageParams params) async {
    if (messageId <= 0) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateFileMessage(
      channelUrl,
      messageId,
      params,
    );

    try {
      final res = await _sdk.cmdManager.sendCommand(cmd);
      if (res != null) {
        return BaseMessage.msgFromJson<FileMessage>(
          res.payload,
          type: cmd.cmd,
        )!; //mark!
      } else {
        logger.e('failed to update file message');
        throw WebSocketError();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes message with given [messageId].
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onMessageDeleted] will be invoked.
  Future<void> deleteMessage(int messageId) async {
    if (messageId <= 0) {
      throw InvalidParameterError();
    }

    await _sdk.api.send(ChannelMessageDeleteRequest(
      channelType: channelType,
      channelUrl: channelUrl,
      messageId: messageId,
    ));
  }

  /// Translates a [message] with given list of [targetLanguages].
  ///
  /// An element of target language should be from
  /// http://www.lingoes.net/en/translator/langcode.htm
  Future<UserMessage> translateUserMessage(
    UserMessage message,
    List<String> targetLanguages,
  ) async {
    if (message.messageId <= 0) {
      throw InvalidParameterError();
    }
    if (targetLanguages.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.send<UserMessage>(
      ChannelMessageTranslateRequest(
        channelType: channelType,
        channelUrl: channelUrl,
        messageId: message.messageId,
        targetLanguages: targetLanguages,
      ),
    );
  }

  /// Copies [message] to [targetChannel].
  ///
  /// It returns either [UserMessage] or [FileMessage] with
  /// [MessageSendingStatus.pending] and [onCompleted] will be invoked once the
  /// message has been sent completely. Channel event
  /// [ChannelEventHandler.onMessageReceived] will be invoked on all
  /// other members' end.
  BaseMessage copyMessage(
    BaseMessage message,
    BaseChannel targetChannel, {
    OnMessageCallback? onCompleted,
  }) {
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (message is UserMessage) {
      final params = UserMessageParams.withMessage(message, deepCopy: false);
      return targetChannel.sendUserMessage(
        params,
        onCompleted: onCompleted,
      );
    } else if (message is FileMessage) {
      final params = FileMessageParams.withMessage(message, deepCopy: false);
      return targetChannel.sendFileMessage(
        params,
        onCompleted: onCompleted,
      );
    } else {
      throw InvalidParameterError();
    }
  }

  /// Retrieves a list of [BaseMessage] with given [timestamp] and [params].
  Future<List<BaseMessage>> getMessagesByTimestamp(
    int timestamp,
    MessageListParams params,
  ) async {
    if (timestamp <= 0) {
      throw InvalidParameterError();
    }

    if (channelType == ChannelType.group) {
      params.showSubChannelMessagesOnly = false;
    }

    return _sdk.api.send<List<BaseMessage>>(
      ChannelMessagesGetRequest(
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        timestamp: timestamp,
      ),
    );
  }

  /// Retrieves a list of [BaseMessage] with given [messageId] and [params].
  Future<List<BaseMessage>> getMessagesById(
    int messageId,
    MessageListParams params,
  ) async {
    if (messageId <= 0) {
      throw InvalidParameterError();
    }

    if (channelType == ChannelType.group) {
      params.showSubChannelMessagesOnly = false;
    }

    return _sdk.api.send<List<BaseMessage>>(
      ChannelMessagesGetRequest(
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        messageId: messageId,
      ),
    );
  }

  /// Retreieve massage change logs with [timestamp] or [token] and [params].
  Future<MessageChangeLogsResponse> getMessageChangeLogs({
    int? timestamp,
    String? token,
    required MessageChangeLogParams params,
  }) async {
    return _sdk.api.send(
      ChannelMessageChangeLogGetRequest(
        channelType: channelType,
        channelUrl: channelUrl,
        params: params,
        token: token,
        timestamp: timestamp ?? double.maxFinite.round(),
      ),
    );
  }
}
