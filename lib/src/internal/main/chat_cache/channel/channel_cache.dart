// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_unit.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/delivery_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/read_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/typing_status.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';

class ChannelCache implements CacheStorage {
  Map<String, ChannelCacheUnit> _channelCacheMap = {};

  @override
  void insert({
    required String channelKey,
    required Cacheable data,
  }) {
    var unit = _channelCacheMap[channelKey];
    if (unit == null) {
      unit = ChannelCacheUnit();
      unit.insert(data);
      _channelCacheMap[channelKey] = unit;
    } else {
      unit.insert(data);
    }
  }

  @override
  void delete<T extends Cacheable>({
    required String channelKey,
    String? key,
    Cacheable? data,
  }) {
    final unit = _channelCacheMap[channelKey];
    if (unit != null && key != null) {
      unit.delete<T>(key: key, data: data);
    } else {
      _channelCacheMap.remove(channelKey);
    }
  }

  @override
  void deleteAll() {
    _channelCacheMap = {};
  }

  @override
  List<T>? findAll<T extends Cacheable>({String? channelKey}) {
    // find channels only support atm
    if (T == OpenChannel || T == GroupChannel) {
      return _channelCacheMap.values
          .where((e) => e.channel is T)
          .map((e) => e.channel as T)
          .toList();
    } else if (T == ReadStatus && channelKey != null) {
      return _channelCacheMap[channelKey]?.readStatusMap.values.toList()
          as List<T>;
    } else if (T == TypingStatus) {
      return _channelCacheMap[channelKey]?.typingStatusMap.values.toList()
          as List<T>;
    } else if (T == DeliveryStatus) {
      return [_channelCacheMap[channelKey]?.deliveryStatus] as List<T>;
    }
    return null;
  }

  @override
  T? find<T extends Cacheable>({
    required String? channelKey,
    String? key,
  }) {
    final unit = _channelCacheMap[channelKey];
    return unit?.find<T>(key: key);
  }

  @override
  void markAsDirtyAll() {
    for (final element in _channelCacheMap.values) {
      element.markAsDirty(); // Check
    }
  }

  void cleanUp() {
    deleteAll();
  }
}
