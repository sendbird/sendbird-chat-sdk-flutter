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
  bool isAuthenticateFeed = false;

  /// When true, this request opts into in-flight deduplication (see
  /// [apiDedupKey] / RequestDeduplicator). Only set for idempotent GETs that
  /// are safe to coalesce (e.g. getChannel refreshes).
  bool dedup = false;

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

  /// Key used to coalesce identical in-flight requests via `RequestDeduplicator`.
  ///
  /// Non-null only when [dedup] is set, so a request participates in
  /// deduplication only when its caller opted in. The key is derived from the
  /// request signature — see [buildDedupKey].
  String? get apiDedupKey =>
      dedup ? buildDedupKey(method, url, queryParams) : null;

  /// Builds a canonical dedup key from a request's [method], [url] and
  /// [queryParams] so that identical requests map to the same key.
  static String buildDedupKey(
    HttpMethod method,
    String url,
    Map<String, dynamic> queryParams,
  ) {
    final entries = queryParams.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final query = entries.map((e) => '${e.key}=${e.value}').join('&');
    return '${method.name}:$url?$query';
  }
}
