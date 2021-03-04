import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'open_channel.dart';
import 'group_channel.dart';

import '../constant/enums.dart';
import '../constant/error_code.dart';
import '../constant/types.dart';
import '../core/async/async_operation.dart';
import '../core/async/async_queue.dart';
import '../models/command.dart';
import '../events/reaction_event.dart';
import '../message/base_message.dart';
import '../message/file_message.dart';
import '../message/user_message.dart';
import '../models/error.dart';
import '../models/sender.dart';
import '../models/meta_array.dart';
import '../models/responses.dart';
import '../models/user.dart';
import '../params/file_message_params.dart';
import '../params/message_change_logs_params.dart';
import '../params/message_list_params.dart';
import '../params/user_message_params.dart';
import '../sdk/sendbird_sdk_api.dart';
import '../sdk/sendbird_sdk_internal.dart';
import '../services/db/cache_service.dart';
import '../utils/logger.dart';

/// Represents base channel
///
/// This class contains properties and methods for both [GroupChannel] and
/// [OpenChannel]. Note that this is base class for two offical types -
/// group and open - so you won't have any given channel that only derives
/// from this class.
class BaseChannel implements Cacheable<BaseChannel> {
  /// This channel url
  String channelUrl;

  /// name for this channel
  String name;

  /// cover image URL for this channel
  String coverUrl;

  /// User who creates this channel
  User creator;

  /// timestamp when this channel is created
  int createdAt;

  /// custom data for this channel
  String data;

  /// custom type for this channel
  String customType;

  /// Ture if this channel is frozen
  @JsonKey(name: 'freeze')
  bool isFrozen;

  /// True if this channel is ephemeral
  bool isEphemeral;

  /// local usage
  @JsonKey(ignore: true)
  bool fromCache = false;

  @JsonKey(ignore: true)
  bool dirty = false;

  AsyncQueue _messageQueue;

  /// **WARNING:** Do not use default constructor to initialize manually
  BaseChannel({
    this.channelUrl,
    this.name,
    this.coverUrl,
    this.creator,
    this.createdAt,
    this.data,
    this.customType,
    this.isFrozen,
    this.isEphemeral,
    this.fromCache,
    this.dirty,
  }) : _messageQueue = AsyncQueue();

  SendbirdSdkInternal get _sdk => SendbirdSdk().getInternal();

  /// Channel type for this channel
  ChannelType get channelType =>
      this is GroupChannel ? ChannelType.group : ChannelType.open;

  /// Refreshes this channel instance
  static Future<BaseChannel> refreshChannel(
    ChannelType channelType,
    String channelUrl,
  ) async {
    if (channelType == ChannelType.group) {
      return GroupChannel.refreshChannel(channelUrl);
    } else {
      return OpenChannel.refreshChannel(channelUrl);
    }
  }

