import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/utils/json_from_parser.dart';

part 'read_status.g.dart';

/// Represents read status of a [User].
@JsonSerializable(createToJson: false)
class ReadStatus implements Cacheable {
  /// [User]'s id
  @JsonKey(fromJson: userToUserId, name: 'user')
  final String userId;

  /// Channel url for this read status
  final String channelUrl;

  /// Channel type for this read status
  final ChannelType channelType;

  /// Latest read timestamps
  @JsonKey(defaultValue: 0, name: 'ts')
  int timestamp;

  @JsonKey(ignore: true)
  @override
  bool dirty = false;

  ReadStatus({
    required this.userId,
    required this.timestamp,
    required this.channelUrl,
    required this.channelType,
  });

  factory ReadStatus.fromJson(Map<String, dynamic> json) =>
      _$ReadStatusFromJson(json);

  @override
  String get primaryKey => channelUrl;

  @override
  String get key => userId;

  @override
  void copyWith(dynamic others) {
    timestamp = others.timestamp;
  }
}
