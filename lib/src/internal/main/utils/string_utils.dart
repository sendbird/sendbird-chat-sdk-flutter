// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:math';

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final _random = Random();

String getRandomString(int length) {
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));
}

String getFileExtension(String fileName) {
  return ".${fileName.split('.').last}";
}

String getUrlEncodedUserId(Chat chat, String? userId) {
  return Uri.encodeComponent(userId ?? chat.chatContext.currentUserId ?? '');
}
