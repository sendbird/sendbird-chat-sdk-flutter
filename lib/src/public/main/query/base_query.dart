// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/internal/main/chat/chat.dart';

/// Abstract class for query
abstract class BaseQuery {
  static const defaultQueryLimit = 20;
  // Default value is different from other queries because this query's limit max is 20
  static const defaultPollListQueryLimit = 10;

  /// Whether the current query is in communication progress with server.
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isLoading = false;

  /// Whether there is a next page.
  bool hasNext = true;

  /// The maximum number of items per queried page.
  int limit = defaultQueryLimit;

  String? token;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Chat chat;

  BaseQuery({required this.chat});

  /// Gets the list of next items.
  Future<List> next();
}
