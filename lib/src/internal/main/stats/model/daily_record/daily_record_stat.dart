// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/stats/model/base_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';

abstract class DailyRecordStat extends BaseStat {
  DailyRecordStat(StatType type, int ts) : super(type, ts);

  void update(DailyRecordStat stat);

  static const keyPrefix = 'daily_record';

  String get key =>
      '${keyPrefix}_${getDateString(ts)}_${StatUtils.getStatTypeString(type)}';

  static String getDateString(int ts) {
    String dateString;
    try {
      final date = DateTime.fromMillisecondsSinceEpoch(ts);
      String year = date.year.toString();
      String month = date.month.toString();
      String day = date.day.toString();

      if (month.length == 1) month = '0$month';
      if (day.length == 1) day = '0$day';

      dateString = '$year$month$day';
    } catch (_) {
      dateString = '';
    }
    return dateString;
  }
}
