// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

const _pushTriggerOptionEnumMap = <PushTriggerOption, String>{
  PushTriggerOption.all: 'all',
  PushTriggerOption.off: 'off',
  PushTriggerOption.mentionOnly: 'mention_only',
};

class UserPushTriggerOptionSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserPushTriggerOptionSetRequest(
    Chat chat,
    PushTriggerOption option, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
    body = {'push_trigger_option': _pushTriggerOptionEnumMap[option]};
  }
}

class UserPushTriggerOptionGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserPushTriggerOptionGetRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
  }

  @override
  Future<PushTriggerOption> response(Map<String, dynamic> res) async {
    return enumDecode(
      _pushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: PushTriggerOption.all,
    );
  }
}
