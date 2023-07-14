// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';

class BaseStat {
  final StatType type;
  final int ts;

  BaseStat(this.type, this.ts);

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'stat_type': StatUtils.getStatTypeString(type),
      'ts': ts,
    };
    return result;
  }
}
