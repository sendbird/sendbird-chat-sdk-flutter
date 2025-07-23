// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:math';

import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_configuration.dart';
import 'package:uuid/uuid.dart';

class ReconnectTask {
  final String _id = const Uuid().v1();
  String? url;
  int _backOffPeriod = 0;
  int _retryCount = 0;
  ReconnectConfiguration config;

  ReconnectTask(this.config);

  String get id => _id;

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

  void increaseRetryCount({bool reset = false}) {
    if (reset) {
      if (_retryCount == 0) {
        _retryCount = 1;
      }

      _backOffPeriod = 0;
    } else if (_backOffPeriod < config.maxInterval) {
      _retryCount++;

      double newBackOff;
      if (_retryCount <= 2) {
        newBackOff = config.interval;
      } else {
        newBackOff =
            config.interval * pow(config.multiplier, (_retryCount - 2));
      }
      _backOffPeriod = min(newBackOff.toInt(), config.maxInterval.toInt());
    }
  }
}
