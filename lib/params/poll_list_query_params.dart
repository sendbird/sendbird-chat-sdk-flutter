import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'poll_list_query_params.g.dart';

@JsonSerializable()
class PollListQueryParams {
  ChannelType channelType;
  String channelUrl;
  int limit;

  PollListQueryParams({
    required this.channelType,
    required this.channelUrl,
    this.limit = 20,
  });

  // Json Serialization
  Map<String, dynamic> toJson() => _$PollListQueryParamsToJson(this);

  factory PollListQueryParams.fromJson(Map<String, dynamic> json) {
    return _$PollListQueryParamsFromJson(json);
  }
}
