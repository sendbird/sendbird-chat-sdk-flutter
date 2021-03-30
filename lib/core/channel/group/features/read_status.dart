import 'package:json_annotation/json_annotation.dart';

import '../../../../constant/enums.dart';
import '../../../../services/db/cache_service.dart';
import '../../../../utils/json_from_parser.dart';

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
  @JsonKey(name: 'ts')
  int timestamp;

  @JsonKey(ignore: true)
  bool dirty = false;

  ReadStatus({
    this.userId,
    this.timestamp,
    this.channelUrl,
    this.channelType,
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
