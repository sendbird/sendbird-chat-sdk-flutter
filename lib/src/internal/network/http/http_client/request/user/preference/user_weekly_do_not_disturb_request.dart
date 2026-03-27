// Copyright (c) 2026 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/dnd/dnd_schedule.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/dnd/weekly_do_not_disturb.dart';

class UserWeeklyDoNotDisturbSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserWeeklyDoNotDisturbSetRequest(
    Chat chat, {
    required List<DndSchedule> dndSchedules,
    String timezone = 'UTC',
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
    body = {
      'dnd_schedules': dndSchedules.map((e) => e.toJson()).toList(),
      'timezone': timezone
    };
  }
}

class UserWeeklyDoNotDisturbGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserWeeklyDoNotDisturbGetRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
  }

  @override
  Future<WeeklyDoNotDisturb> response(Map<String, dynamic> res) async {
    return WeeklyDoNotDisturb.fromJson(res);
  }
}

class UserWeeklyDoNotDisturbDeleteRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  UserWeeklyDoNotDisturbDeleteRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
  }
}
