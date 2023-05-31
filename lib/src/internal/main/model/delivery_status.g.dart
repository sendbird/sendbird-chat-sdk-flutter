// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryStatus _$DeliveryStatusFromJson(Map<String, dynamic> json) =>
    DeliveryStatus(
      channelUrl: json['channel_url'] as String,
      updatedDeliveryStatus: (json['updated'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
    );
