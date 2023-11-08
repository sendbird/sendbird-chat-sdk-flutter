// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';

abstract class CacheStorage {
  void insert({
    required String channelKey,
    required Cacheable data,
  });

  void delete<T extends Cacheable>({
    required String channelKey,
    String? key,
    Cacheable? data,
  });

  void deleteAll();

  T? find<T extends Cacheable>({
    required String channelKey,
    required String key,
  });

  List<T>? findAll<T extends Cacheable>({
    String? channelKey,
  });

  void markAsDirtyAll();
}

abstract class CacheUnit {
  void insert(Cacheable data);

  void delete<T extends Cacheable>({String? key});

  T? find<T extends Cacheable>({required String key});

  void markAsDirty();
}

abstract class Cacheable {
  String get primaryKey;
  String get key;
  bool dirty = false;

  void copyWith(dynamic other);
}

extension Operation on Cacheable {
  void saveToCache(Chat chat) {
    chat.channelCache.insert(channelKey: primaryKey, data: this);
  }

  void removeFromCache(Chat chat) {
    final cacheKey = this is BaseChannel ? null : key;
    chat.channelCache.delete(channelKey: primaryKey, key: cacheKey, data: this);
  }
}
