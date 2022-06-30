// An object consists a set of parameters to create/update poll
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/features/poll/poll_data.dart';

part 'poll_update_params.g.dart';

@JsonSerializable()
class PollUpdateParams {
  /// Title of a poll
  String? title;

  /// An additional text to accompany the poll.
  PollData? data;

  /// Whether to make the votes anonymous. Default is false
  bool? isAnonymous;

  /// Whether to allow user-suggested options. Default is false
  bool? allowUserSuggestion;

  /// Whether to allow multiple vote casting. Default is NO
  bool? allowMutipleVotes;

  /// Unix timestamp at which the poll will close (millisecond)
  int? closeAt;

  PollUpdateParams({
    this.title,
    this.data,
    this.isAnonymous,
    this.allowUserSuggestion,
    this.allowMutipleVotes,
  }) : assert((title?.length ?? 0) <= 2000);

  Map<String, dynamic> toJson() {
    return _$PollUpdateParamsToJson(this);
  }
}
