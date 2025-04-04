// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class WsDisconnectStat extends DefaultStat {
  final bool success; // success or not
  final int errorCode; // error code
  final String errorDescription; // detailed error message

  WsDisconnectStat({
    required int ts,
    required this.success,
    required this.errorCode,
    required this.errorDescription,
  }) : super(StatType.wsDisconnect, ts);

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'success': success,
      'error_code': errorCode,
      'error_description': errorDescription,
    };
    final result = super.toJson();
    result['data'] = json;
    return result;
  }

  // {
  //   'stat_type' : 'ws:disconnect',
  //   'ts': int, // timestamp for log creation,
  //   'data' : {
  //     'success': bool,
  //     'error_code': int,
  //     'error_description': String,
  //   },
  // }
  static WsDisconnectStat? fromJson({
    required int ts,
    required Map<String, dynamic> data,
  }) {
    try {
      final bool? success = data['success'] as bool?;
      final int? errorCode = data['error_code'] as int?;
      final String? errorDescription = data['error_description'] as String?;

      if (success == null || errorCode == null || errorDescription == null) {
        return null;
      }

      return WsDisconnectStat(
        ts: ts,
        success: success,
        errorCode: errorCode,
        errorDescription: errorDescription,
      );
    } catch (e) {
      sbLog.d(StackTrace.current, 'e: ${e.toString()}');
    }
    return null;
  }
}
