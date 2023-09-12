// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/file_info.dart';

class UserInfoUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserInfoUpdateRequest(
    Chat chat, {
    String? userId,
    String? nickname,
    FileInfo? profileFileInfo,
    List<String>? discoveryKeys,
    List<String>? preferredLanguages,
    ProgressHandler? progressHandler,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}';
    body = {
      'nickname': nickname,
      if (profileFileInfo != null) 'profile_file': profileFileInfo,
      if (profileFileInfo?.fileUrl != null)
        'profile_url': profileFileInfo?.fileUrl,
      'discovery_keys': discoveryKeys,
      'preferred_languages': preferredLanguages,
    };
    body.removeWhere((key, value) => value == null);
    isMultipart = profileFileInfo?.file != null;
    this.progressHandler = progressHandler;
  }

  @override
  Future<User> response(Map<String, dynamic> res) async {
    return User.fromJsonWithChat(chat, res);
  }
}
