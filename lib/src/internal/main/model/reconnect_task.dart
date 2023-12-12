// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:math';

import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_configuration.dart';

class ReconnectTask {
  int _backOffPeriod = 0;
  int _retryCount = 1;
  ReconnectConfiguration config;

  ReconnectTask(this.config);

  int get backOffPeriod => _backOffPeriod;
  int get retryCount => _retryCount;

  bool get exceedRetryCount {
    if (config.enabledInfinitelyRetry) return false;
    return _retryCount >= config.maximumRetryCount;
  }

  bool get hasRetriedLastChance {
    if (config.enabledInfinitelyRetry) return false;
    if (config.maximumRetryCount == 0 && _retryCount == 0) return false;
    return _retryCount == config.maximumRetryCount;
  }

  void increaseRetryCount() {
    if (_backOffPeriod < config.maxInterval) {
      final newBackOff =
          config.interval * pow(config.multiplier, (_retryCount - 1));
      _backOffPeriod = min(newBackOff.toInt(), config.maxInterval.toInt());
    }
    _retryCount++;
  }
}
