// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

const _groupChannelPushTriggerOptionEnumMap =
    <GroupChannelPushTriggerOption, String>{
  GroupChannelPushTriggerOption.defaultValue: 'default',
  GroupChannelPushTriggerOption.all: 'all',
  GroupChannelPushTriggerOption.off: 'off',
  GroupChannelPushTriggerOption.mentionOnly: 'mention_only',
};

class GroupChannelPushTriggerOptionGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  GroupChannelPushTriggerOptionGetRequest(
    Chat chat, {
    required String channelUrl,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url =
        'users/${getUrlEncodedUserId(chat, userId)}/push_preference/$channelUrl';
  }

  @override
  Future<GroupChannelPushTriggerOption> response(
      Map<String, dynamic> res) async {
    return enumDecode(
      _groupChannelPushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: GroupChannelPushTriggerOption.defaultValue,
    );
  }
}

class GroupChannelPushTriggerOptionSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelPushTriggerOptionSetRequest(
    Chat chat, {
    required String channelUrl,
    required GroupChannelPushTriggerOption option,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url =
        'users/${getUrlEncodedUserId(chat, userId)}/push_preference/$channelUrl';
    body = {
      'push_trigger_option': _groupChannelPushTriggerOptionEnumMap[option]
    };
  }

  @override
  Future<GroupChannelPushTriggerOption> response(
      Map<String, dynamic> res) async {
    return enumDecode(
      _groupChannelPushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: GroupChannelPushTriggerOption.defaultValue,
    );
  }
}
