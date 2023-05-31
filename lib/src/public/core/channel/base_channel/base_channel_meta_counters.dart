// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'base_channel.dart';

/// BaseChannelMetaCounters
extension BaseChannelMetaCounters on BaseChannel {
  /// Creates meta counters. This can be used to customize the channel.
  Future<Map<String, int>> createMetaCounters(
      Map<String, int> metaCounters) async {
    sbLog.i(StackTrace.current, 'metaCounters: $metaCounters');

    if (metaCounters.isEmpty) {
      throw InvalidParameterException();
    }

    return await chat.apiClient.send(
      ChannelMetaCounterCreateRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        metaCounter: metaCounters,
      ),
    );
  }

  /// Gets meta counters.
  Future<Map<String, int>> getMetaCounters(List<String> keys) async {
    sbLog.i(StackTrace.current, 'keys: $keys');

    if (keys.isEmpty) {
      throw InvalidParameterException();
    }

    return await chat.apiClient.send(
      ChannelMetaCounterGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        keys: keys,
      ),
    );
  }

  /// Get all meta counters.
  Future<Map<String, int>> getAllMetaCounters() async {
    sbLog.i(StackTrace.current);

    return await chat.apiClient.send(
      ChannelMetaCounterGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
      ),
    );
  }

  /// Updates meta counters.
  Future<Map<String, int>> updateMetaCounters(
      Map<String, int> metaCounters) async {
    sbLog.i(StackTrace.current, 'metaCounters: $metaCounters');

    if (metaCounters.isEmpty) {
      throw InvalidParameterException();
    }

    return await chat.apiClient.send(
      ChannelMetaCounterUpdateRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        metaCounter: metaCounters,
        mode: UpdateMetaCounterMode.set,
      ),
    );
  }

  /// Increases meta counters.
  /// This increases atomically the keyed meta counter by the specified value.
  Future<Map<String, int>> increaseMetaCounters(
      Map<String, int> metaCounters) async {
    sbLog.i(StackTrace.current, 'metaCounters: $metaCounters');

    if (metaCounters.isEmpty) {
      throw InvalidParameterException();
    }

    return await chat.apiClient.send(
      ChannelMetaCounterUpdateRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        metaCounter: metaCounters,
        mode: UpdateMetaCounterMode.increase,
      ),
    );
  }

  /// Decreases meta counters.
  /// This decreases atomically the keyed meta counter by the specified value.
  Future<Map<String, int>> decreaseMetaCounters(
      Map<String, int> metaCounters) async {
    sbLog.i(StackTrace.current, 'metaCounters: $metaCounters');

    if (metaCounters.isEmpty) {
      throw InvalidParameterException();
    }

    return await chat.apiClient.send(
      ChannelMetaCounterUpdateRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        metaCounter: metaCounters,
        mode: UpdateMetaCounterMode.decrease,
      ),
    );
  }

  /// Deletes a meta counter.
  Future<void> deleteMetaCounters(String key) async {
    sbLog.i(StackTrace.current);

    if (key.isEmpty) {
      throw InvalidParameterException();
    }

    return await chat.apiClient.send(
      ChannelMetaCounterDeleteRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        key: key,
      ),
    );
  }

  /// Deletes all meta counters.
  Future<void> deleteAllMetaCounters() async {
    sbLog.i(StackTrace.current);

    return await chat.apiClient.send(
      ChannelMetaCounterDeleteAllRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
      ),
    );
  }
}

enum UpdateMetaCounterMode {
  set,
  increase,
  decrease,
}
