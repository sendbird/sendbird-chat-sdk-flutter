import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/params/scheduled_message_list_params.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/messages/scheduled_message_get_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

/// List scheduled messages
@JsonSerializable()
class ScheduledMessageListQuery extends QueryBase {
  ScheduledMessageListParams? params;

  ScheduledMessageListQuery({this.params}) : super() {
    token = params?.token;
    limit = params?.limit ?? 10;
  }

  @override
  Future<List<BaseMessage>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();

    final res = await sdk.api
        .send<ScheduledMessageResponse>(ScheduledMessageListGetRequest(
      channelUrl: params?.channelUrl,
      channelType: params?.channelType,
      reverse: params?.reverse,
      status: params?.status,
      messageType: params?.messageType,
      order: params?.order,
      limit: limit,
      token: token,
    ));
    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.scheduledMessages;
  }
}
