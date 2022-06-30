import 'package:json_annotation/json_annotation.dart';

part 'poll_data.g.dart';

/// Represents additional information to accompany the poll. Can be used to provide explanations for incorrect quiz answers.
@JsonSerializable()
class PollData {
  /// Poll text data information
  String text;

  PollData({this.text = ''});

  factory PollData.fromJson(Map<String, dynamic> json) =>
      _$PollDataFromJson(json);

  Map<String, dynamic> toJson() => _$PollDataToJson(this);
}
