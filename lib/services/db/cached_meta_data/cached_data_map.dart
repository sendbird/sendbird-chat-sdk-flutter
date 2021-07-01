import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/services/db/cached_meta_data/cached_data.dart';
import 'package:sendbird_sdk/services/db/policy.dart';

class CachedDataMap<T> implements Cacheable, Evictable {
  ChannelType _channelType;
  String _channelUrl;

  @override
  late EvictionPolicy policy;

  Map<String, CachedData<T>> _cachedDataMap = {};

  CachedDataMap({
    required ChannelType channelType,
    required String channelUrl,
    Map<String, T> data = const {},
    int? timestamp,
  })  : _channelType = channelType,
        _channelUrl = channelUrl {
    policy = PeriodEviction(periodInSeconds: 180, evict: evict);

    data.forEach((key, value) {
      final data = CachedData<T>(
        value: value,
        ts: timestamp ?? DateTime.now().millisecondsSinceEpoch,
      );
      _cachedDataMap[key] = data;
    });
  }

  @override
  void evict() {
    final keys = _cachedDataMap.keys.toList();
    keys.forEach((key) {
      final data = _cachedDataMap[key]!;
      final diff = DateTime.now().millisecondsSinceEpoch - data.ts;
      if (data.isRemoved && diff > 180) _cachedDataMap.remove(key);
    });
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

  void addWithKey(String key, T value, int ts) {
    if (value == null) return;
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

  void addMap(Map<String, T> dataMap, int? ts) {
    if (dataMap.isEmpty) return;
    final time = ts ?? DateTime.now().millisecondsSinceEpoch;
    dataMap.forEach((k, v) => addWithKey(k, v, time));
  }

  void removeWithKey(String key, int? ts) {
    final existData = _cachedDataMap[key];
    final time = ts ?? DateTime.now().millisecondsSinceEpoch;
    if (existData != null && existData.ts < time) {
      existData
        ..isRemoved = true
        ..ts = time;
    }

    if (_cachedDataMap.isEmpty) (policy as PeriodEviction).stop();
  }

  void removeWithKeys(List<String> keys, int? ts) {
    if (keys.isEmpty) return;
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
