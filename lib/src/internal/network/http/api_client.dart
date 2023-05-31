// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/session_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';

class ApiClient {
  final HttpClient _httpClient;

  ApiClient({
    required ChatContext chatContext,
    required SessionManager sessionManager,
  }) : _httpClient = HttpClient(
          chatContext: chatContext,
          sessionManager: sessionManager,
        );

  void cleanUp() {
    _httpClient.cleanUp();
  }

  HttpClient get httpClient => _httpClient;
  Stream? get errorStreamController =>
      _httpClient.errorStreamController?.stream;

  // possible other solution T is return type
  Future<T> send<T>(ApiRequest request) async {
    try {
      final url = '/${request.version}/${request.url}';
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
            url: url,
            queryParams: request.queryParams,
            headers: request.headers,
          );
          break;

        case HttpMethod.post:
          if (!request.isMultipart) {
            json = await _httpClient.post(
              url: url,
              queryParams: request.queryParams,
              body: request.body,
              headers: request.headers,
            );
          } else {
            json = await _httpClient.requestMultipart(
              method: request.method,
              url: url,
              body: request.body,
              queryParams: request.queryParams,
              headers: request.headers,
              progressHandler: request.progressHandler,
            );
          }
          break;

        case HttpMethod.put:
          if (!request.isMultipart) {
            json = await _httpClient.put(
              url: url,
              queryParams: request.queryParams,
              body: request.body,
              headers: request.headers,
            );
          } else {
            json = await _httpClient.requestMultipart(
              method: request.method,
              url: url,
              body: request.body,
              queryParams: request.queryParams,
              headers: request.headers,
              progressHandler: request.progressHandler,
            );
          }
          break;

        case HttpMethod.delete:
          json = await _httpClient.delete(
            url: url,
            queryParams: request.queryParams,
            body: request.body,
            headers: request.headers,
          );
          break;

        // case HttpMethod.patch:
        //   json = await _httpClient.patch(
        //     url: url,
        //     queryParams: request.queryParams,
        //     body: request.body,
        //     headers: request.headers,
        //   );
        //   break;
      }

      final res = await request.response(json);
      return res as T;
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      if (e is SendbirdException) {
        rethrow;
      } else {
        throw RequestFailedException(message: e.toString());
      }
    }
  }

  // https://github.com/dart-lang/http/issues/424
  bool cancelUploadingFile(String requestId) {
    return _httpClient.cancelUploadingMultipartRequest(requestId);
  }
}
