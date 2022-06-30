// An object consists a set of parameters to create/update poll
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/features/poll/poll_data.dart';

part 'poll_params.g.dart';

@JsonSerializable()
class PollParams {
  /// Title of a poll
  String title;

  /// Possible options for which a user can vote
  List<String> options;

  /// An additional text to accompany the poll.
  PollData? data;

  /// Whether to make the votes anonymous. Default is false
  bool isAnonymous = false;

  /// Whether to allow user-suggested options. Default is false
  bool allowUserSuggestion = false;

  /// Whether to allow multiple vote casting. Default is NO
  bool allowMutipleVotes = false;

  /// Unix timestamp at which the poll will close (millisecond)
  int closeAt = -1;

  PollParams({
    required this.title,
    required this.options,
  })  : assert(options.isNotEmpty && options.length <= 20),
        assert(title.length <= 2000);

  Map<String, dynamic> toJson() {
    final json = _$PollParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
