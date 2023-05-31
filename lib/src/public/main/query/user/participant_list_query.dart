// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/user/list/open_channel_participant_list_request.dart';
import 'package:sendbird_chat/src/public/core/user/user.dart';
import 'package:sendbird_chat/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat/src/public/main/query/base_query.dart';

/// A class representing query to retrieve lists related to participant.
class ParticipantListQuery extends BaseQuery {
  /// The channel url of the channel you want to get participants from.
  String channelUrl;

  ParticipantListQuery({
    required this.channelUrl,
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of next items.
  @override
  Future<List<User>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    final req = OpenChannelParticipantListRequest(
      chat,
      limit: limit,
      channelUrl: channelUrl,
      token: token,
    );

    final res = await chat.apiClient.send<UserListQueryResponse<User>>(req);
    isLoading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }
}
