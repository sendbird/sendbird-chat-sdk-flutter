import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

@JsonSerializable()
class ScheduledMessageListParams {
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

  String? token;

  int? limit;

  ScheduledMessageListParams({
    this.channelUrl,
    this.channelType,
    this.reverse,
    this.status,
    this.messageType,
    this.order,
    this.token,
    this.limit,
  });
}
