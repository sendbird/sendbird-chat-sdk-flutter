import 'dart:math';

import 'package:sendbird_sdk/core/models/reconnect_configuration.dart';

class ReconnectTask {
  int _backOffPeriod = 0;
  int _retryCount = 0;
  ReconnectConfiguration config;

  ReconnectTask(this.config);

  int get backOffPeriod => _backOffPeriod;

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
      final newBackOff = config.interval * pow(config.multiplier, _retryCount);
      _backOffPeriod = min(newBackOff.toInt(), config.maxInterval.toInt());
    }

    _retryCount++;
  }
}
