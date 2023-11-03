// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/restricted_user.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';

part 'responses.g.dart';

@JsonSerializable(createToJson: false)
class OperatorListQueryResponse {
  @JsonKey(defaultValue: [])
  List<User> operators;

  String? next;

  OperatorListQueryResponse({
    required this.operators,
    this.next,
  });

  static OperatorListQueryResponse fromJson(Map<String, dynamic> json) =>
      _$OperatorListQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class PollListQueryResponse {
  List<Poll> polls;
  String? next;

  PollListQueryResponse({
    this.polls = const [],
    this.next,
  });

  factory PollListQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$PollListQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class PollVoterListQueryResponse {
  List<User> voters;
  int? voteCount;
  String? next;

  PollVoterListQueryResponse({
    this.voters = const [],
    this.next,
    this.voteCount,
  });

  factory PollVoterListQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$PollVoterListQueryResponseFromJson(json);
}

@JsonSerializable()
class UserListQueryResponse<T extends User> {
  @_UserConverter()
  List<T> users;

  String? next;

  UserListQueryResponse({
    this.users = const [],
    this.next,
  });

  factory UserListQueryResponse.fromJsonWithChat(
      Chat chat, Map<String, dynamic> json) {
    final res = _$UserListQueryResponseFromJson<T>(json);
    for (var element in res.users) {
      element.set(chat);
    }
    return res;
  }

  Map<String, dynamic> toJson() => _$UserListQueryResponseToJson(this);
}

@JsonSerializable()
class ChannelListQueryResponse<T extends BaseChannel> {
  @JsonKey(name: 'channels')
  @_ChannelConverter()
  List<T> channels;

  String? next;

  ChannelListQueryResponse({
    this.channels = const [],
    this.next,
  });

  factory ChannelListQueryResponse.fromJsonWithChat(
      Chat chat, Map<String, dynamic> json) {
    final res = _$ChannelListQueryResponseFromJson<T>(json);
    for (var element in res.channels) {
      element.set(chat);
    }
    return res;
  }

  Map<String, dynamic> toJson() => _$ChannelListQueryResponseToJson(this);
}

@JsonSerializable()
class FeedChannelListQueryResponse {
  @JsonKey(name: 'channels')
  @FeedChannelConverter()
  List<FeedChannel> channels;

  String? next;

  FeedChannelListQueryResponse({
    this.channels = const [],
    this.next,
  });

  factory FeedChannelListQueryResponse.fromJsonWithChat(
      Chat chat, Map<String, dynamic> json) {
    final res = _$FeedChannelListQueryResponseFromJson(json);
    for (var element in res.channels) {
      element.set(chat);
    }
    return res;
  }

  Map<String, dynamic> toJson() => _$FeedChannelListQueryResponseToJson(this);
}

@JsonSerializable(createToJson: false)
class MessageSearchQueryResponse {
  @JsonKey(fromJson: toBaseMessageList)
  List<BaseMessage> results;

  bool hasNext;

  int totalCount;

  @JsonKey(name: 'end_cursor')
  String? next;

  MessageSearchQueryResponse({
    this.results = const [],
    this.hasNext = false,
    this.totalCount = -1,
    this.next,
  });

  factory MessageSearchQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageSearchQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class MetaDataResponse {
  Map<String, String> metadata;
  int? ts;

  MetaDataResponse({
    this.metadata = const {},
    this.ts,
  }) : super();

  factory MetaDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaDataResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class ScheduledMessageResponse {
  @JsonKey(fromJson: toBaseMessageList, defaultValue: [])
  List<BaseMessage> scheduledMessages;

  String? next;

  ScheduledMessageResponse({
    required this.scheduledMessages,
    this.next,
  });

  factory ScheduledMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduledMessageResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class UploadResponse {
  final String url;

  @JsonKey(defaultValue: [])
  final List thumbnails;

  final bool requireAuth;
  final int fileSize;

  UploadResponse({
    required this.url,
    required this.thumbnails,
    required this.requireAuth,
    required this.fileSize,
  });

  static UploadResponse fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);
}

class _ChannelConverter<T> implements JsonConverter<T, Object> {
  const _ChannelConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('participant_count')) {
        return OpenChannel.fromJson(json) as T;
      } else {
        return GroupChannel.fromJson(json) as T;
      }
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object as Object;
  }
}

class FeedChannelConverter<T> implements JsonConverter<FeedChannel, Object> {
  const FeedChannelConverter();

  @override
  FeedChannel fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      return FeedChannel.fromJson(json)
        ..set(SendbirdChat().chat); // Set the singleton chat;
    }
    return json as FeedChannel;
  }

  @override
  Object toJson(FeedChannel object) {
    return object;
  }
}

class _UserConverter<T> implements JsonConverter<T, Object> {
  const _UserConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('end_at')) {
        return RestrictedUser.fromJson(json) as T;
      } else if (json.containsKey('muted_end_at') ||
          json.containsKey('is_muted')) {
        return Member.fromJson(json) as T;
      } else {
        return User.fromJson(json) as T;
      }
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object as Object;
  }
}
