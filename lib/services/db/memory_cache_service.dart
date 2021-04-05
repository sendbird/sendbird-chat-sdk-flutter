import 'package:flutter/foundation.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/features/delivery_status.dart';
import 'package:sendbird_sdk/core/channel/group/features/read_status.dart';
import 'package:sendbird_sdk/core/channel/group/features/typing_status.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/services/db/cached_meta_data/cached_data_map.dart';

class MemoryCacheStorage implements CacheStorage {
  Map<String, ChannelCacheUnit> _cacheMap = {};

  @override
  List<T> findAll<T extends Cacheable>({String channelKey}) {
    //find channels only support atm
    if (T == OpenChannel || T == GroupChannel) {
      return _cacheMap.values
          .where((e) => e.channel is T)
          .map((e) => e.channel as T)
          .toList();
    } else if (T == ReadStatus) {
      return _cacheMap[channelKey].readStatus.values.toList() as List<T>;
    } else if (T == TypingStatus) {
      return _cacheMap[channelKey].typingStatus.values.toList() as List<T>;
    } else if (T == DeliveryStatus) {
      return [_cacheMap[channelKey].deliveryStatus] as List<T>;
    }
    return null;
  }

  @override
  void insert({@required Cacheable data, @required String channelKey}) {
    var unit = _cacheMap[channelKey];
    if (unit == null) {
      unit = ChannelCacheUnit();
      unit.insert(data);
      _cacheMap[channelKey] = unit;
    } else {
      unit.insert(data);
    }
  }

  @override
  void delete<T extends Cacheable>(
      {@required String channelKey, String key, Cacheable data}) {
    final unit = _cacheMap[channelKey];
    if (key != null) {
      unit.delete<T>(key: key, data: data);
    } else {
      _cacheMap.remove(channelKey);
    }
  }

  @override
  void deleteAll() {
    _cacheMap = {};
  }

  @override
  T find<T extends Cacheable>({@required String channelKey, String key}) {
    final unit = _cacheMap[channelKey];
    return unit?.find<T>(key: key);
  }

  @override
  void markAsDirtyAll() {
    _cacheMap.values.forEach((element) {});
  }
}

class ChannelCacheUnit implements CacheUnit {
  BaseChannel channel;
  DeliveryStatus deliveryStatus;
  Map<String, TypingStatus> typingStatus = {}; //userid key
  Map<String, ReadStatus> readStatus = {}; //userid key
  CachedDataMap<String> cachedMetaData;

  @override
  void delete<T extends Cacheable>({String key, Cacheable data}) {
    if (T == DeliveryStatus || data is DeliveryStatus) {
      deliveryStatus = null;
    } else if (T == TypingStatus || data is TypingStatus) {
      typingStatus?.remove(key);
    } else if (T == ReadStatus || data is ReadStatus) {
      readStatus?.remove(key);
    } else if (T == CachedDataMap || data is CachedDataMap) {
      cachedMetaData = null;
    }

    //channel should be delete itself
  }

  @override
  void insert(Cacheable data) {
    if (data is GroupChannel || data is OpenChannel) {
      if (channel != null)
        channel.copyWith(data);
      else
        channel = data;
    } else if (data is ReadStatus) {
      final existData = readStatus[data.key];
      if (existData != null) {
        existData.copyWith(data);
      } else {
        readStatus[data.key] = data;
      }
    } else if (data is DeliveryStatus) {
      if (deliveryStatus != null)
        deliveryStatus.copyWith(data);
      else
        deliveryStatus = data;
    } else if (data is TypingStatus) {
      final existData = typingStatus[data.key];
      if (existData != null) {
        existData.copyWith(data);
      } else {
        typingStatus[data.key] = data;
      }
    } else if (data is CachedDataMap) {
      if (cachedMetaData != null) {
        cachedMetaData.merge(data);
      } else {
        cachedMetaData = data;
      }
    }
  }

  @override
  Cacheable find<T extends Cacheable>({String key}) {
    if (T == GroupChannel || T == OpenChannel) {
      return channel;
    } else if (T == ReadStatus) {
      return readStatus != null ? readStatus[key] : null;
    } else if (T == TypingStatus) {
      return typingStatus != null ? typingStatus[key] : null;
    } else if (T == DeliveryStatus) {
      return deliveryStatus;
    } else if (T == CachedDataMap) {
      return cachedMetaData;
    }
    return null;
  }

  @override
  void markAsDirty() {
    channel.dirty = true;
    deliveryStatus.dirty = true;
    readStatus.values.forEach((element) => element.dirty = true);
  }
}
