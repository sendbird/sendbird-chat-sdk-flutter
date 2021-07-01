import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

abstract class CacheStorage {
  void insert({required Cacheable data, required String channelKey});
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
  List<T>? findAll<T extends Cacheable>({String? channelKey});
  void markAsDirtyAll();
}

abstract class CacheUnit {
  T? find<T extends Cacheable>({required String key});
  void delete<T extends Cacheable>({String? key});
  void insert(Cacheable data);
  void markAsDirty();
}

abstract class Cacheable {
  String get key;
  String get primaryKey;
  bool dirty = false;
  void copyWith(others);
}

extension Operation on Cacheable {
  void removeFromCache() {
    final sdk = SendbirdSdk().getInternal();
    final cacheKey = this is BaseChannel ? null : key;
    sdk.cache.delete(channelKey: primaryKey, key: cacheKey, data: this);
  }

  void saveToCache() {
    final sdk = SendbirdSdk().getInternal();
    sdk.cache.insert(data: this, channelKey: primaryKey);
  }
}
