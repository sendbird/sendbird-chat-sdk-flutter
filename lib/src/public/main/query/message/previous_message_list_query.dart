// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_get_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/message_list_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A query object to retrieve previous messages
class PreviousMessageListQuery extends BaseQuery {
  /// The type of the channel to get messages from.
  ChannelType channelType;

  /// The url of the channel to get messages from.
  String channelUrl;

  /// Indicates whether the queried result will be reversed.
  /// If `true`, the result will be returned by creation time descending order.
  bool reverse = false;

  /// Message type filter. [MessageTypeFilter]
  MessageTypeFilter messageTypeFilter = MessageTypeFilter.all;

  /// The custom type filter of the message.
  List<String> customTypesFilter = [];

  /// Sender user ids filter.
  List<String> senderIdsFilter = [];

  //+ BaseMessageFetchParams

  /// Whether the meta arrays should be included in the results.
  bool includeMetaArray = false;

  /// Whether the reaction data should be included in the results.
  bool includeReactions = false;

  /// Whether the thread information should be included in the results.
  bool includeThreadInfo = false;

  /// Whether the information of a parent message should be included in the reply messages included in the results.
  bool includeParentMessageInfo = false;

  /// Determines the reply types to include in the results.
  ReplyType replyType = ReplyType.none;

  //- BaseMessageFetchParams

  /// If set to true, only messages that belong to current user's subchannel is fetched.
  /// If set to false, all messages will be fetched. Default is false.
  /// Takes effect only when the requested channel is a dynamically partitioned open channel.
  bool showSubChannelMessagesOnly = false;

  /// The time of a request.
  /// After each call of [next], this value will change to the oldest [BaseMessage.createdAt] value of the message that have been fetched.
  int? messageTimestamp = SendbirdChat.maxInt;

  PreviousMessageListQuery({
    required this.channelType,
    required this.channelUrl,
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of next items.
  @override
  Future<List<BaseMessage>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    final params = MessageListParams()
      ..previousResultSize = limit
      ..reverse = reverse
      ..messageType = messageTypeFilter
      ..customTypes = customTypesFilter
      ..senderIds = senderIdsFilter
      ..showSubChannelMessagesOnly = showSubChannelMessagesOnly
      // BaseMessageFetchParams
      ..includeMetaArray = includeMetaArray
      ..includeReactions = includeReactions
      ..includeThreadInfo = includeThreadInfo
      ..includeParentMessageInfo = includeParentMessageInfo
      ..replyType = replyType;

    final res = await chat.apiClient.send<ChannelMessagesGetResponse>(
      ChannelMessagesGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        timestamp: messageTimestamp ?? 0,
      ),
    );
    final messages = List<BaseMessage>.from(res.messages);

    if (messages.isNotEmpty) {
      final oldestMessage = reverse ? messages.last : messages.first;
      messageTimestamp = oldestMessage.createdAt;
    } else {
      messageTimestamp = null;
    }

    isLoading = false;
    hasNext = messages.length == limit;
    return messages;
  }
}
