// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat/src/internal/main/chat_cache/policy.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

class _CachedData<T> {
  T value;
  bool isRemoved;
  int timestamp;

  _CachedData({
    required this.value,
    this.isRemoved = false,
    this.timestamp = 0,
  });
}

class MetaDataCache<T> implements Cacheable, Evictable {
  static const evictionDurationSec = 180;

  ChannelType _channelType;
  final String _channelUrl;

  @override
  late EvictionPolicy policy;

  final Map<String, _CachedData<T>> _cachedDataMap = {};

  MetaDataCache({
    required ChannelType channelType,
    required String channelUrl,
    Map<String, T> data = const {},
    int? timestamp,
  })  : _channelType = channelType,
        _channelUrl = channelUrl {
    policy = PeriodEviction(periodInSeconds: evictionDurationSec, evict: evict);

    data.forEach((key, value) {
      final data = _CachedData<T>(
        value: value,
        timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
      );
      _cachedDataMap[key] = data;
    });
  }

  @override
  void evict() {
    final keys = _cachedDataMap.keys.toList();
    for (final key in keys) {
      final data = _cachedDataMap[key]!;
      final diffMilliSec =
          DateTime.now().millisecondsSinceEpoch - data.timestamp;
      if (data.isRemoved && (diffMilliSec > evictionDurationSec * 1000)) {
        _cachedDataMap.remove(key);
      }
    }
  }

  @override
  bool dirty = false;

  @override
  void copyWith(others) {
    _channelType = others._channelType;
  }

  @override
  String get key => '';

  @override
  String get primaryKey => _channelUrl;

  T? getWithKey(String key) {
    final data = _cachedDataMap[key];
    if (data == null || data.isRemoved) return null;
    return data.value;
  }

  Map<String, T?> getWithKeys(List<String> keys) {
    if (keys.isEmpty) return {};
    return {for (var key in keys) key: getWithKey(key)};
  }

  Map<String, T> getAll() {
    final cached = <String, T>{};
    for (var key in _cachedDataMap.keys) {
      final validValue = getWithKey(key);
      if (validValue != null) cached[key] = validValue;
    }
    return cached;
  }

  void addWithKey(String key, T value, int timestamp) {
    if (value == null) return;
    final existData = _cachedDataMap[key];
    if (existData == null) {
      final newData = _CachedData<T>(value: value, timestamp: timestamp);
      _cachedDataMap[key] = newData;
    } else if (existData.timestamp < timestamp) {
      existData.value = value;
      existData.timestamp = timestamp;
    }

    if (_cachedDataMap.length == 1) (policy as PeriodEviction).start();
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
      existData
        ..isRemoved = true
        ..timestamp = time;
    }

    if (_cachedDataMap.isEmpty) (policy as PeriodEviction).stop();
  }

  void removeWithKeys(List<String> keys, int? ts) {
    if (keys.isEmpty) return;
    for (final k in keys) {
      removeWithKey(k, ts);
    }
  }

  void removeAll(int timestamp) {
    _cachedDataMap.forEach((k, v) {
      v.isRemoved = true;
      v.timestamp = timestamp;
    });

    (policy as PeriodEviction).stop();
  }

  void merge(MetaDataCache<T> others) {
    others._cachedDataMap.forEach((k, v) {
      addWithKey(k, v.value, v.timestamp);
    });
  }
}
