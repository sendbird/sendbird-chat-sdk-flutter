// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/meta_data_cache.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/delivery_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/read_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/typing_status.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';

class ChannelCacheUnit implements CacheUnit {
  BaseChannel? channel;
  DeliveryStatus? deliveryStatus;
  Map<String, TypingStatus> typingStatusMap = {}; // userId key
  Map<String, ReadStatus> readStatusMap = {}; // userId key
  MetaDataCache<String>? _metaDataCache;

  @override
  void insert(Cacheable data) {
    if (data is BaseChannel) {
      if (channel != null) {
        channel?.copyWith(data);
      } else {
        channel = data;
      }
    } else if (data is ReadStatus) {
      final existData = readStatusMap[data.key];
      if (existData != null) {
        existData.copyWith(data);
      } else {
        readStatusMap[data.key] = data;
      }
    } else if (data is DeliveryStatus) {
      if (deliveryStatus != null) {
        deliveryStatus!.copyWith(data);
      } else {
        deliveryStatus = data;
      }
    } else if (data is TypingStatus) {
      final existData = typingStatusMap[data.key];
      if (existData != null) {
        existData.copyWith(data);
      } else {
        typingStatusMap[data.key] = data;
      }

      data.setTypingTimer();
    } else if (data is MetaDataCache<String>) {
      if (_metaDataCache != null) {
        _metaDataCache?.merge(data);
      } else {
        _metaDataCache = data;
      }
    }
  }

  @override
  void delete<T extends Cacheable>({String? key, Cacheable? data}) {
    if (data is ReadStatus) {
      readStatusMap.remove(key);
    } else if (data is DeliveryStatus) {
      deliveryStatus = null;
    } else if (data is TypingStatus) {
      typingStatusMap.remove(key);
      data.cancelTypingTimer();
    } else if (data is MetaDataCache) {
      _metaDataCache = null;
    }
    // channel should be delete itself
  }

  @override
  T? find<T extends Cacheable>({String? key}) {
    if (T == BaseChannel ||
        T == GroupChannel ||
        T == OpenChannel ||
        T == FeedChannel) {
      return channel as T?;
    } else if (T == ReadStatus) {
      return readStatusMap[key] as T?;
    } else if (T == DeliveryStatus) {
      return deliveryStatus as T?;
    } else if (T == TypingStatus) {
      return typingStatusMap[key] as T?;
    } else if (T == MetaDataCache) {
      return _metaDataCache as T?;
    }
    return null;
  }

  @override
  void markAsDirty() {
    channel?.dirty = true;
    deliveryStatus?.dirty = true;
    for (final element in readStatusMap.values) {
      element.dirty = true;
    }
  }
}
