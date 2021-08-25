import 'dart:async';

import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

abstract class ApiRequest {
  //this is problem when if api request cannot be depended on sdk
  final state = SendbirdSdk().getInternal().state;

  // String? baseUrl;
  String? token;
  String version = 'v3';

  //requires
  Method method = Method.get;
  String url = '';

  //optional
  Map<String, dynamic> queryParams = {};
  Map<String, dynamic> body = {};
  Map<String, String> headers = {};
  OnUploadProgressCallback? progress;
  bool isMultipart = false;
  bool bypassAuth = false;

  String? userId;

  ApiRequest({
    // this.queryParams = const {},
    // this.body = const {},
    // this.headers = const {},
    // this.progress,
    // this.isMultipart = false,
    // this.baseUrl,
    this.token,
    this.bypassAuth = false,
    this.userId,
  }) {
    userId = userId ?? state.userId;
  }

  Future response(Map<String, dynamic> res) async {}
}
