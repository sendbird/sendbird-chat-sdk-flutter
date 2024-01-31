// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class CBaseChannel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String channelUrl;

  @Index(composite: [CompositeIndex('channelUrl')])
  @enumerated
  late ChannelType channelType;

  late String name;
  int? createdAt;

  String? coverUrl;
  String? data;
  String? customType;
  bool? isFrozen;
  bool? isEphemeral;

  // Internal
  late bool fromCache;
  late bool dirty;

  CBaseChannel();

  factory CBaseChannel.fromBaseChannel(BaseChannel channel) {
    return CBaseChannel()..setBaseChannel(channel);
  }

  void setBaseChannel(BaseChannel channel) {
    channelUrl = channel.channelUrl;
    channelType = channel.channelType;
    name = channel.name;
    createdAt = channel.createdAt;
    if (channel is! FeedChannel) {
      coverUrl = channel.coverUrl;
      data = channel.data;
      customType = channel.customType;
      isFrozen = channel.isFrozen;
      isEphemeral = channel.isEphemeral;
    }
    fromCache = channel.fromCache;
    dirty = channel.dirty;
  }

  BaseChannel toBaseChannel(Chat chat, Isar isar) {
    final baseChannel = BaseChannel(
      channelUrl: channelUrl,
    )..set(chat);
    return setCBaseChannel(chat, isar, baseChannel, this);
  }

  static BaseChannel setCBaseChannel(
    Chat chat,
    Isar isar,
    BaseChannel baseChannel,
    CBaseChannel cBaseChannel,
  ) {
    BaseChannel channel = baseChannel
      ..name = cBaseChannel.name
      ..createdAt = cBaseChannel.createdAt
      ..fromCache = cBaseChannel.fromCache
      ..dirty = cBaseChannel.dirty;

    if (baseChannel is! FeedChannel) {
      channel
        ..coverUrl = cBaseChannel.coverUrl
        ..data = cBaseChannel.data
        ..customType = cBaseChannel.customType
        ..isFrozen = cBaseChannel.isFrozen
        ..isEphemeral = cBaseChannel.isEphemeral;
    }
    return channel;
  }
}
