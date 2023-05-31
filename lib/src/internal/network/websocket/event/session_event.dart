// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/internal/network/websocket/event/base_event.dart';

part 'session_event.g.dart';

@JsonSerializable(createToJson: false)
class SessionEvent extends BaseEvent {
  final String? newKey;

  @JsonKey(name: 'ekey')
  final String? eKey;

  final String? key;

  String get sessionKey => key ?? newKey ?? '';

  SessionEvent({this.newKey, this.eKey, this.key});

  factory SessionEvent.fromJson(Map<String, dynamic> json) =>
      _$SessionEventFromJson(json);
}
