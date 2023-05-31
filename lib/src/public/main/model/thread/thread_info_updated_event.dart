// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/model/thread/thread_info.dart';

part 'thread_info_updated_event.g.dart';

/// Objects representing a thread info event.
@JsonSerializable(createToJson: false)
class ThreadInfoUpdateEvent {
  /// The [ThreadInfo] that has information about threaded messages.
  final ThreadInfo threadInfo;

  /// The unique ID of the message that has threaded replies and holds thread information.
  @JsonKey(name: 'parent_message_id')
  final int targetMessageId;

  /// The type of the channel where threaded messages belong.
  final ChannelType channelType;

  /// The unique URL of the channel where threaded messages belong.
  final String channelUrl;

  ThreadInfoUpdateEvent({
    required this.threadInfo,
    required this.targetMessageId,
    required this.channelType,
    required this.channelUrl,
  });

  factory ThreadInfoUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$ThreadInfoUpdateEventFromJson(json);
}
