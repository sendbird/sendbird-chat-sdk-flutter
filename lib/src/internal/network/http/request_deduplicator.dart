// Copyright (c) 2026 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';

/// Coalesces duplicate API requests that share the same key.
///
/// An **in-flight** request is always joined by later requests with the same
/// key, regardless of how long it has been running — so a slow request never
/// spawns a duplicate. Once it **completes**, its result is reused for the
/// remainder of the server-provided `request_dedup_interval_ms` window
/// (measured from when the request started), then evicted. This honors the
/// server-configured interval and matches the Android/iOS/JS SDKs, while
/// guaranteeing a burst (e.g. the many concurrent `GET group_channels/{url}`
/// refreshes triggered by join events) collapses into a single network call.
///
/// Failures are never cached. Deduplication is disabled when the interval is
/// not positive.
class RequestDeduplicator {
  RequestDeduplicator(this._chatContext);

  final ChatContext _chatContext;
  final Map<String, _OngoingRequest> _ongoingRequests = {};

  /// Lower bound applied to a positive interval, matching the other SDKs.
  static const int _minIntervalMs = 50;

  /// Effective dedup window in milliseconds. `0` disables deduplication.
  int get _intervalMs {
    final interval = _chatContext.requestDedupIntervalMs;
    if (interval <= 0) return 0;
    return interval < _minIntervalMs ? _minIntervalMs : interval;
  }

  /// Runs [request] under deduplication for [key].
  ///
  /// Joins an in-flight request unconditionally; reuses a completed one only
  /// while it is still within the dedup window. Otherwise invokes [request] and
  /// registers it so concurrent/duplicate callers can join.
  Future<T> run<T>(String key, Future<T> Function() request) {
    final intervalMs = _intervalMs;
    if (intervalMs <= 0) return request();

    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final ongoing = _ongoingRequests[key];
    if (ongoing != null) {
      // Always join an in-flight request; reuse a completed result only within
      // the window (measured from the request start).
      if (!ongoing.completed || nowMs - ongoing.requestedAtMs <= intervalMs) {
        return ongoing.future.then((value) => value as T);
      }
      _ongoingRequests.remove(key); // completed and window elapsed
    }

    final completer = Completer<T>();
    final entry =
        _OngoingRequest(requestedAtMs: nowMs, future: completer.future);
    _ongoingRequests[key] = entry;

    // `Future.sync` funnels a synchronous throw from [request] into the error
    // path.
    unawaited(
      Future.sync(request).then(
        (value) {
          entry.completed = true;
          completer.complete(value);

          // Keep the completed result until the end of the window (measured
          // from the request start), then evict the entry.
          final remainingMs =
              intervalMs - (DateTime.now().millisecondsSinceEpoch - nowMs);
          Timer(Duration(milliseconds: remainingMs > 0 ? remainingMs : 0), () {
            if (identical(_ongoingRequests[key], entry)) {
              _ongoingRequests.remove(key);
            }
          });
        },
        onError: (Object error, StackTrace stackTrace) {
          // Never cache failures: drop immediately so callers can retry.
          if (identical(_ongoingRequests[key], entry)) {
            _ongoingRequests.remove(key);
          }
          completer.completeError(error, stackTrace);
        },
      ),
    );

    return completer.future;
  }

  /// Drops all tracked requests so dedup state does not survive across
  /// connection sessions. Called on every WS teardown via
  /// `ApiClient.clearRequestDedup()`.
  void clear() {
    _ongoingRequests.clear();
  }
}

class _OngoingRequest {
  _OngoingRequest({required this.requestedAtMs, required this.future});

  final int requestedAtMs;
  final Future<dynamic> future;
  bool completed = false;
}
