// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/stats/model/base_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class DefaultStat extends BaseStat {
  DefaultStat(StatType type, int ts) : super(type, ts);
}
