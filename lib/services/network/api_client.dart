import 'package:sendbird_sdk/core/models/state.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ApiClient {
  late HttpClient client;
  String? currentUserId; //inject userid whenever current user status changes

  String? appId;
  String? baseUrl;
  String? sessionKey;
  String? token;
  Map<String, String> headers = {};

  SendbirdState? state;

  ApiClient({this.state, this.appId, this.token}) {
    client = HttpClient(state);
  }

  void initialize({
    String? appId,
    String? token,
    String? baseUrl,
    Map<String, String>? headers,
  }) {
    if (appId != null) this.appId = appId;
    if (token != null) this.token = token;
    if (baseUrl != null) this.baseUrl = baseUrl;
    if (headers != null) this.headers = headers;

    client
      ..appId = appId ?? this.appId
      ..token = token ?? this.token
      ..baseUrl = baseUrl ?? this.baseUrl
      ..headers = headers ?? this.headers;
  }

  void cleanUp() {
    sessionKey = null;
    token = null;
    client.cleanUp();
  }

  Stream get errorStream {
    return client.errorController.stream;
  }

  //possible other solution T is return type
  Future<T> send<T>(ApiRequest request) async {
    final url = '/${request.version}/${request.url}';
    //inject current user id if field is empty when only needs
    //need to clarify the condition
    if (request.method != Method.get &&
        request.body['user_id'] == null &&
        request.userId != null) {
      request.body['user_id'] = request.userId; // ?? state.userId;
    }

    Map<String, dynamic> json;

    switch (request.method) {
      case Method.get:
        json = await client.get(
          url: url,
          queryParams: request.queryParams,
          headers: request.headers,
        );
        break;
      case Method.post:
        if (!request.isMultipart) {
          json = await client.post(
            url: url,
            queryParams: request.queryParams,
            body: request.body,
            headers: request.headers,
          );
        } else {
          json = await client.multipartRequest(
            method: request.method,
            url: url,
            body: request.body,
            queryParams: request.queryParams,
            headers: request.headers,
            progress: request.progress,
          );
        }
        break;
      case Method.delete:
        json = await client.delete(
          url: url,
          queryParams: request.queryParams,
          body: request.body,
          headers: request.headers,
        );
        break;
      case Method.patch:
        json = await client.patch(
          url: url,
          queryParams: request.queryParams,
          body: request.body,
          headers: request.headers,
        );
        break;
      case Method.put:
        if (!request.isMultipart) {
          json = await client.put(
            url: url,
            queryParams: request.queryParams,
            body: request.body,
            headers: request.headers,
          );
        } else {
          json = await client.multipartRequest(
            method: request.method,
            url: url,
            body: request.body,
            queryParams: request.queryParams,
            headers: request.headers,
            progress: request.progress,
          );
        }
    }

    final res = await request.response(json);
    return res as T;
  }

  // // https://github.com/dart-lang/http/issues/424
  bool cancelUploadingFile(String requestId) {
    return client.cancelUploadRequest(requestId);
  }
}
