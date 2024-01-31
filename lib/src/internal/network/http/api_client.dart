// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/session_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';

class ApiClient {
  final StatManager? _statManager;
  final HttpClient _httpClient;

  bool throwExceptionForTest = false;

  ApiClient({
    required ChatContext chatContext,
    required SessionManager sessionManager,
    StatManager? statManager,
  })  : _statManager = statManager,
        _httpClient = HttpClient(
          chatContext: chatContext,
          sessionManager: sessionManager,
          statManager: statManager,
        );

  void cleanUp() {
    _httpClient.cleanUp();
  }

  HttpClient get httpClient => _httpClient;

  Stream? get errorStreamController =>
      _httpClient.errorStreamController?.stream;

  // possible other solution T is return type
  Future<T> send<T>(ApiRequest request) async {
    if (throwExceptionForTest) {
      throw Exception();
    }

    final url = '/${request.version}/${request.url}';
    final uri = _httpClient.toUri(
      url,
      queryParams: request.queryParams,
    );

    try {
      // inject current user id if field is empty when only needs
      // need to clarify the condition
      if (request.method != HttpMethod.get &&
          request.body['user_id'] == null &&
          request.userId != null) {
        request.body['user_id'] = request.userId; // ?? _chatContext.userId;
      }

      Map<String, dynamic> json;

      switch (request.method) {
        case HttpMethod.get:
          json = await _httpClient.get(
            uri: uri,
            queryParams: request.queryParams,
            headers: request.headers,
          );
          break;

        case HttpMethod.post:
          if (!request.isMultipart) {
            json = await _httpClient.post(
              uri: uri,
              queryParams: request.queryParams,
              body: request.body,
              headers: request.headers,
              isAuthenticateFeed: request.isAuthenticateFeed,
            );
          } else {
            json = await _httpClient.requestMultipart(
              method: request.method,
              uri: uri,
              queryParams: request.queryParams,
              body: request.body,
              headers: request.headers,
              progressHandler: request.progressHandler,
            );
          }
          break;

        case HttpMethod.put:
          if (!request.isMultipart) {
            json = await _httpClient.put(
              uri: uri,
              queryParams: request.queryParams,
              body: request.body,
              headers: request.headers,
            );
          } else {
            json = await _httpClient.requestMultipart(
              method: request.method,
              uri: uri,
              queryParams: request.queryParams,
              body: request.body,
              headers: request.headers,
              progressHandler: request.progressHandler,
            );
          }
          break;

        case HttpMethod.delete:
          json = await _httpClient.delete(
            uri: uri,
            queryParams: request.queryParams,
            body: request.body,
            headers: request.headers,
          );
          break;
      }

      final res = await request.response(json);

      _statManager?.endApiResultStat(
        endpoint: uri.toString(),
        method: request.method.name.toUpperCase(),
        success: true,
      );

      return res as T;
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');

      if (e is SendbirdException) {
        _statManager?.endApiResultStat(
          endpoint: uri.toString(),
          method: request.method.name.toUpperCase(),
          success: false,
          errorCode: e.code,
          errorDescription: e.message,
        );

        rethrow;
      } else {
        final exception = RequestFailedException(message: e.toString());

        _statManager?.endApiResultStat(
          endpoint: uri.toString(),
          method: request.method.name.toUpperCase(),
          success: false,
          errorCode: exception.code,
          errorDescription: exception.message,
        );

        throw exception;
      }
    }
  }

  // https://github.com/dart-lang/http/issues/424
  bool cancelUploadingFile(String requestId) {
    return _httpClient.cancelUploadingMultipartRequest(requestId);
  }
}
