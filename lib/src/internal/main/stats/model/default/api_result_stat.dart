// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class ApiResultStat extends DefaultStat {
  final String endpoint; // endpoint
  final String method; // 'GET|POST|PUT|DELETE'
  final bool success; // success or not
  final int latency; // roundtrip latency
  final int? errorCode; // error code if exist
  final String? errorDescription; // detailed error message

  ApiResultStat({
    required int ts,
    required this.endpoint,
    required this.method,
    required this.success,
    required this.latency,
    this.errorCode,
    this.errorDescription,
  }) : super(StatType.apiResult, ts);

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'endpoint': endpoint,
      'method': method,
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
  //   'stat_type' : 'api:result',
  //   'ts': int, // timestamp for log creation,
  //   'data' : {
  //     'endpoint': String,
  //     'method': String,
  //     'success': bool,
  //     'latency': int,
  //     'error_code': int?,
  //     'error_description': String?,
  //   },
  // }
  static ApiResultStat? fromJson({
    required int ts,
    required Map<String, dynamic> data,
  }) {
    try {
      final String? endpoint = data['endpoint'] as String?;
      final String? method = data['method'] as String?;
      final bool? success = data['success'] as bool?;
      final int? latency = data['latency'] as int?;
      final int? errorCode = data['error_code'] as int?;
      final String? errorDescription = data['error_description'] as String?;

      if (endpoint == null ||
          method == null ||
          success == null ||
          latency == null) {
        return null;
      }

      return ApiResultStat(
        ts: ts,
        endpoint: endpoint,
        method: method,
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
