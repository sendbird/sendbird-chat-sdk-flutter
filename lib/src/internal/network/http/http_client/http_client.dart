// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/session_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_manager.dart';
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
}

class HttpClient {
  final Map<String, MultipartRequest> uploadingMultipartRequests = {};
  StreamController? errorStreamController =
      StreamController<SendbirdException>.broadcast(sync: true);

  final ChatContext _chatContext;
  final SessionManager _sessionManager;
  final StatManager? _statManager;

  HttpClient({
    required ChatContext chatContext,
    required SessionManager sessionManager,
    StatManager? statManager,
  })  : _chatContext = chatContext,
        _sessionManager = sessionManager,
        _statManager = statManager;

  ChatContext get chatContext => _chatContext;

  void cleanUp() {
    cancelAllUploadingMultipartRequest();
    errorStreamController?.close();
    errorStreamController = null;
  }

  Uri toUri(
    String url, {
    Map<String, dynamic>? queryParams,
  }) {
    return Uri(
      scheme: 'https',
      host: _chatContext.apiHost,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );
  }

  Future<dynamic> get({
    required Uri uri,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    final request = http.Request('GET', uri);
    request.headers.addAll(_commonHeaders());
    request.headers.addAll(headers ?? {});

    _statManager?.startApiResultStat(
      endpoint: uri.toString(),
    );

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}');

    http.Response res = await http.Response.fromStream(await request.send());
    if (await _checkSessionKeyExpired(res)) {
      final secondRequest = _copyRequest(request);
      if (secondRequest != null) {
        res = await http.Response.fromStream(await secondRequest.send());
      }
    }
    return _response(res);
  }

  Future<dynamic> post({
    required Uri uri,
    Map<String, dynamic> queryParams = const {},
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
    bool? isAuthenticateFeed,
  }) async {
    final request = http.Request('POST', uri);
    request.body = jsonEncode(body);
    request.headers.addAll(_commonHeaders(
      isAuthenticateFeed: isAuthenticateFeed,
    ));
    request.headers.addAll(headers);

    _statManager?.startApiResultStat(
      endpoint: uri.toString(),
    );

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');

    http.Response res = await http.Response.fromStream(await request.send());
    if (await _checkSessionKeyExpired(res)) {
      final secondRequest = _copyRequest(request);
      if (secondRequest != null) {
        res = await http.Response.fromStream(await secondRequest.send());
      }
    }
    return _response(res);
  }

  Future<dynamic> put({
    required Uri uri,
    Map<String, dynamic> queryParams = const {},
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final request = http.Request('PUT', uri);
    request.body = jsonEncode(body);
    request.headers.addAll(_commonHeaders());
    request.headers.addAll(headers);

    _statManager?.startApiResultStat(
      endpoint: uri.toString(),
    );

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');

    http.Response res = await http.Response.fromStream(await request.send());
    if (await _checkSessionKeyExpired(res)) {
      final secondRequest = _copyRequest(request);
      if (secondRequest != null) {
        res = await http.Response.fromStream(await secondRequest.send());
      }
    }
    return _response(res);
  }

  Future<dynamic> delete({
    required Uri uri,
    Map<String, dynamic> queryParams = const {},
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final request = http.Request('DELETE', uri);
    request.headers.addAll(_commonHeaders());
    request.body = jsonEncode(body);
    request.headers.addAll(headers);

    _statManager?.startApiResultStat(
      endpoint: uri.toString(),
    );

    sbLog.d(StackTrace.current,
        '\n-[url] $uri\n-[headers] ${jsonEncoder.convert(request.headers)}\n-[queryParams] ${jsonEncoder.convert(queryParams)}\n-[body] ${jsonEncoder.convert(body)}');

    http.Response res = await http.Response.fromStream(await request.send());
    if (await _checkSessionKeyExpired(res)) {
      final secondRequest = _copyRequest(request);
      if (secondRequest != null) {
        res = await http.Response.fromStream(await secondRequest.send());
      }
    }
    return _response(res);
  }

  Future<dynamic> requestMultipart({
    required HttpMethod method,
    required Uri uri,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    ProgressHandler? progressHandler,
  }) async {
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

    http.Response res = await http.Response.fromStream(await request.send());
    if (await _checkSessionKeyExpired(res)) {
      final secondRequest = _copyRequest(request);
      if (secondRequest != null) {
        res = await http.Response.fromStream(await secondRequest.send());
      }
    }
    uploadingMultipartRequests.remove(reqId);
    return _response(res);
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

  Map<String, String> _commonHeaders({bool? isAuthenticateFeed}) {
    final sessionKey = _chatContext.sessionKey;
    final commonHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (sessionKey != null &&
          (isAuthenticateFeed == null || isAuthenticateFeed == false))
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

  Future<bool> _checkSessionKeyExpired(http.Response response) async {
    dynamic body;

    try {
      body = jsonDecode(response.body.toString());
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      throw MalformedDataException();
    }

    if (response.statusCode >= 400 && response.statusCode < 500) {
      final err =
          SendbirdException(message: body['message'], code: body['code']);
      errorStreamController?.sink.add(err);

      if (err.code == SendbirdError.sessionKeyExpired) {
        try {
          await _sessionManager.updateSessionKey();
          return true;
        } catch (e) {
          sbLog.e(StackTrace.current, 'e: $e');
          rethrow;
        }
      }
    }
    return false;
  }

  http.BaseRequest? _copyRequest(http.BaseRequest request) {
    http.BaseRequest requestCopy;

    if (request is http.Request) {
      requestCopy = http.Request(request.method, request.url)
        ..encoding = request.encoding
        ..bodyBytes = request.bodyBytes;
    } else if (request is http.MultipartRequest) {
      requestCopy = http.MultipartRequest(request.method, request.url)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else {
      throw NotSupportedException();
    }

    requestCopy
      ..persistentConnection = request.persistentConnection
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..headers.addAll(request.headers)
      ..headers.addAll(_commonHeaders()); // Apply updated sessionKey
    return requestCopy;
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
