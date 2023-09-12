// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/snooze_period.dart';

class UserSnoozePeriodSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserSnoozePeriodSetRequest(
    Chat chat, {
    required bool enable,
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
    body = {
      'snooze_enabled': enable,
      if (startDate != null)
        'snooze_start_ts': startDate.millisecondsSinceEpoch,
      if (endDate != null) 'snooze_end_ts': endDate.millisecondsSinceEpoch
    };
  }
}

class UserSnoozePeriodGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserSnoozePeriodGetRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
  }

  @override
  Future<SnoozePeriod> response(Map<String, dynamic> res) async {
    return SnoozePeriod.fromJson(res);
  }
}
