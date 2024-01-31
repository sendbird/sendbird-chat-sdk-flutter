// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class ChannelMessage {
  final String rootId;
  final MessageType messageType;
  final String channelUrl;
  final ChannelType channelType;
  final int createdAt;
  final SendingStatus sendingStatus; // sendingStatus for filtering
  final String? customType; // customType for filtering
  final String? senderId; // senderId for filtering
  final RootMessage message;

  ChannelMessage({
    required this.rootId,
    required this.messageType,
    required this.channelUrl,
    required this.channelType,
    required this.createdAt,
    required this.sendingStatus,
    required this.customType,
    required this.senderId,
    required this.message,
  });
}
