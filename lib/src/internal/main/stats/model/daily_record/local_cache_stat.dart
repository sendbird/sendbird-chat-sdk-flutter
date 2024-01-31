// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/daily_record/daily_record_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class CollectionInterfaceStat {
  bool? useGroupChannelCollection;
  bool? useMessageCollection;
}

class LocalCacheStat extends DailyRecordStat {
  bool useLocalCache;
  CollectionInterfaceStat? collectionInterfaceStat;

  LocalCacheStat({
    required int ts,
    required this.useLocalCache,
    this.collectionInterfaceStat,
  }) : super(StatType.featureLocalCache, ts);

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'use_local_cache': useLocalCache,
    };

    if (collectionInterfaceStat != null) {
      json['collection_interface'] = {
        if (collectionInterfaceStat?.useGroupChannelCollection != null)
          'group_channel': collectionInterfaceStat?.useGroupChannelCollection,
        if (collectionInterfaceStat?.useMessageCollection != null)
          'message': collectionInterfaceStat?.useMessageCollection,
      };
    }

    final result = super.toJson();
    result['data'] = json;
    return result;
  }

  // {
  //   'stat_type' : 'feature:local_cache',
  //   'ts': int, // timestamp for log creation,
  //   'data' : {
  //     'use_local_cache': bool
  //     'collection_interface' : { // optional
  //       'group_channel': bool?,
  //       'message': bool?,
  //       'message_init_policy': String?, // 'cache_and_replace_by_api'
  //     },
  //   },
  // }
  static LocalCacheStat? fromJson({
    required int ts,
    required Map<String, dynamic> data,
  }) {
    try {
      final bool? useLocalCache = data['use_local_cache'] as bool?;

      CollectionInterfaceStat? collectionInterfaceStat;
      final collectionInterfaceStatMap = data['collection_interface'];
      if (collectionInterfaceStatMap != null) {
        collectionInterfaceStat = CollectionInterfaceStat();
        collectionInterfaceStat.useGroupChannelCollection =
            collectionInterfaceStatMap['group_channel'] as bool?;
        collectionInterfaceStat.useMessageCollection =
            collectionInterfaceStatMap['message'] as bool?;
      }

      if (useLocalCache == null) {
        return null;
      }

      return LocalCacheStat(
        ts: ts,
        useLocalCache: useLocalCache,
        collectionInterfaceStat: collectionInterfaceStat,
      );
    } catch (e) {
      sbLog.d(StackTrace.current, 'e: ${e.toString()}');
    }
    return null;
  }

  @override
  void update(DailyRecordStat stat) {
    if (stat is! LocalCacheStat) {
      return;
    }

    useLocalCache = stat.useLocalCache;

    if (collectionInterfaceStat == null &&
        stat.collectionInterfaceStat == null) {
      return;
    }

    collectionInterfaceStat ??= CollectionInterfaceStat();

    collectionInterfaceStat!.useGroupChannelCollection =
        stat.collectionInterfaceStat?.useGroupChannelCollection ??
            collectionInterfaceStat?.useGroupChannelCollection;
    collectionInterfaceStat!.useMessageCollection =
        stat.collectionInterfaceStat?.useMessageCollection ??
            collectionInterfaceStat?.useMessageCollection;
  }
}