  /// Adds operators on this channel with given [userIds].
  ///
  /// After this method completes sucessfully, channel event
  /// [ChannelEventHandler.onChannelOperatorsUpdated] will be invoked.
  /// Operator only
  Future<void> addOperators(List<String> userIds) async {
    if (userIds == null || userIds.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.addOperators(
      channelType: channelType,
      channelUrl: channelUrl,
      userIds: userIds,
    );
  }

  /// Removes operators on this channel with given [userIds].
  ///
  /// After this method completes sucessfully, channel event
  /// [ChannelEventHandler.onChannelOperatorsUpdated] will be invoked.
  /// Operator only
  Future<void> removeOperators(List<String> userIds) async {
    if (userIds == null || userIds.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.removeOperators(
      channelType: channelType,
      channelUrl: channelUrl,
      userIds: userIds,
    );
  }

  /// Removes all operators on this channel.
  ///
  /// After this method completes sucessfully, channel event
  /// [ChannelEventHandler.onChannelOperatorsUpdated] will be invoked.
  /// Operator only
  Future<void> removeAllOperators() async {
    await _sdk.api.removeAllOperators(
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Retrieves a list of [BaseMessage] with given [timestamp] and [params].
  Future<List<BaseMessage>> getMessagesByTimestamp(
    int timestamp,
    MessageListParams params,
  ) async {
    if (timestamp == null || timestamp <= 0) {
      throw InvalidParameterError();
    }
    if (params == null) {
      throw InvalidParameterError();
    }

    if (channelType == ChannelType.group)
      params.showSubChannelMessagesOnly = false;

    return _sdk.api.getMessages(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params.toJson(),
      timestamp: timestamp,
    );
  }

  /// Retrieves a list of [BaseMessage] with given [messageId] and [params].
  Future<List<BaseMessage>> getMessagesById(
    int messageId,
    MessageListParams params,
  ) async {
    if (messageId == null || messageId <= 0) {
      throw InvalidParameterError();
    }
    if (params == null) {
      throw InvalidParameterError();
    }

    if (channelType == ChannelType.group)
      params.showSubChannelMessagesOnly = false;

    return _sdk.api.getMessages(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params.toJson(),
      messageId: messageId,
    );
  }

  /// Sends [UserMessage] on this channel with [text].
  ///
  /// It returns [UserMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
  UserMessage sendUserMessageWithText(
    String text, {
    OnMessageCallback onCompleted,
  }) {
    final params = UserMessageParams()..message = text;
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
    OnMessageCallback onCompleted,
  }) {
    if (params.message == null || params.message.isEmpty) {
      throw SBError(code: ErrorCode.invalidParameter);
    }

    final cmd = Command.buildUserMessage(
      channelUrl,
      params,
      Uuid().v1(),
    );
    final pending = BaseMessage.msgFromJson<UserMessage>(
      cmd.payload,
      channelType: channelType,
    ); //UserMessage.fromJson(cmd.payload);

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

    _sdk.cmdManager.sendCommand(cmd).then((cmdResult) {
      final msg = BaseMessage.msgFromJson<UserMessage>(cmdResult.payload);
      if (onCompleted != null) onCompleted(msg, null);
    }).catchError((e) {
      // pending.errorCode = e?.code ?? ErrorCode.unknownError;
      pending
        ..errorCode = e.code
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
    OnMessageCallback onCompleted,
  }) {
    if (message == null ||
        message.sendingStatus != MessageSendingStatus.failed) {
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
  ///
  /// [onCompleted] will be invoked once the message has been updated
  /// completely. Channel event [ChannelEventHandler.onMessageUpdated] will be
  /// invoked on all other members' end.
  Future<UserMessage> updateUserMessage(
      int messageId, UserMessageParams params) async {
    if (messageId == null || messageId <= 0) {
      throw InvalidParameterError();
    }
    if (params == null) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateUserMessage(
      channelUrl,
      messageId,
      params,
    );

    try {
      final res = await _sdk.cmdManager.sendCommand(cmd);
      final msg = BaseMessage.msgFromJson<UserMessage>(res.payload);
      return msg;
    } catch (e) {
      throw e;
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
    OnFileMessageCallback onCompleted,
    OnUploadProgressCallback progress,
  }) {
    if (params == null) {
      throw InvalidParameterError();
    }

    if (params.uploadFile == null || !params.uploadFile.hasSource) {
      throw InvalidParameterError();
    }

    UploadResponse upload;
    int fileSize;
    String url;

    final pending = FileMessage.fromParams(params: params, channel: this);
    pending.sendingStatus = MessageSendingStatus.pending;
    pending.sender = Sender.fromUser(_sdk.state.currentUser, this);

    final queue = _sdk.messageQueues[channelUrl] ?? AsyncQueue();
    queue.enqueue(AsyncSimpleTask(() async {
      if (params.uploadFile.hasBinary) {
        upload = await _sdk.api
            .uploadFile(
                channelUrl: channelUrl,
                requestId: pending.requestId,
                params: params,
                progress: progress)
            .timeout(
          Duration(seconds: _sdk.options.fileTransferTimeout),
          onTimeout: () {
            logger.e('[Sendbird] upload timeout');
            if (onCompleted != null)
              onCompleted(
                pending..sendingStatus = MessageSendingStatus.failed,
                SBError(
                  message: 'upload timeout',
                  code: ErrorCode.fileUploadTimeout,
                ),
              );
            return;
          },
        );
        fileSize = upload.fileSize;
        url = upload.url;
      }

      if (fileSize != null) params.uploadFile.fileSize = fileSize;
      if (url != null) params.uploadFile.url = url;

      final cmd = Command.buildFileMessage(
        channelUrl: channelUrl,
        params: params,
        requestId: Uuid().v1(),
        requireAuth: upload?.requireAuth,
        thumbnails: upload?.thumbnails,
      );

      final msgFromPayload = BaseMessage.msgFromJson<FileMessage>(
        cmd.payload,
        channelType: channelType,
      );

      if (!_sdk.state.hasActiveUser) {
        final error = ConnectionRequiredError();
        msgFromPayload
          ..errorCode = error.code
          ..sendingStatus = MessageSendingStatus.failed;
        if (onCompleted != null) onCompleted(msgFromPayload, error);
        return msgFromPayload;
      }

      try {
        final result = await _sdk.cmdManager.sendCommand(cmd);
        final msg = BaseMessage.msgFromJson<FileMessage>(result.payload);
        if (onCompleted != null) onCompleted(msg, null);
      } catch (e) {
        pending.sendingStatus = MessageSendingStatus.failed;
        if (onCompleted != null) onCompleted(pending, e);
      }
    }));

    if (_sdk.messageQueues[channelUrl] == null)
      _sdk.messageQueues[channelUrl] = queue;

    return pending;
  }

  /// Resends failed [FileMessage] on this channel with [message].
  ///
  /// It returns [FileMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
  FileMessage resendFileMessage(
    FileMessage message, {
    @required FileMessageParams params,
    OnFileMessageCallback onCompleted,
    OnUploadProgressCallback progress,
  }) {
    if (message == null ||
        message.sendingStatus != MessageSendingStatus.failed) {
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
  ///
  /// [onCompleted] will be invoked once the message has been updated
  /// completely. Channel event [ChannelEventHandler.onMessageUpdated] will be
  /// invoked on all other members' end.
  Future<FileMessage> updateFileMessage(
      int messageId, FileMessageParams params) async {
    if (messageId == null || messageId <= 0) {
      throw InvalidParameterError();
    }
    if (params == null) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateFileMessage(
      channelUrl,
      messageId,
      params,
    );

    try {
      final res = await _sdk.cmdManager.sendCommand(cmd);
      final msg = BaseMessage.msgFromJson<FileMessage>(res.payload);
      return msg;
    } catch (e) {
      throw e;
    }
  }

  /// Deletes message with given [messageId].
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onMessageDeleted] will be invoked.
  Future<void> deleteMessage(int messageId) async {
    if (messageId == null || messageId <= 0) {
      throw InvalidParameterError();
    }

    await _sdk.api.deleteMessage(
      channelType: channelType,
      channelUrl: channelUrl,
      messageId: messageId,
    );
  }

  /// Translates a [message] with given list of [targetLanguages].
  ///
  /// An element of target language should be from
  /// http://www.lingoes.net/en/translator/langcode.htm
  Future<UserMessage> translateUserMessage(
    UserMessage message,
    List<String> targetLanguages,
  ) async {
    if (message == null || message.messageId <= 0) {
      throw InvalidParameterError();
    }
    if (targetLanguages == null || targetLanguages.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.translateUserMessage(
      channelType: channelType,
      channelUrl: channelUrl,
      messageId: message.messageId,
      targetLanguages: targetLanguages,
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
    OnMessageCallback onCompleted,
  }) {
    if (message == null || targetChannel == null) {
      throw InvalidParameterError();
    }

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

  /// Retreieve massage change logs with [timestamp] or [token] and [params].
  Future<MessageChangeLogsResponse> getMessageChangeLogs({
    int timestamp,
    String token,
    MessageChangeLogParams params,
  }) async {
    if (params == null) {
      throw InvalidParameterError();
    }

    return _sdk.api.getMessageChangeLogs(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params,
      token: token,
      timestamp: timestamp ?? double.maxFinite.round(),
    );
  }

  /// Creates meta data on this channel with [metaData].
  ///
  /// It returns [Map<String, String>] that newly created. Once it completes
  /// successfully, channel event [ChannelEventHandler.onChannelMetaDataCreated]
  /// will be invoked.
  Future<Map<String, String>> createMetaData(
      Map<String, String> metaData) async {
    if (metaData == null || metaData.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.createChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      metaData: metaData,
    );
  }

  /// Retrieves meta data from this channel with [keys].
  Future<Map<String, String>> getMetaData(List<String> keys) async {
    if (keys == null || keys.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.getChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      keys: keys,
    );
  }

  /// Retrieves all metaData from this channel.
  Future<Map<String, String>> getAllMetaData() async {
    return _sdk.api.getChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Updates meta data on this channel with [metaData].
  ///
  /// It returns [Map<String, String>] that newly updated. Once it completes
  /// successfully, channel event [ChannelEventHandler.onChannelMetaDataUpdated]
  /// will be invoked.
  Future<Map<String, String>> updateMetaData(
      Map<String, String> metaData) async {
    if (metaData == null || metaData.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.updateChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      metaData: metaData,
    );
  }

  /// Deletes a meta data on this channel with [key].
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelMetaDataDeleted] will be invoked.
  Future<void> deleteMetaData(String key) async {
    if (key == null || key.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.deleteChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      key: key,
    );
  }

  /// Deletes a meta data on this channel with [key].
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelMetaDataDeleted] will be invoked.
  Future<void> deleteAllMetaData() async {
    return _sdk.api.deleteAllChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Creates meta counters on this channel with [metaCounters].
  ///
  /// It returns [Map<String, String>] that newly created. Once it completes
  /// successfully, channel event
  /// [ChannelEventHandler.onChannelMetaCountersCreated] will be invoked.
  Future<Map<String, int>> createMetaCounters(
      Map<String, int> metaCounters) async {
    if (metaCounters == null || metaCounters.isEmpty) {
      throw InvalidParameterError();
    }
    return _sdk.api.createChannelMetaCounters(
      channelType: channelType,
      channelUrl: channelUrl,
      metaCounters: metaCounters,
    );
  }

  /// Retrieves meta counters from this channel with [keys].
  Future<Map<String, int>> getMetaCounters(List<String> keys) async {
    if (keys == null || keys.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.getChannelMetaCounters(
      channelType: channelType,
      channelUrl: channelUrl,
      keys: keys,
    );
  }

  /// Retrieves all meta counters from this channel.
  Future<Map<String, int>> getAllMetaCounters() async {
    return _sdk.api.getChannelMetaCounters(
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Updates meta counters on this channel with [metaCounters].
  ///
  /// It returns [Map<String, int>] that newly updated. Once it completes
  /// successfully, channel event
  /// [ChannelEventHandler.onChannelMetaCountersUpdated] will be
  /// invoked. Updated given key will be replaced with given value.
  ///
  /// before
  /// ```
  /// {'key1' : 2}
  /// ```
  ///
  /// updateMetaCounters({'key1': 5})
  ///
  /// after
  /// ```
  /// {'key1': 5}
  /// ```
  Future<Map<String, int>> updateMetaCounters(
      Map<String, int> metaCounters) async {
    if (metaCounters == null || metaCounters.isEmpty) {
      throw InvalidParameterError();
    }

    return _sdk.api.updateChannelMetaCounters(
      channelType: channelType,
      channelUrl: channelUrl,
      metaCounters: metaCounters,
      mode: MetaCounterMode.set,
    );
  }

  /// Increases meta counters on this channel with [metaCounters].
  ///
  /// It returns [Map<String, int>] that newly updated. Once it completes
  /// successfully, channel event
  /// [ChannelEventHandler.onChannelMetaCountersUpdated] will be
  /// invoked. Given values will be added to given keys.
  ///
  /// before
  /// ```
  /// {'key1' : 2}
  /// ```
  ///
  /// increaseMetaCounters({'key1': 5})
  ///
  /// after
  /// ```
  /// {'key1': 7}
  /// ```
  Future<Map<String, int>> increaseMetaCounters(
      Map<String, int> metaCounters) async {
    if (metaCounters == null || metaCounters.isEmpty) {
      throw InvalidParameterError();
    }
    return _sdk.api.updateChannelMetaCounters(
      channelType: channelType,
      channelUrl: channelUrl,
      metaCounters: metaCounters,
      mode: MetaCounterMode.increase,
    );
  }

  /// Decreases meta counters on this channel with [metaCounters].
  ///
  /// It returns [Map<String, int>] that newly updated. Once it completes
  /// successfully, channel event
  /// [ChannelEventHandler.onChannelMetaCountersUpdated] will be
  /// invoked. Given values will be added to given keys.
  ///
  /// before
  /// ```
  /// {'key1' : 10}
  /// ```
  ///
  /// increaseMetaCounters({'key1': 9})
  ///
  /// after
  /// ```
  /// {'key1': 1}
  /// ```
  Future<Map<String, int>> decreaseMetaCounters(
      Map<String, int> metaCounters) async {
    if (metaCounters == null || metaCounters.isEmpty) {
      throw InvalidParameterError();
    }
    return _sdk.api.updateChannelMetaCounters(
      channelType: channelType,
      channelUrl: channelUrl,
      metaCounters: metaCounters,
      mode: MetaCounterMode.decrease,
    );
  }

  /// Deletes a meta counter with given [key]
  Future<void> deleteMetaCounters(String key) async {
    if (key == null || key.isEmpty) {
      throw InvalidParameterError();
    }
    return _sdk.api.deleteChannelMetaCounter(
      channelType: channelType,
      channelUrl: channelUrl,
      key: key,
    );
  }

  /// Deletes all meta counters
  Future<void> deleteAllMetaCounters() async {
    await _sdk.api.deleteAllChannelMetaCounters(
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Adds list of [metaArrays] with given [message].
  Future<BaseMessage> addMessageMetaArray(
    BaseMessage message,
    List<MessageMetaArray> metaArrays,
  ) async {
    if (message == null || message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (metaArrays == null || metaArrays.length == 0) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.add, true);

    final result = await _sdk.cmdManager.sendCommand(cmd);
    result.payload['type'] = result.cmd;
    return BaseMessage.msgFromJson(result.payload);
  }

  /// Deletes [keys] from [MessageMetaArray] given [message].
  Future<BaseMessage> deleteMessageMetaArrayKeys(
    BaseMessage message,
    List<String> keys,
  ) async {
    if (message == null || message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (keys == null || keys.length <= 0) {
      throw InvalidParameterError();
    }

    final metaArrays =
        keys.map((e) => MessageMetaArray(key: e, value: [])).toList();
    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.remove, false);

    final result = await _sdk.cmdManager.sendCommand(cmd);
    result.payload['type'] = result.cmd;
    return BaseMessage.msgFromJson(result.payload);
  }

  /// Removes list of [metaArrays] with given [message]
  Future<BaseMessage> removeMessageMetaArray(
    BaseMessage message,
    List<MessageMetaArray> metaArrays,
  ) async {
    if (message == null || message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (metaArrays == null || metaArrays.length == 0) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.remove, true);

    final result = await _sdk.cmdManager.sendCommand(cmd);
    result.payload['type'] = result.cmd;
    return BaseMessage.msgFromJson(result.payload);
  }

  /// Adds reaction [key] to given [message]
  ///
  /// [ChannelEventHandler.onReactionUpdated] callback will be invoked with
  /// event after completion, and you should apply the event to the message by
  /// calling [BaseMessage.applyReactionEvent]
  Future<ReactionEvent> addReaction(BaseMessage message, String key) async {
    if (message == null || message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (key == null || key.isEmpty) {
      throw InvalidParameterError();
    }

    final res = await _sdk.api.addReaction(
      channelType: message.channelType,
      channelUrl: message.channelUrl,
      messageId: message.messageId,
      key: key,
    );

    res.messageId = message.messageId;
    return res;
  }

  /// Deletes reaction [key] from [message]
  ///
  /// [ChannelEventHandler.onReactionUpdated] callback will be invoked with
  /// event after completion, and you should apply the event to the message by
  /// calling [BaseMessage.applyReactionEvent]
  Future<ReactionEvent> deleteReaction(BaseMessage message, String key) async {
    if (message == null || message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (key == null || key.isEmpty) {
      throw InvalidParameterError();
    }

    final res = await _sdk.api.deleteReaction(
      channelType: message.channelType,
      channelUrl: message.channelUrl,
      messageId: message.messageId,
      key: key,
    );

    res.messageId = message.messageId;
    return res;
  }

  /// Reports a [user] with [category] and [description] (optional)
  Future<void> reportUser({
    @required User user,
    @required ReportCategory category,
    String description,
  }) async {
    if (user == null) {
      throw InvalidParameterError();
    }

    if (category == null) {
      throw InvalidParameterError();
    }

    await _sdk.api.reportUser(
      userId: user.userId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      reporterId: _sdk.state.userId,
    );
  }

  /// Reports this channel with [category] and [description] (optional)
  Future<void> reportChannel({
    @required ReportCategory category,
    String description,
  }) async {
    if (category == null) {
      throw InvalidParameterError();
    }

    await _sdk.api.reportChannel(
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
    );
  }

  /// Reports [message] with [category] and [description] (optional)
  Future<void> reportMessage({
    @required BaseMessage message,
    @required ReportCategory category,
    String description,
  }) async {
    if (message == null) {
      throw InvalidParameterError();
    }

    if (category == null) {
      throw InvalidParameterError();
    }

    await _sdk.api.reportMessage(
      messageId: message.messageId,
      senderId: message.sender.userId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
    );
  }

  /// Bans a user from this channel.
  ///
  /// Provides [seconds] to set how long the user should be banned. `-1`
  /// indicates to ban the user parmanently.
  Future<void> banUser({
    @required String userId,
    int seconds = -1,
    String description,
  }) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.banUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    );
  }

  /// Unbans a user from this channel
  Future<void> unbanUser({@required String userId}) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.unbanUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Mutes a user from this channel.
  ///
  /// Provides [seconds] to set how long the user should be muted. `-1`
  /// indicates to mute the user parmanently.
  Future<void> muteUser({
    @required String userId,
    int seconds = -1,
    String description,
  }) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.muteUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    );
  }

  /// Unmutes user from this channel.
  Future<void> unmuteUser({@required String userId}) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.unmuteUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Returns channel with given [type] and [channelUrl]
  static Future<BaseChannel> getBaseChannel(
    ChannelType type,
    String channelUrl,
  ) async {
    switch (type) {
      case ChannelType.group:
        return GroupChannel.getChannel(channelUrl);
      case ChannelType.open:
        return OpenChannel.getChannel(channelUrl);
      default:
        return null;
    }
  }

  // TBD
  // Builds a message object from serialized data TBD
  // static BaseMessage buildFromSeralizedData(ByteData data) {
  //   return null;
  // }

  // /// Serializes message object TBD
  // ByteData serialize() {
  //   return null;
  // }

  /// Cacheable
  @override
  String get key => 'channel/' + channelType.toString() + channelUrl;

  @override
  String get primaryKey => channelUrl;

  @override
  void copyWith(BaseChannel others) {
    channelUrl = others.channelUrl;
    name = others.name;
    coverUrl = others.coverUrl;
    creator = others.creator;
    createdAt = others.createdAt;
    data = others.data;
    customType = others.customType;
  }
}
