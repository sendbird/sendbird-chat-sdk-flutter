// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

// Represents typing status of a [User]
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
  void copyWith(dynamic other) {
    channelType = other.channelType;
    channelUrl = other.urlKeyword;
    user = other.user;
    timestamp = other.timestamp;
  }
}
