// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final _random = Random();

String getRandomString(int length) {
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));
}

String getFileExtension(String fileName) {
  return ".${fileName.split('.').last}";
}
