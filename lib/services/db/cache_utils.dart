import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/features/delivery/delivery_status.dart';
import 'package:sendbird_sdk/features/delivery/read_status.dart';
import 'package:sendbird_sdk/services/db/cached_meta_data/cached_data_map.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';

extension JsonCacheUtils on Map<String, dynamic> {
  void cacheMetaData({required BaseChannel channel, int? ts}) {
    if (this['metadata'] != null) {
      final data = Map<String, String>.from(this['metadata']);
      final metaData = CachedDataMap<String>(
        channelType: channel.channelType,
        channelUrl: channel.channelUrl,
        data: data,
        timestamp: ts ?? DateTime.now().millisecondsSinceEpoch,
      );
      metaData.saveToCache();
    }
  }

  void cacheReadReceipt(BaseChannel channel) {
    if (this['read_receipt'] != null) {
      final data = Map<String, int>.from(this['read_receipt']);
      data.forEach((key, value) {
        final status = ReadStatus(
          channelType: channel.channelType,
          channelUrl: channel.channelUrl,
          userId: key,
          timestamp: value,
        );
        status.saveToCache();
      });
    }
  }

  void cacheDeliveryReceipt(BaseChannel channel) {
    if (this['delivery_receipt'] != null) {
      final status = DeliveryStatus(
        channelUrl: channel.channelUrl,
        updatedDeliveryReceipt: Map<String, int>.from(this['delivery_receipt']),
      );
      status.saveToCache();
    }
  }
}
