// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/websocket/event/base_event.dart';
import 'package:sendbird_chat/src/public/core/user/user.dart';

part 'user_event.g.dart';

@JsonSerializable(createToJson: false)
class UserEvent extends BaseEvent {
  @JsonKey(fromJson: userEventValueOf, name: 'cat')
  UserEventCategory category;

  final Map<String, dynamic> data;

  int ts;

  List<User> get friendDiscoveries => data['friend_discoveries'];
  User get blocker => User.fromJsonWithChat(chat, data['blocker']);
  User get blockee => User.fromJsonWithChat(chat, data['blockee']);

  UserEvent({required this.category, required this.data, required this.ts});

  factory UserEvent.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return _$UserEventFromJson(json)..set(chat);
  }
}

UserEventCategory userEventValueOf(int value) {
  switch (value) {
    case 20000:
      return UserEventCategory.userUnblock;
    case 20001:
      return UserEventCategory.userBlock;
    case 20900:
      return UserEventCategory.friendDiscovered;
    default:
      return UserEventCategory.categoryNone;
  }
}

enum UserEventCategory {
  categoryNone,
  userUnblock,
  userBlock,
  friendDiscovered,
}
