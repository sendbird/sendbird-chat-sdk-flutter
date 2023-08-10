// An object consists a set of parameters to create/update poll
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/features/poll/poll_data.dart';

part 'poll_params.g.dart';

@JsonSerializable()
class PollCreateParams {
  /// Title of a poll
  String title;

  /// Possible options for which a user can vote
  List<String> options;

  /// An additional text to accompany the poll.
  PollData? data;

  /// Whether to allow user-suggested options. Default is false
  bool? allowUserSuggestion;

  /// Whether to allow multiple vote casting. Default is NO
  bool? allowMultipleVotes;

  /// Unix timestamp at which the poll will close (millisecond)
  int closeAt = -1;

  PollCreateParams({
    required this.title,
    required this.options,
    this.data,
    this.allowUserSuggestion,
    this.allowMultipleVotes,
    this.closeAt = -1, // Default value
  })  : assert(options.isNotEmpty && options.length <= 20),
        assert(title.length <= 2000);

  Map<String, dynamic> toJson() {
    final json = _$PollCreateParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
