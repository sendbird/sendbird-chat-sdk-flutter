import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;

import '../../constant/error_code.dart';
import '../../constant/types.dart';
import '../../models/image_info.dart';
import '../../models/error.dart';
import '../../sdk/sendbird_sdk_api.dart';
import '../../services/connection/connection_manager.dart';
import '../../utils/extensions.dart';
import '../../utils/logger.dart';

enum Method {
  get,
  post,
  put,
  delete,
  patch,
}

class HttpClient {
  Map<String, String> headers = {};
  String baseUrl;
  int port;
  String appId;
  String sessionKey;
  String token;

  bool isLocal = false;
  bool bypassAuth = false;
  StreamController errorController =
      StreamController<SBError>.broadcast(sync: true);

  HttpClient({
    this.baseUrl,
    this.port,
    this.appId,
    this.sessionKey,
    this.token,
    this.headers,
  });

  void cleanUp() {
    sessionKey = null;
    token = null;
    headers = {};
    errorController?.close();
  }

  //form commom headers
  Map<String, String> commonHeaders() {
    final commonHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (sessionKey != null)
        'Session-Key': sessionKey
      else if (token != null)
        'Api-Token': token
    };
    if (headers.isNotEmpty) {
      commonHeaders.addAll(headers);
    }

    return commonHeaders;
  }

  Future<dynamic> get({
    String url,
    Map<String, dynamic> queryParams,
    Map<String, String> headers = const {},
  }) async {
    await ConnectionManager.readyToExecuteAPIRequest(force: this.bypassAuth);

    final uri = Uri(
      scheme: isLocal ? 'http' : 'https',
      host: baseUrl,
      port: port,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );

    final request = http.Request('GET', uri);
    request.headers.addAll(commonHeaders());
    request.headers.addAll(headers);

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> post({
    String url,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    await ConnectionManager.readyToExecuteAPIRequest(force: this.bypassAuth);

    final uri = Uri(
      scheme: isLocal ? 'http' : 'https',
      host: baseUrl,
      port: port,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );
    final request = http.Request('POST', uri);
    request.body = jsonEncode(body);
    request.headers.addAll(commonHeaders());
    request.headers.addAll(headers);

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> put({
    String url,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    await ConnectionManager.readyToExecuteAPIRequest(force: this.bypassAuth);

    final uri = Uri(
      scheme: isLocal ? 'http' : 'https',
      host: baseUrl,
      port: port,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );
    final request = http.Request('PUT', uri);
    request.body = jsonEncode(body);
    request.headers.addAll(commonHeaders());
    request.headers.addAll(headers);

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> delete({
    String url,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    await ConnectionManager.readyToExecuteAPIRequest(force: this.bypassAuth);

    final uri = Uri(
      scheme: isLocal ? 'http' : 'https',
      host: baseUrl,
      port: port,
      path: url,
      queryParameters: _convertQueryParams(queryParams),
    );
    final request = http.Request('DELETE', uri);
    request.headers.addAll(commonHeaders());
    request.body = jsonEncode(body);
    request.headers.addAll(headers);

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> multipartRequest({
    Method method,
    String url,
    Map<String, dynamic> body,
    Map<String, dynamic> queryParams,
    Map<String, String> headers,
    OnUploadProgressCallback progress,
  }) async {
    await ConnectionManager.readyToExecuteAPIRequest(force: this.bypassAuth);

    final request = MultipartRequest(
      method.asString().toUpperCase(),
      Uri(
        scheme: isLocal ? 'http' : 'https',
        host: baseUrl,
        port: port,
        path: url,
        queryParameters: _convertQueryParams(queryParams),
      ),
      onProgress: progress,
    );

    body.forEach((key, value) {
      if (value is ImageInfo) {
        request.files.add(http.MultipartFile.fromBytes(
          key,
          value.file.readAsBytesSync(),
          filename: value.name,
          contentType: MediaType.parse(value.mimeType),
        ));
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

    request.headers.addAll(commonHeaders());
    if (headers != null && headers.isNotEmpty) request.headers.addAll(headers);

    final res = await request.send();
    final result = await http.Response.fromStream(res);
    return _response(result);
  }

  Future<dynamic> _response(http.Response response) async {
    //use compute
    final res = jsonDecode(response.body.toString());
    logger.i('[Sendbird] HTTP response ' +
        res.toString() +
        '\nHTTP request ' +
        response.request.url.toString() +
        '\nheaders: ${response.request.headers}');
    if (response.statusCode >= 400 && response.statusCode < 500) {
      final err = SBError(message: res['message'], code: res['code']);
      errorController.sink.add(err);
      //NOTE: is this best way to do?..
      if (err.code == ErrorCode.sessionKeyExpired) {
        sessionKey = null;
        final result =
            await SendbirdSdk().getInternal().sessionManager.updateSession();
        if (result)
          throw SBError(code: ErrorCode.sessionKeyRefreshSucceeded);
        else
          throw SBError(code: ErrorCode.sessionKeyRefreshFailed);
      }
    }

    switch (response.statusCode) {
      case 200:
        return res;
      case 400:
        logger.e('[Sendbird] Bad request: ${res['message']}');
        throw BadRequestError(message: res['message'], code: res['code']);
      case 401:
      case 403:
        logger.e('[Sendbird] Unauthorized request: ${res['message']}');
        throw UnauthorizeError(message: res['message'], code: res['code']);
      case 500:
      default:
        logger.e('[Sendbird] internal server error ${res['message']}');
        throw InternalServerError(
            message: 'internal server error :${response.statusCode}');
    }
  }

  Map<String, dynamic> _convertQueryParams(Map<String, dynamic> q) {
    if (q == null) return {};
    Map<String, dynamic> result = {};
    q.forEach((key, value) {
      if (value is List) {
        if (value is List<String>)
          result[key] = value;
        else
          result[key] = value.map((e) => e.toString()).toList();
      } else if (value != null) {
        result[key] = value.toString();
      }
    });
    return result;
  }
}

class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  var client = http.Client();

  MultipartRequest(
    String method,
    Uri url, {
    this.onProgress,
  }) : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  @override
  Future<http.StreamedResponse> send() async {
    try {
      var response = await client.send(this);
      var stream = onDone(response.stream, client.close);
      return new http.StreamedResponse(
        new http.ByteStream(stream),
        response.statusCode,
        contentLength: response.contentLength,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } catch (_) {
      client.close();
      rethrow;
    }
  }

  Stream<T> onDone<T>(Stream<T> stream, void onDone()) =>
      stream.transform(new StreamTransformer.fromHandlers(handleDone: (sink) {
        sink.close();
        onDone();
      }));

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = this.contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        if (onProgress != null) onProgress(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}

class CloseableMultipartRequest extends http.MultipartRequest {
  var client = http.Client();

  CloseableMultipartRequest(String method, Uri uri) : super(method, uri);

  void close() => client.close();
}
