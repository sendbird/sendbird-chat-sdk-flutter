import 'package:json_annotation/json_annotation.dart';

import '../channel/base_channel.dart';
import '../channel/group_channel.dart';
import '../channel/open_channel.dart';
import '../models/user.dart';
import '../message/base_message.dart';
import '../services/db/cache_service.dart';

part 'responses.g.dart';

DateTime _epochFromJson(int time) => DateTime.fromMillisecondsSinceEpoch(time);

class BaseResponse {}

@JsonSerializable(createToJson: false)
class ChannelChangeLogsResponse extends BaseResponse {
  @JsonKey(name: 'updated')
  final List<GroupChannel> updatedChannels;

  @JsonKey(name: 'deleted')
  final List<String> deletedChannelUrls;

  final bool hasMore;

  final String next;

  ChannelChangeLogsResponse({
    this.updatedChannels,
    this.deletedChannelUrls,
    this.hasMore,
    this.next,
  });

  static ChannelChangeLogsResponse fromJson(Map<String, dynamic> json) {
    final res = _$ChannelChangeLogsResponseFromJson(json);
    res.updatedChannels.forEach((element) => element.saveToCache());
    return res;
  }
}

@JsonSerializable(createToJson: false)
class MessageChangeLogsResponse extends BaseResponse {
  @JsonKey(name: 'updated')
  final List<BaseMessage> updatedMessages;

  @JsonKey(name: 'deleted')
  final List<String> deletedMessageIds;

  final bool hasMore;

  final String next;

  MessageChangeLogsResponse({
    this.updatedMessages,
    this.deletedMessageIds,
    this.hasMore,
    this.next,
  });

  static MessageChangeLogsResponse fromJson(Map<String, dynamic> json) =>
      _$MessageChangeLogsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class MuteInfoResponse extends BaseResponse {
  final bool isMuted;
  final String description;
  final int startAt;
  final int endAt;
  final int remainingDuration;

  MuteInfoResponse({
    this.isMuted,
    this.description,
    this.startAt,
    this.endAt,
    this.remainingDuration,
  });

  static MuteInfoResponse fromJson(Map<String, dynamic> json) =>
      _$MuteInfoResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class DoNotDisturbResponse extends BaseResponse {
  @JsonKey(name: 'do_not_disturb')
  final bool enabled;
  final int startHour;
  final int startMin;
  final int endHour;
  final int endMin;
  final String timezone;

  DoNotDisturbResponse({
    this.enabled,
    this.startHour,
    this.startMin,
    this.endHour,
    this.endMin,
    this.timezone,
  });

  static DoNotDisturbResponse fromJson(Map<String, dynamic> json) =>
      _$DoNotDisturbResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class SnoozeResponse extends BaseResponse {
  @JsonKey(name: 'snooze_enabled')
  final bool enabled;

  @JsonKey(fromJson: _epochFromJson, name: 'snooze_start_ts')
  final DateTime startDate;

  @JsonKey(fromJson: _epochFromJson, name: 'snooze_end_ts')
  final DateTime endDate;

  SnoozeResponse({this.enabled, this.startDate, this.endDate});

  static SnoozeResponse fromJson(Map<String, dynamic> json) =>
      _$SnoozeResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class UploadResponse extends BaseResponse {
  final String url;
  final List thumbnails;
  final bool requireAuth;
  final int fileSize;

  UploadResponse({
    this.url,
    this.thumbnails,
    this.requireAuth,
    this.fileSize,
  });

  static UploadResponse fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class OperatorListQueryResponse extends BaseResponse {
  List<User> operators;
  String next;

  OperatorListQueryResponse({this.operators, this.next});

  static OperatorListQueryResponse fromJson(Map<String, dynamic> json) =>
      _$OperatorListQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class UserListQueryResponse extends BaseResponse {
  List<User> users;
  String next;

  UserListQueryResponse({this.users, this.next});

  static UserListQueryResponse fromJson(Map<String, dynamic> json) =>
      _$UserListQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class ChannelListQueryResponse<T extends BaseChannel> extends BaseResponse {
  @JsonKey(name: 'channels')
  @ChannelConverter()
  List<T> channels;
  String next;

  ChannelListQueryResponse({this.channels, this.next});

  factory ChannelListQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelListQueryResponseFromJson<T>(json);
}

class ChannelConverter<T> implements JsonConverter<T, Object> {
  const ChannelConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> && json.containsKey('participant_count')) {
      return OpenChannel.fromJsonAndCached(json) as T;
    }
    return GroupChannel.fromJsonAndCached(json) as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}

@JsonSerializable(createToJson: false)
class MessageSearchQueryResponse extends BaseResponse {
  List<BaseMessage> results;

  @JsonKey(name: 'end_cursor')
  String next;
  bool hasNext;
  int totalCount;

  MessageSearchQueryResponse({
    this.results,
    this.next,
    this.hasNext,
    this.totalCount,
  });

  factory MessageSearchQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageSearchQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class MetaDataResponse extends BaseResponse {
  Map<String, String> metadata;
  int ts;

  MetaDataResponse({this.metadata, this.ts});

  factory MetaDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaDataResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class MetaCounterResponse extends BaseResponse {
  Map<String, num> metaCounter;
  int ts;

  MetaCounterResponse({this.metaCounter, this.ts});

  factory MetaCounterResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaCounterResponseFromJson(json);
}

class ThreadedMessageResponse extends BaseResponse {
  BaseMessage parentMessage;
  List<BaseMessage> replies;

  ThreadedMessageResponse({
    this.parentMessage,
    this.replies,
  });
}

class ChannelMessageResponse extends BaseResponse {
  BaseChannel channel;
  BaseMessage message;
  int deletedId;

  ChannelMessageResponse(this.channel, {this.message, this.deletedId});
}
