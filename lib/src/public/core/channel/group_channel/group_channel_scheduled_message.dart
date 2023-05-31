// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelScheduledMessage
extension GroupChannelScheduledMessage on GroupChannel {
  /// Creates a user message to be sent at the specified time.
  Future<UserMessage> createScheduledUserMessage(
    ScheduledUserMessageCreateParams params,
  ) async {
    sbLog.i(StackTrace.current, 'message: ${params.message}');

    return await chat.apiClient.send(
      GroupChannelScheduledUserMessageSendRequest(
        chat,
        channelUrl: channelUrl,
        params: params,
      ),
    );
  }

  /// Sends a scheduled message now.
  Future<void> sendScheduledMessageNow({
    required int scheduledMessageId,
  }) async {
    sbLog.i(StackTrace.current, 'scheduledMessageId: $scheduledMessageId');

    return await chat.apiClient.send(
      GroupChannelScheduledMessageSendNowRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        scheduledMessageId: scheduledMessageId,
      ),
    );
  }

  /// Creates a file message to be sent at the specified time.
  Future<FileMessage> createScheduledFileMessage(
    ScheduledFileMessageCreateParams params,
  ) async {
    sbLog.i(StackTrace.current, 'fileMessageParams.name: ${params.fileName}');

    UploadResponse? upload;

    if (params.fileInfo.hasBinary) {
      upload = await chat.apiClient
          .send<UploadResponse>(GroupChannelScheduledFileUploadRequest(
        chat,
        channelUrl: channelUrl,
        params: params,
      ))
          .timeout(
              Duration(seconds: chat.chatContext.options.fileTransferTimeout),
              onTimeout: () {
        throw SendbirdException(code: SendbirdError.fileUploadTimeout);
      });

      params.fileInfo
        ..fileSize = upload.fileSize
        ..fileUrl = upload.url;
    }

    return await chat.apiClient.send<FileMessage>(
      GroupChannelScheduledFileMessageSendRequest(
        chat,
        channelUrl: channelUrl,
        params: params,
      ),
    );
  }

  /// Update a scheduled user message with scheduledMessageId and ScheduledUserMessageUpdateParams.
  Future<UserMessage> updateScheduledUserMessage({
    required ScheduledUserMessageUpdateParams params,
    required int scheduledMessageId,
  }) async {
    sbLog.i(StackTrace.current, 'scheduledMessageId: $scheduledMessageId');

    return await chat.apiClient.send(
      GroupChannelScheduledUserMessageUpdateRequest(
        chat,
        scheduledMessageId: scheduledMessageId,
        channelUrl: channelUrl,
        params: params,
      ),
    );
  }

  /// Update a scheduled file message with scheduledMessageId and ScheduledFileMessageUpdateParams.
  Future<FileMessage> updateScheduledFileMessage({
    required ScheduledFileMessageUpdateParams params,
    required int scheduledMessageId,
  }) async {
    sbLog.i(StackTrace.current, 'scheduledMessageId: $scheduledMessageId');

    return await chat.apiClient.send(
      GroupChannelScheduledFileMessageUpdateRequest(
        chat,
        scheduledMessageId: scheduledMessageId,
        channelUrl: channelUrl,
        params: params,
      ),
    );
  }

  /// Cancels a scheduled message with scheduledMessageId.
  Future<void> cancelScheduledMessage({
    required int scheduledMessageId,
  }) async {
    sbLog.i(StackTrace.current, 'scheduledMessageId: $scheduledMessageId');

    return await chat.apiClient.send(
      GroupChannelScheduledMessageCancelRequest(
        chat,
        channelUrl: channelUrl,
        scheduledMessageId: scheduledMessageId,
      ),
    );
  }
}
