// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class UserPushTokenRegisterRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  UserPushTokenRegisterRequest(
    Chat chat, {
    required PushTokenType type,
    required String token,
    bool alwaysPush = false,
    bool unique = false,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    final typeUrl = pushTokenToString(type);
    if (typeUrl == null) {
      return;
    }

    url = 'users/${getUrlEncodedUserId(chat, userId)}/push/$typeUrl';

    body = {
      if (type == PushTokenType.fcm) 'gcm_reg_token': token,
      if (type == PushTokenType.apns) 'apns_device_token': token,
      if (type == PushTokenType.hms) 'huawei_device_token': token,
      'is_unique': unique,
      'always_push': alwaysPush,
    };
  }

  @override
  Future<PushTokenRegistrationStatus> response(Map<String, dynamic> res) async {
    return PushTokenRegistrationStatus.success;
  }

  String? pushTokenToString(PushTokenType type) {
    switch (type) {
      case PushTokenType.fcm:
        return 'gcm';
      case PushTokenType.apns:
        return 'apns';
      case PushTokenType.hms:
        return 'huawei';
      default:
        return null;
    }
  }
}
