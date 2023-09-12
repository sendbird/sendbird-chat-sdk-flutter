// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class GroupChannelCountReferenceRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  final countPreferenceEnumMap = <CountPreference, String>{
    CountPreference.all: 'all',
    CountPreference.unreadMessageCountOnly: 'unread_message_count_only',
    CountPreference.unrealMentionCountOnly: 'unread_mention_count_only',
    CountPreference.off: 'off',
  };

  GroupChannelCountReferenceRequest(
    Chat chat, {
    required String channelUrl,
    required CountPreference prefs,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url =
        'users/${getUrlEncodedUserId(chat, userId)}/count_preference/$channelUrl';
    body = {'count_preference': countPreferenceEnumMap[prefs]};
  }

  @override
  Future<CountPreference> response(Map<String, dynamic> res) async {
    return enumDecode<CountPreference>(
      countPreferenceEnumMap,
      res['count_preference'],
      unknownValue: CountPreference.all,
    );
  }
}
