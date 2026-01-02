// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelMessage
extension GroupChannelMessage on GroupChannel {
  /// Sends multiple files or file URLs as a single [MultipleFilesMessage].
  /// @since 4.8.0
  MultipleFilesMessage sendMultipleFilesMessage(
    MultipleFilesMessageCreateParams params, {
    MultipleFilesMessageHandler? handler,
    FileUploadHandler? fileUploadHandler,
    int? resendMessageId,
  }) {
    sbLog.i(StackTrace.current,
        'params.uploadableFileInfoList.length: ${params.uploadableFileInfoList.length}');
    checkUnsupportedAction();

    if (chat.currentUser == null) {
      throw ConnectionRequiredException();
    }

    final limit =
        chat.chatContext.appInfo?.multipleFilesMessageFileCountLimit ??
            AppInfo.multipleFilesMessageDefaultFileCountLimit;

    final uploadableFileInfoList = params.uploadableFileInfoList;
    if (uploadableFileInfoList.length < 2 ||
        uploadableFileInfoList.length > limit) {
      throw InvalidParameterException();
    }

    for (final uploadableFileInfo in uploadableFileInfoList) {
      if (uploadableFileInfo?.fileInfo.hasSource == false) {
        throw InvalidParameterException();
      }

      final fileSize = uploadableFileInfo?.fileInfo.file?.lengthSync() ??
          uploadableFileInfo?.fileInfo.fileBytes?.lengthInBytes ??
          0;

      if (fileSize > chat.chatContext.uploadSizeLimit) {
        throw FileSizeLimitExceededException();
      }
    }

    final pendingFileMessage =
        MultipleFilesMessage.fromParams(params: params, channel: this)
          ..set(chat);

    pendingFileMessage.sendingStatus = SendingStatus.pending;
    pendingFileMessage.sender =
        Sender.fromUser(chat.chatContext.currentUser, this);
    pendingFileMessage.messageCreateParams = params;

    pendingFileMessage.messageId = resendMessageId ?? 0;

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

    bool isCanceled = false;
    int? currentUploadingIndex;
    runZonedGuarded(() async {
      final queue = chat.getMessageQueue(channelUrl);

      List<bool?> requireAuthList = [];
      List<List<dynamic>?> thumbnailsList = [];

      final task = AsyncSimpleTask(
        () async {
          for (int index = 0; index < uploadableFileInfoList.length; index++) {
            final uploadableFileInfo = uploadableFileInfoList[index];
            if (uploadableFileInfo == null) {
              continue; // Check
            }

            final fileInfo = uploadableFileInfo.fileInfo;

            UploadResponse? uploadResponse;

            if (fileInfo.hasBinary) {
              currentUploadingIndex = index;

              if (index ==
                  chat.apiClient.uploadingIndexToThrowExceptionForTest) {
                chat.apiClient.throwExceptionForTest = true;
              }

              uploadResponse = await chat.apiClient
                  .send<UploadResponse>(ChannelFileUploadRequest(chat,
                      channelUrl: channelUrl,
                      requestId: pendingFileMessage.requestId!,
                      fileInfo: uploadableFileInfo.fileInfo,
                      thumbnailSizes: uploadableFileInfo.thumbnailSizes,
                      progressHandler: null)) // Check
                  .timeout(
                Duration(seconds: chat.chatContext.options.fileTransferTimeout),
                onTimeout: () {
                  if (fileUploadHandler != null) {
                    fileUploadHandler(
                      pendingFileMessage.requestId!,
                      index,
                      uploadableFileInfo,
                      SendbirdException(code: SendbirdError.fileUploadTimeout),
                    );
                  }

                  pendingFileMessage
                    ..sendingStatus = SendingStatus.failed
                    ..messageId = resendMessageId ??
                        DateTime.now().millisecondsSinceEpoch;

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

                  if (handler != null) {
                    handler(
                      pendingFileMessage,
                      SendbirdException(code: SendbirdError.fileUploadTimeout),
                    );
                  }
                  throw SendbirdException(
                      code: SendbirdError.fileUploadTimeout);
                },
              );

              if (index ==
                  chat.apiClient.uploadingIndexToThrowExceptionForTest) {
                chat.apiClient.uploadingIndexToThrowExceptionForTest = null;
                chat.apiClient.throwExceptionForTest = false;
              }
            }

            if (fileUploadHandler != null) {
              fileUploadHandler(
                pendingFileMessage.requestId!,
                index,
                uploadableFileInfo,
                null,
              );
            }

            String? fileUrl = uploadResponse?.url;
            int? fileSize = uploadResponse?.fileSize;
            if (fileUrl != null) fileInfo.fileUrl = fileUrl;
            if (fileSize != null) fileInfo.fileSize = fileSize;

            requireAuthList.add(uploadResponse?.requireAuth);
            thumbnailsList.add(uploadResponse?.thumbnails);
          }

          final cmd = Command.buildMultipleFilesMessage(
            channelUrl: channelUrl,
            params: params,
            requestId: pendingFileMessage.requestId,
            thumbnailsList: thumbnailsList,
            requireAuthList: requireAuthList,
          );

          final messageBeforeSent =
              RootMessage.getMessageFromJsonWithChat<MultipleFilesMessage>(
            chat,
            cmd.payload,
            channelType: channelType,
            commandType: cmd.cmd,
          ) as MultipleFilesMessage
                ..messageId = pendingFileMessage.messageId;

          if (chat.chatContext.currentUser == null) {
            final error = ConnectionRequiredException();
            messageBeforeSent
              ..errorCode = error.code
              ..sendingStatus = SendingStatus.failed
              ..messageId =
                  resendMessageId ?? DateTime.now().millisecondsSinceEpoch;

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

            if (handler != null) {
              handler(messageBeforeSent, error);
            }
            return messageBeforeSent;
          }

          if (chat.connectionManager.isConnected()) {
            chat.commandManager.sendCommand(cmd).then((result) async {
              if (result == null) return;

              final message =
                  RootMessage.getMessageFromJsonWithChat<MultipleFilesMessage>(
                chat,
                result.payload,
                channelType: channelType,
                commandType: result.cmd,
              ) as MultipleFilesMessage;

              for (int i = 0; i < params.uploadableFileInfoList.length; i++) {
                final uploadableFileInfo = params.uploadableFileInfoList[i];
                if (uploadableFileInfo != null && message.files.length > i) {
                  if (uploadableFileInfo.fileInfo.file != null) {
                    message.files[i].file = uploadableFileInfo.fileInfo.file!;
                  }
                }
              }

              chat.collectionManager.onMessageSentByMe(
                channel: this,
                pendingMessage: messageBeforeSent,
                sentMessage: message,
              );

              if (handler != null) {
                handler(message, null);
              }
            });
          } else {
            final request = ChannelMultipleFilesMessageSendRequest(
              chat,
              channelType: channelType,
              channelUrl: channelUrl,
              params: params,
              requireAuthList: requireAuthList,
              thumbnailsList: thumbnailsList,
              requestId: pendingFileMessage.requestId,
            );
            final message =
                await chat.apiClient.send<MultipleFilesMessage>(request);

            chat.collectionManager.onMessageSentByMe(
              channel: this,
              pendingMessage: messageBeforeSent,
              sentMessage: message,
            );

            if (handler != null) {
              handler(message, null);
            }
          }
        },
        onCancel: () {
          isCanceled = true;
          pendingFileMessage.sendingStatus = SendingStatus.canceled;
          pendingFileMessage.errorCode = SendbirdError.fileUploadCanceled;

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

      // Check (_20_mfm_local_cache_failed_test)
      // if (pendingFileMessage.messageCreateParams != null &&
      //     currentUploadingIndex != null) {
      //   final count = pendingFileMessage
      //       .messageCreateParams!.uploadableFileInfoList.length;
      //   for (int i = 0; i < count; i++) {
      //     if (i >= currentUploadingIndex!) {
      //       pendingFileMessage.messageCreateParams!.uploadableFileInfoList[i] =
      //           null;
      //     }
      //   }
      // }

      if (fileUploadHandler != null && currentUploadingIndex != null) {
        e = e is SendbirdException
            ? e
            : SendbirdException(code: SendbirdError.requestFailed);
        fileUploadHandler(
          pendingFileMessage.requestId!,
          currentUploadingIndex!,
          null,
          e,
        );
      }

      if (e is SendbirdException) {
        pendingFileMessage
          ..errorCode = e.code ?? SendbirdError.unknownError
          ..sendingStatus = SendingStatus.failed
          ..messageId = resendMessageId ?? DateTime.now().millisecondsSinceEpoch
          ..files = [];

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

        if (handler != null) {
          handler(pendingFileMessage, e);
        }
      }
    });

    return pendingFileMessage;
  }

  /// Resends multiple files with given file information.
  /// [message] Failed MultipleFilesMessage.
  /// @since 4.8.0
  MultipleFilesMessage resendMultipleFilesMessage(
    MultipleFilesMessage message, {
    MultipleFilesMessageHandler? handler,
    FileUploadHandler? fileUploadHandler,
  }) {
    sbLog.i(StackTrace.current, 'message.requestId: ${message.requestId}');
    checkUnsupportedAction();

    if (message.sendingStatus != SendingStatus.failed &&
        message.sendingStatus != SendingStatus.canceled) {
      throw InvalidParameterException();
    }
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }
    if (!message.isResendable()) {
      if (message.errorCode == SendbirdError.fileSizeLimitExceeded) {
        throw FileSizeLimitExceededException();
      } else {
        throw InvalidParameterException();
      }
    }

    final params = message.messageCreateParams ??
        MultipleFilesMessageCreateParams.withMessage(message);
    return sendMultipleFilesMessage(
      params,
      handler: handler,
      fileUploadHandler: fileUploadHandler,
      resendMessageId: message.messageId,
    );
  }
}
