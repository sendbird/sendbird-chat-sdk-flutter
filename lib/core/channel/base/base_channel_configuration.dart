part of 'base_channel.dart';

/// Set of functionality related to configure channel
extension BaseChannelConfiguration on BaseChannel {
  /// Adds operators on this channel with given [userIds].
  ///
  /// After this method completes sucessfully, channel event
  /// [ChannelEventHandler.onChannelOperatorsUpdated] will be invoked.
  /// Operator only
  Future<void> addOperators(List<String> userIds) async {
    if (userIds.isEmpty) {
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
    if (userIds.isEmpty) {
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
}
