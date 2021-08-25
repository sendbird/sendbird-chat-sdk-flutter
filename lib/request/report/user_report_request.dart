import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class UserReportRequest extends ApiRequest {
  @override
  final method = Method.post;

  UserReportRequest({
    required String targetId,
    required ChannelType channelType,
    required String channelUrl,
    required ReportCategory category,
    String? reporterId,
    String? description,
  }) : super() {
    url = 'report/users/$targetId';
    body = {
      'channel_type': channelType.urlString,
      'channel_url': channelUrl,
      'report_category': category.asString(),
      'reporting_user_id': reporterId ?? state.userId,
      if (description != null) 'report_description': description
    };
  }
}
