import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';

/// Represents typing status of a [User]
class TypingStatus implements Cacheable {
  ChannelType channelType;
  String channelUrl;
  User user;
  int timestamp;

  @override
  bool dirty = false;

  TypingStatus({
    required this.channelType,
    required this.channelUrl,
    required this.user,
    required this.timestamp,
  });

  @override
  String get primaryKey => channelUrl;

  @override
  String get key => user.userId;

  @override
  void copyWith(dynamic others) {
    channelType = others.channelType;
    channelUrl = others.channelUrl;
    user = others.user;
    timestamp = others.timestamp;
  }
}
