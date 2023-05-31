// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

class TypeChecker {
  static String? fromJsonToNullableString(dynamic json) {
    return json is String ? json : null;
  }
}
