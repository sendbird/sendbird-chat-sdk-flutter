import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/utils/json_from_parser.dart';

part 'restricted_user.g.dart';

/// An object represents a sender of a message.
@JsonSerializable()
class RestrictedUser extends User {
  /// Information about restriction
  RestrictionInfo? get restrictionInfo => _info;
  RestrictionInfo? _info;

  RestrictedUser({
    required String userId,
    required String nickname,
    String? profileUrl,
    UserConnectionStatus connectionStatus = UserConnectionStatus.notAvailable,
    int? lastSeenAt,
    List<String>? preferredLanguages,
    String? friendDiscoveryKey,
    String? friendName,
    List<String>? discoveryKeys,
    Map<String, String> metaData = const {},
    bool requireAuth = false,
  }) : super(
          userId: userId,
          nickname: nickname,
          profileUrl: profileUrl,
          connectionStatus: connectionStatus,
          lastSeenAt: lastSeenAt,
          preferredLanguages: preferredLanguages,
          friendDiscoveryKey: friendDiscoveryKey,
          friendName: friendName,
          discoveryKeys: discoveryKeys,
          metaData: metaData,
          requireAuth: requireAuth,
        );

  factory RestrictedUser.fromJson(Map<String, dynamic> json) {
    final user = _$RestrictedUserFromJson(json);
    user._info = RestrictionInfo.fromJson(json);
    return user;
  }

  @override
  Map<String, dynamic> toJson() => _$RestrictedUserToJson(this);
}

@JsonSerializable()
class RestrictionInfo {
  // description of restriction
  final String? description;

  // timestamp when restriction will end
  final int? endAt;

  // timestamp when restriction started
  final int? startAt;

  // restriction type
  final RestrictionType type;

  RestrictionInfo({
    this.description,
    this.endAt,
    this.startAt,
    this.type = RestrictionType.muted,
  });

  factory RestrictionInfo.fromJson(Map<String, dynamic> json) {
    json['end_at'] = json['end_at'] ?? json['muted_end_at'];
    json['start_at'] = json['start_at'] ?? json['muted_start_at'];
    json['description'] = json['description'] ?? json['muted_description'];
    if (json['type'] == null) json['type'] = 'muted';
    return _$RestrictionInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RestrictionInfoToJson(this);
}
