import 'cached_data.dart';

import '../policy.dart';
import '../cache_service.dart';
import '../../../constant/enums.dart';

class CachedDataMap<T> implements Cacheable, Evictable {
  ChannelType _channelType;
  String _channelUrl;

  @override
  EvictionPolicy policy;

  Map<String, CachedData<T>> _cachedDataMap = {};

  CachedDataMap({
    ChannelType channelType,
    String channelUrl,
    Map<String, T> data = const {},
    int timestamp,
  })  : _channelType = channelType,
        _channelUrl = channelUrl {
    policy = PeriodEviction(periodInSeconds: 180, evict: evict);

    data.forEach((key, value) {
      final data = CachedData<T>()
        ..value = value
        ..ts = timestamp;
      _cachedDataMap[key] = data;
    });
  }

  @override
  void evict() {
    final keys = _cachedDataMap.keys.toList();
    keys.forEach((key) {
      final data = _cachedDataMap[key];
      final diff = DateTime.now().millisecondsSinceEpoch - data.ts;
      if (data.isRemoved && diff > 180) _cachedDataMap.remove(key);
    });
  }

  @override
  bool dirty;

  @override
  void copyWith(others) {
    _channelType = others._channelType;
  }

  @override
  String get key => null;

  @override
  String get primaryKey => _channelUrl;

  T getWithKey(String key) {
    if (key == null) return null;
    final data = _cachedDataMap[key];
    if (data == null || data.isRemoved) return null;
    return data.value;
  }

  Map<String, T> getWithKeys(List<String> keys) {
    if (keys == null || keys.isEmpty) return {};
    return {for (var key in keys) key: getWithKey(key)};
  }

  Map<String, T> getAll() {
    final cached = {for (var key in _cachedDataMap.keys) key: getWithKey(key)};
    cached.removeWhere((key, value) => value == null);
    return cached;
  }

  void addWithKey(String key, T value, int ts) {
    if (key == null || value == null) return;
    final existData = _cachedDataMap[key];
    if (existData == null) {
      final newData = CachedData<T>(value: value, ts: ts);
      _cachedDataMap[key] = newData;
    } else if (existData.ts < ts) {
      existData.value = value;
      existData.ts = ts;
    }

    if (_cachedDataMap.length == 1) (policy as PeriodEviction).start();
  }

  void addMap(Map<String, T> dataMap, int ts) {
    if (dataMap == null || dataMap.isEmpty) return;
    dataMap.forEach((k, v) => addWithKey(k, v, ts));
  }

  void removeWithKey(String key, int ts) {
    if (key == null) return;
    final existData = _cachedDataMap[key];
    if (existData != null && existData.ts < ts) {
      existData
        ..isRemoved = true
        ..ts = ts;
    }

    if (_cachedDataMap.isEmpty) (policy as PeriodEviction).stop();
  }

  void removeWithKeys(List<String> keys, int ts) {
    if (keys == null || keys.isEmpty) return;
    keys.forEach((k) => removeWithKey(k, ts));
  }

  void removeAll(int ts) {
    _cachedDataMap.forEach((k, v) {
      v.isRemoved = true;
      v.ts = ts;
    });

    (policy as PeriodEviction).stop();
  }

  void merge(CachedDataMap<T> others) {
    others._cachedDataMap.forEach((k, v) {
      addWithKey(k, v.value, v.ts);
    });
  }
}
