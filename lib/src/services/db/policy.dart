import 'dart:async';

import 'package:flutter/material.dart';

abstract class EvictionPolicy {
  void start();
  void stop();
}

abstract class Evictable {
  EvictionPolicy policy;
  void evict();
}

class PeriodEviction implements EvictionPolicy {
  final int periodInSeconds;
  final Function evict;
  Timer timer;

  PeriodEviction({
    @required this.periodInSeconds,
    @required this.evict,
  });

  @override
  void start() {
    timer?.cancel();
    timer = Timer(Duration(seconds: periodInSeconds), () {
      this.evict();
    });
  }

  @override
  void stop() {
    timer?.cancel();
  }
}

class LRUEviction implements EvictionPolicy {
  @override
  void start() {}

  @override
  void stop() {}
}
