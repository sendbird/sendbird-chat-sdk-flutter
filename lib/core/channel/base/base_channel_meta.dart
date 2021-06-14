part of 'base_channel.dart';

/// Set of functionality related to meta
extension Meta on BaseChannel {
  /// Creates meta data on this channel with [metaData].
  ///
  /// It returns [Map<String, String>] that newly created. Once it completes
  /// successfully, channel event [ChannelEventHandler.onMetaDataCreated]
  /// will be invoked.
  Future<Map<String, String>> createMetaData(
      Map<String, String> metaData) async {
    if (metaData.isEmpty) {
      throw InvalidParameterError();
    }

    final result = await _sdk.api.createChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      metaData: metaData,
    );

    final cached = _sdk.cache.find<CachedDataMap>(channelKey: channelUrl) ??
        CachedDataMap<String>(
          channelType: channelType,
          channelUrl: channelUrl,
          timestamp: result.ts,
        );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache();

    return result.metadata;
  }

  /// Retrieves meta data from this channel with [keys].
  Future<Map<String, String>> getMetaData(List<String> keys) async {
    if (keys.isEmpty) {
      throw InvalidParameterError();
    }

    final result = await _sdk.api.getChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      keys: keys,
    );

    final cached = _sdk.cache.find<CachedDataMap>(channelKey: channelUrl) ??
        CachedDataMap<String>(
          channelType: channelType,
          channelUrl: channelUrl,
          timestamp: result.ts,
        );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache();

    return result.metadata;
  }

  /// Retrieves all metaData from this channel.
  Future<Map<String, String>> getAllMetaData() async {
    final result = await _sdk.api.getChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
    );

    final cached = _sdk.cache.find<CachedDataMap>(channelKey: channelUrl) ??
        CachedDataMap<String>(
          channelType: channelType,
          channelUrl: channelUrl,
          timestamp: result.ts,
        );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache();

    return result.metadata;
  }

  /// Updates meta data on this channel with [metaData].
  ///
  /// It returns [Map<String, String>] that newly updated. Once it completes
  /// successfully, channel event [ChannelEventHandler.onMetaDataUpdated]
  /// will be invoked.
  Future<Map<String, String>> updateMetaData(
      Map<String, String> metaData) async {
    if (metaData.isEmpty) {
      throw InvalidParameterError();
    }

    final result = await _sdk.api.updateChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      metaData: metaData,
    );

    final cached = _sdk.cache.find<CachedDataMap>(channelKey: channelUrl) ??
        CachedDataMap<String>(
          channelType: channelType,
          channelUrl: channelUrl,
          timestamp: result.ts,
        );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache();

    return result.metadata;
  }

  /// Deletes a meta data on this channel with [key].
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onMetaDataDeleted] will be invoked.
  Future<void> deleteMetaData(String key) async {
    if (key.isEmpty) {
      throw InvalidParameterError();
    }

    final ts = await _sdk.api.deleteChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
      key: key,
    );

    final cached = _sdk.cache.find<CachedDataMap>(channelKey: channelUrl) ??
        CachedDataMap<String>(
          channelType: channelType,
          channelUrl: channelUrl,
          timestamp: ts,
        );
    cached.removeWithKey(key, ts);
    cached.saveToCache();
  }

  /// Deletes a meta data on this channel with [key].
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onMetaDataDeleted] will be invoked.
  Future<void> deleteAllMetaData() async {
    final ts = await _sdk.api.deleteAllChannelMetaData(
      channelType: channelType,
      channelUrl: channelUrl,
    );

    final cached = _sdk.cache.find<CachedDataMap>(channelKey: channelUrl) ??
        CachedDataMap<String>(
          channelType: channelType,
          channelUrl: channelUrl,
          timestamp: ts,
        );
    cached.removeAll(ts);
    cached.saveToCache();
  }

  /// Creates meta counters on this channel with [metaCounters].
  ///
  /// It returns [Map<String, String>] that newly created. Once it completes
  /// successfully, channel event
  /// [ChannelEventHandler.onMetaCountersCreated] will be invoked.
  Future<Map<String, int>> createMetaCounters(
      Map<String, int> metaCounters) async {
    if (metaCounters.isEmpty) {
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
    if (keys.isEmpty) {
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
  /// [ChannelEventHandler.onMetaCountersUpdated] will be
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
    if (metaCounters.isEmpty) {
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
  /// [ChannelEventHandler.onMetaCountersUpdated] will be
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
    if (metaCounters.isEmpty) {
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
  /// [ChannelEventHandler.onMetaCountersUpdated] will be
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
    if (metaCounters.isEmpty) {
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
    if (key.isEmpty) {
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
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (metaArrays.isEmpty) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.add, true);

    try {
      var result = await _sdk.cmdManager.sendCommand(cmd);
      if (result != null) {
        return BaseMessage.msgFromJson(result.payload, type: result.cmd)!;
      } else {
        throw WebSocketError();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes [keys] from [MessageMetaArray] given [message].
  Future<BaseMessage> deleteMessageMetaArrayKeys(
    BaseMessage message,
    List<String> keys,
  ) async {
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (keys.isEmpty) {
      throw InvalidParameterError();
    }

    final metaArrays =
        keys.map((e) => MessageMetaArray(key: e, value: [])).toList();
    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.remove, false);

    try {
      var result = await _sdk.cmdManager.sendCommand(cmd);
      if (result != null) {
        return BaseMessage.msgFromJson(result.payload, type: result.cmd)!;
      } else {
        throw WebSocketError();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Removes values from list of [metaArrays] with given [message]
  Future<BaseMessage> removeMessageMetaArray(
    BaseMessage message,
    List<MessageMetaArray> metaArrays,
  ) async {
    if (message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (metaArrays.isEmpty) {
      throw InvalidParameterError();
    }

    final cmd = Command.buildUpdateMessageMetaArray(
        message, metaArrays, MetaArrayUpdateMode.remove, true);

    try {
      var result = await _sdk.cmdManager.sendCommand(cmd);
      if (result != null) {
        return BaseMessage.msgFromJson(result.payload, type: result.cmd)!;
      } else {
        throw WebSocketError();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Returns cached meta data
  ///
  /// This meta data is cached by any of create / update / delete operations
  /// and channel query with `includeMetaData`
  Map<String, String> getCachedMetaData() {
    final metaData =
        _sdk.cache.find<CachedDataMap>(channelKey: channelUrl)?.getAll() ?? {};
    return Map<String, String>.from(metaData);
  }
}
