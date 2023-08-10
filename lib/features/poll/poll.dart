import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/events/poll_update_event.dart';
import 'package:sendbird_sdk/events/poll_vote_event.dart';
import 'package:sendbird_sdk/features/poll/poll_data.dart';
import 'package:sendbird_sdk/features/poll/poll_option.dart';
import 'package:sendbird_sdk/params/poll_params.dart';
import 'package:sendbird_sdk/params/poll_retrieval_params.dart';
import 'package:sendbird_sdk/request/poll/poll_create_request.dart';
import 'package:sendbird_sdk/request/poll/poll_get_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'poll.g.dart';

/// Represents a poll
@JsonSerializable()
class Poll {
  /// Unique id for this poll
  final int id;

  /// Title of this poll
  @JsonKey(defaultValue: '')
  String title;

  /// Unix timestamp at which the poll is created (millisecond)
  final int createdAt;

  /// Unix timestamp at which the poll is updated (millisecond)
  int updatedAt;

  /// Unix timestamp at which the poll has closed or will close (second).
  /// If this value is -1, it means the poll is indefinitely open.
  int closeAt = -1;

  /// The status of the poll.
  /// The value is one of the following: "open", or "closed".
  PollStatus status;

  final int? messageId;

  /// Additional information to accompany the poll.
  ///Can be used to provide explanations for incorrect quiz answers.
  PollData? data;

  /// Number of voters who casted a vote on the poll
  int voterCount = -1;

  /// Lists of options for this current poll
  List<PollOption> options = [];

  /// ID of the user who has created the poll
  final String? createdBy;

  /// Whether to allow user-suggested options
  bool allowUserSuggestion = false;

  /// Whether to allow multiple vote casting
  bool allowMultipleVotes = false;

  /// List of option ids which the user has voted on.
  @JsonKey(defaultValue: [])
  List<int>? votedPollOptionIds;

  Poll({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.closeAt,
    required this.status,
    this.messageId,
    this.data,
    this.voterCount = -1,
    this.options = const [],
    this.createdBy,
    this.allowUserSuggestion = false,
    this.allowMultipleVotes = false,
    this.votedPollOptionIds,
  });

  /// Create Poll
  static Future<Poll> create({
    required PollCreateParams params,
    OnPollCallback? onCompleted,
  }) async {
    final sdk = SendbirdSdk().getInternal();
    var poll = await sdk.api
        .send(PollCreateRequest(params: params))
        .onError((error, stackTrace) {
      if (onCompleted != null) {
        onCompleted(null, SBError(message: 'Failed Creating Poll'));
      }
      throw SBError(message: 'Failed Creating Poll');
    });

    if (onCompleted != null) {
      onCompleted(poll, null);
    }

    return poll;
  }

  /// Get Poll
  static Future<Poll> get({
    required PollRetrievalParams params,
    OnPollCallback? onCompleted,
  }) async {
    final sdk = SendbirdSdk().getInternal();
    var poll = await sdk.api
        .send(PollGetRequest(
      channelUrl: params.channelUrl,
      pollId: params.pollId,
      channelType: params.channelType,
    ))
        .onError((error, stackTrace) {
      if (onCompleted != null) {
        onCompleted(null, SBError(message: 'Failed Getting Poll'));
      }
      throw SBError(message: 'Failed Getting Poll');
    });

    if (onCompleted != null) {
      onCompleted(poll, null);
    }

    return poll;
  }

  /// Applies [PollUpdateEvent] event to this message
  bool applyPollUpdateEvent(PollUpdateEvent event) {
    if (this.id != event.pollId) {
      return false;
    } else if (updatedAt < event.json['ts']) {
      //Replace all event here
      if (event.json['poll']['title'] != null) {
        this.title = event.json['poll']['title'];
      }
      if (event.json['poll']['close_at'] != null) {
        this.closeAt = event.json['poll']['close_at'];
      }
      if (event.json['poll']['status'] != null) {
        switch (event.json['poll']['status']) {
          case 'open':
            this.status = PollStatus.open;
            break;
          case 'closed':
            this.status = PollStatus.closed;
            break;
        }
      }
      if (event.json['poll']['data'] != null) {
        this.data = PollData(text: event.json['poll']['data']['text']);
      }
      if (event.json['poll']['voter_count'] != null) {
        this.voterCount = event.json['poll']['voter_count'];
      }
      if (event.json['poll']['options'] != null) {
        List<PollOption> list = [];
        for (var pollOption in event.json['poll']['options']) {
          list.add(PollOption.fromJson(pollOption));
        }
        this.options = list;
      }
      if (event.json['poll']['allow_user_suggestion'] != null) {
        this.allowUserSuggestion = event.json['poll']['allow_user_suggestion'];
      }
      if (event.json['poll']['allow_multiple_votes'] != null) {
        this.allowMultipleVotes = event.json['poll']['allow_multiple_votes'];
      }
      if (event.json['poll']['voted_poll_option_ids'] != null) {
        this.votedPollOptionIds = event.json['poll']['voted_poll_option_ids'];
      }

      return true;
    } else {
      return false;
    }
  }

  /// Applies [PollVoteEvent] event to this message
  bool applyPollVoteEvent(PollVoteEvent event) {
    if (this.id != event.pollId) {
      return false;
    } else if (updatedAt < event.json['ts']) {
      //Replace all event here
      if (event.json['updated_vote_counts'] != null) {
        //go through each list and update
        (event.json['updated_vote_counts'] as List).forEach((e) {
          int id = e['option_id'];
          int voteCount = e['vote_count'];
          options.indexWhere((option) {
            if (option.id == id) {
              option.voteCount = voteCount;
            }
            return true;
          });
        });
      }
    } else {
      return false;
    }

    return true;

    // var _result = false;
    // final currentPoll = poll;
    // if (currentPoll == null) {
    //   return false;
    // }
    // if (currentPoll.id != event.pollId) return false;
    // final currentPollDetail = currentPoll.details;
    // if (currentPollDetail == null) {
    //   return false;
    // } else {
    //   //update vote count and vote at
    //   for (var option in currentPollDetail.options) {
    //     if (option.applyEvent(event)) {
    //       _result = true;
    //     }
    //   }
    //   return _result;
    // }
  }

  factory Poll.fromJson(Map<String, dynamic> json) {
    var poll = _$PollFromJson(json);
    return poll;
  }

  Map<String, dynamic> toJson() => _$PollToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is Poll && other.id == id && other.title == title;
  }
}
