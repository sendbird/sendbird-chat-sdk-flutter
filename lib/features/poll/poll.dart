import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/features/poll/poll_detail.dart';
import 'package:sendbird_sdk/params/poll_params.dart';
import 'package:sendbird_sdk/params/poll_retrieval_params.dart';
import 'package:sendbird_sdk/params/poll_update_params.dart';
import 'package:sendbird_sdk/request/poll/poll_option_add_request.dart';
import 'package:sendbird_sdk/request/poll/poll_close_request.dart';
import 'package:sendbird_sdk/request/poll/poll_create_request.dart';
import 'package:sendbird_sdk/request/poll/poll_delete_request.dart';
import 'package:sendbird_sdk/request/poll/poll_get_request.dart';
import 'package:sendbird_sdk/request/poll/poll_update_request.dart';
import 'package:sendbird_sdk/request/poll/poll_vote_request.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
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

  /// Detail of this poll
  PollDetail? details;

  Poll({
    required this.id,
    required this.title,
    this.details,
  });

  SendbirdSdkInternal get _sdk => SendbirdSdk().getInternal();

  /// Create Poll
  static Future<Poll> create({required PollParams params}) async {
    final sdk = SendbirdSdk().getInternal();
    return sdk.api.send(PollCreateRequest(params: params));
  }

  /// Get Poll
  static Future<Poll> get({required PollRetrievalParams params}) async {
    final sdk = SendbirdSdk().getInternal();
    return sdk.api.send(PollGetRequest(
      channelUrl: params.channelUrl,
      pollId: params.pollId,
      showPartialVoterList: params.showPartialVoterList,
      channelType: params.channelType,
    ));
  }

  /// Update Poll
  Future<Poll> update({required PollUpdateParams params}) async {
    return _sdk.api.send(PollUpdateRequest(
      pollId: id,
      params: params,
    ));
  }

  /// Delete Poll
  Future<void> delete() async {
    return _sdk.api.send(PollDeleteRequest(pollId: id));
  }

  /// Add Option Poll
  Future<Poll> addOption({
    required String channelUrl,
    required String text,
    required ChannelType channelType,
  }) async {
    return _sdk.api.send(PollOptionAddRequest(
      pollId: id,
      channelUrl: channelUrl,
      text: text,
      channelType: channelType,
    ));
  }

  /// Vote Poll Options
  Future<Poll> vote({
    required String channelUrl,
    required List<int> optionIds,
    required ChannelType channelType,
  }) async {
    return _sdk.api.send(PollVoteRequest(
      channelType: channelType,
      pollId: id,
      channelUrl: channelUrl,
      optionIds: optionIds,
    ));
  }

  ///  Closes Poll
  Future<Poll> close() async {
    return _sdk.api.send(PollCloseRequest(pollId: id));
  }

  factory Poll.fromJson(Map<String, dynamic> json) {
    var pollDetail;
    if (json['status'] != 'removed') {
      pollDetail = PollDetail.fromJson(json);
    }

    var poll = _$PollFromJson(json);
    poll.details = pollDetail;
    return poll;
  }

  Map<String, dynamic> toJson() => _$PollToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is Poll &&
        other.id == id &&
        other.title == title &&
        other.details == details;
  }
}
