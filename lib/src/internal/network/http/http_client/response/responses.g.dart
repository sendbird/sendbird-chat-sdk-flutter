// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatorListQueryResponse _$OperatorListQueryResponseFromJson(
        Map<String, dynamic> json) =>
    OperatorListQueryResponse(
      operators: (json['operators'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      next: json['next'] as String?,
    );

PollListQueryResponse _$PollListQueryResponseFromJson(
        Map<String, dynamic> json) =>
    PollListQueryResponse(
      polls: (json['polls'] as List<dynamic>?)
              ?.map((e) => Poll.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as String?,
    );

PollVoterListQueryResponse _$PollVoterListQueryResponseFromJson(
        Map<String, dynamic> json) =>
    PollVoterListQueryResponse(
      voters: (json['voters'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      next: json['next'] as String?,
      voteCount: json['vote_count'] as int?,
    );

UserListQueryResponse<T> _$UserListQueryResponseFromJson<T extends User>(
        Map<String, dynamic> json) =>
    UserListQueryResponse<T>(
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => _UserConverter<T>().fromJson(e as Object))
              .toList() ??
          const [],
      next: json['next'] as String?,
    );

ChannelListQueryResponse<T>
    _$ChannelListQueryResponseFromJson<T extends BaseChannel>(
            Map<String, dynamic> json) =>
        ChannelListQueryResponse<T>(
          channels: (json['channels'] as List<dynamic>?)
                  ?.map((e) => _ChannelConverter<T>().fromJson(e as Object))
                  .toList() ??
              const [],
          next: json['next'] as String?,
        );

FeedChannelListQueryResponse _$FeedChannelListQueryResponseFromJson(
        Map<String, dynamic> json) =>
    FeedChannelListQueryResponse(
      channels: (json['channels'] as List<dynamic>?)
              ?.map((e) => const FeedChannelConverter().fromJson(e as Object))
              .toList() ??
          const [],
      next: json['next'] as String?,
    );

MessageSearchQueryResponse _$MessageSearchQueryResponseFromJson(
        Map<String, dynamic> json) =>
    MessageSearchQueryResponse(
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => BaseMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hasNext: json['has_next'] as bool? ?? false,
      totalCount: json['total_count'] as int? ?? -1,
      next: json['end_cursor'] as String?,
    );

MetaDataResponse _$MetaDataResponseFromJson(Map<String, dynamic> json) =>
    MetaDataResponse(
      metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      ts: json['ts'] as int?,
    );

ScheduledMessageResponse _$ScheduledMessageResponseFromJson(
        Map<String, dynamic> json) =>
    ScheduledMessageResponse(
      scheduledMessages: (json['scheduled_messages'] as List<dynamic>?)
              ?.map((e) => BaseMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      next: json['next'] as String?,
    );

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    UploadResponse(
      url: json['url'] as String,
      thumbnails: json['thumbnails'] as List<dynamic>? ?? [],
      requireAuth: json['require_auth'] as bool,
      fileSize: json['file_size'] as int,
    );
