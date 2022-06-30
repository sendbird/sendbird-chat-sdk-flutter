import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/messages/scheduled_message_get_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

/// List scheduled messages
@JsonSerializable()
class ScheduledMessageListQuery extends QueryBase {
  /// Specifies the URL of the channel to retrieve a list of scheduled messages.
  String? channelUrl;

  /// Specifies the channel type of channel_url.
  /// Only “group_channels” is allowed for now.
  String? channelType;

  ///Specifies the sort order will be reversed.
  bool? reverse = false;

  /// Specifies the statuses of the scheduled message to retrieve.
  List<ScheduledStatus>? status;

  /// Specifies the message type to filter the messages with the corresponding type.
  MessageTypeFilter? messageType = MessageTypeFilter.all;

  /// Specifies the method to sort a list of results
  ScheduledMessageListOrder? order = ScheduledMessageListOrder.createdAt;

  ScheduledMessageListQuery({
    this.channelUrl,
    this.channelType,
    this.reverse,
    this.status,
    this.messageType,
    this.order,
    String? token,
    int? limit,
  }) : super() {
    token = token ?? '0';
    limit = limit ?? 10;
  }

  @override
  Future<List<BaseMessage>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();

    final res = await sdk.api
        .send<ScheduledMessageResponse>(ScheduledMessageListGetRequest(
      channelUrl: channelUrl,
      channelType: channelType,
      reverse: reverse,
      status: status,
      messageType: messageType,
      order: order,
      limit: limit,
      token: token,
    ));
    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.scheduledMessages;
  }
}
