import 'dart:async';

import 'package:flutter/material.dart';

abstract class EvictionPolicy {}

abstract class Evictable {
  EvictionPolicy policy;
  void evict();
}

class LRUEviction implements EvictionPolicy {}

class PeriodEviction implements EvictionPolicy {
  final int periodInSeconds;
  final Function evict;
  Timer timer;

  PeriodEviction({
    @required this.periodInSeconds,
    @required this.evict,
  });

  void start() {
    timer?.cancel();
    timer = Timer(Duration(seconds: periodInSeconds), () {
      evict();
    });
  }

  void stop() {
    timer?.cancel();
  }
}
