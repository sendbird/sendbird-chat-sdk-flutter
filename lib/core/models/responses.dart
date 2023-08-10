import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbird_sdk/core/models/restricted_user.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';

part 'responses.g.dart';

DateTime _epochFromJson(int time) => DateTime.fromMillisecondsSinceEpoch(time);
List<int> _deletedIds(List<dynamic> json) =>
    json.map((e) => e['message_id'] as int).toList();

class BaseResponse {}

@JsonSerializable(createToJson: false)
class ChannelChangeLogsResponse extends BaseResponse {
  @JsonKey(defaultValue: [], name: 'updated')
  final List<GroupChannel> updatedChannels;

  @JsonKey(defaultValue: [], name: 'deleted')
  final List<String> deletedChannelUrls;

  @JsonKey(defaultValue: false)
  final bool hasMore;

  final String? next;

  ChannelChangeLogsResponse({
    required this.updatedChannels,
    required this.deletedChannelUrls,
    required this.hasMore,
    this.next,
  });

  static ChannelChangeLogsResponse fromJson(Map<String, dynamic> json) {
    final res = _$ChannelChangeLogsResponseFromJson(json);
    res.updatedChannels.forEach((element) => element.saveToCache());
    return res;
  }
}

@JsonSerializable(createToJson: false)
class PollChangeLogsResponse extends BaseResponse {
  @JsonKey(defaultValue: [], name: 'updated')
  List<Poll>? updatedPolls;

  @JsonKey(name: 'deleted')
  List<double>? deletedPollIds;

  @JsonKey(defaultValue: false)
  final bool hasMore;

  @JsonKey(name: 'next')
  String? token;

  static PollChangeLogsResponse fromJson(Map<String, dynamic> json) =>
      _$PollChangeLogsResponseFromJson(json);

  PollChangeLogsResponse({
    this.updatedPolls,
    this.deletedPollIds,
    required this.hasMore,
    this.token,
  });
}

@JsonSerializable(createToJson: false)
class MessageChangeLogsResponse extends BaseResponse {
  @JsonKey(defaultValue: [], name: 'updated')
  final List<BaseMessage> updatedMessages;

  @JsonKey(fromJson: _deletedIds, name: 'deleted')
  final List<int> deletedMessageIds;

  @JsonKey(defaultValue: false)
  final bool hasMore;

  final String? next;

  MessageChangeLogsResponse({
    required this.updatedMessages,
    required this.deletedMessageIds,
    required this.hasMore,
    this.next,
  });

  static MessageChangeLogsResponse fromJson(Map<String, dynamic> json) =>
      _$MessageChangeLogsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class MuteInfoResponse extends BaseResponse {
  final bool isMuted;
  final String? description;
  final int? startAt;
  final int? endAt;
  final int? remainingDuration;

  MuteInfoResponse({
    required this.isMuted,
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
  final int? startHour;
  final int? startMin;
  final int? endHour;
  final int? endMin;
  final String? timezone;

  DoNotDisturbResponse({
    required this.enabled,
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
  final DateTime? startDate;

  @JsonKey(fromJson: _epochFromJson, name: 'snooze_end_ts')
  final DateTime? endDate;

  SnoozeResponse({required this.enabled, this.startDate, this.endDate});

  static SnoozeResponse fromJson(Map<String, dynamic> json) =>
      _$SnoozeResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class UploadResponse extends BaseResponse {
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

@JsonSerializable(createToJson: false)
class OperatorListQueryResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<User> operators;

  String? next;

  OperatorListQueryResponse({required this.operators, this.next});

  static OperatorListQueryResponse fromJson(Map<String, dynamic> json) =>
      _$OperatorListQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class PollListQueryResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<Poll> polls;

  String? next;

  PollListQueryResponse({this.polls = const [], this.next});

  factory PollListQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$PollListQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class PollVoterListQueryResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<User> voters;
  int? voteCount;

  String? next;

  PollVoterListQueryResponse(
      {this.voters = const [], this.next, this.voteCount});

  factory PollVoterListQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$PollVoterListQueryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class UserListQueryResponse<T extends User> extends BaseResponse {
  @JsonKey(defaultValue: [])
  @UserConverter()
  List<T> users;

  String? next;

  UserListQueryResponse({this.users = const [], this.next});

  factory UserListQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListQueryResponseFromJson<T>(json);
}

@JsonSerializable(createToJson: false)
class ChannelListQueryResponse<T extends BaseChannel> extends BaseResponse {
  @JsonKey(defaultValue: [], name: 'channels')
  @ChannelConverter()
  List<T> channels;
  String? next;

  ChannelListQueryResponse({this.channels = const [], this.next});

  factory ChannelListQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelListQueryResponseFromJson<T>(json);
}

class ChannelConverter<T> implements JsonConverter<T, Object> {
  const ChannelConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('participant_count')) {
        return OpenChannel.fromJsonAndCached(json) as T;
      } else {
        return GroupChannel.fromJsonAndCached(json) as T;
      }
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object as Object;
  }
}

class UserConverter<T> implements JsonConverter<T, Object> {
  const UserConverter();

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

@JsonSerializable(createToJson: false)
class MessageSearchQueryResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<BaseMessage> results;

  @JsonKey(name: 'end_cursor')
  String? next;

  @JsonKey(defaultValue: false)
  bool hasNext;

  @JsonKey(defaultValue: -1)
  int totalCount;

  MessageSearchQueryResponse({
    this.results = const [],
    this.next,
    this.hasNext = false,
    this.totalCount = -1,
  });

  factory MessageSearchQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageSearchQueryResponseFromJson(json);
}

abstract class Serializable {
  Serializable();
  Serializable.fromJson(Map<String, dynamic> json);
}

@JsonSerializable(createToJson: false)
class MetaDataResponse extends Serializable {
  @JsonKey(defaultValue: {})
  Map<String, String> metadata;

  int? ts;

  MetaDataResponse({this.metadata = const {}, this.ts}) : super();

  factory MetaDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaDataResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class MetaCounterResponse extends BaseResponse {
  @JsonKey(defaultValue: {})
  Map<String, num> metaCounter;

  int? ts;

  MetaCounterResponse({this.metaCounter = const {}, this.ts});

  factory MetaCounterResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaCounterResponseFromJson(json);
}

class ThreadedMessageResponse extends BaseResponse {
  BaseMessage parentMessage;

  @JsonKey(defaultValue: [])
  List<BaseMessage> replies;

  ThreadedMessageResponse({
    required this.parentMessage,
    required this.replies,
  });
}

class ChannelMessageResponse extends BaseResponse {
  BaseChannel channel;
  BaseMessage? message;
  int? deletedId;

  ChannelMessageResponse(this.channel, {this.message, this.deletedId});
}

@JsonSerializable()
class ScheduledMessageResponse extends BaseResponse {
  String? next;
  @JsonKey(defaultValue: [])
  List<BaseMessage> scheduledMessages;

  ScheduledMessageResponse({required this.scheduledMessages, this.next});

  factory ScheduledMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduledMessageResponseFromJson(json);
}
