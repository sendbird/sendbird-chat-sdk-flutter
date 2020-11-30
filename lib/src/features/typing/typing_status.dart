import '../../constant/enums.dart';
import '../../models/user.dart';
import '../../services/db/cache_service.dart';

class TypingStatus implements Cacheable {
  ChannelType channelType;
  String channelUrl;
  User user;
  int timestamp;

  bool dirty = false;

  TypingStatus({
    this.channelType,
    this.channelUrl,
    this.user,
    this.timestamp,
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
