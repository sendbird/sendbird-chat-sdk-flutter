import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class MessageReportRequest extends ApiRequest {
  @override
  final method = Method.post;

  MessageReportRequest({
    required int messageId,
    required String senderId,
    required ChannelType channelType,
    required String channelUrl,
    required ReportCategory category,
    String? description,
  }) : super() {
    url = 'report/${channelType.urlString}/$channelUrl/messages/$messageId';
    body = {
      'reporting_user_id': state.userId,
      'offending_user_id': senderId,
      'report_category': category.asString(),
      if (description != null) 'report_description': description
    };
  }
}
