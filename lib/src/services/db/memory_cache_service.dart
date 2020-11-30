import 'package:flutter/foundation.dart';

import '../../channel/base_channel.dart';
import '../../channel/group_channel.dart';
import '../../channel/open_channel.dart';
import '../../features/delivery/delivery_status.dart';
import '../../features/read/read_status.dart';
import '../../features/typing/typing_status.dart';

import 'cache_service.dart';

class MemoryCacheStorage implements CacheStorage {
  Map<String, ChannelCacheUnit> _cacheMap = {};

  @override
  List<T> findAll<T extends Cacheable>({String channelKey}) {
    //find channels only support atm
    if (T == OpenChannel || T == GroupChannel) {
      return _cacheMap.values.map((e) => e.channel as T).toList();
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
  void delete<T extends Cacheable>({@required String channelKey, String key}) {
    final unit = _cacheMap[channelKey];
    if (key != null) {
      unit.delete<T>(key: key);
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

  @override
  void delete<T extends Cacheable>({String key}) {
    if (T == DeliveryStatus) {
      deliveryStatus = null;
    } else if (T == TypingStatus) {
      if (key == null)
        typingStatus = null;
      else
        typingStatus?.remove(key);
    } else if (T == ReadStatus) {
      if (key == null)
        readStatus = null;
      else
        readStatus?.remove(key);
    } //channel should be delete itself
  }

  @override
  void insert(Cacheable data) {
    if (data is GroupChannel || data is OpenChannel) {
      if (channel != null)
        channel.copyWith(data);
      else
        channel = data;
    } else if (data is ReadStatus || data is TypingStatus) {
      final existData =
          data is ReadStatus ? readStatus[data.key] : typingStatus[data.key];
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
