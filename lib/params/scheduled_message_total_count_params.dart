import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/error.dart';

class TotalScheduledMessageCountParams {
  String? channelUrl;
  ChannelType? channelType;
  String? senderId;
  List<ScheduledStatus>? statuses;
  MessageTypeFilter? messageType;

  TotalScheduledMessageCountParams({
    this.channelUrl,
    this.channelType,
    this.senderId,
    this.statuses,
    this.messageType,
  }) {
    if (channelType != ChannelType.group) {
      throw (SBError(message: 'Channel Type Group is ONLY allowed'));
    }
  }

  Map<String, dynamic> toJson() {
    var statusList = [];
    if (statuses != null) {
      statuses!.forEach((val) {
        statusList.add(val.toString().split('.').last);
      });
    }

    final ret = <String, dynamic>{
      'channel_url': channelUrl,
      'channel_type': channelType.toString().split('.').last,
      'senderId': senderId,
      'status': statusList.isEmpty ? null : statusList,
      'message_type':
          messageType == null ? null : messageType.toString().split('.').last,
    };

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
