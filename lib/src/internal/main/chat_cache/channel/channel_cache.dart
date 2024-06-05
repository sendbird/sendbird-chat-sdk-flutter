// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_unit.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/meta_data_cache.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/delivery_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/read_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/typing_status.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class ChannelCache implements CacheStorage {
  final Map<String, ChannelCacheUnit> _channelCacheMap = {};

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
    _channelCacheMap.clear();
  }

  @override
  List<T>? findAll<T extends Cacheable>({String? channelKey}) {
    if (T is BaseChannel) {
      return _channelCacheMap.values
          .where((e) => e.channel is T)
          .map((e) => e.channel as T)
          .toList();
    } else if (T == TypingStatus && channelKey != null) {
      return _channelCacheMap[channelKey]?.typingStatusMap.values.toList()
          as List<T>?;
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

  Map<String, String> getCachedMetaData(String channelUrl) {
    final metaData =
        find<MetaDataCache>(channelKey: channelUrl)?.getAll() ?? {};
    return Map<String, String>.from(metaData);
  }

  void setCachedMetaData(
    String channelUrl,
    Map<String, String> metaData,
  ) {
    final metaDataCache = _channelCacheMap[channelUrl]?.metaDataCache;
    if (metaDataCache != null) {
      metaDataCache.clear();
      metaDataCache.addMap(metaData, null);
    }
  }

  Map<String, int> getCachedReadStatus(String channelUrl) {
    final result = <String, int>{};
    final readStatusMap = _channelCacheMap[channelUrl]?.readStatusMap;
    if (readStatusMap != null) {
      for (final key in readStatusMap.keys) {
        result[key] = readStatusMap[key]?.timestamp ?? 0;
      }
    }
    return result;
  }

  void setCachedReadStatus(
    String channelUrl,
    Map<String, int> readStatus,
  ) {
    _channelCacheMap[channelUrl]?.readStatusMap.clear();

    for (final key in readStatus.keys) {
      final data = ReadStatus(
        userId: key,
        timestamp: readStatus[key] ?? 0,
        channelUrl: channelUrl,
        channelType: ChannelType.group,
      );
      insert(channelKey: channelUrl, data: data);
    }
  }

  Map<String, int> getCachedDeliveryStatus(String channelUrl) {
    final result =
        _channelCacheMap[channelUrl]?.deliveryStatus?.updatedDeliveryStatus ??
            {};
    return result;
  }

  void setCachedDeliveryStatus(
    String channelUrl,
    Map<String, int> deliveryStatus,
  ) {
    _channelCacheMap[channelUrl]?.deliveryStatus?.updatedDeliveryStatus.clear();

    insert(
      channelKey: channelUrl,
      data: DeliveryStatus(
          channelUrl: channelUrl, updatedDeliveryStatus: deliveryStatus),
    );
  }
}
