// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'base_channel.dart';

/// BaseChannelOperator
extension BaseChannelOperator on BaseChannel {
  /// Add operators to the channel.
  /// See [https://docs.sendbird.com/platform/user_type#3_operator](https://docs.sendbird.com/platform/user_type#3_operator) for the explanations on the operators.
  Future<void> addOperators(List<String> userIds) async {
    sbLog.i(StackTrace.current, 'userIds: $userIds');

    if (userIds.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(ChannelOperatorsAddRequest(
      chat,
      channelType: channelType,
      channelUrl: channelUrl,
      userIds: userIds,
    ));
  }

  /// Remove operators from the channel.
  /// See [https://docs.sendbird.com/platform/user_type#3_operator](https://docs.sendbird.com/platform/user_type#3_operator) for the explanations on the operators.
  Future<void> removeOperators(List<String> userIds) async {
    sbLog.i(StackTrace.current, 'userIds: $userIds');

    if (userIds.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(ChannelOperatorsRemoveRequest(
      chat,
      channelType: channelType,
      channelUrl: channelUrl,
      userIds: userIds,
    ));
  }

  /// Remove all operators from the channel.
  /// See [https://docs.sendbird.com/platform/user_type#3_operator](https://docs.sendbird.com/platform/user_type#3_operator) for the explanations on the operators.
  Future<void> removeAllOperators() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(ChannelOperatorsRemoveRequest(
      chat,
      channelType: channelType,
      channelUrl: channelUrl,
      removeAll: true,
    ));
  }
}
