import 'package:meta/meta.dart';
import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/message/scheduled_user_message.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';
import 'package:sendbird_sdk/core/models/emoji.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/group_channel_filters.dart';
import 'package:sendbird_sdk/core/models/file_info.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/unread_item_count.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/reaction_event.dart';
import 'package:sendbird_sdk/params/file_message_params.dart';
import 'package:sendbird_sdk/params/group_channel_change_logs_params.dart';
import 'package:sendbird_sdk/params/group_channel_params.dart';
import 'package:sendbird_sdk/params/message_change_logs_params.dart';
import 'package:sendbird_sdk/params/message_retrieval_params.dart';
import 'package:sendbird_sdk/params/open_channel_params.dart';
import 'package:sendbird_sdk/params/scheduled_user_message_params.dart';
import 'package:sendbird_sdk/params/user_message_params.dart';
import 'package:sendbird_sdk/services/network/api_endpoints.dart' as endpoint;
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class ApiClient {
  HttpClient client = HttpClient();
  String currentUserId; //inject userid whenever current user status changes

  String appId;
  String sessionKey;
  String token;
  String baseUrl;
  int uploadSizeLimit;

  void initialize({
    String appId,
    String sessionKey,
    String token,
    String baseUrl,
    int uploadSizeLimit,
    Map<String, String> headers,
  }) {
    if (appId != null) this.appId = appId;
    if (sessionKey != null) this.sessionKey = sessionKey;
    if (token != null) this.token = token;
    if (baseUrl != null) this.baseUrl = baseUrl;
    if (uploadSizeLimit != null) this.uploadSizeLimit = uploadSizeLimit;

    client
      ..appId = appId ?? this.appId
      ..sessionKey = sessionKey ?? this.sessionKey
      ..token = token ?? this.token
      ..baseUrl = baseUrl ?? this.baseUrl
      ..headers = headers ?? {};
  }

  void cleanUp() {
    sessionKey = null;
    token = null;
    client.cleanUp();
  }

  Stream get errorStream {
    return client.errorController.stream;
  }

  // channels

  Future<OpenChannel> createOpenChannel(
    OpenChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    var body = {
      'channel_url': params.channelUrl,
      'name': params.name,
      'data': params.data,
      'custom_type': params.customType,
      'operator_ids': params.operatorUserIds,
    };
    final url = endpoint.OpenChannels.origin;
    if (params.coverImage != null && params.coverImage.hasBinary) {
      body['cover_file'] = params.coverImage;
      body.removeWhere((key, value) => value == null);
      final res = await client.multipartRequest(
        method: Method.post,
        url: url,
        body: body,
        progress: progress,
      );
      return OpenChannel.fromJsonAndCached(res);
    } else {
      body['cover_url'] = params.coverImage?.url;
      body.removeWhere((key, value) => value == null);
      final res = await client.post(url: url, body: body);
      final channel = OpenChannel.fromJsonAndCached(res);
      return channel;
    }
  }

  Future<OpenChannel> updateOpenChannel(
    OpenChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    var body = {
      'channel_url': params.channelUrl,
      'name': params.name,
      'data': params.data,
      'custom_type': params.customType,
      if (params.operatorUserIds != null)
        'operator_ids': params.operatorUserIds,
    };

    final url = endpoint.OpenChannels.channelurl.format([params.channelUrl]);
    if (params.coverImage != null && params.coverImage.hasBinary) {
      body['cover_file'] = params.coverImage;
      body.removeWhere((key, value) => value == null);
      final res = await client.multipartRequest(
        method: Method.put,
        url: url,
        body: body,
        progress: progress,
      );
      return OpenChannel.fromJsonAndCached(res);
    } else {
      body['cover_url'] = params.coverImage?.url;
      body.removeWhere((key, value) => value == null);
      final res = await client.put(url: url, body: body);
      return OpenChannel.fromJsonAndCached(res);
    }
  }

  Future<GroupChannel> createGroupChannel(
    GroupChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    final body = {
      'name': params.name,
      'user_ids': params.userIds,
      'custom_type': params.customType,
      'data': params.data,
      'channel_url': params.channelUrl,
      'is_super': params.isSuper,
      'is_broadcast': params.isBroadcast,
      'is_public': params.isPublic,
      if (params.isPublic) 'is_discoverable': params.isDiscoverable,
      'is_ephemeral': params.isEphemeral,
      'is_distinct': params.isDistinct,
      if (params.isPublic) 'access_code': params.accessCode,
      if (params.operatorUserIds != null)
        'operator_ids': params.operatorUserIds,
      // 'message_survival_seconds': params.
    };
    final url = endpoint.GroupChannels.origin;
    if (params.coverImage != null && params.coverImage.hasBinary) {
      body['cover_file'] = params.coverImage;
      body.removeWhere((key, value) => value == null);
      final res = await client.multipartRequest(
        method: Method.post,
        url: url,
        body: body,
        progress: progress,
      );
      return GroupChannel.fromJsonAndCached(res);
    } else {
      body['cover_url'] = params.coverImage?.url;
      body.removeWhere((key, value) => value == null);
      final res = await client.post(url: url, body: body);
      return GroupChannel.fromJsonAndCached(res);
    }
  }

  Future<GroupChannel> updateGroupChannel(
    GroupChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    final body = {
      'name': params.name,
      'user_ids': params.userIds,
      'custom_type': params.customType,
      'data': params.data,
      'channel_url': params.channelUrl,
      'is_public': params.isPublic,
      if (params.isPublic) 'is_discoverable': params.isDiscoverable,
      'is_distinct': params.isDistinct,
      'access_code': params.accessCode,
      if (params.operatorUserIds != null)
        'operator_ids': params.operatorUserIds,
    };

    final url = endpoint.GroupChannels.channelurl.format([params.channelUrl]);
    if (params.coverImage != null && params.coverImage.hasBinary) {
      body['cover_file'] = params.coverImage;
      body.removeWhere((key, value) => value == null);
      final res = await client.multipartRequest(
        method: Method.put,
        url: url,
        body: body,
        progress: progress,
      );
      return GroupChannel.fromJsonAndCached(res);
    } else {
      body['cover_url'] = params.coverImage?.url;
      body.removeWhere((key, value) => value == null);
      final res = await client.put(url: url, body: body);
      return GroupChannel.fromJsonAndCached(res);
    }
  }

  Future<BaseChannel> getChannel({
    @required ChannelType channelType,
    @required String channelUrl,
    @required bool passive,
    List<ChannelQueryIncludeOption> options,
  }) async {
    var url = passive
        ? endpoint.Channels.channelurl_passively
        : endpoint.Channels.channelurl;
    url = url.format([channelType.urlString, channelUrl]);

    final res = await client.get(url: url, queryParams: options.toJson());
    final ts = DateTime.now().millisecondsSinceEpoch;
    return channelType == ChannelType.group
        ? GroupChannel.fromJsonAndCached(res, ts: ts)
        : OpenChannel.fromJsonAndCached(res, ts: ts);
  }

  Future<void> deleteChannel({
    @required ChannelType channelType,
    @required String channelUrl,
  }) async {
    final url = endpoint.Channels.channelurl.format([
      channelType.urlString,
      channelUrl,
    ]);
    await client.delete(url: url);
  }

  Future<int> hideGroupChannel({
    @required String channelUrl,
    bool hidePreviousMessages = false,
    bool allowAutoUnhide,
  }) async {
    final url = endpoint.GroupChannels.channelurl_hide.format([channelUrl]);
    final body = {
      'user_id': currentUserId,
      'hide_previous_messages': hidePreviousMessages,
      'allow_auto_unhide': allowAutoUnhide,
    };

    final res = await client.put(url: url, body: body);
    return res['ts_message_offset'] as int;
  }

  Future<void> unhideGroupChannel({@required String channelUrl}) async {
    final url = endpoint.GroupChannels.channelurl_hide.format([channelUrl]);
    await client.delete(url: url);
  }

  Future<int> resetGroupChannelHistory({
    @required String channelUrl,
    bool resetAll,
  }) async {
    final url =
        endpoint.GroupChannels.channelurl_reset_history.format([channelUrl]);
    final body = {'user_id': currentUserId, 'reset_all': resetAll};
    final res = await client.put(url: url, body: body);
    return res['ts_message_offset'];
  }

  Future<GroupChannel> joinGroupChannel({
    @required String channelUrl,
    String accessCode,
    String userId,
  }) async {
    final url = endpoint.GroupChannels.channelurl_join.format([channelUrl]);
    final body = {
      'user_id': userId ?? currentUserId,
      if (accessCode != null) 'access_code': accessCode,
    };
    final res = await client.put(url: url, body: body);
    return GroupChannel.fromJsonAndCached(res);
  }

  Future<void> leaveGroupChannel({
    @required String channelUrl,
    String userId,
  }) async {
    final url = endpoint.GroupChannels.channelurl_leave.format([channelUrl]);
    await client.put(url: url, body: {'user_id': userId ?? currentUserId});
  }

  Future<ScheduledUserMessage> registerScheduleUserMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required ScheduledUserMessageParams params,
    @required String userId,
    bool markAsRead = false,
  }) async {
    final url = endpoint.Channels.channelurl_scheduled_message.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {
      'user_id': userId,
      'mark_as_read': markAsRead,
    };
    body.addAll(params.toJson());
    final res = await client.post(url: url, body: body);
    return ScheduledUserMessage.fromJson(res);
  }

  Future<void> deleteMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required int messageId,
  }) async {
    final url = endpoint.Channels.channelurl_messages_messageid.format([
      channelType.urlString,
      channelUrl,
      messageId,
    ]);
    await client.delete(url: url);
  }

  Future<ChannelChangeLogsResponse> getGroupChannelChangeLogs({
    @required GroupChannelChangeLogsParams params,
    @required String userId,
    String token,
    int timestamp,
  }) async {
    if (params == null || userId == null) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_groupchannel_changelogs.format([userId]);
    var queryParams = <String, dynamic>{};
    queryParams.addAll(params.toJson());
    if (timestamp != null && timestamp > 0) {
      queryParams['change_ts'] = timestamp;
    } else if (token != null) queryParams['token'] = token;

    final res = await client.get(url: url, queryParams: queryParams);
    return ChannelChangeLogsResponse.fromJson(res);
  }

  Future<GroupChannel> inviteUsers({
    @required List<String> userIds,
    @required String channelUrl,
    @required String inviterId,
  }) async {
    final url = endpoint.GroupChannels.channelurl_invite.format([channelUrl]);
    final body = {'user_ids': userIds, 'inviter_id': inviterId};
    final res = await client.post(url: url, body: body);
    return GroupChannel.fromJsonAndCached(res);
  }

  Future<void> acceptInvitation({
    @required String channelUrl,
    String accessCode,
    String userId,
  }) async {
    final url = endpoint.GroupChannels.channelurl_accept.format([channelUrl]);
    final body = {
      if (accessCode != null) 'access_code': accessCode,
      'user_id': userId ?? currentUserId,
    };
    await client.put(url: url, body: body);
  }

  Future<void> declineInvitation({
    @required String channelUrl,
    String userId,
  }) async {
    final url = endpoint.GroupChannels.channelurl_decline.format([channelUrl]);
    await client.put(url: url, body: {'user_id': userId ?? currentUserId});
  }

  Future<void> markAsRead({
    List<String> channelUrls,
    String userId,
  }) async {
    final url = endpoint.Users.userid_readall.format([userId]);
    final body = {
      'user_id': userId,
      if (channelUrls != null && channelUrls.isNotEmpty)
        'channel_urls': channelUrls,
    };
    await client.put(url: url, body: body);
  }

  Future<void> markAsDelivered({
    @required String channelUrl,
    @required String userId,
    int timestamp,
  }) async {
    final url = endpoint.GroupChannels.channelurl_messages_delivered
        .format([channelUrl]);
    final body = {
      'user_id': userId,
      'ts': timestamp,
    };
    await client.put(url: url, body: body);
  }

  Future<int> getGroupChannelCount({
    @required MemberStateFilter memberFilter,
    @required String userId,
  }) async {
    final url = endpoint.Users.userid_groupchannel_count.format([userId]);
    final params = {'state': memberStateFilterEnumMap[memberFilter]};
    final res = await client.get(url: url, queryParams: params);
    return res['group_channel_count'];
  }

  Future<void> notifyScreenshotWasTaken(String channelUrl) async {
    final url =
        endpoint.GroupChannels.channelurl_screenshot.format([channelUrl]);
    await client.post(url: url);
  }

  // moderation

  Future<void> banUser({
    @required String userId,
    @required ChannelType channelType,
    @required String channelUrl,
    String description,
    int seconds = -1,
  }) async {
    final url = endpoint.Channels.channelurl_ban.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {
      'user_id': userId,
      'seconds': seconds,
      if (description != null) 'description': description,
    };
    await client.post(url: url, body: body);
  }

  Future<void> unbanUser({
    @required String userId,
    @required ChannelType channelType,
    @required String channelUrl,
  }) async {
    final url = endpoint.Channels.channelurl_ban_banned_userid.format([
      channelType.urlString,
      channelUrl,
      userId,
    ]);
    await client.delete(url: url);
  }

  Future<void> muteUser({
    @required String userId,
    @required ChannelType channelType,
    @required String channelUrl,
    String description,
    int seconds = -1,
  }) async {
    final url = endpoint.Channels.channelurl_mute.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {
      'user_id': userId,
      'seconds': seconds,
      if (description != null) 'description': description,
    };
    await client.post(url: url, body: body);
  }

  Future<void> unmuteUser({
    @required String userId,
    @required ChannelType channelType,
    @required String channelUrl,
  }) async {
    final url = endpoint.Channels.channelurl_mute_muted_userid.format([
      channelType.urlString,
      channelUrl,
      userId,
    ]);
    await client.delete(url: url);
  }

  Future<MuteInfoResponse> getMuteInfo({
    @required ChannelType channelType,
    @required String channelUrl,
    String userId,
  }) async {
    final url = endpoint.Channels.channelurl_mute_muted_userid.format([
      channelType.urlString,
      channelUrl,
      userId ?? currentUserId,
    ]);
    final res = await client.get(url: url);
    return MuteInfoResponse.fromJson(res);
  }

  Future<void> freezeChannel({
    @required ChannelType channelType,
    @required String channelUrl,
    @required bool freeze,
  }) async {
    final url = endpoint.Channels.channelurl_freeze.format([
      channelType.urlString,
      channelUrl,
    ]);
    await client.put(url: url, body: {'freeze': freeze});
  }

  Future<void> reportUser({
    @required String userId,
    @required ChannelType channelType,
    @required String channelUrl,
    @required ReportCategory category,
    String reporterId,
    String description,
  }) async {
    final url = endpoint.Misc.report_userid.format([userId]);
    final body = {
      'channel_type': channelType.urlString,
      'channel_url': channelUrl,
      'report_category': category.asString(),
      'reporting_user_id': reporterId,
      if (description != null) 'report_description': description
    };
    await client.post(url: url, body: body);
  }

  Future<void> reportChannel({
    @required ChannelType channelType,
    @required String channelUrl,
    @required ReportCategory category,
    String description,
  }) async {
    final url = endpoint.Misc.report_channelurl.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {
      'reporting_user_id': currentUserId,
      'report_category': category.asString(),
      if (description != null) 'report_description': description
    };
    await client.post(url: url, body: body);
  }

  Future<void> reportMessage({
    @required int messageId,
    @required String senderId,
    @required ChannelType channelType,
    @required String channelUrl,
    @required ReportCategory category,
    String description,
  }) async {
    final url = endpoint.Misc.report_channelurl_messageid.format([
      channelType.urlString,
      channelUrl,
      messageId,
    ]);
    final body = {
      'reporting_user_id': currentUserId,
      'offending_user_id': senderId,
      'report_category': category.asString(),
      if (description != null) 'report_description': description
    };
    await client.post(url: url, body: body);
  }

  // messages

  Future<UserMessage> sendUserMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required UserMessageParams params,
    @required String senderId,
    List<String> additionalMentionedUserIds,
    bool markAsRead,
  }) async {
    final url = endpoint.Channels.channelurl_messages.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {
      'message_type': CommandType.userMessage,
      'user_id': senderId,
      'mark_as_read': markAsRead ?? false,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);

    final res = await client.post(url: url, body: body);
    return BaseMessage.msgFromJson<UserMessage>(res, channelType: channelType);
  }

  Future<UserMessage> updateUserMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required int messageId,
    @required UserMessageParams params,
    @required String senderId,
    List<String> additionalMentionedUserIds,
  }) async {
    final url = endpoint.Channels.channelurl_messages_messageid.format([
      channelType.urlString,
      channelUrl,
      messageId,
    ]);

    final body = {
      'message_type': CommandType.userMessage,
      'user_id': senderId,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);

    final res = await client.put(url: url, body: body);
    return BaseMessage.msgFromJson<UserMessage>(res, channelType: channelType);
  }

  Future<FileMessage> sendFileMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required FileMessageParams params,
    @required String senderId,
    List<Thumbnail> thumbnails,
    bool markAsRead = false,
    bool requireAuth = false,
    List<String> additionalMentionedUserIds,
  }) async {
    final url = endpoint.Channels.channelurl_messages.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {
      'message_type': CommandType.fileMessage,
      'user_id': senderId,
      'mark_as_read': markAsRead ?? false,
      'require_auth': requireAuth,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);

    final res = await client.post(url: url, body: body);
    return BaseMessage.msgFromJson<FileMessage>(res, channelType: channelType);
  }

  Future<FileMessage> updateFileMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required int messageId,
    @required FileMessageParams params,
    @required String senderId,
    List<String> additionalMentionedUserIds,
  }) async {
    final url = endpoint.Channels.channelurl_messages_messageid.format([
      channelType.urlString,
      channelUrl,
      messageId,
    ]);

    final body = {
      'message_type': CommandType.fileMessage,
      'user_id': senderId,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);

    final res = await client.put(url: url, body: body);
    return BaseMessage.msgFromJson<FileMessage>(res, channelType: channelType);
  }

  Future<UploadResponse> uploadFile({
    @required String channelUrl,
    @required String requestId,
    @required FileMessageParams params,
    OnUploadProgressCallback progress,
  }) async {
    if (!params.uploadFile.hasBinary) {
      throw InvalidParameterError();
    }

    final fileSize = params.uploadFile.file?.lengthSync() ?? 0;
    if (fileSize == 0) {
      throw InvalidParameterError();
    }

    if (fileSize > uploadSizeLimit) {
      throw FileSizeLimitExceededError();
    }

    final url = endpoint.Misc.storage_upload_file;
    var body = {
      'channel_url': channelUrl,
      'request_id': requestId,
      'file': params.uploadFile
    };

    params.thumbnailSizes?.asMap()?.forEach((index, value) =>
        body['thumbnail${index + 1}'] =
            '${value.width.round()},${value.height.round()}');

    try {
      final res = await client.multipartRequest(
        method: Method.post,
        url: url,
        body: body,
        progress: progress,
      );
      return UploadResponse.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }

  // https://github.com/dart-lang/http/issues/424
  bool cancelUploadingFile(String requestId) {
    return client.cancelUploadRequest(requestId);
  }

  Future<UserMessage> translateUserMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required int messageId,
    @required List<String> targetLanguages,
  }) async {
    final url =
        endpoint.Channels.channelurl_messages_messageid_translation.format([
      channelType.urlString,
      channelUrl,
      messageId,
    ]);
    final body = {'target_langs': targetLanguages};
    final res = await client.post(url: url, body: body);
    return BaseMessage.msgFromJson<UserMessage>(res, channelType: channelType);
  }

  Future<BaseMessage> getMessage({
    @required ChannelType channelType,
    @required String channelUrl,
    @required int messageId,
    @required MessageRetrievalParams params,
  }) async {
    final url = endpoint.Channels.channelurl_messages_messageid
        .format([channelType.urlString, channelUrl, messageId]);
    final queryParams = params.toJson();

    final res = await client.get(url: url, queryParams: queryParams);
    return BaseMessage.msgFromJson(res, channelType: channelType);
  }

  Future<List<BaseMessage>> getMessages({
    @required ChannelType channelType,
    @required String channelUrl,
    @required Map<String, dynamic> params,
    int messageId,
    int timestamp,
    int parentMessageId,
  }) async {
    final url = endpoint.Channels.channelurl_messages
        .format([channelType.urlString, channelUrl]);
    var queryParams = params; //params.toJson();

    queryParams['is_sdk'] = true;
    if (messageId != null && messageId > 0) {
      queryParams['message_id'] = messageId;
    } else {
      queryParams['message_ts'] = timestamp;
    }

    if (parentMessageId != null && parentMessageId > 0) {
      queryParams['root_message_id'] = parentMessageId;
    }

    final res = await client.get(url: url, queryParams: queryParams);
    return (res['messages'] as List)
        .map((e) => BaseMessage.msgFromJson(e, channelType: channelType))
        .toList()
          ..removeWhere((e) => e == null);
  }

  Future<MessageChangeLogsResponse> getMessageChangeLogs({
    @required ChannelType channelType,
    @required String channelUrl,
    @required MessageChangeLogParams params,
    String token,
    int timestamp,
  }) async {
    final url = endpoint.Channels.channelurl_messages_changelogs
        .format([channelType.urlString, channelUrl]);
    var queryParams = params.toJson();
    if (token != null) {
      queryParams['token'] = token;
    } else {
      queryParams['change_ts'] = timestamp;
    }
    final res = await client.get(url: url, queryParams: queryParams);
    return MessageChangeLogsResponse.fromJson(res);
  }
  // MetaData

  Future<Map<String, dynamic>> createUserMetaData(
      {Map<String, String> metaData, String userId}) async {
    final url =
        endpoint.Users.userid_metadata.format([userId ?? currentUserId]);
    final body = {'metadata': metaData, 'upsert': true};
    final res = await client.post(url: url, body: body);
    return res;
  }

  Future<Map<String, dynamic>> updateUserMetaData({
    @required Map<String, String> metaData,
    String userId,
    bool upsert = true,
  }) async {
    final url =
        endpoint.Users.userid_metadata.format([userId ?? currentUserId]);
    final body = {'metadata': metaData, 'upsert': upsert};
    final res = await client.put(url: url, body: body);
    return res;
  }

  Future<void> deleteUserMetaData(String key, {String userId}) async {
    final url = endpoint.Users.userid_metadata_key
        .format([userId ?? currentUserId, key]);
    await client.delete(url: url);
  }

  Future<void> deleteAllUserMetaData({String userId}) async {
    final url =
        endpoint.Users.userid_metadata.format([userId ?? currentUserId]);
    await client.delete(url: url);
  }

  Future<MetaDataResponse> createChannelMetaData({
    @required ChannelType channelType,
    @required String channelUrl,
    @required Map<String, String> metaData,
  }) async {
    final url = endpoint.Channels.channelurl_metadata.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {'metadata': metaData, 'upsert': true};
    final res = await client.post(
      url: url,
      body: body,
      queryParams: {'include_ts': true},
    );
    return MetaDataResponse.fromJson(res);
  }

  Future<MetaDataResponse> updateChannelMetaData({
    @required ChannelType channelType,
    @required String channelUrl,
    @required Map<String, String> metaData,
    bool upsert = true,
  }) async {
    final url = endpoint.Channels.channelurl_metadata.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {'metadata': metaData, 'upsert': upsert};
    final res = await client.put(
      url: url,
      body: body,
      queryParams: {'include_ts': true},
    );
    return MetaDataResponse.fromJson(res);
  }

  Future<MetaDataResponse> getChannelMetaData({
    @required ChannelType channelType,
    @required String channelUrl,
    List<String> keys,
  }) async {
    final url = endpoint.Channels.channelurl_metadata.format([
      channelType.urlString,
      channelUrl,
    ]);
    final queryParams = <String, dynamic>{'include_ts': true};
    if (keys != null && keys.isNotEmpty) {
      queryParams['keys'] = keys;
    }
    final res = await client.get(url: url, queryParams: queryParams);
    return MetaDataResponse.fromJson(res);
  }

  Future<int> deleteChannelMetaData({
    @required ChannelType channelType,
    @required String channelUrl,
    @required String key,
  }) async {
    final url = endpoint.Channels.channelurl_metadata_key.format([
      channelType.urlString,
      channelUrl,
      key,
    ]);
    final res = await client.delete(
      url: url,
      queryParams: {'include_ts': true},
    );
    return res['ts'] as int;
  }

  Future<int> deleteAllChannelMetaData({
    @required ChannelType channelType,
    @required String channelUrl,
  }) async {
    final url = endpoint.Channels.channelurl_metadata.format([
      channelType.urlString,
      channelUrl,
    ]);
    final res = await client.delete(
      url: url,
      queryParams: {'include_ts': true},
    );
    return res['ts'] as int;
  }

  // MetaCounter

  Future<Map<String, int>> createChannelMetaCounters({
    @required ChannelType channelType,
    @required String channelUrl,
    @required Map<String, int> metaCounters,
  }) async {
    final url = endpoint.Channels.channelurl_metacounter.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {'metacounter': metaCounters};
    final res = await client.post(url: url, body: body);
    return Map<String, int>.from(res);
  }

  Future<Map<String, int>> updateChannelMetaCounters({
    @required ChannelType channelType,
    @required String channelUrl,
    @required Map<String, int> metaCounters,
    MetaCounterMode mode,
    bool upsert = true,
  }) async {
    final url = endpoint.Channels.channelurl_metacounter.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {
      'metacounter': metaCounters,
      'upsert': upsert,
      'mode': mode.asString()
    };
    final res = await client.put(url: url, body: body);
    return Map<String, int>.from(res);
  }

  Future<Map<String, int>> getChannelMetaCounters({
    @required ChannelType channelType,
    @required String channelUrl,
    List<String> keys,
  }) async {
    final url = endpoint.Channels.channelurl_metacounter.format([
      channelType.urlString,
      channelUrl,
    ]);
    final queryParams = <String, dynamic>{};
    if (keys != null && keys.isNotEmpty) {
      queryParams['keys'] = keys;
    }
    final res = await client.get(url: url, queryParams: queryParams);
    return Map<String, int>.from(res);
  }

  Future<void> deleteChannelMetaCounter({
    @required ChannelType channelType,
    @required String channelUrl,
    @required String key,
  }) async {
    final url = endpoint.Channels.channelurl_metacounter_key.format([
      channelType.urlString,
      channelUrl,
      key,
    ]);
    await client.delete(url: url);
  }

  Future<void> deleteAllChannelMetaCounters({
    @required ChannelType channelType,
    @required String channelUrl,
  }) async {
    final url = endpoint.Channels.channelurl_metacounter.format([
      channelType.urlString,
      channelUrl,
    ]);
    await client.delete(url: url);
  }

  // configurations

  Future<void> setAutoAcceptInvitation(bool autoAccept, {String userId}) async {
    if (autoAccept == null) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_channel_invitation_preference
        .format([userId ?? currentUserId]);
    await client.put(url: url, body: {'auto_accept': autoAccept});
  }

  Future<bool> getAutoAcceptInvitation() async {
    final url = endpoint.Users.userid_channel_invitation_preference
        .format([currentUserId]);
    final res = await client.get(url: url);
    return res['auto_accept'] as bool;
  }

  Future<void> setDoNotDisturb({
    @required bool enable,
    @required int startHour,
    @required int startMin,
    @required int endHour,
    @required int endMin,
    @required String timezone,
  }) async {
    if (enable == null) {
      throw InvalidParameterError();
    }
    if (enable && startHour < 0 ||
        startHour > 23 ||
        startMin < 0 ||
        startMin > 59 ||
        endHour < 0 ||
        endHour > 23 ||
        endMin < 0 ||
        endMin > 59) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final body = {
      'do_not_disturb': enable,
      'start_hour': startHour,
      'start_min': startMin,
      'end_hour': endHour,
      'end_min': endMin,
      'timezone': timezone
    };

    await client.put(url: url, body: body);
  }

  Future<DoNotDisturbResponse> getDoNotDisturb() async {
    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final res = await client.get(url: url);
    return DoNotDisturbResponse.fromJson(res);
  }

  Future<void> setSnoozePeriod({
    @required bool enable,
    @required DateTime startDate,
    @required DateTime endDate,
  }) async {
    if (enable) {
      if (startDate == null || endDate == null) throw InvalidParameterError();
      if (endDate.difference(startDate).inSeconds < 0) {
        throw InvalidParameterError();
      }
    }

    if (enable == null) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final body = {
      'snooze_enabled': enable,
      'snooze_start_ts': startDate.millisecondsSinceEpoch,
      'snooze_end_ts': endDate.millisecondsSinceEpoch
    };
    await client.put(url: url, body: body);
  }

  Future<SnoozeResponse> getSnoozePeriod() async {
    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final res = await client.get(url: url);
    return SnoozeResponse.fromJson(res);
  }

  Future<PushTriggerOption> setPushTriggerOption(
    PushTriggerOption option,
  ) async {
    if (option == null) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final body = {'push_trigger_option': pushTriggerOptionEnumMap[option]};
    final res = await client.put(url: url, body: body);
    return enumDecode(
      pushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: PushTriggerOption.all,
    );
  }

  Future<PushTriggerOption> getPushTriggerOption() async {
    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final res = await client.get(url: url);
    return enumDecode(
      pushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: PushTriggerOption.all,
    );
  }

  Future<GroupChannelPushTriggerOption> setGroupChannelPushTriggerOption({
    @required String channelUrl,
    @required GroupChannelPushTriggerOption option,
  }) async {
    final url = endpoint.Users.userid_push_preference_channelurl.format([
      currentUserId,
      channelUrl,
    ]);
    final body = {
      'push_trigger_option': groupChannelPushTriggerOptionEnumMap[option]
    };
    final res = await client.put(url: url, body: body);
    return enumDecode(
      groupChannelPushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: GroupChannelPushTriggerOption.global,
    );
  }

  Future<GroupChannelPushTriggerOption> getGroupChannelPushTriggerOption(
    String channelUrl,
  ) async {
    final url = endpoint.Users.userid_push_preference_channelurl.format([
      currentUserId,
      channelUrl,
    ]);
    final res = await client.get(url: url);
    return enumDecode(
      groupChannelPushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: GroupChannelPushTriggerOption.global,
    );
  }

  Future<CountPreference> setCountPreference({
    String channelUrl,
    CountPreference prefs,
  }) async {
    final url = endpoint.Users.userid_count_preference_channelurl.format([
      currentUserId,
      channelUrl,
    ]);
    final body = {'count_preference': countPreferenceEnumMap[prefs]};
    final res = await client.put(url: url, body: body);
    return enumDecode<CountPreference>(
      countPreferenceEnumMap,
      res['count_preference'],
      unknownValue: CountPreference.all,
    );
  }

  Future<void> setPushSound(String sound) async {
    if (sound == null || sound.isEmpty) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final body = {'push_sound': sound};
    await client.put(url: url, body: body);
  }

  Future<String> getPushSound() async {
    final url = endpoint.Users.userid_push_preference.format([currentUserId]);
    final res = await client.get(url: url);
    return res['push_sound'];
  }

  Future<void> setPushTemplate(String name) async {
    if (name == null || name.isEmpty) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_push_template.format([currentUserId]);
    final body = {'name': name};
    await client.put(url: url, body: body);
  }

  Future<String> getPushTemplate() async {
    final url = endpoint.Users.userid_push_template.format([currentUserId]);
    final res = await client.get(url: url);
    return res['name'];
  }

  // push

  Future<PushTokenRegistrationStatus> registerPushToken({
    @required PushTokenType type,
    @required String token,
    bool unique = true,
  }) async {
    final typeString = type == PushTokenType.fcm ? 'gcm' : type.asString();
    final url = endpoint.Users.userid_push_tokentype.format([
      currentUserId,
      typeString,
    ]);

    final body = {
      if (type == PushTokenType.fcm) 'gcm_reg_token': token,
      if (type == PushTokenType.apns) 'apns_device_token': token,
      'is_unique': unique,
    };

    await client.post(url: url, body: body);
    return PushTokenRegistrationStatus.success;
  }

  Future<void> unregisterPushToken({PushTokenType type, String token}) async {
    final typeString = type == PushTokenType.fcm ? 'gcm' : type.asString();
    final url = endpoint.Users.userid_push_tokentype_token.format([
      currentUserId,
      typeString,
      token,
    ]);
    await client.delete(url: url);
  }

  Future<void> unregisterAllPushToken(PushTokenType type) async {
    final url = endpoint.Users.userid_push.format([currentUserId]);
    await client.delete(url: url);
  }

  // users
  Future<User> blockUser(String targetId) async {
    if (targetId == null || targetId.isEmpty) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid_block.format([currentUserId]);
    final body = {'target_id': targetId};
    final res = await client.post(url: url, body: body);
    return User.fromJson(res);
  }

  Future<void> unblockUser(String targetId) async {
    if (targetId == null || targetId.isEmpty) {
      throw InvalidParameterError();
    }

    final url =
        endpoint.Users.userid_block_targetid.format([currentUserId, targetId]);
    await client.delete(url: url);
  }

  Future<int> getTotalUnreadMessageCount({
    List<String> customTypes,
    SuperChannelFilter filter = SuperChannelFilter.all,
  }) async {
    final url =
        endpoint.Users.userid_unread_message_count.format([currentUserId]);
    final params = {
      'custom_types': customTypes,
      'super_mode': groupChannelSuperFilterEnumMap[filter],
    };
    final res = await client.get(url: url, queryParams: params);
    return res['unread_count'];
  }

  Future<int> getTotalUnreadChannelCount({@required String userId}) async {
    final url = endpoint.Users.userid_unread_channel_count.format([userId]);
    final res = await client.get(url: url);
    return res['unread_count'];
  }

  Future<UnreadItemCount> getUnreadItemCount({
    @required List<UnreadItemKey> keys,
    @required String userId,
  }) async {
    final url = endpoint.Users.userid_unread_item_count.format([userId]);
    final params = {
      'item_keys': keys.map((e) => unreadItemKeyEnumMap[e]).toList()
    };
    final res = await client.get(url: url, queryParams: params);
    return UnreadItemCount.fromJson(res);
  }

  Future<User> updateUser({
    @required String userId,
    String nickname,
    FileInfo fileInfo,
    List<String> discoveryKeys,
    List<String> preferredLanguages,
    OnUploadProgressCallback progress,
  }) async {
    if (nickname == null && fileInfo == null && preferredLanguages == null) {
      throw InvalidParameterError();
    }

    final url = endpoint.Users.userid.format([userId]);
    if (fileInfo?.hasBinary ?? false) {
      final body = {
        'nickname': nickname,
        'profile_file': uploadFile,
        'discovery_keys': discoveryKeys,
        'preferred_languages': preferredLanguages,
      };
      body.removeWhere((key, value) => value == null);
      final res = await client.multipartRequest(
        method: Method.put,
        url: url,
        body: body,
        progress: progress,
      );
      return User.fromJson(res);
    } else {
      final body = {
        'nickname': nickname,
        'profile_url': fileInfo?.url,
        'discovery_keys': discoveryKeys,
        'preferred_languages': preferredLanguages,
      };
      body.removeWhere((key, value) => value == null);
      final res = await client.put(url: url, body: body);
      return User.fromJson(res);
    }
  }

  Future<void> addOperators({
    @required ChannelType channelType,
    @required String channelUrl,
    @required List<String> userIds,
  }) async {
    final url = endpoint.Channels.channelurl_operators.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {'operator_ids': userIds};
    await client.post(url: url, body: body);
  }

  Future<void> removeOperators({
    @required ChannelType channelType,
    @required String channelUrl,
    @required List<String> userIds,
  }) async {
    final url = endpoint.Channels.channelurl_operators.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {'operator_ids': userIds};
    await client.delete(url: url, body: body);
  }

  Future<void> removeAllOperators({
    @required ChannelType channelType,
    @required String channelUrl,
  }) async {
    final url = endpoint.Channels.channelurl_operators.format([
      channelType.urlString,
      channelUrl,
    ]);
    final body = {'delete_all': true};
    await client.delete(url: url, body: body);
  }

  Future<Map<String, dynamic>> updateSessionKey({
    String appId,
    String accessToken,
    bool expiringSession,
  }) async {
    final url = endpoint.Users.userid_session_key.format([currentUserId]);
    final body = {'expiring_session': expiringSession};
    var headers = {'App-Id': appId};
    if (accessToken != null) {
      headers['Access-Token'] = accessToken;
    }

    final res = await client.post(url: url, body: body, headers: headers);
    return Map.from(res);
  }

  //fetch list

  Future<ChannelListQueryResponse> getOpenChannels({
    String channelName,
    String channelUrl,
    String customType,
    List<ChannelQueryIncludeOption> options,
    String token,
    int limit = 30,
  }) async {
    final url = endpoint.OpenChannels.origin;
    final params = <String, dynamic>{
      'token': token,
      'limit': limit.toString(),
      'name_contains': channelName,
      'url_contains': channelUrl,
      'custom_type': customType,
    };

    params.addAll(options.toJson());
    params.removeWhere((key, value) => value == null);

    final res = await client.get(url: url, queryParams: params);
    return ChannelListQueryResponse()
      ..channels = (res['channels'] as List)
          .map((e) => OpenChannel.fromJsonAndCached(e, ts: res['ts']))
          .toList()
      ..next = res['next'] as String;
  }

  Future<ChannelListQueryResponse> getPublicGroupChannels({
    PublicGroupChannelListOrder order,
    String token,
    int limit = 30,
    List<String> channelUrls,
    List<ChannelQueryIncludeOption> options,
    GroupChannelFilter filter,
  }) async {
    final url = endpoint.GroupChannels.origin;
    final params = {
      'user_id': currentUserId,
      'token': token,
      'limit': limit,
      'channelUrls': channelUrls,
      'order': publicGroupChannelListOrderEnumMap[order],
      'distinct_mode': 'all',
    };

    params.addAll(options.toJson());
    params.addAll(filter.toJson());

    if (order == PublicGroupChannelListOrder.channelMetaDataValueAlphabetical &&
        filter.metadataOrderKey != null) {
      params['metadata_order_key'] = filter.metadataOrderKey;
    }

    params.removeWhere((key, value) => value == null);
    final res = await client.get(url: url, queryParams: params);
    return ChannelListQueryResponse()
      ..channels = (res['channels'] as List)
          .map((e) => GroupChannel.fromJsonAndCached(e, ts: res['ts']))
          .toList()
      ..next = res['next'] as String;
  }

  Future<ChannelListQueryResponse> getMyGroupChannels({
    GroupChannelListOrder order,
    GroupChannelListQueryType queryType,
    String token,
    int limit = 30,
    List<String> channelUrls,
    List<ChannelQueryIncludeOption> options,
    GroupChannelFilter filter,
    String searchQuery,
    List<GroupChannelListQuerySearchField> searchFields,
    @required String userId,
  }) async {
    final url = endpoint.Users.userid_my_groupchannel.format([userId]);
    final searchFieldStrings = stringFromSearchFields(searchFields);
    final params = {
      'user_id': userId,
      'token': token,
      'limit': limit,
      'channelUrls': channelUrls,
      'order': groupChannelListOrderEnumMap[order],
      if (searchFieldStrings.isNotEmpty) 'search_field': searchFieldStrings,
      if (searchFieldStrings.isNotEmpty) 'search_query': searchQuery,
      'distinct_mode': 'all',
      'show_member': true,
    };

    params.addAll(options.toJson());
    params.addAll(filter.toJson());

    if (filter.membersIncludeIn != null && filter.membersIncludeIn.isNotEmpty) {
      params['members_include_in'] = filter.membersIncludeIn;
      params['query_type'] = queryType.asString();
    }

    if (order == GroupChannelListOrder.channelMetaDataValueAlphabetical &&
        filter.metadataOrderKey != null) {
      params['metadata_order_key'] = filter.metadataOrderKey;
    }

    params.removeWhere((key, value) => value == null);
    final res = await client.get(url: url, queryParams: params);
    return ChannelListQueryResponse()
      ..channels = (res['channels'] as List)
          .map((e) => GroupChannel.fromJsonAndCached(e, ts: res['ts']))
          .toList()
      ..next = res['next'] as String;
  }

  Future<UserListQueryResponse> getUsers({
    List<String> userIds,
    String metaDataKey,
    List<String> metaDataValues,
    String nicknameStartsWith,
    String token,
    int limit = 30,
  }) async {
    final url = endpoint.Users.users;
    final params = {
      'limit': limit,
      'token': token,
      'user_ids': userIds,
      'metadatakey': metaDataKey,
      'metadatavalues_in': metaDataValues,
      'nickname_startswith': nicknameStartsWith,
    };
    params.removeWhere((key, value) => value == null);
    final res = await client.get(url: url, queryParams: params);
    return UserListQueryResponse.fromJson(res);
  }

  Future<UserListQueryResponse> getBlockedUsers({
    List<String> userIds,
    String token,
    int limit = 30,
  }) async {
    final url = endpoint.Users.userid_block.format([currentUserId]);
    final params = {
      'limit': limit,
      if (token != null) 'token': token,
      if (userIds != null && userIds.isNotEmpty) 'user_ids': userIds,
    };
    final res = await client.get(url: url, queryParams: params);
    return UserListQueryResponse.fromJson(res);
  }

  Future<UserListQueryResponse> getBannedUsers({
    @required ChannelType type,
    @required String channelUrl,
    String token,
    int limit = 30,
  }) async {
    final url =
        endpoint.Channels.channelurl_ban.format([type.urlString, channelUrl]);
    final params = {
      'limit': limit,
      if (token != null) 'token': token,
    };
    final res = await client.get(url: url, queryParams: params);
    final users =
        List<Map>.from(res['banned_list']).map((e) => e['user']).toList();
    final output = {'users': users, 'next': res['next']};
    return UserListQueryResponse.fromJson(output);
  }

  Future<UserListQueryResponse> getMutedUsers({
    @required ChannelType type,
    @required String channelUrl,
    String token,
    int limit = 30,
  }) async {
    final url =
        endpoint.Channels.channelurl_mute.format([type.urlString, channelUrl]);
    final params = {
      'limit': limit,
      if (token != null) 'token': token,
    };
    final res = await client.get(url: url, queryParams: params);
    final output = {'users': res['muted_list'], 'next': res['next']};
    return UserListQueryResponse.fromJson(output);
  }

  Future<OperatorListQueryResponse> getOperators({
    @required ChannelType channelType,
    @required String channelUrl,
    String token,
    int limit = 30,
  }) async {
    final url = endpoint.Channels.channelurl_operators
        .format([channelType.urlString, channelUrl]);
    final params = {
      'limit': limit.toString(),
      if (token != null) 'token': token,
    };
    final res = await client.get(url: url, queryParams: params);
    return OperatorListQueryResponse.fromJson(res);
  }

  Future<UserListQueryResponse> getGroupChannelMembers({
    @required channelUrl,
    String token,
    int limit,
    OperatorFilter operatorFilter,
    MutedMemberFilter mutedMemberFilter,
    MemberStateFilter memberStateFilter,
    String nicknameStartsWith,
    MemberListOrder order,
  }) async {
    final url = endpoint.GroupChannels.channelurl_members.format([channelUrl]);
    final params = {
      'limit': limit,
      if (token != null) 'token': token,
      'operator_filter': operatorFilterEnumMap[operatorFilter],
      'muted_member_filter': mutedMemberFilterEnumMap[mutedMemberFilter],
      'order': memberListOrderEnumMap[order],
      'member_state_filter': memberStateFilterEnumMap[memberStateFilter],
      'nickname_startswith': nicknameStartsWith,
      //
      'show_read_receipt': 'true',
      'show_delivery_receipt': 'true',
      'show_member_is_muted': 'true',
    };
    final res = await client.get(url: url, queryParams: params);
    final output = {'users': res['members'], 'next': res['next']};
    return UserListQueryResponse.fromJson(output);
  }

  Future<UserListQueryResponse> getOpenChannelParticipants({
    @required channelUrl,
    String token,
    int limit = 30,
  }) async {
    final url = endpoint.OpenChannels.channelurl_members.format([channelUrl]);
    final params = {
      'limit': limit,
      if (token != null) 'token': token,
    };
    final res = await client.get(url: url, queryParams: params);
    final output = {'users': res['participants'], 'next': res['next']};
    return UserListQueryResponse.fromJson(output);
  }

  Future<Emoji> getEmoji(String key) async {
    final url = endpoint.Misc.emoji_emojiid.format([key]);
    final res = await client.get(url: url);
    return Emoji.fromJson(res);
  }

  Future<EmojiCategory> getEmojiCategory(int categoryId) async {
    final url = endpoint.Misc.emoji_categories_categoryid.format([categoryId]);
    final res = await client.get(url: url);
    return EmojiCategory.fromJson(res);
  }

  Future<EmojiContainer> getAllEmojis() async {
    final url = endpoint.Misc.emoji_categories;
    final res = await client.get(url: url);
    return EmojiContainer.fromJson(res);
  }

  Future<MessageSearchQueryResponse> searchMessages({
    String keyword,
    String channelUrl,
    String customType,
    String beforeIndex,
    String afterIndex,
    String token,
    List<String> targetUserIds,
    int startAt,
    int endAt,
    String sortField,
    int limit,
    bool reverse,
    bool exactMatch,
    bool advanced,
    List<String> targetFields,
  }) async {
    final url = endpoint.Misc.search_messages;
    final params = {
      'query': keyword,
      'channel_url': channelUrl,
      'custom_type': customType,
      'limit': limit,
      'before': beforeIndex,
      'after': afterIndex,
      'token': token,
      'target_user_ids': targetUserIds,
      'include_open': false,
      'include_not_joined_public': false,
      'sort_field': sortField,
      'reverse': reverse,
      'exact_match': exactMatch,
      'advanced_query': advanced,
      'target_fields': targetFields,
      if (startAt != 0) 'message_ts_from': startAt,
      if (endAt != 0) 'message_ts_to': endAt,
    };

    params.removeWhere((key, value) => value == null);
    final res = await client.get(url: url, queryParams: params);
    return MessageSearchQueryResponse.fromJson(res);
  }

  Future<ReactionEvent> addReaction({
    @required ChannelType channelType,
    @required String channelUrl,
    @required int messageId,
    @required String key,
    String userId,
  }) async {
    final url = endpoint.Channels.channelurl_messages_messageid_reactions
        .format([channelType.urlString, channelUrl, messageId]);
    final body = {'user_id': userId ?? currentUserId, 'reaction': key};
    final res = await client.post(url: url, body: body);
    return ReactionEvent.fromJson(res);
  }

  Future<ReactionEvent> deleteReaction({
    @required ChannelType channelType,
    @required String channelUrl,
    @required int messageId,
    @required String key,
    String userId,
  }) async {
    final url = endpoint.Channels.channelurl_messages_messageid_reactions
        .format([channelType.urlString, channelUrl, messageId]);
    final body = {'user_id': userId ?? currentUserId, 'reaction': key};
    final res = await client.delete(url: url, body: body);
    return ReactionEvent.fromJson(res);
  }
}
