// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_message_retrieval_params.dart';

class GroupChannelScheduledMessageGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  GroupChannelScheduledMessageGetRequest(
    Chat chat, {
    required ScheduledMessageRetrievalParams params,
  }) : super(chat: chat) {
    url =
        'group_channels/${params.channelUrl}/scheduled_messages/${params.scheduledMessageId}';
  }

  @override
  Future<BaseMessage> response(Map<String, dynamic> res) async {
    var sortedMetaArrayList = [];
    if (res['sorted_metaarray'].isNotEmpty) {
      sortedMetaArrayList.add(res['sorted_metaarray']);
    }
    res['sorted_metaarray'] = sortedMetaArrayList;

    if (res['scheduled_message_id'] == null ||
        res['scheduled_status'] == null ||
        res['scheduled_at'] == null) {
      throw SendbirdException(message: 'Scheduled message info not found');
    }
    res['scheduled_info'] = {
      'scheduled_message_id': res['scheduled_message_id'],
      'scheduled_status': res['scheduled_status'],
      'scheduled_at': res['scheduled_at'],
    };

    return RootMessage.fromJsonWithChat(chat, res) as BaseMessage;
  }
}
