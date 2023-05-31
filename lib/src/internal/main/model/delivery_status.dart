// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat/src/internal/main/chat_cache/cache_service.dart';

part 'delivery_status.g.dart';

@JsonSerializable(createToJson: false)
class DeliveryStatus implements Cacheable {
  final String channelUrl;

  @JsonKey(name: 'updated')
  Map<String, int> updatedDeliveryStatus;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool dirty = false;

  DeliveryStatus({
    required this.channelUrl,
    this.updatedDeliveryStatus = const {},
  });

  factory DeliveryStatus.fromJson(Map<String, dynamic> json) =>
      _$DeliveryStatusFromJson(json);

  @override
  String get key => 'delivery/$channelUrl';

  @override
  String get primaryKey => channelUrl;

  @override
  void copyWith(dynamic others) {
    if (others is DeliveryStatus) {
      updatedDeliveryStatus.addAll(others.updatedDeliveryStatus);
    }
  }
}
