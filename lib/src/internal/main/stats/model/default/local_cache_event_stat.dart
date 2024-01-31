// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';

class LocalCacheEventStat extends DefaultStat {
  final String channelUrl;
  final int startingPoint;
  final LocalCacheEventMeasuredOn measuredOn;
  final LocalCacheEvent event;
  final int maxDbSize;
  final String messageInitPolicy; // always 'cache_and_replace_by_api'
  final bool useLocalCache; // always true
  final String collectionId;

  LocalCacheEventStat({
    required int ts,
    required this.channelUrl,
    required this.startingPoint,
    required this.measuredOn,
    required this.event,
    required this.maxDbSize,
    required this.messageInitPolicy,
    required this.useLocalCache,
    required this.collectionId,
  }) : super(StatType.featureLocalCacheEvent, ts);

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'channel_url': channelUrl,
      'starting_point': startingPoint,
      'measured_on': StatUtils.getLocalCacheEventMeasuredOnString(measuredOn),
      'event': StatUtils.getLocalCacheEventString(event),
      'max_db_size': maxDbSize,
      'message_init_policy': messageInitPolicy,
      'use_local_cache': useLocalCache,
      'collection_id': collectionId,
    };
    final result = super.toJson();
    result['data'] = json;
    return result;
  }

  // {
  //   'stat_type': 'feature:local_cache_event',
  //   'ts': DEVICE_TIMESTAMP,
  //   'data': {
  //     'channel_url': CHANNEL_URL,
  //     'starting_point': STARTING_POINT,
  //     'measured_on': 'initial_load'/'load_next'/'load_prev'/'gap_check'/'back_sync'
  //     'event': 'cache_miss'/'cache_hit'/'cache_fetch',
  //     'max_db_size': MAX_DB_SIZE in MB,
  //     'message_init_policy': 'cache_and_replace_by_api',
  //     'use_local_cache': true/false,
  //     'collection_id': RANDOM_COLLECTION_ID_STRING, // value used internally
  //   }
  // }
  static LocalCacheEventStat? fromJson({
    required int ts,
    required Map<String, dynamic> data,
  }) {
    try {
      final String? channelUrl = data['channel_url'] as String?;
      final int? startingPoint = data['starting_point'] as int?;
      final String? measuredOnString = data['measured_on'] as String?;
      final String? eventString = data['event'] as String?;
      final int? maxDbSize = data['max_db_size'] as int?;
      final String? messageInitPolicy = data['message_init_policy'] as String?;
      final bool? useLocalCache = data['use_local_cache'] as bool?;
      final String? collectionId = data['collection_id'] as String?;

      final measuredOn = measuredOnString != null
          ? StatUtils.getLocalCacheEventMeasuredOn(measuredOnString)
          : null;
      final event = eventString != null
          ? StatUtils.getLocalCacheEvent(eventString)
          : null;

      if (channelUrl == null ||
          startingPoint == null ||
          measuredOn == null ||
          event == null ||
          maxDbSize == null ||
          messageInitPolicy == null ||
          useLocalCache == null ||
          collectionId == null) {
        return null;
      }

      return LocalCacheEventStat(
        ts: ts,
        channelUrl: channelUrl,
        startingPoint: startingPoint,
        measuredOn: measuredOn,
        event: event,
        maxDbSize: maxDbSize,
        messageInitPolicy: messageInitPolicy,
        useLocalCache: useLocalCache,
        collectionId: collectionId,
      );
    } catch (e) {
      sbLog.d(StackTrace.current, 'e: ${e.toString()}');
    }
    return null;
  }
}

enum LocalCacheEventMeasuredOn {
  initialLoad,
  loadPrev,
  loadNext,
}

enum LocalCacheEvent {
  cacheMiss,
  cacheHit,
}
