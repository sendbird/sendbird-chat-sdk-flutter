import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/params/poll_option_retrieval_params.dart';
import 'package:sendbird_sdk/request/poll/poll_option_get_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'poll_option.g.dart';

/// Represents a poll option that a user can vote for
@JsonSerializable()
class PollOption {
  /// ID for the poll to which this option belongs.
  final int pollId;

  /// ID for an option. This value is unique within a poll.
  final int id;

  /// Representation of this option
  final String text;

  /// ID of the user who has created the poll
  String? createdBy;

  /// Timestamp (milliseconds) this option was created
  final int createdAt;

  /// Number of votes casted on the option
  int voteCount;

  /// Timestamp (milliseconds) this option was created
  int updatedAt;

  PollOption({
    required this.pollId,
    required this.id,
    required this.text,
    this.createdBy,
    required this.createdAt,
    required this.voteCount,
    required this.updatedAt,
  });

  /// Get Poll Options
  static Future<PollOption> get({
    required PollOptionRetrievalParams params,
    OnPollOptionCallback? onCompleted,
  }) async {
    final sdk = SendbirdSdk().getInternal();
    PollOption option = await sdk.api
        .send(PollOptionGetRequest(
      channelType: params.channelType,
      channelUrl: params.channelUrl,
      pollOptionId: params.pollOptionId,
      pollId: params.pollId,
    ))
        .onError((error, stackTrace) {
      if (onCompleted != null) {
        onCompleted(null, SBError(message: "Failed getting poll option"));
      }
      throw SBError(message: "Failed getting poll option");
    });

    if (onCompleted != null) {
      onCompleted(option, null);
    }
    return option;
  }

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return _$PollOptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PollOptionToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is PollOption &&
        other.id == id &&
        other.text == text &&
        other.pollId == pollId &&
        other.voteCount == voteCount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        pollId,
        id,
        text,
        voteCount,
        createdAt,
        updatedAt,
      );
}
