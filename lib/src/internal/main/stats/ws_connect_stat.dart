// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class WsConnectStat extends DefaultStat {
  final String hostUrl; // ws host url
  final bool success; // success or not
  final int latency; // roundtrip latency
  final int? errorCode; // error code if exist
  final String? errorDescription; // detailed error message

  WsConnectStat({
    required int ts,
    required this.hostUrl,
    required this.success,
    required this.latency,
    this.errorCode,
    this.errorDescription,
  }) : super(StatType.wsConnect, ts);

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'host_url': hostUrl,
      'success': success,
      'latency': latency,
      'error_code': errorCode,
      'error_description': errorDescription,
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
  //     'error_code': int?,
  //     'error_description': String?,
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
      final int? errorCode = data['error_code'] as int?;
      final String? errorDescription = data['error_description'] as String?;

      if (hostUrl == null || success == null || latency == null) {
        return null;
      }

      return WsConnectStat(
        ts: ts,
        hostUrl: hostUrl,
        success: success,
        latency: latency,
        errorCode: errorCode,
        errorDescription: errorDescription,
      );
    } catch (e) {
      sbLog.d(StackTrace.current, 'e: ${e.toString()}');
    }
    return null;
  }
}
