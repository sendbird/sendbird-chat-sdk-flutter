// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class WsConnectStat extends DefaultStat {
  final String hostUrl; // ws host url
  final bool success; // success or not
  final int latency; // until connected or failed
  final int accumTrial;
  final String connectionId;
  final int? logiLatency; // until received LOGI
  final int? errorCode; // error code if exist
  final String? errorDescription; // detailed error message
  final bool? isSoftRateLimited;

  WsConnectStat({
    required int ts,
    required this.hostUrl,
    required this.success,
    required this.latency,
    required this.accumTrial,
    required this.connectionId,
    this.logiLatency,
    this.errorCode,
    this.errorDescription,
    this.isSoftRateLimited,
  }) : super(StatType.wsConnect, ts);

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'host_url': hostUrl,
      'success': success,
      'latency': latency,
      'accum_trial': accumTrial,
      'connection_id': connectionId,
      'logi_latency': logiLatency,
      'error_code': errorCode,
      'error_description': errorDescription,
      'is_soft_rate_limited': isSoftRateLimited,
    };
    final result = super.toJson();
    result['data'] = json;
    return result;
  }

  // {
  //   'stat_type' : 'ws:connect',
  //   'ts': int, // timestamp for log creation,
  //   'data' : {
  //     'host_url': String,
  //     'success': bool,
  //     'latency': int,
  //     'accum_trial': int,
  //     'connection_id': String,
  //     'logi_latency': int?,
  //     'error_code': int?,
  //     'error_description': String?,
  //     'is_soft_rate_limited': bool?,
  //   },
  // }
  static WsConnectStat? fromJson({
    required int ts,
    required Map<String, dynamic> data,
  }) {
    try {
      final String? hostUrl = data['host_url'] as String?;
      final bool? success = data['success'] as bool?;
      final int? latency = data['latency'] as int?;
      final int? accumTrial = data['accum_trial'] as int?;
      final String? connectionId = data['connection_id'] as String?;
      final int? logiLatency = data['logi_latency'] as int?;
      final int? errorCode = data['error_code'] as int?;
      final String? errorDescription = data['error_description'] as String?;
      final bool? isSoftRateLimited = data['is_soft_rate_limited'] as bool?;

      if (hostUrl == null ||
          success == null ||
          latency == null ||
          accumTrial == null ||
          connectionId == null) {
        return null;
      }

      return WsConnectStat(
        ts: ts,
        hostUrl: hostUrl,
        success: success,
        latency: latency,
        accumTrial: accumTrial,
        connectionId: connectionId,
        logiLatency: logiLatency,
        errorCode: errorCode,
        errorDescription: errorDescription,
        isSoftRateLimited: isSoftRateLimited,
      );
    } catch (e) {
      sbLog.d(StackTrace.current, 'e: ${e.toString()}');
    }
    return null;
  }
}
