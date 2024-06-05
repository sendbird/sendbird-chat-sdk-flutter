// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/meta_data_cache.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/delivery_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/read_status.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';

extension JsonCacheUtils on Map<String, dynamic> {
  void cacheMetaData({required BaseChannel channel, int? ts}) {
    if (this['metadata'] != null) {
      final data = Map<String, String>.from(this['metadata']);
      final metaData = MetaDataCache<String>(
        channelType: channel.channelType,
        channelUrl: channel.channelUrl,
        data: data,
        timestamp: ts ?? DateTime.now().millisecondsSinceEpoch,
      );
      metaData.saveToCache(channel.chat);
    }
  }

  void cacheReadStatus(BaseChannel channel) {
    if (this['read_receipt'] != null) {
      final data = Map<String, int>.from(this['read_receipt']);
      data.forEach((key, value) {
        final readStatus = ReadStatus(
          channelType: channel.channelType,
          channelUrl: channel.channelUrl,
          userId: key,
          timestamp: value,
        );
        readStatus.saveToCache(channel.chat);
      });
    }
  }

  void cacheDeliveryStatus(BaseChannel channel) {
    if (this['delivery_receipt'] != null) {
      final deliveryStatus = DeliveryStatus(
        channelUrl: channel.channelUrl,
        updatedDeliveryStatus: Map<String, int>.from(this['delivery_receipt']),
      );
      deliveryStatus.saveToCache(channel.chat);
    }
  }
}
