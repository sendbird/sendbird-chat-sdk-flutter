// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'base_channel.dart';

/// BaseChannelMetaData
extension BaseChannelMetaData on BaseChannel {
  /// Creates meta data. This can be used to customize the channel.
  Future<Map<String, String>> createMetaData(
    Map<String, String> metaData,
  ) async {
    sbLog.i(StackTrace.current, 'metaData: $metaData');
    checkUnsupportedAction();

    if (metaData.isEmpty) {
      throw InvalidParameterException();
    }

    final result = await chat.apiClient.send<MetaDataResponse>(
      ChannelMetaDataCreateRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        metaData: metaData,
      ),
    );

    final cached =
        chat.channelCache.find<MetaDataCache>(channelKey: channelUrl) ??
            MetaDataCache<String>(
              channelType: channelType,
              channelUrl: channelUrl,
              timestamp: result.ts,
            );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache(chat);

    return result.metadata;
  }

  /// Gets meta data.
  Future<Map<String, String>> getMetaData(List<String> keys) async {
    sbLog.i(StackTrace.current, 'keys: $keys');
    checkUnsupportedAction();

    if (keys.isEmpty) {
      throw InvalidParameterException();
    }

    final result = await chat.apiClient.send<MetaDataResponse>(
      ChannelMetaDataGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        keys: keys,
      ),
    );

    final cached =
        chat.channelCache.find<MetaDataCache>(channelKey: channelUrl) ??
            MetaDataCache<String>(
              channelType: channelType,
              channelUrl: channelUrl,
              timestamp: result.ts,
            );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache(chat);

    return result.metadata;
  }

  /// Gets all meta data.
  Future<Map<String, String>> getAllMetaData() async {
    sbLog.i(StackTrace.current);
    checkUnsupportedAction();

    final result = await chat.apiClient.send<MetaDataResponse>(
      ChannelMetaDataGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
      ),
    );

    final cached =
        chat.channelCache.find<MetaDataCache>(channelKey: channelUrl) ??
            MetaDataCache<String>(
              channelType: channelType,
              channelUrl: channelUrl,
              timestamp: result.ts,
            );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache(chat);

    return result.metadata;
  }

  /// Updates meta data.
  Future<Map<String, String>> updateMetaData(
      Map<String, String> metaData) async {
    sbLog.i(StackTrace.current, 'metaData: $metaData');
    checkUnsupportedAction();

    if (metaData.isEmpty) {
      throw InvalidParameterException();
    }

    final result = await chat.apiClient.send<MetaDataResponse>(
      ChannelMetaDataUpdateRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        metaData: metaData,
      ),
    );

    final cached =
        chat.channelCache.find<MetaDataCache>(channelKey: channelUrl) ??
            MetaDataCache<String>(
              channelType: channelType,
              channelUrl: channelUrl,
              timestamp: result.ts,
            );
    cached.addMap(result.metadata, result.ts);
    cached.saveToCache(chat);

    return result.metadata;
  }

  /// Deletes a meta data.
  Future<void> deleteMetaData(String key) async {
    sbLog.i(StackTrace.current, 'key: $key');
    checkUnsupportedAction();

    if (key.isEmpty) {
      throw InvalidParameterException();
    }

    final ts = await chat.apiClient.send<int>(
      ChannelMetaDataDeleteRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        key: key,
      ),
    );

    final cached =
        chat.channelCache.find<MetaDataCache>(channelKey: channelUrl) ??
            MetaDataCache<String>(
              channelType: channelType,
              channelUrl: channelUrl,
              timestamp: ts,
            );
    cached.removeWithKey(key, ts);
    cached.saveToCache(chat);
  }

  /// Deletes all meta data.
  Future<void> deleteAllMetaData() async {
    sbLog.i(StackTrace.current);
    checkUnsupportedAction();

    final ts = await chat.apiClient.send<int>(
      ChannelMetaDataDeleteAllRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
      ),
    );

    final cached =
        chat.channelCache.find<MetaDataCache>(channelKey: channelUrl) ??
            MetaDataCache<String>(
              channelType: channelType,
              channelUrl: channelUrl,
              timestamp: ts,
            );
    cached.removeAll(ts);
    cached.saveToCache(chat);
  }

  /// All locally cached metadata as a map.
  /// Cached metadata is updated under following circumstances:
  ///
  ///  [getAllMetaData] returned successfully
  ///  [deleteMetaData] returned successfully
  ///  [deleteAllMetaData] returned successfully
  ///  [updateMetaData] returned successfully
  ///  [BaseChannelHandler.onMetaDataCreated] is called
  ///  [BaseChannelHandler.onMetaDataUpdated] is called
  ///  [BaseChannelHandler.onMetaDataDeleted] is called
  ///
  /// Please note that this method only caches values available in above methods.
  /// If [getAllMetaData] is never called on this instance, the map returned
  /// by this method may not contain all metadata mappings.
  Map<String, String> getCachedMetaData() {
    sbLog.i(StackTrace.current);
    checkUnsupportedAction();

    final metaData = chat.channelCache
            .find<MetaDataCache>(channelKey: channelUrl)
            ?.getAll() ??
        {};
    return Map<String, String>.from(metaData);
  }
}
