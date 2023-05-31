// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';

abstract class ApiRequest {
  final String version = 'v3';

  // requires
  HttpMethod method = HttpMethod.get;
  String url = '';

  // optional
  Map<String, dynamic> queryParams = {};
  Map<String, dynamic> body = {};
  Map<String, String> headers = {};
  ProgressHandler? progressHandler;
  bool isMultipart = false;

  final Chat chat;
  String? userId;
  String? apiToken;

  ApiRequest({
    required this.chat,
    this.userId,
    this.apiToken,
  }) {
    userId ??= chat.chatContext.currentUserId;
  }

  Future response(Map<String, dynamic> res) async {}
}
