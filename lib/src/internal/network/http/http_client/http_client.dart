// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/session_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/multipart_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/file_info.dart';

enum HttpMethod {
  get,
  post,
  put,
  delete,
  // patch,
}

class HttpClient {
  final Map<String, MultipartRequest> uploadingMultipartRequests = {};
  StreamController? errorStreamController =
      StreamController<SendbirdException>.broadcast(sync: true);

  final ChatContext _chatContext;
  final SessionManager _sessionManager;

  HttpClient({
    required ChatContext chatContext,
    required SessionManager sessionManager,
  })  : _chatContext = chatContext,
        _sessionManager = sessionManager;

  ChatContext get chatContext => _chatContext;

  void cleanUp() {
    cancelAllUploadingMultipartRequest();
    errorStreamController?.close();
    errorStreamController = null;
  }

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    final uri = Uri(
      scheme: 'https',
      host: _chatContext.apiHost,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );

    final request = http.Request('GET', uri);
    request.headers.addAll(_commonHeaders());
    request.headers.addAll(headers ?? {});

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}');

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> post({
    required String url,
    Map<String, dynamic> queryParams = const {},
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final uri = Uri(
      scheme: 'https',
      host: _chatContext.apiHost,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );

    final request = http.Request('POST', uri);
    request.body = jsonEncode(body);
    request.headers.addAll(_commonHeaders());
    request.headers.addAll(headers);

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> put({
    required String url,
    Map<String, dynamic> queryParams = const {},
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final uri = Uri(
      scheme: 'https',
      host: _chatContext.apiHost,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );

    final request = http.Request('PUT', uri);
    request.body = jsonEncode(body);
    request.headers.addAll(_commonHeaders());
    request.headers.addAll(headers);

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic> queryParams = const {},
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final uri = Uri(
      scheme: 'https',
      host: _chatContext.apiHost,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );

    final request = http.Request('DELETE', uri);
    request.headers.addAll(_commonHeaders());
    request.body = jsonEncode(body);
    request.headers.addAll(headers);

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  // Future<dynamic> patch({
  //   required String url,
  //   Map<String, dynamic>? queryParams,
  //   Map<String, dynamic>? body,
  //   Map<String, String>? headers,
  // }) async {
  //   final uri = Uri(
  //     scheme: 'https',
  //     host: _chatContext.apiHost,
  //     path: url,
  //     queryParameters: _convertQueryParams(queryParams),
  //   );
  //
  //   final request = http.Request('PATCH', uri);
  //   request.headers.addAll(_commonHeaders());
  //   request.headers.addAll(headers ?? {});
  //
  //   sbLog.d(StackTrace.current,
  //       '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');
  //
  //   final res = await request.send();
  //   final result = await http.Response.fromStream(res);
  //   return _response(result);
  // }

  Future<dynamic> requestMultipart({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    ProgressHandler? progressHandler,
  }) async {
    final uri = Uri(
      scheme: 'https',
      host: _chatContext.apiHost,
      path: url,
      queryParameters: _convertQueryParams(queryParams ?? {}),
    );

    final request = MultipartRequest(
      method.asString().toUpperCase(),
      uri,
      onProgress: progressHandler,
    );

    body?.forEach((key, value) {
      if (value is FileInfo) {
        final http.MultipartFile part;
        if (value.fileBytes != null) {
          part = http.MultipartFile.fromBytes(
            key,
            value.fileBytes!,
            filename: value.fileName,
            contentType: (value.mimeType == null || value.mimeType == "")
                ? null
                : MediaType.parse(value.mimeType!),
          );
        } else {
          part = http.MultipartFile(
            key,
            value.file!.openRead(),
            value.file!.lengthSync(),
            filename: value.fileName,
            contentType: MediaType.parse(value.mimeType!),
          );
        }
        request.files.add(part);
      } else if (value is List<String>) {
        request.fields[key] = value.join(',');
      } else if (value is List) {
        final converted = value.map((e) => jsonEncode(e));
        request.fields[key] = converted.join(',');
      } else if (value is String) {
        request.fields[key] = value;
      } else if (value != null) {
        request.fields[key] = jsonEncode(value);
      }
    });

    request.headers.addAll(_commonHeaders());
    if (headers != null && headers.isNotEmpty) request.headers.addAll(headers);

    String? reqId = body?['request_id'];
    if (reqId != null) uploadingMultipartRequests[reqId] = request;

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[method] $method\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');

    final res = await request.send();
    final result = await http.Response.fromStream(res);

    uploadingMultipartRequests.remove(reqId);
    return _response(result);
  }

  bool cancelUploadingMultipartRequest(String requestId) {
    final req = uploadingMultipartRequests[requestId];
    if (req != null) {
      req.cancel();
      uploadingMultipartRequests.remove(requestId);
      return true;
    }
    return false;
  }

  void cancelAllUploadingMultipartRequest() {
    uploadingMultipartRequests.values.map((req) => req.cancel());
    uploadingMultipartRequests.clear();
  }

  Map<String, String> _commonHeaders() {
    final sessionKey = _chatContext.sessionKey;
    final commonHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (sessionKey != null)
        'Session-Key': sessionKey
      else if (_chatContext.apiToken != null)
        'Api-Token': _chatContext.apiToken!
    };

    if (_chatContext.apiHeaders.isNotEmpty) {
      commonHeaders.addAll(_chatContext.apiHeaders);
    }
    return commonHeaders;
  }

  Future<dynamic> _response(http.Response response) async {
    dynamic body;

    try {
      body = jsonDecode(response.body.toString());
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      throw MalformedDataException();
    }

    final headersString = jsonEncoder.convert(response.headers);
    final bodyString = '${response.statusCode} ${jsonEncoder.convert(body)}';
    final hasErrorCode =
        response.statusCode >= 400 && response.statusCode < 500;
    final logFunc = hasErrorCode ? sbLog.e : sbLog.d;
    logFunc(StackTrace.current,
        '\n-[url] ${response.request!.url}\n-[response_headers] $headersString\n-[response] $bodyString');

    if (response.statusCode >= 400 && response.statusCode < 500) {
      final err =
          SendbirdException(message: body['message'], code: body['code']);
      errorStreamController?.sink.add(err);

      if (err.code == SendbirdError.sessionKeyExpired) {
        try {
          await _sessionManager.updateSessionKey();
        } catch (e) {
          sbLog.e(StackTrace.current, 'e: $e');
          rethrow;
        }
      }
    }

    switch (response.statusCode) {
      case 200:
        return body;
      case 400:
        throw BadRequestException(message: body['message'], code: body['code']);
      case 401:
      case 403:
        throw UnauthorizedException(
            message: body['message'], code: body['code']);
      case 500:
      default:
        throw InternalServerException(
            message: 'Internal server error: ${response.statusCode}');
    }
  }

  Map<String, dynamic> _convertQueryParams(Map<String, dynamic>? q) {
    if (q == null) return {};
    final result = <String, dynamic>{};
    q.forEach((key, value) {
      if (value is List) {
        if (value is List<String>) {
          result[key] = value;
        } else {
          result[key] = value.map((e) => e.toString()).toList();
        }
      } else if (value != null) {
        result[key] = value.toString();
      }
    });
    return result;
  }
}
