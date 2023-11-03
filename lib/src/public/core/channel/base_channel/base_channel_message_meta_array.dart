// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'base_channel.dart';

/// BaseChannelMessageMetaArray
extension BaseChannelMessageMetaArray on BaseChannel {
  /// Creates message meta array keys.
  Future<BaseMessage> createMessageMetaArrayKeys(
    BaseMessage message,
    List<String> keys,
  ) async {
    sbLog.i(StackTrace.current, 'keys: $keys');
    checkUnsupportedAction();

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    if (keys.isEmpty) {
      throw InvalidParameterException();
    }

    final metaArrays =
        keys.map((e) => MessageMetaArray(key: e, value: [])).toList();
    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.add, true);

    var result = await chat.commandManager.sendCommand(cmd);
    if (result != null) {
      return RootMessage.getMessageFromJsonWithChat(chat, result.payload,
          commandType: result.cmd) as BaseMessage;
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Deletes message meta array keys.
  Future<BaseMessage> deleteMessageMetaArrayKeys(
    BaseMessage message,
    List<String> keys,
  ) async {
    sbLog.i(StackTrace.current, 'keys: $keys');
    checkUnsupportedAction();

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    if (keys.isEmpty) {
      throw InvalidParameterException();
    }

    final metaArrays =
        keys.map((e) => MessageMetaArray(key: e, value: [])).toList();
    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.remove, true);

    var result = await chat.commandManager.sendCommand(cmd);
    if (result != null) {
      return RootMessage.getMessageFromJsonWithChat(chat, result.payload,
          commandType: result.cmd) as BaseMessage;
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Adds message meta array values.
  Future<BaseMessage> addMessageMetaArrayValues(
    BaseMessage message,
    List<MessageMetaArray> metaArrays,
  ) async {
    sbLog.i(StackTrace.current, 'metaArrays: $metaArrays');
    checkUnsupportedAction();

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    if (metaArrays.isEmpty) {
      throw InvalidParameterException();
    }

    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.add, true);

    var result = await chat.commandManager.sendCommand(cmd);
    if (result != null) {
      return RootMessage.getMessageFromJsonWithChat(chat, result.payload,
          commandType: result.cmd) as BaseMessage;
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Removes message meta array values.
  Future<BaseMessage> removeMessageMetaArrayValues(
    BaseMessage message,
    List<MessageMetaArray> metaArrays,
  ) async {
    sbLog.i(StackTrace.current, 'metaArrays: $metaArrays');
    checkUnsupportedAction();

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    if (metaArrays.isEmpty) {
      throw InvalidParameterException();
    }

    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.remove, true);

    var result = await chat.commandManager.sendCommand(cmd);
    if (result != null) {
      return RootMessage.getMessageFromJsonWithChat(chat, result.payload,
          commandType: result.cmd) as BaseMessage;
    } else {
      throw WebSocketFailedException();
    }
  }
}

enum MetaArrayUpdateMode {
  add,
  remove,
}
