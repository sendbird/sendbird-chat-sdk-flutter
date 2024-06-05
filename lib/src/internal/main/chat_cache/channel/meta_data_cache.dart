// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class _CachedData<T> {
  T value;
  int timestamp;

  _CachedData({
    required this.value,
    this.timestamp = 0,
  });
}

class MetaDataCache<T> implements Cacheable {
  ChannelType _channelType;
  String _channelUrl;
  Map<String, _CachedData<T>> _cachedDataMap = {};

  MetaDataCache({
    required ChannelType channelType,
    required String channelUrl,
    Map<String, T> data = const {},
    int? timestamp,
  })  : _channelType = channelType,
        _channelUrl = channelUrl {
    data.forEach((key, value) {
      final data = _CachedData<T>(
        value: value,
        timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
      );
      _cachedDataMap[key] = data;
    });
  }

  @override
  bool dirty = false;

  @override
  void copyWith(dynamic other) {
    _channelType = other._channelType;
    _channelUrl = other._channelUrl;
    _cachedDataMap = other._cachedDataMap;
  }

  @override
  String get key => '';

  @override
  String get primaryKey => _channelUrl;

  T? getWithKey(String key) {
    final data = _cachedDataMap[key];
    if (data == null) return null;
    return data.value;
  }

  Map<String, T?> getWithKeys(List<String> keys) {
    if (keys.isEmpty) return {};
    return {for (final key in keys) key: getWithKey(key)};
  }

  Map<String, T> getAll() {
    final cached = <String, T>{};
    for (final key in _cachedDataMap.keys) {
      final value = getWithKey(key);
      if (value != null) {
        cached[key] = value;
      }
    }
    return cached;
  }

  void addWithKey(String key, T value, int ts) {
    if (value == null) return;
    final existData = _cachedDataMap[key];
    if (existData == null) {
      final newData = _CachedData<T>(value: value, timestamp: ts);
      _cachedDataMap[key] = newData;
    } else if (existData.timestamp < ts) {
      existData.value = value;
      existData.timestamp = ts;
    }
  }

  void addMap(Map<String, T> dataMap, int? ts) {
    if (dataMap.isEmpty) return;
    final time = ts ?? DateTime.now().millisecondsSinceEpoch;
    dataMap.forEach((k, v) => addWithKey(k, v, time));
  }

  void removeWithKey(String key, int? ts) {
    final existData = _cachedDataMap[key];
    final time = ts ?? DateTime.now().millisecondsSinceEpoch;
    if (existData != null && existData.timestamp < time) {
      _cachedDataMap.remove(key);
    }
  }

  void removeWithKeys(List<String> keys, int? ts) {
    if (keys.isEmpty) return;
    for (final k in keys) {
      removeWithKey(k, ts);
    }
  }

  void removeAll(int ts) {
    removeWithKeys(_cachedDataMap.keys.toList(), ts);
  }

  void clear() {
    _cachedDataMap.clear();
  }

  void merge(MetaDataCache<T> others) {
    others._cachedDataMap.forEach((k, v) {
      addWithKey(k, v.value, v.timestamp);
    });
  }
}
