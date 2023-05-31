// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/base_event.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';

part 'mcnt_event.g.dart';

@JsonSerializable(createToJson: false)
class MCNTEvent extends BaseEvent {
  @JsonKey(defaultValue: [])
  List<GroupChannel> groupChannels;

  @JsonKey(defaultValue: [])
  List<OpenChannel> openChannels;

  @JsonKey(name: 'sts')
  int? systemTimestamp;

  @JsonKey(name: 'ts')
  int? timestamp;

  MCNTEvent({
    required this.groupChannels,
    required this.openChannels,
    this.systemTimestamp,
    this.timestamp,
  });

  factory MCNTEvent.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    final event = _$MCNTEventFromJson(json);

    for (final channel in event.groupChannels) {
      channel.set(chat);
    }
    for (final channel in event.openChannels) {
      channel.set(chat);
    }
    return event;
  }
}
