// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

abstract class BaseEvent {
  @JsonKey(includeFromJson: false, includeToJson: false)
  late Chat chat;

  void set(Chat chat) {
    this.chat = chat;
  }
}
