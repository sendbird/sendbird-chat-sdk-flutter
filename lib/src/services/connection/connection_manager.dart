import 'dart:async';

import '../../constant/enums.dart';
import '../../core/models/error.dart';
import '../../sdk/sendbird_sdk_api.dart';

import '../../handlers/authenticate_event_handler.dart';

class ConnectionManager {
  // Map<String, NetworkEventHandler> _networkHandlers = {};
  // AuthenticateEventHandler authHandler;

  // /// Add network [delegate] with `identifier`
  // void addNetworkDelegate(String identifier, NetworkEventHandler delegate) {
  //   _networkHandlers[identifier] = delegate;
  // }

  // /// Remove network delegate with `identifier`
  // void removeNetworkDelegate(String identifier) {
  //   _networkHandlers.remove(identifier);
  // }

  // /// Remove all network delegates
  // void removeAllNetworkDelegates() {
  //   _networkHandlers.removeWhere((key, value) => true);
  // }

  // /// Set authenticate `delegate`
  // void setAuthenticateDelegate(AuthenticateEventHandler handler) {
  //   authHandler = handler;
  // }

  /// Perform authentication. This process should complete within timeout
  /// that is set on `authenticationTimeout` property in [Options]. While it
  /// performs authentication, [AuthenticationDelegate] methods will be invoked
  /// as it needed.
  // void authenticate() {}

  static List<Completer> _queue = [];

  static Future<void> readyToExecuteAPIRequest({bool force = false}) async {
    if (force) return;

    final sdk = SendbirdSdk().getInternal();
    final sessionKey = await sdk.sessionManager.getSessionKey();
    final hasValidSession = sessionKey != null && sessionKey.length > 0;
    final hasToken = sdk.api.token != null;
    if (hasValidSession || hasToken) {
      return;
    }

    throw ConnectionRequiredError();
  }

  static Future<void> readyToExecuteWSRequest() async {
    final state = SendbirdSdk().getConnectionState();
    if (state == ConnectionState.open) {
      flushCompleters();
      return;
    }

    if (state == ConnectionState.closed) {
      throw ConnectionRequiredError();
    }

    final completer = Completer();
    _queue.add(completer);
    return completer.future;
  }

  static void flushCompleters({SBError error}) {
    while (_queue.length > 0) {
      final completer = _queue.removeAt(0);
      if (error != null) {
        completer.completeError(error);
      } else {
        completer.complete();
      }
    }
  }
}
