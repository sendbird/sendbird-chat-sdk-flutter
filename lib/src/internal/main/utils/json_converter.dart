// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

const jsonEncoder = JsonEncoder.withIndent('  ');

MuteState boolToMuteState(bool? isMuted) =>
    isMuted != null && isMuted ? MuteState.muted : MuteState.unmuted;

bool muteStateToBool(MuteState muteState) =>
    muteState == MuteState.muted ? true : false;

String userToUserId(Map<String, dynamic>? userDic) =>
    userDic != null ? userDic['user_id'] ?? userDic['guest_id'] : null;

UserConnectionStatus boolToConnectionStatus(bool? isOnline) => isOnline == null
    ? UserConnectionStatus.notAvailable
    : isOnline
        ? UserConnectionStatus.online
        : UserConnectionStatus.offline;

bool? connectionStatusToBool(UserConnectionStatus status) =>
    status == UserConnectionStatus.notAvailable
        ? null
        : status == UserConnectionStatus.online;

// message
BaseMessage? toNullableBaseMessage(dynamic json) {
  if (json == null) return null;
  if (json['notification_message_id'] != null) return null;
  return RootMessage.fromJson(json) as BaseMessage;
}

List<BaseMessage> toBaseMessageList(List<dynamic> json) {
  return json.map((e) => RootMessage.fromJson(e) as BaseMessage).toList();
}

List<RootMessage> toRootMessageList(List<dynamic> json) {
  return json.map((e) => RootMessage.fromJson(e)).toList();
}

List<int> toDeletedIntMessageIds(List<dynamic> json) {
  return json.map((e) => e['message_id'] as int).toList();
}

List<dynamic> toDeletedMessageIds(List<dynamic> json) {
  return json.map((e) => e['message_id']).toList();
}
