import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/file_info.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserInfoUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  UserInfoUpdateRequest({
    String? userId,
    String? nickname,
    FileInfo? fileInfo,
    List<String>? discoveryKeys,
    List<String>? preferredLanguages,
    OnUploadProgressCallback? onProgress,
  }) : super(userId: userId) {
    isMultipart = fileInfo?.file != null;
    url = 'users/${userId ?? state.userId}';
    body = {
      'nickname': nickname,
      if (fileInfo != null) 'profile_file': fileInfo,
      if (fileInfo?.url != null) 'profile_url': fileInfo?.url,
      'discovery_keys': discoveryKeys,
      'preferred_languages': preferredLanguages,
    };
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<User> response(res) async {
    return User.fromJson(res);
  }
}
